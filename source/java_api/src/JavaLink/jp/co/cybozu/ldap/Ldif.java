/* Ldif.java */
package jp.co.cybozu.ldap;

import jp.co.cybozu.text.*;
import java.io.*;
import java.util.*;
import java.net.URL;


/**
 * LDIF ファイルの内容を表現する。<br>
 * すなわち、LDIF ファイルのバージョンと 含まれるエントリの森を持つ。<br>
 * さらに、LDIF ファイルを解析して読み込む機能 も提供する。
 *
 * @author サイボウズ
 * @version	1.0.0
 * @see		<a href="http://www.ietf.org/rfc/rfc2849.txt">RFC2849</a>
 */
public class Ldif
{
    private class ConcatReader extends LineNumberReader
    {
    	public ConcatReader(Reader r)
    	{
    		super(r);
    	}

    	public ConcatReader(Reader r, int sz)
    	{
    		super(r, sz);
    	}

    	private String nextLine	= null;
    	private boolean eofReached	= false;

    	public String readLine()
	    throws IOException
	    {
    		StringBuffer sb = new StringBuffer();

    		if ( nextLine != null ) {
    			sb.append( nextLine );
    			nextLine = null;
    		} else {
    			if ( eofReached )
    			{
    				return null;
    			}

    			String line = super.readLine();
    			if ( line == null )
    			{
    				eofReached = true;
    				return null;
    			}
    			sb.append( line );
    		}

    		while ( ! eofReached )
    		{
    			nextLine = super.readLine();

    			if ( nextLine == null ) {
    				eofReached = true;
    			} else {
    				if ( (nextLine.length() > 0) &&
			             (nextLine.charAt(0) == ' ') ) {
    					sb.append( nextLine.substring(1) );
    					continue;
    				} else {
    					break;
    				}
    			}
    		}
    		return sb.toString();
	    }

    	public int getLineNumber()
    	{
    		int nl = super.getLineNumber();
    		return (nextLine == null) ? nl : nl - 1;
    	}

    	public boolean ready()
	    throws IOException
	    {
    		if ( nextLine != null ) return true;
    		if ( eofReached ) return false;
    		return super.ready();
	    }
    }

    // The LDIF version.  Currently, only 1 is legitimate and therefore
    // is the default.
    private int version = 1;

    /**
     * このオブジェクトが表現する LDIF のバージョン番号を返す。<br>
     * 現在は 1 しか規定されていないため、常に 1 が返る。
     * 
     * @return 1を返す。
     */
    public int getVersion()
    {
    	return version;
    }

    /**
     * この LDIF オブジェクトが持つエントリのリスト 
     */
    protected final List entries = new ArrayList(4096);

    /** 
     * DN -> Entry のマッピング  
     */
    protected final Map dnToEntry = new HashMap();

    /**
     * この LDIF オブジェクトに新たにエントリを追加する。<br>
     * エントリの森を再構築するには、{@link #resolveRelation} を呼び出す必要がある。
     *
     * @param entry 追加するエントリ
     */
    public void addEntry(Entry entry)
    {
    	entries.add( entry );
    	dnToEntry.put( entry.getDN(), entry );
    }

    /**
     * <var>dn</var> で指定されたエントリを返す。
     *
     * @param dn エントリの 識別名 (DN)
     * @return エントリ、もしなければ <kbd>null</kbd>
     */
    public Entry getEntry( DN dn )
    {
    	return (Entry)dnToEntry.get( dn );
    }

    /** Hold roots of entry trees. */
    protected final Entry root = new Entry();

    /**
     * エントリの森の、それぞれの木のルートの、変更不可能なリストを返す。
     */
    public List getRootEntries()
    {
    	return Collections.unmodifiableList( root.getChildren() );
    }

    /**
     * LDIF オブジェクトを作成する。
     *
     * @param version LDIF のバージョン. 現在は必ず 1 を指定する。
     */
    public Ldif( int version )
    {
    	this.version = version;
    }

    /**
     * LDIF ファイルを <var>in</var> から読み込んで、LDIF オブジェクト を作成する。
     *
     * @param in LDIFファイルの内容を読み込むストリーム
     * @throws IOException 通信エラーが発生
     * @throws ParseException 読み込んだ LDIF ファイルの内容にエラーがある 
     */
    public Ldif( InputStream in )
	throws IOException, ParseException
    {
    	this(in, "UTF8" );
    }

    /**
     * LDIF ファイルを <var>in</var> から読み込んで、LDIF オブジェクト を作成する。
     * LDIFファイル内の文字列を標準(ASCII)以外で記述していても、<var>enc</var> で指定して読み込むことができる。
     *
     * @param in LDIFファイルの内容を読み込むストリーム
     * @param enc LDIFファイル内の文字列のキャラクタエンコーディング 
     * @throws IOException 通信エラーが発生
     * @throws ParseException 読み込んだ LDIF ファイルの内容にエラーがある。
     */
    public Ldif( InputStream in, String enc )
	throws IOException, ParseException
    {
    	LineNumberReader r =
    		new ConcatReader( new InputStreamReader( in, enc ) );

    	Entry entry = null;
    	while ( true )
    	{
    		String l = r.readLine();
    		if ( l == null )
    		{
    			break;
    		}

    		try {
    			entry  = parseLine( l.toCharArray(), entry );
    		} catch ( ParseException e ) {
    			e.setLineNumber( r.getLineNumber() );
    			throw e;
    		} catch ( IOException e ) {
    			System.err.println( "ignore line " + r.getLineNumber() +
				    " that issues:");
    			System.err.println( e.toString() );
    		}

    	}

    	if ( entry != null )
    	{
// 	    	System.err.println("New Entry");
// 	    	System.err.println( entry.toString() );
    		addEntry( entry );
		}

    	resolveRelation();
    }

