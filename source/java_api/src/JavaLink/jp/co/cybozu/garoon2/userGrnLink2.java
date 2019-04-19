package jp.co.cybozu.garoon2;

import jp.co.cybozu.http.*;
import java.io.*;

/**
 * �V�X�e���Ǘ��Ƀ��O�C�����A���[�U�[���̏������݂��s���B
 *
 * @author �T�C�{�E�Y
 * @version	1.0.0
 */
public class userGrnLink2 extends HttpClient
{
    private static final String GASERROR_HEADER = "X-Cybozu-Error";
  
    /**
     * �V�X�e���Ǘ��ɐڑ��A���O�C�����A�Z�b�V�������J�n���܂�
     *
     * @param uri �K���[���Q��URL
     * @param userName ���O�C�����郆�[�U�[�A�J�E���g��
     * @param password ���O�C�����邽�߂̃p�X���[�h 
     * @throws IOException �ʐM�G���[������
     * @throws RemoteException �V�X�e���Ǘ��ŃG���[������
     */
    protected userGrnLink2(URI uri, String userName, String password)
	throws IOException, RemoteException
    {
    	super(uri);
    	login(userName, password);
    }

    /**
     * �V�X�e���Ǘ��ɐڑ��A���O�C�����A�Z�b�V�������J�n���܂�
     * 
     * @param uri �K���[���Q��URL
     * @throws IOException �ʐM�G���[������
     * @throws RemoteException �V�X�e���Ǘ��ŃG���[������
     */
    protected userGrnLink2(URI uri)
	throws IOException, RemoteException
    {
    	super(uri);
    }
    
    /**
     * �V�X�e���Ǘ��ɐڑ��A���O�C�����A�Z�b�V�������J�n���܂��B�i���[�U�[���j
     *
     * @param uri �K���[���Q��URL
     * @param userName ���O�C�����郆�[�U�[�A�J�E���g��
     * @param password ���O�C�����邽�߂̃p�X���[�h 
     * @throws IOException �ʐM�G���[������
     * @throws RemoteException �V�X�e���Ǘ��ŃG���[������
     */
    public userGrnLink2(String uri, String userName, String password)
	throws IOException, RemoteException
    {
    	this(URI.create(uri + "/ldap/system/ldapUser_import1"), userName, password);
    }
    
    /**
     * �V�X�e���Ǘ��ɐڑ��A���O�C�����A�Z�b�V�������J�n���܂��B�i���[�U�[���j
     * 
     * @param uri �K���[���Q��URL
     * @throws IOException �ʐM�G���[������
     * @throws RemoteException �V�X�e���Ǘ��ŃG���[������
     */
    public userGrnLink2(String uri)
	throws IOException, RemoteException
    {
    	this(URI.create(uri + "/ldap/system/ldapUser_import2"));
    }
    
    /**
     * �V�X�e���Ǘ�����̕ԓ�����͂���B
     * �����ԓ����G���[�������ꍇ�A {@link RemoteException} ����������B
     *
     * @param hc {@link #getConnection} ����擾���� HttpURLConnection�B
     * @param context RemoteException ���ɖ��ߍ��܂��A�󋵂� �\��������
     * @throws IOException �ʐM�G���[������
     * @throws RemoteException �V�X�e���Ǘ��ŃG���[������
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
     * �V�X�e���Ǘ�����̕ԓ�����͂���B
     * �����ԓ����G���[�������ꍇ�A {@link RemoteException} ����������B
     * 
     * @param hc {@link #getConnection} ����擾���� HttpURLConnection�B
     * @param context RemoteException ���ɖ��ߍ��܂��A�󋵂� �\��������
     * @return �K���[���Q�̃G���[�R�[�h
     * @throws IOException �ʐM�G���[������
     * @throws RemoteException �V�X�e���Ǘ��ŃG���[������
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
     * �V�X�e���Ǘ�����̕ԓ�����͂���B
     * �����ԓ����G���[�������ꍇ�A {@link RemoteException} ����������B
     *
     * @param hc {@link #getConnection} ����擾���� HttpURLConnection�B
     * @param context RemoteException ���ɖ��ߍ��܂��A�󋵂� �\��������
     * @throws IOException �ʐM�G���[������
     * @throws RemoteException �V�X�e���Ǘ��ŃG���[������
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
     * �V�X�e���Ǘ��Ƀ��O�C�����ăZ�b�V�������J�n����B
     * �C���X�^���X�������ɁA{@link #userGrnLink2}���ŌĂ΂�Ă���B
     *
     * @param userName ���O�C�����郆�[�U�[�A�J�E���g��
     * @param password ���O�C�����邽�߂̃p�X���[�h 
     * @throws IOException �ʐM�G���[������
     * @throws RemoteException �V�X�e���Ǘ��ŃG���[������
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
     * �K���[���Q�Ƀ��[�U�[���f�[�^�𑗐M
     * 
     * @param data ���[�U�[���
     * @param skipFirst �擪�s�ɍ��ږ��������o���Btrue�̏ꍇ�͐擪�s�ɍ��ږ��������o���Afalse�̏ꍇ�͐擪�s�ɍ��ږ��������o���Ȃ��B
     * @return �K���[���Q�̃G���[�R�[�h
     * @throws IOException �ʐM�G���[������
     * @throws RemoteException �V�X�e���Ǘ��ŃG���[������
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
     * ���M���ꂽ���[�U�[�����g�D���f�[�^���K���[���Q�Ɏ�荞��
     * 
     * @param uri �K���[���Q��URL
     * @throws IOException �ʐM�G���[������
     * @throws RemoteException �V�X�e���Ǘ��ŃG���[������
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
