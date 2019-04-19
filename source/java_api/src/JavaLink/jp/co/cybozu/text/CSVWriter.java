/* CSVWriter.java */
package jp.co.cybozu.text;

import java.util.*;
import java.io.*;

/**
 * CSV 形式の行を出力します。
 * 行のカラムを並べた配列あるいはリストを、適切にエスケープして行単位で出力します。
 *
 * @author サイボウズ
 * @version	1.0.0
 * @see		CSVReader
 */
public class CSVWriter
{
    protected final BufferedWriter o;

    /**
     * CSV 形式の行を書き込むバッファ付きライターを作成します。
     * バッファサイズはデフォルト値になります。
     *
     * @param w 書き出す先の Writer
     */
    public CSVWriter( Writer w )
    {
    	o = new BufferedWriter( w );
    }

    /**
     * CSV 形式の行を書き込むバッファ付きライターを作成します.
     * バッファサイズは <var>sz</var> で指定された値になります。
     *
     * @param w 書き出す先
     * @param sz バッファサイズ
     */
    public CSVWriter( Writer w, int sz )
    {
    	o = new BufferedWriter( w, sz );
    }

    /**
     * CSV ファイルの行を書き出します。
     * 行のカラムは <var>line</var> の要素を順に並べたものになります。
     * 各文字列は CSV 形式に合わせてエスケープされます。
     * 行の最後には newline 文字が書き出されます。
     *
     * @param line 書き出す行の内容を表す文字列の配列
     * @throws IOException 通信エラーが発生
     */
    public void println( String[] line )
	throws IOException
    {
    	boolean comma = false;
    	for ( int i = 0; i < line.length; i++ )
    	{
    		if ( comma ) {
    			o.write( ',' & 0xFFFF );
    		} else {
    			comma = true;
    		}

    		printColumn( line[i] );
    	}

    	o.newLine();
    }

    /**
     * CSV ファイルの行を書き出します。
     * 行のカラムは <var>line</var> の要素を順に並べたものになります。
     * 各文字列は CSV 形式に合わせてエスケープされます。
     * 行の最後には newline 文字が書き出されます。
     *
     * @param line 書き出す行の内容を表す文字列のリスト 
     * @throws IOException 通信エラーが発生
     */
    public void println( List line )
	throws IOException
    {
    	boolean comma = false;
    	Iterator it = line.iterator();

    	while ( it.hasNext() )
    	{
    		if ( comma ) {
    			o.write( ',' & 0xFFFF );
    		} else {
    			comma = true;
    		}

    		printColumn( (String)it.next() );
    	}

    	o.newLine();
    }

    /**
     * <var>column</var> を CSV 形式に適切なようにエスケープして出力します。
     *
     * @param column カラムの内容を示す文字列
     * @throws IOException 通信エラーが発生
     */
    protected void printColumn( String column )
	throws IOException
    {
    	o.write( '"' & 0xFFFF );

    	char[] ca = column.toCharArray();
    	for ( int i = 0; i < ca.length; i++ )
    	{
    		if ( ca[i] == '\r' )
    		{
    			if ( (i == (ca.length - 1)) || (ca[i+1] != '\n') )
    			{
    				o.write( '\n' & 0xFFFF );
    			}
    			continue;
    		}

    		if ( ca[i] == '"' )
    		{
    			o.write( '"' & 0xFFFF );
    		}

    		o.write( ca[i] & 0xFFFF );
    	}

    	o.write( '"' & 0xFFFF );
    }

    /**
     * ライターを flush します。
     * 
     * @throws IOException 通信エラーが発生
     */
    public void flush()
	throws IOException
    {
    	o.flush();
    }

    /**
     * ライターを close します。
     * 
     * @throws IOException 通信エラーが発生
     */
    public void close()
	throws IOException
    {
    	o.close();
    }


    /* test routine */
//     public static void main ( String[] args )
// 	throws IOException
//     {
// 	String[] line = { "abc,､｢､､､ｦdef \"", "ghi\njkl,mn", "opq " };

// 	CSVWriter o = new CSVWriter( new OutputStreamWriter( System.out ) );
// 	o.println(line);
// 	o.close();
//     }
}