    /**
     * LDIFファイル内のエントリの親子関係を解決する. 別名(alias)も同時に解決する。
     *
     * @throws ParseException 別名(alias)の解決に失敗した。
     */
    public void resolveRelation()
	throws ParseException
    {
    	Set entrySet = new HashSet( entries );

    	Iterator it = entries.iterator();
    	while ( it.hasNext() )
    	{
    		Entry e = (Entry)it.next();
    		root.addChild( e );
    		e.resolveAlias( dnToEntry );
    	}

    	it = entries.iterator();
    	while ( it.hasNext() )
    	{
    		Entry e1 = (Entry)it.next();

    		Iterator it2 = entrySet.iterator();
    		while ( it2.hasNext() )
    		{
    			Entry e2 = (Entry)it2.next();
    			if ( e1.isParent( e2 ) )
    			{
    				e1.addChild( e2 );
    			}
    		}
    	}
    }

    private Entry parseLine( char[] ca, Entry entry )
	throws IOException, ParseException
    {
    	int i = 0;

    	// skip leading white spaces (out of spec.)
    	for ( ; i < ca.length; i++ )
    	{
    		if ( ! Character.isWhitespace( ca[i] ) )
    			break;
    	}

    	if ( i == ca.length )
    	{
    		if ( entry != null )
    		{
// 				System.err.println("New Entry");
// 				System.err.println( entry.toString() );
    			addEntry( entry );
    		}

    		entry = null;
    		return null;
    	}

    	// read attribute type
    	StringBuffer sbName = new StringBuffer();
    	for ( ; i < ca.length; i++ )
    	{
    		if ( (ca[i] == ';') || (ca[i] == ':') )
    			break;
    		sbName.append( ca[i] );
    	}

    	if ( sbName.length() == 0 )
    		throw new ParseException("empty attribute type");

    	// read options
    	List options = null;
    	while ( (i < ca.length) && (ca[i] == ';') )
    	{
    		if ( options == null )
    			options = new LinkedList();

    		StringBuffer sbOption = new StringBuffer();
    		for ( i = i + 1; i < ca.length; i++ )
    		{
    			if ( (ca[i] == ';') || (ca[i] == ':') )
    				break;
    			sbOption.append( ca[i] );
    		}

    		if ( sbOption.length() == 0 )
    			throw new ParseException("empty attribute option");

    		options.add( sbOption.toString() );
    	}

    	// skip ':'
    	i++;

    	if ( i == ca.length )
    		throw new ParseException("syntax error");

    	boolean inBase64 = false;
    	boolean inURL = false;

    	// check if the value is encoded in Base64, or should be
    	// imported from an external resource located by an URL.
    	if ( ca[i] == ':' ) {
    		i++;
    		inBase64 = true;
    	} else if ( ca[i] == '<' ) {
    		i++;
    		inURL = true;
    	}

    	// skip fill spaces
    	for ( ; i < ca.length; i++ )
    	{
    		if ( ca[i] != ' ' )
    			break;
    	}

    	StringBuffer sbValue = new StringBuffer();
    	for ( ; i < ca.length; i++ )
    	{
    		sbValue.append( ca[i] );
    	}

    	String name = sbName.toString();
    	String valueData = sbValue.toString();

    	// handle "version:" line (extended spec)
    	if ( (entry == null) && name.equals( "version" ) )
    	{
    		try {
    			version = Integer.parseInt( valueData );
    		} catch ( NumberFormatException e ) {
    			throw new ParseException("invalid version: " + valueData);
    		}

    		return null;
    	}

    	// new entry
    	if ( (entry == null) && name.equals( "dn" ) )
    	{
    		if ( inURL )
    			throw new ParseException("invalid DN syntax");

    		String dnspec = valueData;
    		if ( inBase64 )
    		{
    			dnspec = new String(Base64.decode(valueData), "UTF8");
    		}

    		return new Entry( new DN( dnspec ) );
    	}

    	// an attribute
    	if ( entry == null )
    		throw new ParseException("illegal attribute declaration");

    	Attribute attr;
    	if ( inBase64 ) {
    		attr = new Attribute(name, Base64.decode(valueData), options);
    	} else if ( inURL ) {
    		attr = new Attribute(name, new URL(valueData), options);
    	} else {
    		attr = new Attribute(name, valueData, options);
    	}

    	entry.addAttribute( attr );
    	return entry;
    }

    /**
     * この LDIF オブジェクトの内容を LDIF 形式で書き出す。
     *
     * @param o ライター
     */
    public void dump( PrintWriter o )
    {
    	// put version
    	o.println("version: " + version);

    	Iterator it = getRootEntries().iterator();
    	while ( it.hasNext() )
    	{
    		o.println();
    		((Entry)it.next()).dump(o);
    	}
    }

//     public static void main( String[] args )
// 	throws IOException, ParseException
//     {
// 	if ( args.length < 1 )
// 	{
// 	    System.err.println("too few arguments.");
// 	    return;
// 	}

// 	Ldif ldif = new Ldif( new FileInputStream( args[0] ) );
// 	PrintWriter o =new PrintWriter(
// 			   new BufferedWriter(
// 			       new OutputStreamWriter( System.out ) ) );
// 	ldif.dump(o);
// 	o.close();
//     }
}
