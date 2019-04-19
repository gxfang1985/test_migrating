/* Cookies.java */
package jp.co.cybozu.http;

import java.io.*;
import java.util.*;
import java.text.*;

/**
 * Represents an HTTP cookie.
 *
 * @author サイボウズ
 * @version	1.0.0
 */
class Cookie
{
    private final String dateFormat = "EEEE, dd-MMM-yy HH:mm:ss z";

    final String	name;
    final String	value;
    final URI		path;
    final Date		expireDate;

    private static String decode (String s)
    {
    	String decoded = null;
    	try {
    		decoded = URLDecoder.decode(s, "Shift_JIS");
    	} catch ( UnsupportedEncodingException e ) {
    		// ignore it
    	}
    	return decoded;
    }

    /**
     * 指定された名前と値を持つクッキーを構築します。
     * 
     * @param name クッキーの名前を指定する
     * @param value クッキーの値を指定する
     * @param path
     * @param expireDate
     */
    public Cookie (String name, String value, URI path, Date expireDate)
    {
    	this.name = name;
    	this.value = value;
    	this.path = path;
    	this.expireDate = expireDate;
    }

    /**
     * Constructs a cookie by parsing setCookie string that is a
     * value of a Set-Cookie: header.
     *
     * @param setCookie A string value of a Set-Cookie: header.
     * @param root The URI to which this cookie belong.
     */
    public Cookie (String setCookie, URI root)
    {
    	int eqPos = setCookie.indexOf('=');
    	if ( eqPos == -1 )
    		throw new IllegalArgumentException("invalid header: " + setCookie);

    	name = decode(setCookie.substring(0, eqPos));
    	root = root.resolve(".");

    	final int sepPos = setCookie.indexOf(';');
    	if ( sepPos == -1 )
    	{
    		value = decode(setCookie.substring(eqPos + 1));
    		path = root;
    		expireDate = null;
    		return;
    	}
    	value = decode(setCookie.substring(eqPos + 1, sepPos));

    	int domPos = setCookie.indexOf("domain=", sepPos + 1);
    	String domain;
    	if ( domPos == -1 ) {
    		domain = root.getHost();
    	} else {
    		int termPos = setCookie.indexOf(';', domPos);
    		if ( termPos == -1 ) {
    			domain = setCookie.substring(domPos + 7);
    		} else {
    			domain = setCookie.substring(domPos + 7, termPos);
    		}

    		// sanity check
            // 2010/03/15 RFC に準拠した Cookie を保存できない場合がある (新不具合管理 333)
    		if ( ! root.getHost().endsWith(domain) )
    		{
    			throw new IllegalArgumentException("invalid domain specification: " + setCookie);
    		}
    	}

    	int pathPos = setCookie.indexOf("path=", sepPos + 1);
    	if ( pathPos == -1 ) {
    		path = URI.create(root.getScheme(), domain, root.getRawPath(),
			      null, null);
    	} else {
    		int termPos = setCookie.indexOf(';', pathPos);
    		String pathString;
    		if ( termPos == -1 ) {
    			pathString = setCookie.substring(pathPos + 5);
    		} else {
    			pathString = setCookie.substring(pathPos + 5, termPos);
    		}
    		path = URI.create(root.getScheme(), domain, pathString, null, null);
    	}

    	int expirePos = setCookie.indexOf("expires=", sepPos + 1);
    	if ( expirePos == -1 ) {
    		expireDate = null;
    	} else {
    		int termPos = setCookie.indexOf(';', expirePos);
    		SimpleDateFormat df = new SimpleDateFormat(dateFormat, Locale.US);

    		try {
    			if ( termPos == -1 ) {
    				expireDate = df.parse(setCookie.substring(expirePos + 8));
    			} else {
    				expireDate = df.parse(setCookie.substring(expirePos + 8, termPos));
    			}
    		} catch ( ParseException e ) {
    			throw new IllegalArgumentException("illegal expiration date: " + setCookie);
    		}
    	}
    }

    /**
     * この StringBuffer の値を表す String オブジェクトを返します。
     */
    public String toString ()
    {
    	StringBuffer buf = new StringBuffer();
    	buf.append("Cookie: ");
    	buf.append(name);
    	buf.append('=');
    	buf.append(value);
    	buf.append("; path=");
    	buf.append(path.toASCIIString());

    	if ( expireDate != null )
    	{
    		buf.append("; expires=");

    		SimpleDateFormat df = new SimpleDateFormat(dateFormat, Locale.US);
    		df.setTimeZone(TimeZone.getTimeZone("GMT"));
    		buf.append(df.format(expireDate));
    	}
    	return buf.toString();
    }

    /**
     * このオブジェクトと他のオブジェクトが等しいかどうかを示します。
     */
    public boolean equals (Object o)
    {
    	if ( ! ( o instanceof Cookie ) )
    		return false;

    	Cookie c = (Cookie)o;

    	if ( ! path.equals(c.path) )
    		return false;

    	if ( ! name.equals(c.name) )
    		return false;

    	return true;
    }

    /**
     * オブジェクトのハッシュコード値を返します。
     */
    public int hashCode ()
    {
    	String hashString = path.toString() + "+" + name;
    	return hashString.hashCode();
    }
}


