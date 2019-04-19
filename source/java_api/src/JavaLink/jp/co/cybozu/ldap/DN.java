package jp.co.cybozu.ldap;

import jp.co.cybozu.text.ParseException;
import java.util.*;
import java.io.*;


/**
 * RFC2253で規定された、LDAPの 識別名 (DN) を表現する。<br>
 * 識別名 (DN) は {@link RDN} のリストからなる。
 *
 * @author サイボウズ
 * @version	1.0.0
 * @see		<a href="http://www.ietf.org/rfc/rfc2253.txt">RFC2253</a>
 */
public class DN
{
    /**
     * Create a new DN with no RDN.
     */
    public DN () {}

    /**
     * RFC2253で規定された、識別名 (DN) の文字列表現 <var>s</var> を解析した 結果を表現する 識別名 (DN) を作成する。
     *
     * @see #parse
     */
    public DN (String s)
	throws ParseException
    {
    	parse(s);
    }

    private ArrayList rdns = new ArrayList(8);

    /**
     * この 識別名 (DN) を表現する RDN の、変更不可能なリストを返す。
     */
    public List getRDNs()
    {
    	return Collections.unmodifiableList( rdns );
    }

    /**
     * RFC2253で規定された 識別名 (DN) の文字列表現 <var>s</var> を解析する。
     * 
     * @param s 識別名 (DN) の文字列
     */
    public void parse( String s )
	throws ParseException
    {
    	try {
    		parse( s.getBytes( "UTF8" ) );
    	} catch ( UnsupportedEncodingException e ) {
    		// ignore it
    	}
    }

