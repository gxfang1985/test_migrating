/* Base64.java */
package jp.co.cybozu.text;

import java.io.*;

/**
 * MIME の Base64 エンコーダーとデコーダーを実装します。<br>
 * このクラスはまた、main によって単独のコマンドとしても動作します。
 *
 * @author サイボウズ
 * @version	1.0.0
 * @see #main
 */
public class Base64
{
    /** no instantiation */
    private Base64 () {}

    /** The padding character. */
    private final static char padChar = '=';

    /**
     * <var>s</var> を UTF-8 の文字列として Base64 エンコードします。<br>
     * 結果は折り返しのない文字列で返されます。
     *
     * @param s エンコードする UTF-8 文字列
     * @return Base64 エンコードした結果の文字列
     */
    public static String encode (String s)
    {
    	try {
    		return encode(s, "UTF8");
    	} catch (UnsupportedEncodingException e) {
    		return null;
    	}
    }

    /**
     * <var>s</var> を <var>enc</var> で指定された文字列エンコーディング の文字列として Base64 エンコードします。<br>
     * 結果は折り返しのない文字列で返されます。
     *
     * @param s エンコードする文字列
     * @param enc <var>s</var> の文字列エンコーディング 
     * @return Base64 エンコードした結果の文字列
     * @throws UnsupportedEncodingException <var>enc</var> がサポートされていない場合
     */
    public static String encode (String s, String enc)
	throws UnsupportedEncodingException
    {
    	String encoded = null;

    	try {
    		InputStream in = new ByteArrayInputStream(s.getBytes(enc));
    		encoded = encode(in);
    		in.close();
    	} catch (UnsupportedEncodingException e) {
    		throw e;
    	} catch (IOException e) {
    		// ignore it
    	}

    	return encoded;
    }

    /**
     * オクテットを Base64 エンコードします。結果は折り返しのない文字列で返されます。 
     *
     * @param b エンコードするオクテットの配列
     * @return Base64 エンコードした結果の文字列
     */
    public static String encode (byte[] b)
    {
    	return encode(b, 0, b.length);
    }

    /**
     * オクテットを Base64 エンコードします。<br>
     * 結果は折り返しのない文字列で返されます。
     *
     * @param b エンコードするオクテットの配列
     * @param offset エンコードするオクテットの開始インデックス
     * @param len エンコードするオクテット長
     * @return Base64 エンコードした結果の文字列
     */
    public static String encode (byte[] b, int offset, int len)
    {
    	String encoded = null;
    	try {
    		ByteArrayInputStream in = new ByteArrayInputStream(b, offset, len);
    		encoded = encode(in);
    		in.close();
		} catch (IOException e) {
			// ignore it
		}
		return encoded;
    }


    /* Encoder implementation */
    private final static char[] base64 =
    {
	'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
	'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
	'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
	'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
	'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
    };

    /**
     * {@link InputStream} から読み込んだオクテットを Base64 エンコードします。<br>
     * 結果は折り返しのない文字列で返されます。
     *
     * @param in 読み込むストリーム
     * @return Base64 エンコードした結果の文字列
     * @throws IOException 読み込みエラーが発生した場合
     */
    public static String encode (InputStream in)
	throws IOException
    {
    	int[] buf = new int[3];
    	StringBuffer sb = new StringBuffer(1024);

    	FINISH:
    	while ( true )
    	{
    		for ( int i = 0; i < 3; i++ )
    		{
    			int b = in.read();
    			if ( b == -1 )
    			{
    				if ( i == 0 ) break FINISH;

    				sb.append(base64[(buf[0] >>> 2)]);
    				int t = ((buf[0] & 0x03) << 4);
    				if ( i == 1 )
    				{
    					sb.append(base64[t]);
    					sb.append(padChar);
    					sb.append(padChar);	// need two '='
    					break FINISH;
    				}

    				t |= (buf[1] >>> 4);
    				sb.append(base64[t]);
    				t = ((buf[1] & 0x0f) << 2);
    				sb.append(base64[t]);
    				sb.append(padChar);
    				break FINISH;
    			}

    			buf[i] = b;
    		}

    		int t = (buf[0] >>> 2);
    		sb.append(base64[t]);
    		t = (((buf[0] & 0x03) << 4) | (buf[1] >>> 4));
    		sb.append(base64[t]);
    		t = (((buf[1] & 0x0f) << 2) | (buf[2] >>> 6));
    		sb.append(base64[t]);
    		sb.append(base64[(buf[2] & 0x3f)]);
    	}
    	return sb.toString();
    }


