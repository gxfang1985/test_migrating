/* SearchFilter.java */
package jp.co.cybozu.ldap;

import jp.co.cybozu.text.ParseException;
import java.util.*;
import java.io.*;

/**
 * LDAPの検索フィルターを実装する。<br>
 * RFC2254に定めされる文字列形式のパースと、検索フィルターに適合するエントリのテスト機能を有する。
 *
 * @author サイボウズ
 * @version	1.0.0
 * @see		<a href="http://www.ietf.org/rfc/rfc2254.txt">RFC2254</a>
 */
public class SearchFilter
{
    // decode escaped octets of an attribute value
    private static String decode(byte[] ba, int off, int len)
	throws ParseException
    {
    	ByteArrayOutputStream o = new ByteArrayOutputStream();
    	String s = null;

    	try {
    		final int END = off + len;
    		for ( int i = off; i < END; i++ )
    		{
    			int b = ba[i];

    			if ( b == 92 )	// '\\'
    			{
    				if ( (END - i) < 3 )
    					throw new ParseException("invalid escape in search filter");

    				try {
    					b = Integer.parseInt( new String(ba, i + 1, 2, "UTF8"), 16 );
    				} catch ( NumberFormatException e ) {
    					throw new ParseException("invalid escape in search filter");
    				}

    				i += 2;
    			}

    			o.write( b & 0xFF );
    		}

    		s = o.toString( "UTF8" );
    	} catch ( UnsupportedEncodingException e ) {
    		// ignore it.
    	}
    	return s;
    }

    private static class FilterComp
    {
    	public static final int	SINGLE	= 0;
    	public static final int	NOT	= 1;
    	public static final int	AND	= 2;
    	public static final int	OR	= 3;

    	private final int type;
    	private final Item item;
    	private final List components;

    	private FilterComp(Item item)
    	{
    		this.type = SINGLE;
    		this.item = item;
    		this.components = null;
    	}

    	private FilterComp(int type, List components)
    	{
    		this.type = type;
    		this.item = null;
    		this.components = Collections.unmodifiableList( components );
    	}

    	public static FilterComp parse(String s)
	    throws ParseException
	    {
    		FilterComp comp = null;
    		try {
    			comp = parse( s.getBytes( "UTF8" ) );
    		} catch ( UnsupportedEncodingException e ) {
    			// ignore it.
    		}
    		return comp;
	    }

    	public static FilterComp parse(byte[] ba)
	    throws ParseException
	    {
    		return parse(ba, 0, ba.length);
	    }

    	public static FilterComp parse(byte[] ba, int off, int len)
	    throws ParseException
	    {
    		final int END = off + len;

    		// check surrounding '(' (ASCII 40), ')' (ASCII 41)
    		if ( (len < 3 ) || (ba[off] != 40) || (ba[END - 1] != 41) )
    			throw new ParseException("wrong search filter syntax");

    		switch ( ba[off + 1] )
    		{
    		case 38:	// '&'
    		case 124:	// '|'
    			final int ltype = ( ba[off + 1] == 38 ) ? AND : OR;
    			List lcomps = new ArrayList(4);

    			int hpos = off + 2;
    			int depth = 0;

    			// search for next ')'
    			for ( int j = hpos; j < (END - 1); j++ )
    			{
    				if ( ba[j] == 40 )
    				{
    					depth ++;
    					continue;
    				}

    				if ( ba[j] == 41 )
    				{
    					if ( depth == 0 )
    						break;

    					depth --;
    					if ( depth == 0 )
    					{
    						lcomps.add( parse(ba, hpos, (j - hpos + 1)) );
    						hpos = j + 1;
    					}
    					continue;
    				}
    			}

    			if ( depth != 0 )
    				throw new ParseException("unbalanced parentheses in search filter");

    			return new FilterComp(ltype, lcomps);

    		case 33:	// '!'
    			FilterComp lcomp = parse(ba, off + 2, len - 3);
    			return new FilterComp(NOT, Collections.singletonList( lcomp ));

    		default:	// single item
    			Item litem = Item.parse(ba, off + 1, len - 2);
    		return new FilterComp(litem);
    		}
	    }

