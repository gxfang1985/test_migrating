import java.io.*;
import jp.co.cybozu.garoon2.*;

public class CmdApiVersion
{
    /**
     * ガイダンスを表示します。<BR>
     *
     */
    private static void usage ()
    {
        System.err.println("Usage: java CmdApiVersion [OPTIONS]");
        System.err.println("");
        System.err.println("OPTIONS:");
        System.err.println("       -h                  Display this help,then exit.");
        System.err.println("       -o       URL        The URL of the garoon administration system.");
    }

    /**
     * 連携API(CSPファイル)のバージョンを取得<BR>
     * 
     * @param url garoonのURL
     * @param page バージョンを取得するスクリプトファイル名
     * @return バージョン
     */
    private static String version (String url)
    throws IOException, RemoteException
    {
        String version = null;
        
           // garoonへの接続
           CoopLink verLink = new CoopLink(url); 

           // garoonへデータ送信
           version = verLink.versionInfo();
            
           verLink.logout();
    
        return version;
    }

    /**
     * 指定した桁数に項目が足らない場合に足らない分スペースでうめる。<BR>
     * 
     * @param len 桁数
     * @param strVal 項目
     * @return 編集した項目
     */
    private static String addSpace (int len, String strVal)
    {
        String disppage = strVal;
        for (int index = 0 ; index < len ; index++) {
            disppage = disppage + " ";
        }
        
        return disppage;
    }
    
    /**
     * メイン処理<BR>
     * 
     * @param args
     */
    public static void main( String[] args )
    {
        if ( args.length == 0 )    {
            System.err.println("too few arguments.");
            System.err.println();
            usage();
            return;
        }

        String url = null;                                    // GaroonのURL

        for ( int i = 0; i < args.length; i++ )    {
            if ( args[i].equals("-h") ) {                     // Print this message and exit.
                usage();
                return;
            }
            else if ( args[i].equals("-o") ) {                // GaroonのURL
                if ( i == (args.length - 1) ) {
                    System.err.println("missing URL after -o.");
                    System.err.println();
                    usage();
                    return;
                }
                url = args[++i];
            }
            else {
                System.err.println("warning: unknown option " + args[i]);
                usage(); 
                return; 
            }
        }
            
        try {
            String title = null;
            String verJar = null;
            String verCsp = null;
            String disppage = null;
            String dispver = null;
            
            // APIのバージョン取得
            if ( (verCsp = version(url)) == null ) verCsp = "";
           
			// 2011/06/01 不具合GRNJAVAAPI-6の改修
            System.err.println( "+--------------------------------------+----------------------+");
            System.err.println( "|function                              |version               |");
            System.err.println( "+--------------------------------------+----------------------+");
            
            title = "garoon2.jar version";
            
            verJar = CoopLink.getCoopLinkVersion();
            disppage = addSpace((38 - title.length()), title);
            dispver = addSpace((9 - verJar.length()), verJar);
            System.err.println( "|" + disppage + "|" + dispver + "|" );

            title = "csp File version";
            disppage = addSpace((38 - title.length()), title);
            dispver = addSpace((9 - verCsp.length()), verCsp);
            System.err.println( "|" + disppage + "|" + dispver + "|" );
            System.err.println( "+--------------------------------------+----------------------+");// 2011/06/01 不具合GRNJAVAAPI-6の改修
        }
        catch ( FileNotFoundException e ) {
            System.err.println( e.toString() );
        }
        catch ( RemoteException e ) {
            System.err.println(e.toString());
        }
        catch ( IOException e ) {
            System.err.println( e.toString() );
        }
    }
}
