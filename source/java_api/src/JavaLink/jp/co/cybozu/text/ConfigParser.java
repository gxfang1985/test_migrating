/* ConfigParser.java */
package jp.co.cybozu.text;

import java.util.*;
import java.io.*;
//import jp.co.cybozu.garoon2.*;

/**
 * {@link Properties} クラスと同様の設定ファイルパーサです。<br>
 * 唯一の違いは、このクラスは load で読み込めるファイルの、文字列エンコーディングを指定可能なことです。<br>
 * そのため、ASCII 以外の形式で記述された設定ファイルを読み込めます。
 *
 * @author サイボウズ
 * @version	1.0.0
 */
public class ConfigParser extends HashMap
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

    	private boolean eofReached = false;

    	public String readLine()
	    throws IOException
	    {
    		if ( eofReached )
    		{
    			return null;
    		}

    		String l = super.readLine();
    		if ( l == null )
    		{
    			eofReached = true;
    			return null;
    		}

    		while ( true )
    		{
    			if ( ! l.endsWith("\\") )
    				break;

    			l = l.substring(0, l.length() - 1);

    			String nextl = super.readLine();
    			if ( nextl == null )
    			{
    				eofReached = true;
    				return l;
    			}

    			int LEN = nextl.length();
    			int i;
    			for ( i = 0; i < LEN; i++ )
    			{
    				if ( ! Character.isWhitespace( nextl.charAt(i) ) )
    					break;
    			}

    			l += nextl.substring(i);
    		}
    		return l;
	    }
    }


    /**
     * {@link #load(InputStream)} で使用されるデフォルトの文字列エンコーディング。<br>
     * 現在は "JISAutoDetect" です。
     */
    public static final String DEFAULT_ENCODING = "JISAutoDetect";

    /**
     * プロパティを一切持たない状態で、パーザーを作成します。
     */
    public ConfigParser()
    {
    	super();
    }

    /**
     * パーサを作成し、<var>in</var> で指定された設定ファイルを {@link #load} で読み込みます。<br>
     * 設定ファイルの文字列エンコーディングには {@link #DEFAULT_ENCODING} が使用されます。
     *
     * @param in パースする設定ファイルのストリーム
     * @throws IOException <var>in</var> からの読み込みに失敗した 
     * @throws ParseException 設定ファイルの記述が不正
     */
    public ConfigParser( InputStream in )
	throws IOException, ParseException
    {
    	super();
    	load( in );
    }

    /**
     * パーサを作成し、<var>in</var> で指定された設定ファイルを {@link #load load} で読み込みます。
     *
     * @param in パースする設定ファイルのストリーム
     * @param enc ストリームの文字列エンコーディング
     * @throws IOException <var>in</var> からの読み込みに失敗した、あるいは不正な文字列エンコーディングを指定した。
     * @throws ParseException 設定ファイルの記述が不正
     */
    public ConfigParser( InputStream in, String enc )
	throws IOException, ParseException
    {
    	super();
    	load( in, enc );
    }

    /**
     * <var>in</var> から設定ファイルの内容を読み込み、定義されているプロパティを追加します。<br>
     * 読み込みに使用するルールは {@link Properties#load} と同じです。<br>
     * 設定ファイルの文字列エンコーディングは {@link #DEFAULT_ENCODING} と仮定します。
     *
     * @param in パースする設定ファイルのストリーム
     * @throws IOException <var>in</var> からの読み込みに失敗した。
     * @throws ParseException 設定ファイルの記述が不正
     */
    public void load( InputStream in )
	throws IOException, ParseException
    {
    	load(in, DEFAULT_ENCODING);
    }

    /**
     * <var>in</var> から設定ファイルの内容を読み込み、定義されているプロパティを追加します。<br>
     * 読み込みに使用するルールは {@link Properties#load} と同じです。<br>
     * 設定ファイルの文字列エンコーディングは <var>enc</var> と仮定します。
     *
     * @param in パースする設定ファイルのストリーム
     * @param enc ストリームの文字列エンコーディング
     * @throws IOException <var>in</var> からの読み込みに失敗した、あるいは不正な文字列エンコーディングを指定した。
     * @throws ParseException 設定ファイルの記述が不正
     */
    public void load( InputStream in, String enc )
	throws IOException, ParseException
    {
    	LineNumberReader lin =
    		new ConcatReader(
    		new InputStreamReader( in, enc ) );

    	READLINE:
	    while ( true )
	    {
	    	String line = lin.readLine();
	    	if ( line == null )
	    	{
	    		break;
	    	}
	    	StringReader sr = new StringReader( line );
	    	StringBuffer sbKey = new StringBuffer();
	    	StringBuffer sbValue = new StringBuffer();
	    	StringBuffer sb = sbKey;
	    	boolean escaping = false;
	    	boolean seenseparator = false;
	    	int step = 0;
	    	while ( true )
	    	{
	    		int ic = sr.read();
	    		if ( (ic == -1) )
	    		{
	    			break;
	    		}
	    		char c = (char)ic;

	    		if ( (step == 0) &&
		           ( (c == '#') || (c == '!') ) )
	    		{
	    			sr.close();
	    			continue READLINE;
	    		}

	    		if ( Character.isWhitespace( c ) )
	    		{
	    			if ( (step == 0) ||
	    	 			 (step == 2) )
	    			{
	    				continue;
	    			}

	    			if ( escaping || (step == 3) )
	    			{
	    				escaping = false;
	    				sb.append(c);
	    				continue;
	    			}

	    			// step == 1
	    			step ++;
	    			sb = sbValue;
	    			continue;
	    		}

	    		if ( c == '\\' )
	    		{
	    			if ( (step == 0) || (step == 2) )
	    			{
	    				step ++;
	    			}

	    			if ( escaping ) {
	    				sb.append('\\');
	    				escaping = false;
	    			} else {
	    				escaping = true;
	    			}
	    			continue;
	    		}

	    		if ( (! seenseparator) && ( (c == '=') || (c == ':') ) )
	    		{
	    			seenseparator = true;

	    			if ( step == 0 )
	    				throw new ParseException("syntax error",
	    						lin.getLineNumber());

	    			if ( step == 2 )
	    			{
	    				continue;
	    			}

	    			if ( escaping )
	    			{
	    				escaping = false;
	    				sb.append(c);
	    				continue;
	    			}

	    			if ( step == 1 )
	    			{
	    				step ++;
	    				sb = sbValue;
	    				continue;
	    			}

	    			if ( step == 3 )
	    			{
	    				sb.append(c);
	    				continue;
	    			}
	    		}

	    		if ( escaping )
	    		{
	    			escaping = false;
	    			if ( step == 1 )
	    			{
	    				sb.append(c);
	    				continue;
	    			}

	    			if ( c == 't' )
	    			{
	    				sb.append('\t');
	    				continue;
	    			}
	    			if ( c == 'n' )
	    			{
	    				sb.append('\n');
	    				continue;
	    			}
	    			if ( c == 'r' )
	    			{
	    				sb.append('\r');
	    				continue;
	    			}
	    			if ( c == 'u' )
	    			{
	    				StringBuffer ub = new StringBuffer();
	    				for (int i = 0; i < 4; i++ )
	    				{
	    					int d = sr.read();
	    					if ( (d == -1) )
	    						throw new ParseException("unexpected end of line",
	    								lin.getLineNumber());
	    					ub.append((char)d);
	    				}

	    				try {
	    					sb.append( (char)Integer.parseInt(ub.toString(), 16) );
	    				} catch (NumberFormatException e) {
	    					throw new ParseException("illegal unicode escape: " + ub.toString(),
	    							lin.getLineNumber());
	    				}
	    				continue;
	    			}

	    			sb.append( c );
	    			continue;
    			}

	    		if ( (step == 0) || (step == 2) )
	    		{
	    			step ++;
	    		}
	    		sb.append( c );
	    	}

	    	sr.close();

	    	if ( step > 0 )
	    	{
	    		setProperty( sbKey.toString(), sbValue.toString() );
	    	}
	    }
    }

    /**
     * 指定されたキーのプロパティを検索して返します。
     *
     * @param key プロパティのキー
     * @return もしキーに適合するプロパティがあれば、その値。なければ null。
     */
    public String getProperty(String key)
    {
    	return get(key).toString();
    }

    /**
     * {@link HashMap#put} を呼び出してプロパティを設定します。<br>
     * 返される値は、{@link HashMap#put} で返されるものです。
     *
     * @param key プロパティのキー
     * @param value プロパティの値 
     * @return 以前に同じキーのプロパティが設定されていれば、以前の値。なければ <kbd>null</kbd>。
     */
    public Object setProperty(String key, String value)
    {
    	return put(key, value);
    }

    /**
     * 設定された全てのプロパティを持った、{@link Properties}オブジェクトを作成し返します。
     *
     * @return {@link Properties}オブジェクトを作成し返します。
     */
    public Properties getProperties()
    {
    	Properties props = new Properties();

    	Iterator it = entrySet().iterator();
    	while ( it.hasNext() )
    	{
    		Map.Entry ent = (Map.Entry)it.next();
    		props.setProperty( ent.getKey().toString(),
    				ent.getValue().toString() );
    	}

    	return props;
    }

    /**
     * 設定された全てのプロパティを持った、{@link Properties}オブジェクトを作成し返します。<br>
     * その際、プロパティのデフォルト値を提供する <var>defaults</var> を指定します。
     *
     * @param defaults デフォルトプロパティ
     * @return {@link Properties}オブジェクトを作成し返します。
     */
    public Properties getProperties( Properties defaults )
    {
    	Properties props = new Properties( defaults );

    	Iterator it = entrySet().iterator();
    	while ( it.hasNext() )
    	{
    		Map.Entry ent = (Map.Entry)it.next();
	    	props.setProperty( ent.getKey().toString(),
			       ent.getValue().toString() );
    	}

    	return props;
    }
}
