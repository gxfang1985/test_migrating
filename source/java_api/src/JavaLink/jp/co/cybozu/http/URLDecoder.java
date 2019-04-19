package jp.co.cybozu.http;

import java.io.*;

/**
 * J2SDK1.4.0 に含まれる {@link URLDecoder} クラスのコンパチブルクラスです
 *
 * @author サイボウズ
 * @version	1.0.0
 */
public class URLDecoder
{
    private URLDecoder () {}

    private static int hexToint (char c)
    {
    	if ( ('a' <= c) && (c <= 'f') )
    	{
    		return (int)(c - 'a') + 10;
    	}

    	if ( ('A' <= c) && (c <= 'F') )
    	{
    		return (int)(c - 'A') + 10;
    	}

    	if ( ('0' <= c) && (c <= '9') )
    	{
    		return (int)(c - '0');
    	}

    	throw new IllegalArgumentException("Illegal hexadecimal character.");
    }

    /**
     * 特別な符号化方式を使用して application/x-www-form-urlencoded 文字列を復号化します。指定された符号化方式を使用して、「%xy」の形式の連続シーケンスが表す文字を決定します。
     *
     * @param s 復号化対象の String
     * @param enc サポートされる「文字エンコーディング」の名前
     * @return 新しく復号化された String 
     * @throws UnsupportedEncodingException 指定された文字エンコーディングがサポートされていない場合
     * @throws IllegalArgumentException If <var>s</var> contains illegal
     * characters.
     */
    public static String decode (String s, String enc)
	throws UnsupportedEncodingException
    {
    	if ( s == null )
    		throw new NullPointerException("s is null.");
    	if ( enc == null )
    		throw new NullPointerException("enc is null.");

    	// WARNING: do not use PIPE since it may cause deadblocks.
    	ByteArrayOutputStream o = new ByteArrayOutputStream();

    	final int len = s.length();
    	for ( int i = 0; i < len; i++ )
    	{
    		char c = s.charAt(i);

    		if ( ( ('a' <= c) && (c <= 'z') ) ||
		         ( ('A' <= c) && (c <= 'Z') ) ||
		         ( ('0' <= c) && (c <= '9') ) ||
		         ( c == '.' ) ||
		         ( c == '-' ) ||
		         ( c == '*' ) ||
		         ( c == '_' ) )
    		{
    			o.write(c);
    			continue;
    		}

    		if ( c == '+' )
    		{
    			o.write(' ');
    			continue;
    		}

    		if ( c == '%' )
    		{
    			if ( i > (len - 3) )
    			{
    				throw new IllegalArgumentException("invalid % escape sequence.");
    			}

    			char c1 = s.charAt(++i);
    			char c2 = s.charAt(++i);
    			int n = hexToint(c1) * 16 + hexToint(c2);
    			o.write(n);
    			continue;
    		}

    		throw new IllegalArgumentException("invalid character in s.");
    	}

    	try {
    		o.close();
    	} catch ( IOException e ) {
    		// ignore it
    	}

    	return new String(o.toByteArray(), enc);
    }
}
