package jp.co.cybozu.ldap;

import jp.co.cybozu.text.Base64;
import java.io.*;
import java.util.*;
import java.net.*;

/**
 * LDAPの属性(Attribute)を表現する。<br>
 * データメンバーは全て変更不可能(immutable)である。
 *
 * @author サイボウズ
 * @version	1.0.0
 */
public class Attribute
{
    /**
     * 属性名 
     */
    public final String	type;

    /** 
     * 属性値  
     */
    public final String	value;

    /**
     * この属性に付加されているオプションの、変更不可能なリスト。
     */
    public final List	options;

    /**
     * 新たに属性を作成する。
     *
     * @param type 属性名
     * @param value 属性値
     */
    public Attribute(String type, String value)
    {
    	this(type, value, null);
    }

    /**
     * 新たに属性を作成する。
     *
     * @param type 属性名
     * @param value 属性値
     * @param options 属性に付加されているオプションのリスト
     */
    public Attribute(String type, String value, List options)
    {
    	this.type = type;
    	this.value = value;
    	if ( options != null ) {
    		this.options = Collections.unmodifiableList( options );
    	} else {
    		this.options = null;
    	}
    }

    /**
     * 新たに属性を作成する。
     *
     * @param type 属性名
     * @param value 属性値
     */
    public Attribute(String type, byte[] value)
    {
    	this(type, value, null);
    }

    /**
     * 新たに属性を作成する。
     *
     * @param type 属性名
     * @param value 属性値
     * @param options 属性に付加されているオプションのリスト
     */
    public Attribute(String type, byte[] value, List options)
    {
    	this.type = type;
    	if ( options != null ) {
    		this.options = Collections.unmodifiableList( options );
    	} else {
    		this.options = null;
    	}

    	String tv = null;
    	try {
    		tv = new String(value, "UTF8");
    	} catch ( UnsupportedEncodingException e ) {
    		// ignore it.
    	}
    	this.value = tv;
    }

    /**
     * 新たに属性を作成する. 属性値は <var>url</var> で指定された URL から取得される。
     *
     * @param type 属性名
     * @param url 属性値のデータソース
     */
    public Attribute(String type, URL url)
	throws IOException
    {
    	this(type, url, null);
    }

    /**
     * 新たに属性を作成する. 属性値は <var>url</var> で指定された URL から取得される。 
     *
     * @param type 属性名
     * @param url 属性値のデータソース
     * @param options 属性に付加されているオプションのリスト
     * @throws IOException 通信エラーが発生した
     */
    public Attribute(String type, URL url, List options)
	throws IOException
    {
    	this.type = type;
    	if ( options != null ) {
    		this.options = Collections.unmodifiableList( options );
    	} else {
    		this.options = null;
    	}

    	ByteArrayOutputStream o = new ByteArrayOutputStream();
    	InputStream in = url.openStream();
    	byte[] buf = new byte[1024];
    	while ( true )
    	{
    		int nread = in.read(buf);
    		if ( nread == -1 )
    		{
    			in.close();
    			break;
    		}

    		o.write( buf, 0, nread );
    	}

    	this.value = o.toString( "UTF8" );
    }

    /**
     * この属性の文字列表現を返す。<br>
     * 結果の文字列は人間にとって見易い形式で、厳密な文法はない。<br>
     * 厳密に定義された形式の文字列表現には {@link #toEscapedString} あるいは {@link #toLdif} を使用せよ。
     * 
     * @return 文字列表現
     */
    public String toString()
    {
    	StringBuffer sb = new StringBuffer();
    	sb.append(type);

    	if ( options != null )
    	{
    		Iterator it = options.iterator();
    		while ( it.hasNext() )
    		{
    			sb.append( ';' );
    			sb.append( it.next().toString() );
    		}
    	}

    	sb.append( ": " );
    	sb.append( value );

    	return sb.toString();
    }

    /**
     * 文字列バッファ <var>sb</var> に、この属性の 相対識別名 (RDN)として使用するため適切にエスケープされた UTF-8 文字列表現 を追加する。
     *
     * @param sb 
     * @see <a href="http://www.ietf.org/rfc/rfc2253.txt">RFC2253</a>
     */
    public void toEscapedString( StringBuffer sb )
    {
    	sb.append( type );
    	sb.append( '=' );

    	byte[] ba = null;
    	try {
    		ba = value.getBytes( "UTF8" );
    	} catch ( UnsupportedEncodingException e ) {
    		// ignore it.
    	}

    	ByteArrayOutputStream o = new ByteArrayOutputStream();
    	for ( int i = 0; i < ba.length; i++ )
    	{
    		if ( ba[i] == '\r' )
    		{
    			o.write( '\\' );
    			o.write( '0' );
    			o.write( 'D' );
    			continue;
    		}
    		if ( ba[i] == '\n' )
    		{
    			o.write( '\\' );
    			o.write( '0' );
    			o.write( 'A' );
    			continue;
    		}
    		if ( (ba[i] == '#') ||
		         (ba[i] == ' ') ||
		         (ba[i] == ',') ||
		         (ba[i] == '+') ||
		         (ba[i] == '"') ||
		         (ba[i] == '\\') ||
		         (ba[i] == '<') ||
		         (ba[i] == '>') ||
		         (ba[i] == ';') )
    		{
    			o.write( '\\' );
    		}

    		o.write( ba[i] & 0xFF );
    	}

    	try {
    		sb.append( o.toString( "UTF8" ) );
    	} catch ( UnsupportedEncodingException e ) {
    		// ignore it.
    	}
    }

    /**
     * LDIFファイル内の属性定義として適切な、この属性の文字列表現を返す。
     * 
     * @return LDIF形式の文字列表現
     */
    public String toLdif()
    {
    	StringBuffer sb = new StringBuffer();
    	sb.append(type);

    	if ( options != null )
    	{
    		Iterator it = options.iterator();
    		while ( it.hasNext() )
    		{
    			sb.append( ';' );
    			sb.append( it.next().toString() );
    		}
    	}

    	sb.append( ":: " );
    	sb.append( Base64.encode(value) );

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
    	if ( ! ( o instanceof Attribute ) )
    		return false;

    	Attribute attr = (Attribute)o;
    	if ( ! type.equals( attr.type ) )
    		return false;

    	return value.equals( attr.value );
    }

    /**
     * Integer のハッシュコードを返します。 
     * 
     * @return このオブジェクトのハッシュコード値。この Integer オブジェクトが表すプリミティブ型 int 値に等しい
     */
    public int hashCode()
    {
    	return ( type.hashCode() ^ value.hashCode() );
    }
}
