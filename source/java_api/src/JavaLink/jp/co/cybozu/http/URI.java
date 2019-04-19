package jp.co.cybozu.http;

import java.net.*;
import java.util.*;
import java.io.*;

/**
 * J2SDK1.4.0 以降の URI クラスの制限版コンパチブルクラスです。
 *
 * @author サイボウズ
 * @version	1.0.0
 */
public class URI
{
    private String scheme;				// before ':'
    private String specific;			// after ':'
    private String authority;			// from '://' to the next '/'
    private String path;				// '/'
    private String query;				// after '?'
    private String fragment;			// after '#'

    private String userInfo;			// before '@' in authority
    private String host;				// the middle part in authority
    private int    port = -1;			// after ':' in authority

    private boolean opaque;
	
    private void parseAuthority (String auth)
	throws URISyntaxException
    {
    	if ( auth == null )
    		return;

    	int atPos = auth.indexOf('@');
    	String remain;
    	if ( atPos == -1 ) {
    		remain = auth;
    	} else {
    		userInfo = auth.substring(0, atPos);
    		remain = auth.substring(atPos + 1);
    	}

    	int colPos = remain.indexOf(':');
    	String portString = null;
    	if ( colPos == -1 ) {
    		host = remain;
    	} else {
    		host = remain.substring(0, colPos);
    		portString = remain.substring(colPos + 1);
    	}

    	if ( portString == null )
    		return;

    	try {
    		port = Integer.parseInt(portString);
    	} catch ( NumberFormatException e ) {
    		throw new URISyntaxException("illegal port number: " + portString);
    	}
    }

    private static String encode (String s)
    {
    	if ( s == null )
    		return null;

    	String encoded = null;

    	try {
    		encoded = URLEncoder.encode(s, "UTF8");
    	} catch ( UnsupportedEncodingException e ) {
    		// ignore it
    	}

    	return encoded;
    }

    private void parse (String s)
	throws URISyntaxException
    {
    	int idx = s.indexOf(':');

    	if ( idx == -1 )
    	{
    		// relative URI
    		opaque = false;
    		scheme = null;
    		authority = null;

    		idx = s.lastIndexOf('#');

    		if ( idx == -1 ) {
    			specific = s;
    			fragment = null;
    		} else {
    			specific = s.substring(0, idx);
    			fragment = s.substring(idx + 1);
    		}

    		idx = specific.indexOf('?');
    		if ( idx == -1 ) {
    			path = specific;
    			query = null;
    		} else {
    			path = specific.substring(0, idx);
    			query = specific.substring(idx + 1);
    		}

    		return;
    	}

    	scheme = s.substring(0, idx);
    	String remain = s.substring(idx + 1);

    	idx = remain.lastIndexOf('#');
    	if ( idx == -1 ) {
    		specific = remain;
    		fragment = null;
    	} else {
    		specific = remain.substring(0, idx);
    		fragment = remain.substring(idx + 1);
    	}

    	if ( (specific.length() > 2) &&
	         (specific.charAt(0) == '/') &&
	         (specific.charAt(1) == '/') ) {
    		opaque = false;
    		remain = specific.substring(2);
    	} else {
    		opaque = true;
    		authority = null;
    		path = null;
    		query = null;
    		return;
    	}

    	idx = remain.indexOf('/');
    	if ( idx == -1 )
    	{
    		authority = remain;
    		parseAuthority(authority);
    		path = null;
    		query = null;
    		return;
    	}

    	authority = remain.substring(0, idx);
    	parseAuthority(authority);
    	String pathAndQuery = remain.substring(idx);
    	idx = pathAndQuery.indexOf('?');
    	if ( idx == -1 ) {
    		path = pathAndQuery;
    		query = null;
    	} else {
    		path = pathAndQuery.substring(0, idx);
    		query = pathAndQuery.substring(idx + 1);
    	}

    	return;
    }

    /**
     * 指定された文字列を解析して URI を作成します。
     * 
     * @param scheme スキーマ名
     * @param specific 
     * @param fragment フラグメント
     */
    static URI create (String scheme, String specific, String fragment)
    {
    	StringBuffer sb = new StringBuffer();

    	if ( scheme != null )
    	{
    		sb.append(scheme);
    		sb.append(':');
    	}
    	if ( specific != null )
    	{
    		sb.append(specific);
    	}
    	if ( fragment != null )
    	{
    		sb.append('#');
    		sb.append(fragment);
    	}
    	return create(sb.toString());
    }