    /**
     * Base64 エンコード結果の文字列をデコードします。<br>
     * 結果は byte の配列で返されます。<br>
     * 結果を適切な文字コードでさらにデコードするためには、 {@link String#String(byte[], String)} を使用します。
     *
     * @param s デコードする文字列
     * @return Base64 デコードした byte の配列
     * @throws ParseException <var>s</var> の終端が不適切な場合
     */
    public static byte[] decode (String s)
	throws ParseException
    {
    	byte[] decoded = null;
    	try {
    		decoded = decode(s.getBytes("UTF8"));
    	} catch ( UnsupportedEncodingException e ) {
    		// ignore it
    	}
    	return decoded;
    }

    /**
     * Base64 エンコード結果のオクテット配列をデコードします。<br>
     * 結果は byte の配列で返されます。<br> 
     * 結果を適切な文字コードでさらにデコードするためには、 {@link String#String(byte[], String)} を使用します。
     *
     * @param b デコードするオクテットの配列
     * @return Base64 デコードした byte の配列
     * @throws ParseException <var>b</var> の終端が不適切な場合
     */
    public static byte[] decode (byte[] b)
	throws ParseException
    {
    	return decode(b, 0, b.length);
    }

    /**
     * Base64 エンコード結果のオクテット配列をデコードします。<br>
     * 結果は byte の配列で返されます。<br>
     * 結果を適切な文字コードでさらにデコードするためには、 {@link String#String(byte[], String)} を使用します。
     *
     * @param b デコードするオクテットの配列
     * @param offset デコードするオクテットの開始インデックス
     * @param len デコードするオクテット長
     * @return Base64 デコードした byte の配列
     * @throws ParseException <var>b</var> の終端が不適切な場合
     */
    public static byte[] decode (byte[] b, int offset, int len)
	throws ParseException
    {
    	byte[] decoded = null;

    	try {
    		ByteArrayInputStream in = new ByteArrayInputStream(b, offset, len);
    		decoded = decode(in);
    		in.close();
    	} catch (EOFException e) {
    		throw new ParseException( e.toString() );
    	} catch (IOException e) {
    		// ignore it
    	}
    	return decoded;
    }


    /* Decoder implementation */

