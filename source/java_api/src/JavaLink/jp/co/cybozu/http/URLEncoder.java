package jp.co.cybozu.http;

import java.io.*;

/**
 * J2SDK1.4.0 に含まれる {@link URLEncoder} クラスのコンパチブルクラスです。
 *
 * @author サイボウズ
 * @version	1.0.0
 */
public class URLEncoder
{
    private URLEncoder () {}

    private static final char[] hexChars =
    {
	'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
	'A', 'B', 'C', 'D', 'E', 'F'
    };

    /**
     * 特定の符号化方式を使用して文字列を application/x-www-form-urlencoded 形式に変換します。
     *
     * @param s 変換対象の String
     * @param enc サポートされる「文字エンコーディング」の名前
     * @return 変換後の String 
     * @throws UnsupportedEncodingException 指定された文字エンコーディングがサポートされていない場合
     */
    public static String encode (String s, String enc)
	throws UnsupportedEncodingException
    {
    	if ( s == null )
    		throw new NullPointerException("s is null.");
    	if ( enc == null )
    		throw new NullPointerException("enc is null.");

    	StringBuffer sb = new StringBuffer();
    	byte[] encoded_data = s.getBytes(enc);

    	for ( int i = 0; i < encoded_data.length; i++ )
    	{
    		char c = (char)(encoded_data[i] & 0xff);	// force unsigned
    		if ( ( ('a' <= c) && (c <= 'z') ) ||
		         ( ('A' <= c) && (c <= 'Z') ) ||
		         ( ('0' <= c) && (c <= '9') ) ||
		           ( c == '.' ) ||
		           ( c == '-' ) ||
		           ( c == '*' ) ||
		           ( c == '_' ) )
    		{
    			sb.append(c);
    			continue;
    		}

    		if ( c == ' ' )
    		{
    			sb.append('+');
    			continue;
    		}

    		sb.append('%');
    		sb.append(hexChars[(c / 16)]);
    		sb.append(hexChars[(c % 16)]);
    	}
    	return sb.toString();
    }
}