    	private boolean match( Entry entry )
    	{
    		if ( type == SINGLE )
    		{
    			return item.match( entry );
    		}
    		if ( type == NOT )
    		{
    			return ! ((FilterComp)components.get(0)).match( entry );
    		}
    		if ( type == AND )
    		{
    			Iterator it = components.iterator();
    			while ( it.hasNext() )
    			{
    				FilterComp comp = (FilterComp)it.next();
    				if ( ! comp.match( entry ) )
    					return false;
    			}
    			return true;
    		}
    		if ( type == OR )
    		{
    			Iterator it = components.iterator();
    			while ( it.hasNext() )
    			{
    				FilterComp comp = (FilterComp)it.next();
    				if ( comp.match( entry ) )
    					return true;
    			}
    			return false;
    		}

    		return false;
    	}

    	public void toString( StringBuffer sb )
    	{
    		sb.append( '(' );

    		Iterator it = null;
    		switch ( type )
    		{
    		case SINGLE:
    			item.toString( sb );
    			break;

    		case NOT:
    			sb.append( '!' );
    			((FilterComp)components.get(0)).toString( sb );
    			break;

    		case AND:
    			sb.append( '&' );
    			it = components.iterator();
    			while ( it.hasNext() )
    			{
    				((FilterComp)it.next()).toString( sb );
    			}
    			break;

    		case OR:
    			sb.append( '|' );
    			it = components.iterator();
    			while ( it.hasNext() )
    			{
    				((FilterComp)it.next()).toString( sb );
    			}
    			break;
    		}

    		sb.append( ')' );
    	}

    	public String toString()
    	{
    		StringBuffer sb = new StringBuffer();
    		toString( sb );
    		return sb.toString();
    	}
    }

    private static class Pattern
    {
    	private final String prefix;
    	private final String postfix;
    	private final List parts;

    	private Pattern(String prefix, List parts, String postfix)
    	{
    		this.prefix = prefix;
    		this.parts = Collections.unmodifiableList( parts );
    		this.postfix = postfix;
    	}

    	public static Pattern parse(byte[] ba, int off, int len)
	    throws ParseException
	    {
    		// at least one '*' + a character
    		if ( len < 2 )
    		{
    			throw new ParseException("invalid substring pattern in search filter");
    		}

    		final int END = off + len;

    		// prefix
    		int i = off;
    		String prefix = null;
    		if ( ba[off] != 42 )	// '*'
    		{
    			for ( ; i < END; i++ )
    			{
    				if ( ba[i] == 42 )
    				{
    					break;
    				}
    			}

    			prefix = decode(ba, off, (i - off));
    		}
    		i++;	// skip '*'

    		// postfix
    		int j = END;
    		String postfix = null;
    		if ( ba[j - 1] != 42 )
    		{
    			for ( ; j > i; j-- )
    			{
    				if ( ba[j - 1] == 42 )
    					break;
    			}

    			postfix = decode(ba, j, (END - j));
    		}

    		// parts
    		List parts = new ArrayList(2);
    		int h = i;

    		for ( ; i < j; i++ )
    		{
    			if ( ba[i] != 42 )
    				continue;

    			parts.add( decode(ba, h, (i - h)) );

    			i++;	// skip '*'
    			h = i;
    		}

    		return new Pattern(prefix, parts, postfix);
	    }

    	public boolean match(String s)
    	{
    		if ( prefix != null )
    		{
    			if ( ! s.startsWith( prefix ) )
    				return false;
    			s = s.substring( prefix.length() );
    		}

    		if ( postfix != null )
    		{
    			if ( ! s.endsWith( postfix ) )
    				return false;
    			s = s.substring( 0, (s.length() - postfix.length()) );
    		}

    		if ( parts == null )
    			return true;

    		Iterator it = parts.iterator();
    		while ( it.hasNext() )
    		{
    			String part = (String)it.next();

    			int n = s.indexOf( part );
    			if ( n == -1 )
    				return false;

    			s = s.substring( n + part.length() );
    		}
    		return true;
    	}