    private void parse( byte[] ba )
	throws ParseException
    {
    	// clear RDN list
    	rdns.clear();

    	// state variables
    	RDN rdn = null;

    	for ( int i = 0; i < ba.length; i++ )
    	{
    		// skip ASCII white space
    		if ( ba[i] == 32 )
    		{
    			continue;
    		}

    		boolean seenSeparator = false;
    		String key = null;
    		String value = null;
    		ByteArrayOutputStream o = null;

    		// reading attribute TYPE
    		o = new ByteArrayOutputStream();
    		o.write( ba[i++] & 0xFF );

    		for ( ; i < ba.length; i++ )
    		{
    			// if ' ' or '='
    			if ( (ba[i] == 32) || (ba[i] == 61) )
    			{
    				if ( ba[i] == 61 )
    					seenSeparator = true;
    				i++;
    				break;
    			}
    			o.write( ba[i] & 0xFF );
    		}

    		// skip ASCII white space
    		for ( ; i < ba.length; i++ )
    		{
    			if ( ba[i] == 32 )
    				continue;

    			if ( (! seenSeparator) && (ba[i] == 61) )
    			{
    				seenSeparator = true;
    				continue;
    			}
    			break;
    		}

    		// check syntax
    		if ( ! seenSeparator )
    		{
    			throw new ParseException("invalid DN syntax");
    		}

    		try {
    			key = o.toString( "UTF8" );
    		} catch ( UnsupportedEncodingException e ) {
    			// ignore it.
    		}

    		// reading attribute VALUE
    		o.reset();

    		// test first character is '#', if any
    		if ( (i < ba.length) && (ba[i] == 35) ) {
    			boolean bFirst = true;
    			byte b = 0;

    			// read hex string
    			for ( i = i + 1; i < ba.length; i++ )
    			{
    				if ( (ba[i] == 32) ||	// ' '
			             (ba[i] == 44) ||	// ','
			             (ba[i] == 43) )	// '+'
    				{
    					break;
    				}

    				b <<= 4;

    				// '0' - '9'
    				if ( (48 <= ba[i]) && (ba[i] <= 57) ) {
    					b |= ba[i] - 48;
    				} else if ( (65 <= ba[i]) && (ba[i] <= 70) ) {
    					b |= ba[i] - 65 + 10;
    				} else if ( (97 <= ba[i]) && (ba[i] <= 102) ) {
    					b |= ba[i] - 97 + 10;
    				} else {
    					throw new ParseException("invalid character in hex string");
    				}

    				if ( bFirst ) {
    					bFirst = false;
    				} else {
    					o.write( b & 0xFF );
    					b = 0;
    					bFirst = true;
    				}
    			}

    			if ( ! bFirst )
    				throw new ParseException("invalid DN syntax");
    		} else {
    			// parsing normal string
    			boolean escaping = false;
    			int n_spaces = 0;

    			for ( ; i < ba.length; i++ )
    			{
    				if ( escaping )
    				{
    					if ( (48 <= ba[i]) && (ba[i] <= 57) ) {
    						int b = ba[i++] - 48;
    						if ( i == ba.length )
    						{
    							throw new ParseException("invalid DN syntax");
    						}

    						b <<= 4;
    						if ( (48 <= ba[i]) && (ba[i] <= 57) ) {
    							b |= ba[i] - 48;
    						} else if ( (65 <= ba[i]) && (ba[i] <= 70) ) {
    							b |= ba[i] - 65 + 10;
    						} else if ( (97 <= ba[i]) && (ba[i] <= 102) ) {
    							b |= ba[i] - 97 + 10;
    						} else {
    							throw new ParseException("invalid character in hex string");
    						}

    						for ( int j = 0; j < n_spaces; j++ )
    						{
    							o.write( 32 );
    						}
    						n_spaces = 0;
    						o.write( b & 0xFF );
    					} else if ( (65 <= ba[i]) && (ba[i] <= 70) ) {
    						int b = ba[i++] - 65 + 10;
    						if ( i == ba.length )
    						{
    							throw new ParseException("invalid DN syntax");
    						}

    						b <<= 4;
    						if ( (48 <= ba[i]) && (ba[i] <= 57) ) {
    							b |= ba[i] - 48;
    						} else if ( (65 <= ba[i]) && (ba[i] <= 70) ) {
    							b |= ba[i] - 65 + 10;
    						} else if ( (97 <= ba[i]) && (ba[i] <= 102) ) {
    							b |= ba[i] - 97 + 10;
    						} else {
    							throw new ParseException("invalid character in hex string");
    						}

    						for ( int j = 0; j < n_spaces; j++ )
    						{
    							o.write( 32 );
    						}
    						n_spaces = 0;
    						o.write( b & 0xFF );
    					} else if ( (97 <= ba[i]) && (ba[i] <= 102) ) {
    						int b = ba[i++] - 97 + 10;
    						if ( i == ba.length )
    						{
    							throw new ParseException("invalid DN syntax");
    						}

    						b <<= 4;
    						if ( (48 <= ba[i]) && (ba[i] <= 57) ) {
    							b |= ba[i] - 48;
    						} else if ( (65 <= ba[i]) && (ba[i] <= 70) ) {
    							b |= ba[i] - 65 + 10;
    						} else if ( (97 <= ba[i]) && (ba[i] <= 102) ) {
    							b |= ba[i] - 97 + 10;
    						} else {
    							throw new ParseException("invalid character in hex string");
    						}

    						for ( int j = 0; j < n_spaces; j++ )
    						{
    							o.write( 32 );
    						}
    						n_spaces = 0;
    						o.write( b & 0xFF );
    					} else {
    						for ( int j = 0; j < n_spaces; j++ )
    						{
    							o.write( 32 );
    						}
    						n_spaces = 0;
    						o.write( ba[i] & 0xFF );
    					}

    					escaping = false;
    					continue;
    				}

    				if ( ba[i] == '\\' )
    				{
    					escaping = true;
    					continue;
    				}

    				if ( ba[i] == 32 )
    				{
    					n_spaces++;
    					continue;
    				}

    				if ( (ba[i] == 44) ||	// ','
			             (ba[i] == 43) )	// '+'
    				{
    					break;
    				}

    				for ( int j = 0; j < n_spaces; j++ )
    				{
    					o.write( 32 );
    				}
    				n_spaces = 0;
    				o.write( ba[i] & 0xFF );
    			}
    		}

    		// get value
    		try {
    			value = o.toString( "UTF8" );
    		} catch ( UnsupportedEncodingException e ) {
    			// ignore it.
    		}

    		Attribute attr = new Attribute(key, value);
    		if ( rdn == null )
    		{
    			rdn = new RDN();
    		}
    		rdn.addComponent( attr );

    		// EOL or ','
    		if ( (i == ba.length) || (ba[i] == 44) )
    		{
    			rdns.add( rdn );
    			rdn = null;
    		}
    	}
    }

