/* PostStream.java */
package jp.co.cybozu.http;

import java.io.*;
import java.net.*;

/**
 * HTTP POST リクエストの内容を作成するデータストリームです。<br>
 * このクラスは以下の 2 つのモードを持っています。 
 * <ul>
 * <li>「URLエンコード」モードでは、Content-Type が "application/x-www-form-urlencoded" であるリクエストを作成します。</li> 
 * <li>「マルチパート」モードでは、Content-Type が "multipart/form-data" であるリクエストを作成します。</li>
 * </ul>
 * モードはインスタンスの作成時に、どのコンストラクタを使用するかで決定されます。
 * <br> 
 * <font color="red">ファイルを添付するには、「マルチパート」モードである必要があります。</font>
 * <br>
 * POST リクエストの中身を全て追加し終えたら、データストリームをクローズする必要があります。 
 *
 * @author サイボウズ
 * @version	1.0.0
 * @see #PostStream(OutputStream)
 * @see #PostStream(OutputStream, String)
 * @see #close()
 */
public class PostStream
{
    protected final DataOutputStream out;
    protected final Writer wout;

    private final String boundary;
    private static final String SEPARATOR = "--";
    private static final byte[] CRLF = { 0x0d, 0x0a };
    private boolean needDelimeter = false;

    /**
     * 「URLエンコード」モードのデータストリームを作成します。<br>
     * addProperty(java.lang.String, java.lang.String) で追加されるデータは適切に URL エンコードされます。<br>
     * close() すると、Content-Type を "application/x-www-urlencoded" として POST リクエストを実行します。
     *
     * @param o URLConnection.getOutputStream() で返される {@link URLConnection#getOutputStream}
     */
    public PostStream (OutputStream o)
    {
    	this(o, null);
    }

    /**
     * 「マルチパート」モードのデータストリームを作成します. addProperty(java.lang.String, java.lang.String) や addFile(java.io.File, java.lang.String, java.lang.String) で追加されるデータはマルチパート MIME 形式にフォーマットされます。
     * close() すると、Content-Type を "multipart/form-data" として POST リクエストを実行します。
     *
     * @param o {@link URLConnection#getOutputStream} で返される OutputStream
     * @param boundary マルチパート MIME の区切文字列
     */
    public PostStream (OutputStream o, String boundary)
    {
    	if ( o == null )
    		throw new NullPointerException("o is null.");

    	out = new DataOutputStream(o);
    	Writer tmp_wout = null;
    	try {
    		tmp_wout = new OutputStreamWriter(out, "UTF-8");
//    		tmp_wout = new OutputStreamWriter(out, "Shift_JIS");
    	} catch (UnsupportedEncodingException e) {
    		// ignore it
    	} finally {
    		wout = tmp_wout;
    	}

    	this.boundary = boundary;
    }

    /**
     * 
     * @param s
     * @return
     */
    private static String encode (String s)
    {
    	String encoded = null;
    	try {
    		encoded = URLEncoder.encode(s, "UTF-8");
//    		encoded = URLEncoder.encode(s, "Shift_JIS");
    	} catch ( UnsupportedEncodingException e ) {
    		// ignore it
    	}
    	return encoded;
    }

    /**
     * パラメータをストリームに追加します。
     *
     * @param name パラメータ名
     * @param value パラメータの値
     * @throws IOException 書き込み時にエラーが発生した
     */
    public void addProperty (String name, String value)
	throws IOException
    {
    	if ( boundary == null )
    	{
    		if ( needDelimeter )
    			wout.write('&');
            // ******************************************************************
    		// 2007/03/22 パラメータ値が[&],[+]の場合に不正動作 (不具合管理 188)
            // ******************************************************************
    		String encoded = encode(name) + "=" + encode(value);
    		wout.write(encoded);
    		wout.flush();
    		needDelimeter = true;
    		return;
    	}

    	out.writeBytes(SEPARATOR);
    	out.writeBytes(boundary);
    	out.write(CRLF);
    	wout.write("Content-Disposition: form-data; name=\"" + name + "\"");
    	wout.flush();
    	out.write(CRLF);
    	out.write(CRLF);
    	wout.write(value);
    	wout.flush();
    	out.write(CRLF);
    }

    /**
     * パラメータをストリームに追加します。
     *
     * @param name パラメータ名
     * @param value パラメータの値
     * @throws IOException 通信エラーが発生
     */
    public void addProperty (String name, int value)
	throws IOException
    {
    	addProperty(name, Integer.toString(value));
    }

    /**
     * ファイルの内容をストリームに追加します。<br>
     * 「マルチパート」モードのストリームでしか使用できません。
     *
     * @param file 追加するファイル
     * @param name パラメータ名
     * @param mimeType このファイルの MIME タイプ
     * @throws IOException 通信エラーが発生
     * @see #writeFileEntry
     */
    public void addFile (File file, String name, String mimeType)
	throws IOException
    {
    	if ( boundary == null )
    		throw new IllegalStateException("could not add a file for this stream.");

    	out.writeBytes(SEPARATOR);
    	out.writeBytes(boundary);
    	out.write(CRLF);
    	wout.write("Content-Disposition: form-data; name=\"" + name +
		   "\"; filename=\"" + file.getName() + "\"");
    	wout.flush();
    	out.write(CRLF);
    	wout.write("Content-Type: ");
    	wout.flush();
    	out.writeBytes(mimeType);
    	out.write(CRLF);
    	out.write(CRLF);

        // ************特別対応(バグ修正)*****************
        // put file contents
        FileInputStream reader = null;
        try{
            reader = new FileInputStream(file);
            final int BUFSIZE = 4096;
            byte[] buffer = new byte[BUFSIZE];
            while ( true )
            {
                int nRead = reader.read(buffer);
                if ( nRead == -1 )
                    break;
                out.write(buffer, 0, nRead);
            }
        }finally{
            if(reader!=null) try{reader.close();}catch(Exception e){};
        }

    	out.write(CRLF);
    }