    /**
     * 指定された文字列を解析して URI を作成します。
     * 
     * @param scheme スキーマ名
     * @param authority 権限
     * @param path パス
     * @param query クエリー
     * @param fragment フラグメント
     */
    static URI create (String scheme, String authority, String path,
		       String query, String fragment)
    {
    	StringBuffer sb = new StringBuffer();
    	if ( scheme != null )
    	{
    		sb.append(scheme);
    		sb.append(':');
    	}
    	if ( authority != null )
    	{
    		sb.append("//");
    		sb.append(authority);
    	}
    	if ( path != null )
    	{
    		sb.append(path);
    	}
    	if ( query != null )
    	{
    		sb.append('?');
    		sb.append(query);
    	}
    	if ( fragment != null )
    	{
    		sb.append('#');
    		sb.append(fragment);
    	}

    	return create(sb.toString());
    }

    /**
     * 指定された文字列を解析して URI を作成します。
     * 
     * @param s URI に解析される文字列
     * @return 新しい URI 
     */
    public static URI create (String s)
    {
    	try {
    		return new URI(s);
    	} catch (URISyntaxException e) {
    		throw new IllegalArgumentException("Invalid URI: " + s);
    	}
    }

    /**
     * 指定された文字列を解析して URI を構築します。 
     * 
     * @param s URI に解析される文字列
     * @throws URISyntaxException 上記の変更で追加されたように、指定された文字列が RFC 2396 に違反している場合
     */
    public URI (String s)
	throws URISyntaxException
    {
    	parse(s);
    }
    
    /**
     * この抽象パス名が絶対かどうかを判定します。
     * 
     * @return この抽象パス名が絶対である場合は true、そうでない場合は false
     */
    public boolean isAbsolute ()
    {
    	return (scheme != null);
    }

    /**
     * この URI が不透明かどうかを通知します。 
     * 
     * @return この URI が不透明の場合だけ true
     */
    public boolean isOpaque ()
    {
    	return opaque;
    }

    /**
     * このメソッドのデフォルトの動作は、ラップされた要求オブジェクトに対し getScheme() を呼び出すことです。
     * 
     * @return この要求に使用されるスキーマの名前が格納された String
     */
    public String getScheme ()
    {
    	return scheme;
    }

    /**
     * サービス URL のホスト部分です。
     * 
     * @return サービス URL のホスト部分。null は不可
     */
    public String getHost ()
    {
    	return host;
    }

    /**
     * サービス URL のポートです。
     * 
     * @return サービス URL のポート。存在しない場合は 0

     */
    public int getPort ()
    {
    	return port;
    }

    /**
     * この URI のそのままのパスコンポーネントを返します。
     * 
     * @return この URI のパスコンポーネント。パスが未定義の場合は null
     */
    public String getRawPath ()
    {
    	return path;
    }

    /**
     * この URI のそのままのクエリーコンポーネントを返します。
     * 
     * @return この URI のそのままのクエリーコンポーネント。クエリーが未定義の場合は null
     */
    public String getRawQuery ()
    {
    	return query;
    }

