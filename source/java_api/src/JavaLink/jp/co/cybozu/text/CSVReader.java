/* CSVReader.java */
package jp.co.cybozu.text;

import java.io.*;
import java.util.*;

/**
 * CSV 形式のファイルを読み込み、文字列の配列として返します。
 *
 * @author サイボウズ
 * @version	1.0.0
 * @see		CSVWriter
 */
public class CSVReader
{
    private final BufferedReader in;
    private int lineNumber = 0;

    /**
     * CSV 形式のファイルを読み込むバッファ付きリーダーを作成します。
     * バッファサイズはデフォルト値になります。
     *
     * @param r 読み込む元の Reader
     */
    public CSVReader (Reader r)
    {
    	in = new BufferedReader( r );
    }

    /**
     * CSV 形式のファイルを読み込むバッファ付きリーダーを作成します。
     * バッファサイズは <var>sz</var> で指定された値になります。 
     *
     * @param r 読み込む元の Reader
     * @param sz バッファサイズ
     */
    public CSVReader (Reader r, int sz)
    {
    	in = new BufferedReader( r, sz );
    }

    /**
     * CSV 形式の一行を読み込みます。
     * 読み込んだ行は String の配列として返されます。
     * EOF に達っした場合、null が返ります。
     *
     * @return CSVの行を表す文字列の配列
     * @throws IOException 接続が確立できない等通信上のエラーが発生した場合
     * @throws ParseException ファイルの終端が不正であった場合
     */
    public String[] readLine ()
	throws IOException, ParseException
    {
    	String line = in.readLine();
    	if ( line == null )
    	{
    		in.close();
    		return null;
    	}

    	lineNumber ++;

    	// data buffers
    	final StringBuffer buf = new StringBuffer();
    	final List l = new ArrayList(16);
	
    	// state variables
    	boolean quoting = false;		// changed by '"'

    	while ( true )
    	{
    		char[] ca = line.toCharArray();

    		int i;
    		for ( i = 0; i < ca.length; i++ )
    		{
    			if ( quoting )
    			{
    				if ( ca[i] == '"' )
    				{
    					if ( (i < (ca.length - 1)) && (ca[i+1] == '"' ) ) {
    						buf.append( ca[++i] );

    					} else {
    						quoting = false;
    					}
    					continue;
    				}

    				buf.append( ca[i] );
    				continue;
    			}

    			if ( ca[i] == '"' )
    			{
    				quoting = true;
    				continue;
    			}

    			if ( ca[i] == ',' )
    			{
    				l.add( buf.toString() );
    				buf.setLength(0);
    				continue;
    			}

    			buf.append( ca[i] );
    		}

    		if ( quoting )
    		{
    			line = in.readLine();
    			if ( line == null )
    				throw new ParseException("unbalanced \" .", lineNumber);

    			buf.append('\n');
    			continue;
    		}

    		l.add( buf.toString() );

    		break;
    	}


    	String[] csvline = new String[l.size()];
    	for ( int i = 0; i < csvline.length; i++ )
    	{
    		csvline[i] = (String)l.get(i);
    	}
    	return csvline;
    }

    /**
     * 最後に読み込んだ行の行番号を返します。
     */
    public int getLineNumber ()
    {
    	return lineNumber;
    }

    /**
     * リーダーを close します。
     * 
     * @throws IOException 接続が確立できない等通信上のエラーが発生した場合
     */
    public void close()
	throws IOException
    {
    	in.close();
    }

    /* test routine */
//     public static void main (String[] args)
// 	throws IOException, ParseException
//     {
// 	if ( args.length < 1 )
// 	{
// 	    System.err.println("Usage: java jp.co.cybozu.text.CSVReader FILE");
// 	    return;
// 	}

// 	CSVReader parser = new CSVReader(
// 			       new InputStreamReader(
// 				   new FileInputStream(args[0]),
// 				   "JISAutoDetect"));

// 	while ( true )
// 	{
// 	    String[] l = parser.readLine();
// 	    if ( l == null )
// 		break;

// 	    System.out.println("Columns: " + l.length);
// 	    for ( int i = 0; i < l.length; i++ )
// 	    {
// 		char[] ca = l[i].toCharArray();
// 		System.out.print("\"");
// 		for ( int j = 0; j < ca.length; j++ )
// 		{
// 		    if ( ca[j] == '\n' ) {
// 			System.out.print("\\n");
// 		    } else {
// 			System.out.print( ca[j] );
// 		    }
// 		}
// 		System.out.print("\"");

// 		if ( i < (l.length - 1 ) )
// 		    System.out.print(",");
// 	    }
// 	    System.out.println();
// 	}

// 	parser.close();

// 	return;
//     }
}
