/* LdapExport.java */

import jp.co.cybozu.garoon2.*;
import jp.co.cybozu.text.*;
import javax.naming.NamingException;
import java.io.*;

/**
 * Communicate with an LDAP server to export user/organization entries
 * into Garoon CSV format files.  This class is merely a wrapper of
 * {@link jp.co.cybozu.garoon.LdapToCSV LdapToCSV}.
 * <br>
 * The generated CSV files are saved as "user.csv" for users, "ounit.csv"
 * for organizations, and "belong.csv" for relationships between users
 * and organizations.
 *
 * @author	kubota shoichiro 2005/11
 * @version	2.0
 * @see		jp.co.cybozu.garoon.LdapToCSV
 */
public class Ldap2Export
{
    private static final String userCSVFile = "users.csv";			// ユーザー情報
    private static final String belongCSVFile = "user_ounits.csv";	// 所属情報

    public static void usage() {
    	System.err.println("Usage: java LdapExport CONFIG");
    	System.err.println("CONFIG:                      A file that lists configuration properties.");
    	System.err.println();
    	System.err.println("OPTIONS:");
    	System.err.println("       -h                    Print this message and exit.");
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
    	String encode = null;

    	for ( int i = 1; i < args.length; i++ )	{
    		if ( args[i].equals("-charset") ) {
       			if (args[++i].equals("UTF8")) {
       				encode = "UTF8";
       			}
       			else if (args[i].equals("SJIS")) {
       				encode = "Shift_JIS";
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
    		// query charset.
    		if ( encode == null ) {
    			String en = null;
    			
    			do {
					System.err.println("In UTF8, please input 'UTF8'.");
					System.err.println("In SJIS, please input 'SJIS'.");
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

    		InputStream configIn = new FileInputStream(args[0]);
    		LdapToCSV conv = new LdapToCSV(configIn);
    		configIn.close();

    		/*
    		 * ユーザー情報のCSVデータ作成
    		 */
    		CSVWriter userCSV =
    			new CSVWriter(
    					new OutputStreamWriter(
			            new FileOutputStream(userCSVFile), encode));

    		conv.exportUser(args[0], userCSV);
    		userCSV.close();

    		/*
    		 * ユーザー所属組織情報のCSVデータ作成
    		 */
    		CSVWriter belongCSV =
    			new CSVWriter(
    					new OutputStreamWriter(
			            new FileOutputStream(belongCSVFile), encode));

    		conv.exportBelong(belongCSV);
    		belongCSV.close();
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