    /**
     * {@link InputStream} から読み込んだオクテットを Base64 デコードします。<br>
     * 結果は byte の配列で返されます。<br>
     * 結果を適切な文字コードでさらにデコードするためには、 {@link String#String(byte[], String)} を使用します。
     *
     * @param in 読み込むストリーム
     * @return Base64 デコードした byte の配列
     * @throws IOException 読み込みエラーが発生した場合
     * @throws ParseException <var>in</var> の終端が不適切な場合
     */
    public static byte[] decode (InputStream in)
	throws IOException, ParseException
    {
    	ByteArrayOutputStream out = new ByteArrayOutputStream();
    	byte[] buf = new byte[3];

    	FINISH:
	    while ( true )
	    {
	    	for ( int i = 0; i < 4; i++ )
	    	{
	    		int b = in.read();

	    		if ( b == -1 )
	    		{
	    			if ( i == 0 )
	    				break FINISH;
	    			throw new ParseException("unexpected end of stream.");
	    		}

	    		if ( b == padChar )
	    		{
	    			switch (i)
	    			{
	    			case 2:
	    				out.write(buf[0]);
	    				break FINISH;
	    			case 3:
	    				out.write(buf[0]);
	    				out.write(buf[1]);
	    				break FINISH;
	    			default:
	    				throw new ParseException("unexpected appearance of padding char '='.");
	    			}
	    		}

	    		int c;
	    		if ( b == '/' ) {
	    			c = 63;
	    		} else if ( b == '+' ) {
	    			c = 62;
	    		} else if ( ('0' <= b) && (b <= '9') ) {
	    			c = b - '0' + 52;
	    		} else if ( ('a' <= b) && (b <= 'z') ) {
	    			c = b - 'a' + 26;
	    		} else if ( ('A' <= b) && (b <= 'Z') ) {
	    			c = b - 'A';
	    		} else {
	    			i--;
	    			continue;
	    		}

	    		switch (i)
	    		{
	    		case 0:
	    			buf[0] = (byte)(c << 2);
	    			break;
	    		case 1:
	    			buf[0] |= (c >>> 4);
	    			buf[1] = (byte)((c & 0x0f) << 4);
	    			break;
	    		case 2:
	    			buf[1] |= (c >>> 2);
	    			buf[2] = (byte)((c & 0x03) << 6);
	    			break;
	    		case 3:
	    			buf[2] |= c;
	    			break;
	    		}
	    	}

	    	for ( int i = 0; i < 3; i++ )
	    	{
	    		out.write(buf[i]);
	    	}
	    }

    	byte[] a = out.toByteArray();
    	out.close();
    	return a;
    }


    /* command-line encoder/decoder */

    private static void usage ()
    {
    	System.err.println("Usage: java jp.co.cybozu.text.Base64 encode|decode [OPTIONS]");
    	System.err.println();
    	System.err.println("Options:");
    	System.err.println("        -c ENCODING    The character-encoding to output the decoded data.");
    	System.err.println("                       Default is to write them as it is.");
    	System.err.println("        -f FILE        The input file to be encoded/decoded.");
    	System.err.println("                       Default is to read from the standard input.");
    	System.err.println("        -o FILE        The file to which the output are written.");
    	System.err.println("                       Default is to write to the standard output.");
    }

    /**
     * 単独の Base64 エンコーダー/デコーダー機能を提供するコマンドのエントリポイントです。<br>
     * 結果は標準出力に出力されます。
     *
     * @param args コマンドライン引数
     * @throws IOException 読み込みエラーが発生した場合
     */
    public static void main (String[] args)
	throws IOException, ParseException
    {
    	if ( args.length < 1 )
    	{
    		usage();
    		return;
    	}

    	InputStream in = System.in;
    	PrintStream out = System.out;
    	String encoding = null;
    	for (int i = 1; i < args.length; i++ )
    	{
    		if ( args[i].equals("-c") )
    		{
    			if ( i > (args.length - 2) )
    			{
    				System.err.println("missing character encoding after -c.");
    				usage();
    				return;
    			}
    			encoding = args[++i];
    			continue;
    		}

    		if ( args[i].equals("-f") )
    		{
    			if ( i > (args.length - 2) )
    			{
    				System.err.println("missing file name after -f.");
    				usage();
    				return;
    			}
    			in.close();
    			in = new FileInputStream(args[++i]);
    			continue;
    		}

    		if ( args[i].equals("-o") )
    		{
    			if ( i > (args.length - 2) )
    			{
    				System.err.println("missing file name after -o.");
    				usage();
    				return;
    			}
    			out.close();
    			out = new PrintStream( new FileOutputStream(args[++i]) );
    			continue;
    		}
    	}

    	if ( args[0].equals("encode") ) {
    		String encoded = encode(in);
    		in.close();

    		out.println(encoded);
    		out.close();

    		return;

    	} else if ( args[0].equals("decode") ) {
    		byte[] decoded = decode(in);
    		in.close();

    		if ( encoding != null ) {
    			out.println(new String(decoded, encoding));
    		} else {
    			out.write(decoded);
    		}
    		out.close();

    		return;

    	} else {
    		usage();
    		return;
    	}
    }
}