    	public void toString( StringBuffer sb )
    	{
    		if ( prefix != null )
    		{
    			sb.append( prefix );
    		}

    		sb.append( '*' );

    		if ( parts != null )
    		{
    			Iterator it = parts.iterator();
    			while ( it.hasNext() )
    			{
    				sb.append( (String)it.next() );
    				sb.append( '*' );
    			}
    		}

    		if ( postfix != null )
    		{
    			sb.append( postfix );
    		}
    	}

    	public String toString()
    	{
    		StringBuffer sb = new StringBuffer();
    		toString( sb );
    		return sb.toString();
    	}
    }

    private static class Item
    {
    	public static final int EQUAL	= 1;
    	public static final int APPROX	= 2;
    	public static final int GREATER	= 3;
    	public static final int LESS	= 4;
    	public static final int PRESENT	= 5;
    	public static final int SUB	= 6;	// substring
    	public static final int EXT	= 7;	// extensible;	not supported

    	private final int	type;
    	private final String	name;
    	private final String	value;
    	private final Pattern	pattern;

    	private Item(int type, String attr)
    	{
    		this.type = type;
    		this.name = attr;
    		this.value = null;
    		this.pattern = null;
    	}

    	private Item(int type, String attr, String value)
    	{
    		this.type = type;
    		this.name = attr;
    		this.value = value;
    		this.pattern = null;
    	}

    	private Item(int type, String attr, Pattern pattern)
    	{
    		this.type = type;
    		this.name = attr;
    		this.value = null;
    		this.pattern = pattern;
    	}

    	/**
    	 * Parse a string representation of a filter item and create
    	 * an instance of {@link Item} for that.
    	 *
    	 * @param ba A byte sequence that represents a filter item.
    	 * @param off The offset from the head of <var>ba</var>.
    	 * @param len The length of bytes to be parsed.
    	 */
    	public static Item parse(byte[] ba, int off, int len)
	    throws ParseException
	    {
    		final int END = off + len;

    		// search the first appearence of '=' (ASCII 61)
    		int sep = -1;
    		for ( int i = off; i < END; i++ )
	    	{
    			if ( ba[i] == 61 )
    			{
    				sep = i;
    				break;
    			}
	    	}
    		if ( (sep - off) < 1 )
    			throw new ParseException("invalid search filter item");

    		int ltype = EQUAL;
    		int attrLen = sep - off;
    		switch ( ba[sep-1] )
    		{
    		case 126: // APPROX ~=
    			ltype = APPROX;
    			attrLen -= 1;
    			break;

    		case 62: // GREATER >=
    			ltype = GREATER;
    			attrLen -= 1;
    			break;

    		case 60: // LESS <=
    			ltype = LESS;
    			attrLen -= 1;
    			break;
    		}

    		// got attr
    		if ( attrLen < 1 )
    			throw new ParseException("empty attribute description in search filter");
    		String attr = null;
    		try {
    			attr = new String(ba, off, attrLen, "UTF8");
    		} catch ( UnsupportedEncodingException e ) {
    			// ignore it.
    		}

    		// parse value
    		final int noff = sep + 1;
    		final int valueLen = END - noff;

    		if ( ltype == EQUAL ) {
    			// '*' (ASCII 42)
    			if ( (valueLen == 1) && (ba[noff] == 42) ) {
    				return new Item(PRESENT, attr);
    			} else {
    				// search for '*'
    				boolean isPattern = false;
    				for ( int i = noff; i < END; i++ )
    				{
    					if ( ba[i] == 42 )
    					{
    						isPattern = true;
    						break;
    					}
    				}

    				if ( isPattern ) {
    					Pattern pattern = Pattern.parse(ba, noff, valueLen);
    					return new Item(SUB, attr, pattern);
    				} else {
    					String lvalue = decode(ba, noff, valueLen);
    					return new Item(EQUAL, attr, lvalue);
    				}
    			}

    		} else {
    			String lvalue = decode(ba, noff, valueLen);
    			return new Item(ltype, attr, lvalue);
    		}
	    }

