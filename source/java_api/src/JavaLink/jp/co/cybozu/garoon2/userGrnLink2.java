package jp.co.cybozu.garoon2;

import jp.co.cybozu.http.*;
import java.io.*;

/**
 * システム管理にログインし、ユーザー情報の書き込みを行う。
 *
 * @author サイボウズ
 * @version	1.0.0
 */
public class userGrnLink2 extends HttpClient
{
    private static final String GASERROR_HEADER = "X-Cybozu-Error";
  
    /**
     * システム管理に接続、ログインし、セッションを開始します
     *
     * @param uri ガルーン２のURL
     * @param userName ログインするユーザーアカウント名
     * @param password ログインするためのパスワード 
     * @throws IOException 通信エラーが発生
     * @throws RemoteException システム管理でエラーが発生
     */
    protected userGrnLink2(URI uri, String userName, String password)
	throws IOException, RemoteException
    {
    	super(uri);
    	login(userName, password);
    }

    /**
     * システム管理に接続、ログインし、セッションを開始します
     * 
     * @param uri ガルーン２のURL
     * @throws IOException 通信エラーが発生
     * @throws RemoteException システム管理でエラーが発生
     */
    protected userGrnLink2(URI uri)
	throws IOException, RemoteException
    {
    	super(uri);
    }
    
    /**
     * システム管理に接続、ログインし、セッションを開始します。（ユーザー情報）
     *
     * @param uri ガルーン２のURL
     * @param userName ログインするユーザーアカウント名
     * @param password ログインするためのパスワード 
     * @throws IOException 通信エラーが発生
     * @throws RemoteException システム管理でエラーが発生
     */
    public userGrnLink2(String uri, String userName, String password)
	throws IOException, RemoteException
    {
    	this(URI.create(uri + "/ldap/system/ldapUser_import1"), userName, password);
    }
    
    /**
     * システム管理に接続、ログインし、セッションを開始します。（ユーザー情報）
     * 
     * @param uri ガルーン２のURL
     * @throws IOException 通信エラーが発生
     * @throws RemoteException システム管理でエラーが発生
     */
    public userGrnLink2(String uri)
	throws IOException, RemoteException
    {
    	this(URI.create(uri + "/ldap/system/ldapUser_import2"));
    }
    
    /**
     * システム管理からの返答を解析する。
     * もし返答がエラーを示す場合、 {@link RemoteException} が投げられる。
     *
     * @param hc {@link #getConnection} から取得した HttpURLConnection。
     * @param context RemoteException 中に埋め込まれる、状況を 表す文字列
     * @throws IOException 通信エラーが発生
     * @throws RemoteException システム管理でエラーが発生
     */
    protected void processHeader(java.net.HttpURLConnection hc,
				 String context)
	throws IOException, RemoteException
    {
    	super.processHeader( hc );

    	String err = hc.getHeaderField( GASERROR_HEADER );
    	if ( err != null )
    	{
    		System.err.println("\n" + context);
    		System.err.println("Error Number: " + err);
    	}
    }

    /**
     * システム管理からの返答を解析する。
     * もし返答がエラーを示す場合、 {@link RemoteException} が投げられる。
     * 
     * @param hc {@link #getConnection} から取得した HttpURLConnection。
     * @param context RemoteException 中に埋め込まれる、状況を 表す文字列
     * @return ガルーン２のエラーコード
     * @throws IOException 通信エラーが発生
     * @throws RemoteException システム管理でエラーが発生
     */
    protected String processHeader2(java.net.HttpURLConnection hc,
			 String context)
    throws IOException, RemoteException
    {
    	String s = super.processHeader2( hc );

    	String err = hc.getHeaderField( GASERROR_HEADER );
    	if ( err != null )
    	{
    		System.err.println("\n" + context);
    		System.err.println("Error Number: " + err);
    	}
    	return s;
    }
    
    /**
     * システム管理からの返答を解析する。
     * もし返答がエラーを示す場合、 {@link RemoteException} が投げられる。
     *
     * @param hc {@link #getConnection} から取得した HttpURLConnection。
     * @param context RemoteException 中に埋め込まれる、状況を 表す文字列
     * @throws IOException 通信エラーが発生
     * @throws RemoteException システム管理でエラーが発生
     */
    protected void processResult(java.net.HttpURLConnection hc,
				 String context)
	throws IOException, RemoteException
    {
    	processHeader(hc, context);

    	// closes and discards the result output.
    	hc.getInputStream().close();
    }

