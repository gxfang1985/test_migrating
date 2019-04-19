/* LdapSync.java */

import jp.co.cybozu.garoon2.*;
import jp.co.cybozu.text.*;
import javax.naming.NamingException;
import java.io.*;

/**
 * Synchronize user/organization information between an LDAP server
 * and Garoon.  This class illustrates how to import LDAP information
 * into Garoon without human interaction by using {@link
 * jp.co.cybozu.garoon.LdapToCSV LdapToCSV} and {@link
 * jp.co.cybozu.garoon.GASLink GASLink}.
 *
 * @author	kubota shoichiro 2005/11
 * @version	2.0
 * @see		jp.co.cybozu.garoon.LdapToCSV
 * @see		jp.co.cybozu.garoon.GASLink
 */
public class Ldap2Sync {
    public static void usage() {
    	System.err.println("Usage: java LdapSync CONFIG [OPTIONS]");
    	System.err.println("CONFIG:                      A file that lists configuration properties.");
    	System.err.println();
    	System.err.println("OPTIONS:");
    	System.err.println("       -h                    Print this message and exit.");
    	System.err.println("       -o       URL          The URL of the Garoon Administration System.");
    	System.err.println("       -u       USER         The user name to login GAS.");
    	System.err.println("       -p       PASSWORD     The password of the USER.");
    	System.err.println("       -charset SJIS or UTF8 In SJIS '-charset SJIS' is set up and is UTF8, '-charset UTF8' is set up.");
    }

    public static void main(String[] args)
	throws NamingException {
    	if ( args.length == 0 )	{
    		System.err.println("too few arguments.");
    		System.err.println();
    		usage();
    		return;
    	}
    	else if ( args[0].equals("-h") ) {
			usage();
			return;
    	}

    	// parse command-line arguments
    	String url = null;
    	String user = null;
    	String password = null;
    	String encode = null;

    	for ( int i = 1; i < args.length; i++ )	{
    		if ( args[i].equals("-h") ) {			// Print this message and exit.
    			usage();
    			return;
    		}
    		else if ( args[i].equals("-o") ) {		// The URL of the Garoon Administration System.(URL)
    			if ( i == (args.length - 1) ) {
    				System.err.println("missing URL after -o.");
    				System.err.println();
    				usage();
    				return;
    			}
    			url = args[++i];
    		}
    		else if ( args[i].equals("-u") ) {		// The user name to login GAS.(User)
    			if ( i == (args.length - 1) ) {
    				System.err.println("missing user name after -u.");
    				System.err.println();
    				usage();
    				return;
    			}
    			user = args[++i];
    		}
    		else if ( args[i].equals("-p") ) {		// The password of the USER.(Password)
    			if ( i == (args.length - 1) ) {
    				System.err.println("missing password after -p.");
    				System.err.println();
    				usage();
    				return;
    			}
    			password = args[++i];
    		}
    		else if ( args[i].equals("-charset") ) {
    			if (args[++i].equals("SJIS")) {
    				encode = "Shift_JIS";
    			}
    			else if (args[i].equals("UTF8")) {
    				encode = "UTF8";
    			}
    		}
    		else {
    			System.err.println("warning: unknown option " + args[i]);
        		usage();
        		return;
    		}
    	}

    	BufferedReader in = new BufferedReader(
    			new InputStreamReader(System.in));

    	try {
    		String inp = null;
    		
    		// query URI.
    		if ( url == null ) {
    			do {
        			System.err.print("URI: ");
        			inp = in.readLine();
        			if (inp.length() > 0) {
        				url = inp;
        			}
    			} while(url == null);
    		}

    		// query user.
    		if ( user == null ) {
    			do {
        			System.err.print("User: ");
        			inp = in.readLine();
        			if (inp.length() > 0) {
        				user = inp;
        			}
    			} while(user == null);
    		}

    		// query password.
    		if ( password == null ) {
    			System.err.print("Password: ");
    			password = in.readLine();
    		}
    		
    		// query charset.
    		if ( encode == null ) {
    			String en = null;
    			
    			do {
    				System.err.println("In UTF8, pleass input UTF8.");
    				System.err.println("In SJIS, pleass input SJIS.");
    				System.err.println("charset: ");
    				en = in.readLine();
    				if (en.equals("SJIS")) {
    					encode = "Shift_JIS";
    				}
    				else if (en.equals("UTF8")) {
    					encode = "UTF8";
    				}
    			} while(encode == null);
    		}

    		// data export
    		InputStream configIn = new FileInputStream(args[0]);
    		LdapToCSV conv = new LdapToCSV(configIn);
    		configIn.close();

    		/*
    		 * ユーザー情報のCSVデータ作成
    		 */
    		ByteArrayOutputStream userData = new ByteArrayOutputStream();
    			CSVWriter userCSV =
    				new CSVWriter(
    				new OutputStreamWriter( userData, encode ) );

    		conv.exportUser(args[0], userCSV);
    		userCSV.close();

    		/*
    		 * ユーザー所属組織情報のCSVデータ作成
    		 */
    		ByteArrayOutputStream belongData = new ByteArrayOutputStream();
    			CSVWriter belongCSV =
    				new CSVWriter(
    				new OutputStreamWriter( belongData, encode ) );

    		conv.exportBelong(belongCSV);
    		belongCSV.close();

    		/*
    		 * ユーザー情報のデータ送信
    		 */
    		if ( userData.size() != 0 ) {
        		// ガルーン２への接続
        		userGrnLink2 userGrn2 = new userGrnLink2( url, user, password );
        		
    			// ガルーン２にユーザー情報データを送信
    			String uri = userGrn2.uploadUserCSV( userData.toByteArray(), false, encode );
    			
    			// 送信されたユーザー情報データをガルーン２に取り込む
    			userGrn2 = new userGrnLink2( url );
    			userGrn2.uploadCommit( uri );
    			
        		userGrn2.logout();
    		}
    		
    		/*
    		 * ユーザー所属組織情報のデータ送信
    		 */
    		if ( userData.size() != 0 ) {
        		// ガルーン２への接続
        		belongGrnLink2 belongGrn2 = new belongGrnLink2( url, user, password );

    			// ガルーン２にユーザー情報データを送信
    			String uri = belongGrn2.uploadBelongCSV( belongData.toByteArray(), false, encode );
    			
    			// 送信されたユーザー情報データをガルーン２に取り込む
    			belongGrn2 = new belongGrnLink2( url );
    			belongGrn2.uploadCommit( uri );

        		belongGrn2.logout();
    		}
    	} 
    	catch ( RemoteException e ) {
    		System.err.println(e.toString());
    	} 
    	catch ( IOException e ) {
    		System.err.println(e.toString());
    	} 
    	catch ( NamingException e ) {
    		System.err.println(e.toString());
    	} 
    	catch ( ConfigurationException e ) {
    		System.err.println(e.toString());
    	} 
    	catch ( ParseException e ) {
    		System.err.println(e.toString());
    	}
    }
}