    	private boolean match( String s )
    	{
    		switch ( type )
    		{
    		case EQUAL:
    		case APPROX:	// the same as EQUAL
    			return s.equalsIgnoreCase(value);

    		case GREATER:
    			return ( s.compareTo(value) >= 0 );

    		case LESS:
    			return ( s.compareTo(value) <= 0 );

    		case PRESENT:
    			return true;

    		case SUB:
    			return pattern.match( s );
    		}

    		return false;
    	}

    	public boolean match( Entry entry )
    	{
    		List attrs = entry.getAttributes( name );

    		Iterator it = attrs.iterator();
    		while ( it.hasNext() )
    		{
    			if ( match( (String)it.next() ) )
    				return true;
    		}

	    	return false;
    	}

    	public void toString( StringBuffer sb )
    	{
    		sb.append( name );
    		switch ( type )
    		{
    		case EQUAL:
    		case APPROX:
    			sb.append( '=' );
    			sb.append( value );
    			break;

    		case GREATER:
    			sb.append( ">=" );
    			sb.append( value );
    			break;

	    	case LESS:
	    		sb.append( "<=" );
	    		sb.append( value );
	    		break;

	    	case PRESENT:
	    		sb.append( "=*" );
	    		break;

	    	case SUB:
	    		sb.append( '=' );
	    		pattern.toString( sb );
	    		break;
    		}
    	}

    	public String toString()
    	{
    		StringBuffer sb = new StringBuffer();
    		toString( sb );
    		return sb.toString();
    	}
    }


    private FilterComp filter;

    /**
     * LDAP検索フィルターの文字列表現 <var>s</var> を解析して、結果 を表現するオブジェクトを作成する。
     * 
     * @param s 検索フィルター文字列
     * @throws ParseException 
     */
    public SearchFilter( String s )
	throws ParseException
    {
    	filter = FilterComp.parse( s );
    }

    /**
     * エントリ <var>entry</var> がこの検索フィルターに適合するか テストする。
     *
     * @return 適合した場合、またその時のみ <kbd>true</kbd>
     */
    public boolean match(Entry entry)
    {
    	return filter.match(entry);
    }

    /**
     * このオブジェクトの、RFC2254に規定される文字列表現を返す。
     * 
     * @return このオブジェクトの文字列表現
     */
    public String toString()
    {
    	return filter.toString();
    }


    // test
//     public static void main ( String[] args )
// 	throws ParseException
//     {
// 	// parse test
// 	SearchFilter sf;
// 	//sf = new SearchFilter( "(cn=Babs Jensen)" );
// 	sf = new SearchFilter( "(!(cn=Tim Howes))");
// 	//sf = new SearchFilter( "(&(objectclass=Person)(|(sn=Jensen)(cn=Babs J*)))");
// 	//sf = new SearchFilter( "(o=*of*mich*)");
// 	//sf = new SearchFilter( "(o=Parens R Us \\28for all your parenthetical needs\\29)" );
// 	//sf = new SearchFilter( "(cn=*\\2A*)");

// 	System.out.println( sf.toString() );
// 	System.out.println();

// 	// match test
// 	Entry entry = new Entry();
// 	//entry.addAttribute( new Attribute("cn", "Babs Jensen") );
// 	entry.addAttribute( new Attribute("cn", "Tim Howes") );
// 	entry.addAttribute( new Attribute("objectClass", "object") );
// 	entry.addAttribute( new Attribute("objectClass", "Person") );

// 	System.out.println( entry.toString() );

// 	System.out.println("match: " + sf.match( entry ) );
//     }
}