    /**
     * システム管理にログインしてセッションを開始する。
     * インスタンス生成時に、{@link #userGrnLink2}内で呼ばれている。
     *
     * @param userName ログインするユーザーアカウント名
     * @param password ログインするためのパスワード 
     * @throws IOException 通信エラーが発生
     * @throws RemoteException システム管理でエラーが発生
     */
    public void login(String userName, String password)
	throws IOException, RemoteException
    {
    	if ( userName == null )
    		throw new NullPointerException("userName is null.");

    	if ( password == null )
    		throw new NullPointerException("password is null.");

    	java.net.HttpURLConnection hc = getConnection(HttpClient.POST);

		PostStream ps = getURLEncodingStream(hc);
		ps.addProperty("_system", 1);
		ps.addProperty("_account", userName);
		ps.addProperty("_password", password);
		ps.close();

		processResult(hc, "login failed.");
    }

    // API
    /**
     * ガルーン２にユーザー情報データを送信
     * 
     * @param data ユーザー情報
     * @param skipFirst 先頭行に項目名を書き出す。trueの場合は先頭行に項目名を書き出し、falseの場合は先頭行に項目名を書き出さない。
     * @return ガルーン２のエラーコード
     * @throws IOException 通信エラーが発生
     * @throws RemoteException システム管理でエラーが発生
     */
    public String uploadUserCSV(byte[] data, boolean skipFirst, String encode)
	throws IOException, RemoteException
    {
    	java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
    	
    	PostStream ps = getMultipartStream(hc);
    	ps.writeFileEntry("file", 
    			          "users.csv", 
    			          "",
    			          "text/plain");
    	ps.write( data );
    	ps.writeFileEnd();
    	
    	if ( skipFirst ) {
    		ps.addProperty("ItemName", 1);
    	}
    	if (encode == "Shift_JIS")
    		ps.addProperty("charset", "SJIS-win");
    	else
    		ps.addProperty("charset", "UTF8");
    	if ( skipFirst ) {
    		ps.addProperty("skip", 1);
    	}
    	else {
    		ps.addProperty("skip", 0);
    	}
    	ps.addProperty("old", 1); // Added to import the user.csv file in Garoon 3.0.0 format
    	ps.addProperty("send", "test");
    	ps.addProperty("fn", "system/user/user_import1");
    	ps.close();

    	String s = processHeader2(hc,"failed to upload a user CSV file.");
    	
    	return s;
    }
    
    /**
     * 送信されたユーザー所属組織情報データをガルーン２に取り込む
     * 
     * @param uri ガルーン２のURL
     * @throws IOException 通信エラーが発生
     * @throws RemoteException システム管理でエラーが発生
     */
    public void uploadCommit( String uri )
	throws IOException, RemoteException
	{
    	java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
    	
    	int pos = uri.indexOf('?');
    	if ( pos == -1 )
    	    throw new IllegalArgumentException("invalid header: " + pos);
    	
    	String key = "";
    	String buf = "";
    	boolean keyType = true;
    	
    	PostStream ps = getURLEncodingStream(hc);

    	String buffer = uri.substring(pos + 1);
    	StringReader sr = new StringReader( buffer );
	    while ( true )
	    {
	    	int ic = sr.read();
	    	if ( (ic == -1) ) {
	    		if (buf.length() > 0) {
	    			if (key.equals("file")) key = "file_id";
	    			ps.addProperty(key, buf);
	    		}
	    		break;
	    	}
	    	
	    	char c = (char)ic;

	    	if (c == '=') keyType = false;
	    	else if (c == '&') {
	    		keyType = true;
    			if (key.equals("file")) key = "file_id";
	    		ps.addProperty(key, buf);
	    		key = "";
	    		buf = "";
	    	}
	    	else {
	    		if (keyType)	key = key + c;
	    		else 			buf = buf + c;
	    	}
	    }
    	ps.close();
    	
    	processResult(hc, "failed to upload a user CSV file.");
    }
}