    /**
     * この URI のパスを正規化します。
     * 
     * @param path パス
     * @param getDir
     * @return この URI と同等の URI。ただし、そのパスは正規形式
     */
    private String normalize (String path, boolean getDir)
    {
    	if ( path == null )
    		return null;

    	int len = path.length();
    	boolean absPath = false;
    	if ( (len > 0) &&
    		 (path.charAt(0) == '/') )
    	{
    		absPath = true;
    	}
    	boolean isDir = false;

    	StringTokenizer st = new StringTokenizer(path, "/", true);

    	int depth = 0;
    	int nBack = 0;
    	LinkedList pathComponents = new LinkedList();
    	while ( st.hasMoreTokens() )
    	{
    		String token = st.nextToken();

    		if ( token.equals("/") )
    		{
    			isDir = true;
    			continue;
    		}

    		if ( token.equals(".") )
    		{
    			continue;
    		}

    		if ( token.equals("..") )
    		{
    			if ( depth == 0 ) {
    				nBack ++;
    			} else {
    				depth --;
    				pathComponents.removeLast();
    			}
    			continue;
    		}

    		isDir = false;
    		depth ++;
    		pathComponents.addLast(token);
    	}

    	StringBuffer sb = new StringBuffer();

    	if ( absPath )
    	{
    		sb.append('/');
    	}

    	for ( int i = 0; i < nBack; i++ )
    	{
    		sb.append("../");
    	}

    	Iterator it = pathComponents.iterator();
    	while ( it.hasNext() )
    	{
    		sb.append((String)it.next());
    		if ( it.hasNext() )
    		{
    			sb.append('/');
    		}
    	}

    	len = sb.length();
    	if ( isDir && (len > 0) && (sb.charAt(len - 1) != '/') )
    	{
    		sb.append('/');
    	}

    	String normalized = sb.toString();
    	if ( getDir )
    	{
    		int idx = normalized.lastIndexOf('/');
    		if ( idx != -1 )
    		{
    			normalized = normalized.substring(0, idx + 1);
    		}
    	}

    	return normalized;
    }

    /**
     * この URI のパスを正規化します。
     * 
     * @return 結果の URI
     */
    public URI normalize ()
    {
    	if ( path == null )	// includes opaque cases
    		return this;

    	return create(scheme, authority, normalize(path, false),
    			query, fragment);
    }

    /**
     * 指定された URI をこの URI に対して解決します。
     * 
     * @param s この URI に対して解決される URI 
     * @return 結果の URI 
     */
    public URI resolve (String s)
    {
    	return resolve(create(s));
    }
    
    /**
     * 指定された URI をこの URI に対して解決します。
     * 
     * @param uri この URI に対して解決される URI 
     * @return 結果の URI 
     */
    public URI resolve (URI uri)
    {
    	if ( uri.isAbsolute() )	// includes opaque cases
    		return uri;
    	if ( (! isAbsolute()) || isOpaque() )
    		return uri;

    	// this is an absolute URI and <var>uri</var> is an relative URI.
    	// both are not opaque.

    	if ( uri.fragment != null )
    	{
    		if ( (uri.authority == null) &&
		         (uri.query == null) &&
		         ((uri.path == null) || (uri.path.length() == 0)) )
    			return create(scheme, authority, normalize(path, false),
    					query, uri.fragment);
    	}

    	if ( (path == null) ||
	       ( (uri.path != null) &&
	         (uri.path.length() > 0) &&
	         (uri.path.charAt(0) == '/') ) )
    	{
    		return create(scheme, authority, normalize(uri.path, false),
    				uri.query, uri.fragment);
    	}

    	//int len = path.length();
    	String dir = normalize(path, true);
    	return create(scheme, authority, normalize(dir + uri.path, false),
    			uri.query, uri.fragment);
    }

    /**
     * 指定された URI をこの URI に対して相対化します。
     * 
     * @param s この URI に対して相対化される URI 
     * @return 結果の URI 
     */
    public URI relativize (String s)
    {
    	return relativize(create(s));
    }
    
    /**
     * 指定された URI をこの URI に対して相対化します。
     * 
     * @param uri この URI に対して相対化される URI 
     * @return 結果の URI 
     */
    public URI relativize (URI uri)
    {
    	if ( isOpaque() || uri.isOpaque() )
    		return uri;
    	if ( (! scheme.equalsIgnoreCase(uri.scheme)) ||
	         (! authority.equals(uri.authority)) )
    		return uri;

    	if ( (path == null) || (uri.path == null) )
    		return uri;

    	String prefix = normalize(path, false);
    	String target = normalize(uri.path, false);
    	if ( ! target.startsWith(prefix) )
    		return uri;

    	String relPath = target.substring(prefix.length());
    	if ( (relPath.length() > 0) && (relPath.charAt(0) == '/') )
    		relPath = relPath.substring(1);
    	return create(null, null, relPath, uri.query, uri.fragment);
    }

    /**
     * この URI から URL を構築します。
     * 
     * @return この URI から構築された URL 
     * @throws MalformedURLException URL のプロトコルハンドラが発見できなかった場合、または URL の構築時にほかのエラーが発生した場合
     */
    public URL toURL ()
	throws MalformedURLException
    {
    	return new URL(toASCIIString());
    }