/**
 * HTTP Cookie のレポジトリを実装します. Set-Cookie ヘッダで指定された内容を解釈して保存する機能と、特定の URI 用の Cookie ヘッダを作成する機能を有します。しかし、現在のレポジトリの内容をディスクに保存する機能を持たないので、事実上セッション Cookie の保持にしか使えません。
 * <br>
 * このレポジトリには複数のスレッドから同時にアクセス可能です。 
 *
 * @author サイボウズ
 * @version	1.0.0
 */
public class Cookies
{
    /**
     * 空の Cookie レポジトリを作成します。
     */
    public Cookies () {}

    /**
     * Cookie を保持する内部構造
     */
    protected final Set cookies = new HashSet();

    private static String encode (String s)
    {
    	String encoded = null;
    	try {
    		encoded = URLEncoder.encode(s, "Shift_JIS");
    	} catch ( UnsupportedEncodingException e ) {
    		// ignore it
    	}
    	return encoded;
    }

    /**
     * Set-Cookie ヘッダで指定された Cookie をレポジトリに追加あるいは更新します。
     *
     * @param cookieString "Set-Cookie" HTTP ヘッダの値
     * @param path HTTP リクエストした際に使用した URI
     * @return Cookie を受容した場合、<kbd>true</kbd>。拒否した場合 <kbd>false</kbd>。
     */
    public boolean setCookie (String cookieString, URI path)
    {
    	if ( cookieString == null )
    		throw new NullPointerException("cookieString is null.");
    	if ( path == null )
    		throw new NullPointerException("path is null.");
    	if ( ! path.isAbsolute() )
    		throw new IllegalArgumentException("path is not an absolute URI: " + path.toASCIIString());

    	Cookie cookie = null;
    	try {
    		cookie = new Cookie(cookieString, path);
    	} catch ( IllegalArgumentException e ) {
    		return false;
    	}
    	Date now = new Date();

    	synchronized (this)
    	{
    		cookies.remove(cookie);
    		if ( (cookie.expireDate == null) ||
		         (now.compareTo(cookie.expireDate) < 0) )
    		{
    			cookies.add(cookie);
    		}
    	}
    	return true;
    }

    /**
     * 現在のレポジトリから、指定された URI 向けの Cookie を作成します。
     * <var>uri</var> の存在するドメイン向け Cookie を全て結合し、またエスケープが必要な文字は適切に URL エンコードした結果を文字列として返します。
     *
     * @param uri Cookie を発行する URI
     * @return "Cookie" HTTP ヘッダ用の文字列
     */
    public synchronized String getCookie (URI uri)
    {
    	if ( uri == null )
    		throw new NullPointerException("uri is null.");
    	if ( ! uri.isAbsolute() )
    		throw new IllegalArgumentException("uri is not absolute: " + uri.toASCIIString());

    	String host = uri.getHost();
    	String path = uri.getRawPath();		// maybe NULL
    	StringBuffer buf = new StringBuffer();

    	// append all cookies to which domain URI belongs.
    	Iterator it = cookies.iterator();
    	while ( it.hasNext() )
    	{
    		Cookie cookie = (Cookie)it.next();

    		String domain = cookie.path.getHost();
            // 2010/03/15 RFC に準拠した Cookie を保存できない場合がある (新不具合管理 333)
    		if ( ! host.endsWith(domain) )
    			continue;

    		String tPath = cookie.path.getRawPath();
    		if ( tPath != null )
    		{
    			if ( path == null )
    				continue;
    			if ( ! path.startsWith(tPath) )
    				continue;
    		}

    		buf.append(encode(cookie.name));
    		buf.append('=');
    		buf.append(encode(cookie.value));
    		buf.append("; ");
    	}
    	return buf.toString();
    }

    /**
     * 有効期限の過ぎた Cookie と、セッション Cookie をレポジトリから取り除きます。
     */
    public synchronized void clean ()
    {
    	Date now = new Date();

    	Iterator it = cookies.iterator();
    	while ( it.hasNext() )
    	{
    		Cookie cookie = (Cookie)it.next();

    		if ( ( cookie.expireDate == null ) ||
		         ( now.compareTo(cookie.expireDate) >= 0 ) )
    		{
    			it.remove();
    		}
    	}
    }

    /* test routines. */
//     synchronized void dump ()
//     {
// 	Iterator it = cookies.iterator();
// 	while ( it.hasNext() )
// 	{
// 	    Cookie cookie = (Cookie)it.next();
// 	    System.out.println(cookie);
// 	}
//     }

//     public static void main (String[] args)
// 	throws URISyntaxException
//     {
// 	URI uri  = new URI("http://hyamamoto.dev.cybozu.co.jp");
// 	URI uri2 = new URI("http://devnt.dev.cybozu.co.jp/scripts/cbgas/gas.exe");
// 	Cookies cookies = new Cookies();
// 	cookies.setCookie("_Login=+351", uri);
// 	cookies.setCookie("_Login=XXXX", uri);
// 	cookies.setCookie("_Login=aiueo", uri2);
// 	cookies.setCookie("MyName=79394; path=/scripts/cbgr/", uri);
// 	cookies.setCookie("BizID=39938289293; expires=Wed, 04-Dec-2002 09:08:36 GMT", uri2);
// 	cookies.setCookie("ABC=123", new URI("http://www.jp/aaa"));

// 	cookies.dump();

// 	System.err.println("------------------------------------------------------------------------");
// 	System.err.println(cookies.getCookie(new URI("http://aiueo.www.jp/")));

// 	return;
//     }
}