    /**
     * ファイルを追加するための、"Content-Disposition" ヘッダを書き出します。<br>
     * ファイルの内容は write メソッドを使用してその後に追加します。<br>
     * ファイルの末尾では {@link #writeFileEnd} を呼び出します。<br>
     * 「マルチパート」モードのストリームでしか使用できません。
     *
     * @param name The name of this file property.
     * @param fileName 追加するファイル
     * @param mimeType このファイルの MIME タイプ
     * @throws IOException 通信エラーが発生
     * @see #writeFileEnd
     */
    public void writeFileEntry (String name, String fileName, String mimeType)
	throws IOException
    {
    	if ( boundary == null )
    		throw new IllegalStateException("could not add a file for this stream.");

    	out.writeBytes(SEPARATOR);
    	out.writeBytes(boundary);
    	out.write(CRLF);
    	wout.write("Content-Disposition: form-data; name=\"" + name +
    			"\"; filename=\"" + fileName + "\"");
    	wout.flush();
    	out.write(CRLF);
    	wout.write("Content-Type: ");
    	wout.flush();
    	out.writeBytes(mimeType);
    	out.write(CRLF);
    	out.write(CRLF);
    }

    /**
     * ファイルを追加するための、"Content-Disposition" ヘッダを書き出します。<br>
     * ファイルの内容は write メソッドを使用してその後に追加します。<br>
     * ファイルの末尾では {@link #writeFileEnd} を呼び出します。<br>
     * 「マルチパート」モードのストリームでしか使用できません。
     *
     * @param name The name of this file property.
     * @param fileName 追加するファイル
     * @param mimeType このファイルの MIME タイプ
	 * @param contType ファイルの種類で、MIME（マイム）形式を指定(コンテントタイプ)
     * @throws IOException 通信エラーが発生
     * @see #writeFileEnd
     */
    public void writeFileEntry (String name, 
    		                    String fileName, 
    		                    String mimeType,
    		                    String contType)
	throws IOException
    {
    	if ( boundary == null )
    		throw new IllegalStateException("could not add a file for this stream.");

    	out.writeBytes(SEPARATOR);
    	out.writeBytes(boundary);
    	out.write(CRLF);
    	wout.write("Content-Disposition: form-data; name=\"" + name +
    			"\"; filename=\"" + fileName + "\"");
    	wout.flush();
    	out.write(CRLF);
    	wout.write("Content-Type: " + contType);
    	wout.flush();
    	//out.writeBytes(mimeType);
    	out.write(CRLF);
    	out.write(CRLF);
    }

    /**
     * ファイルを追加するための、"Content-Disposition" ヘッダを書き出します。<br>
     * ファイルの内容は write メソッドを使用してその後に追加します。<br>
     * ファイルの末尾では {@link #writeFileEnd} を呼び出します。<br>
     * 「マルチパート」モードのストリームでしか使用できません。
     * 
     * @param accept
     * @throws IOException 通信エラーが発生
     */
    public void writeFileEntry2(String accept)
    throws IOException
    {
    	if ( boundary == null )
    		throw new IllegalStateException("could not add a file for this stream.");

    	//out.writeBytes(SEPARATOR);
    	//out.writeBytes(boundary);
    	//out.write(CRLF);
    	//wout.write("Content-Disposition: form-data; name=\"" + name +
    	//		"\"; filename=\"" + fileName + "\"");
    	//wout.flush();
    	out.write(CRLF);
    	wout.write("Accept-Encoding: " + accept);
    	wout.flush();
    	//out.writeBytes(mimeType);
    	out.write(CRLF);
    	out.write(CRLF);
    }
    
    /**
     * ファイルの内容をストリームに追加します。
     *
     * @param data 追加するオクテットデータ
     * @throws IOException 通信エラーが発生
     * @see #writeFileEntry
     */
    public void write (byte[] data)
	throws IOException
    {
    	out.write(data);
    }

    /**
     * ファイルの内容をストリームに追加します。<br>
     * 文字列は "Shift_JIS" にエンコードされます。
     *
     * @param s 追加する文字列
     * @throws IOException 通信エラーが発生
     * @see #writeFileEntry
     */
    public void write (String s)
	throws IOException
    {
    	wout.write(s);
    	wout.flush();
    }

    /**
     * ファイルの末尾のセパレータを書き出します。
     *
     * @throws IOException 通信エラーが発生
     * @see #writeFileEntry
     */
    public void writeFileEnd ()
	throws IOException
    {
    	out.write(CRLF);
    }

    /**
     * ストリームをクローズします。<br>
     * 「マルチパート」モードの場合は、終端記号をその前に書き出します。
     * 
     * @throws IOException 通信エラーが発生
     */
    public void close ()
	throws IOException
    {
    	if ( boundary != null )
    	{
    		out.writeBytes(SEPARATOR);
    		out.writeBytes(boundary);
    		out.writeBytes(SEPARATOR);
    		out.write(CRLF);
    	}
    	wout.close();
    }
}