    /**
     * この URI のコンテンツを US-ASCII 文字列として返します。
     * 
     * @return この URI の文字列形式。必要に応じて、US-ASCII 文字セットの文字だけを含むように符号化される
     */
    public String toASCIIString ()
    {
    	StringBuffer sb = new StringBuffer();

    	if ( scheme != null )
    	{
    		sb.append(scheme);
    		sb.append(':');
    	}

    	if ( isOpaque() )
    	{
    		if ( specific != null )
    		{
    			sb.append(specific);
    		}
    		if ( fragment != null )
    		{
    			sb.append('#');
    			sb.append(encode(fragment));
    		}
    		return sb.toString();
    	}

    	if ( authority != null )
    	{
    		sb.append("//");
    		sb.append(authority);
    	}
    	if ( path != null )
    	{
    		sb.append(path);
    	}
    	if ( query != null )
    	{
    		sb.append('?');
    		sb.append(query);
    		
    	}
    	if ( fragment != null )
    	{
    		sb.append('#');
    		sb.append(encode(fragment));
    	}

    	return sb.toString();
    }

    /**
     * この URI のコンテンツを文字列として返します。
     * 
     * @return この URI の文字列形式
     */
    public String toString()
    {
    	return toASCIIString();
    }

    /**
     * この URI が別のオブジェクトと等しいかどうかを判定します。
     * 
     * @param o このオブジェクトと比較するオブジェクト 
     * @return 指定されたオブジェクトがこの URI と同じ URI である場合だけ true
     */
    public boolean equals (Object o)
    {
    	if ( (o == null) || (! (o instanceof URI)) )
    		return false;

    	URI uri = (URI)o;

    	if ( (scheme == null) && (uri.scheme != null) )
    		return false;
    	if ( (scheme != null) &&
	       (! scheme.equalsIgnoreCase(uri.scheme)) )
    		return false;

    	if ( isOpaque() )
    	{
    		if ( (specific == null) && (uri.specific != null) )
    			return false;
    		if ( (specific != null) &&
		       (! specific.equals(uri.specific)) )
    			return false;

    		if ( (fragment == null) && (uri.fragment != null) )
    			return false;
    		if ( (fragment != null) &&
		       (! fragment.equals(uri.fragment)) )
    			return false;

    		return true;
    	}

    	if ( (authority == null) && (uri.authority != null) )
    		return false;
    	if ( (authority != null) &&
	       (! authority.equals(uri.authority)) )
    		return false;

    	String norm1 = normalize(path, false);
    	String norm2 = normalize(uri.path, false);
    	if ( (norm1 == null) && (norm2 != null) )
    		return false;
    	if ( (norm1 != null) &&
	       (! norm1.equals(norm2)) )
    		return false;

    	if ( (fragment == null) && (uri.fragment != null) )
    		return false;
    	if ( (fragment != null) &&
	       (! fragment.equals(uri.fragment)) )
    		return false;

    	return true;
    }

    // test routines
    void dump ()
    {
    	System.err.println("Scheme: " + scheme);
    	System.err.println("Specific: " + specific);
    	System.err.println("Authority: " + authority);
    	System.err.println("UserInfo: " + userInfo);
    	System.err.println("Host: " + host);
    	System.err.println("Port: " + port);
    	System.err.println("Path: " + path);
    	System.err.println("Query: " + query);
    	System.err.println("Fragment: " + fragment);
    	System.err.println("Opaque: " + opaque);
    	System.err.println();
    }

//	public static void main (String[] args)
//	{
//		try {
//			URI a = new URI("http://devnt.dev.cybozu.co.jp/");
//			a.dump();
//			URI b = new URI("../foobar/zot.c?page=File#review");
//			b.dump();
//
//			URI c = a.resolve(b);
//			c.dump();
//			URI d = a.relativize(c);
//			d.dump();
//
//			URI e = new URI("/abc/def//../../ghi/./foo.c/");
//
//			e.normalize().dump();
//			URI f = new URI("http://ymmt@cybozu.co.jp:39/abc/#eof");
//			f.dump();
//
//		} catch (URISyntaxException e) {
//			e.printStackTrace();
//		}
//	}
}