    /**
     * もしこの 識別名 (DN) が <var>dn</var> の親エントリを表す場合、またその時のみ <kbd>true</kbd> を返す
     * 
     * @param dn 識別名 (DN)
     */
    public boolean isParent(DN dn)
    {
    	int NDIFF = dn.rdns.size() - rdns.size();
    	if ( NDIFF != 1 )
    		return false;

    	Iterator it1 = dn.rdns.iterator();
    	it1.next();

    	Iterator it2 = rdns.iterator();

    	while ( it1.hasNext() )
    	{
    		if ( ! it1.next().equals( it2.next() ) )
    			return false;
    	}

    	return true;
    }

    /**
     * もしこの 識別名 (DN) が <var>dn</var> より上の位置のエントリであれば、 またその時のみ <kbd>true</kbd> を返す
     * 
     * @param dn 識別名 (DN)
     */
    public boolean isAncestor(DN dn)
    {
    	int NDIFF = dn.rdns.size() - rdns.size();
    	if ( NDIFF < 0 )
    		return false;

    	Iterator it1 = dn.rdns.iterator();
    	Iterator it2 = rdns.iterator();

    	for ( int i = 0; i < NDIFF; i++ )
    	{
    		it1.next();
    	}

    	while ( it1.hasNext() )
    	{
    		if ( ! it1.next().equals( it2.next() ) )
    			return false;
    	}

    	return true;
    }

    /**
     * もしこの 識別名 (DN) が <var>dn</var> の子エントリを表す場合、またその時のみ <kbd>true</kbd> を返す。
     * 
     * @param dn 識別名 (DN)
     */
    public boolean isChild(DN dn)
    {
    	return dn.isParent(this);
    }

    /**
     * もしこの 識別名 (DN) が <var>dn</var> より下の位置のエントリであれば、 またその時のみ <kbd>true</kbd> を返す
     * 
     * @param dn 識別名 (DN)
     */
    public boolean isDescendant(DN dn)
    {
    	return dn.isAncestor(this);
    }

    /**
     * RFC2253で規定された、この 識別名 (DN) の文字列表現を返す。
     *
     * @return 文字列表現
     * @see <a href="http://www.ietf.org/rfc/rfc2253.txt">RFC2253</a>
     */
    public String toString()
    {
    	StringBuffer sb = new StringBuffer();

    	boolean needComma = false;
    	Iterator it = rdns.iterator();
    	while ( it.hasNext() )
    	{
    		if ( needComma )
    		{
    			sb.append( ',' );
    		}

    		RDN rdn = (RDN)it.next();
    		rdn.toString( sb );

    		needComma = true;
    	}

    	return sb.toString();
    }

    /**
     * このオブジェクトを指定されたオブジェクトと比較します。結果が true になるのは、引数が null ではなく、このオブジェクトと同じ int 値を含む Integer オブジェクトである場合だけです。
     * 
     * @param o 比較対象のオブジェクト
     * @return オブジェクトが同じである場合は true、そうでない場合は false
     */
    public boolean equals( Object o )
    {
    	if ( ! ( o instanceof DN ) )
    		return false;

    	DN dn = (DN)o;

    	return rdns.equals( dn.rdns );
    }

    /**
     * Integer のハッシュコードを返します。 
     * 
     * @return このオブジェクトのハッシュコード値。この Integer オブジェクトが表すプリミティブ型 int 値に等しい
     */
    public int hashCode()
    {
    	return rdns.hashCode();
    }

    // test main
//     public static void main (String[] args)
// 	throws ParseException
//     {
// 	DN dn = new DN();

// 	dn.parse("cn=ｻｳﾋﾜ ﾂﾙｱｧ , o= Widget  Inc.,c=US");
// 	System.out.println( dn.toString() );

// 	DN dn2 = new DN("cn=ｻｳﾋﾜ ﾂﾙｱｧ ,o= Widget  Inc.,c=US");
// 	System.out.println( dn2.toString() );

// 	if ( dn.equals( dn2 ) ) {
// 	    System.out.println("dn == dn2");
// 	} else {
// 	    System.out.println("dn != dn2");
// 	}

// 	if ( dn.isAncestor( dn2 ) ) {
// 	    System.out.println("dn is ancestor of dn2");
// 	} else {
// 	    System.out.println("dn is NOT ancestor of dn2");
// 	}
//     }
}
