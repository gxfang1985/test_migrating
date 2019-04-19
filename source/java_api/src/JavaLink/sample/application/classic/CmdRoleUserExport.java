import java.io.*;
import jp.co.cybozu.garoon2.*;

public class CmdRoleUserExport
{
    /**
     * ガイダンスを表示します。<BR>
     *
     */
    private static void usage ()
    {
        System.err.println("Usage: java CmdRoleUserExport [OPTIONS]");
        System.err.println("");
        System.err.println("OPTIONS:");
        System.err.println("       -h                 Display this help,then exit.");
        System.err.println("       -o   URL           The url of the garoon administration system.");
        System.err.println("       -u   USER          The user account to login garoon administration system.");
        System.err.println("       -p   PASSWORD      The password of the user.");
        System.err.println("       -f   FILE          The csv file to write.");
        System.err.println("       -utf8              The character-code of the file is utf8.");
        System.err.println("                          When not specifying this.The character-code of the file is shift_jis.");
        System.err.println("       -he                There is the header.");
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
        String user = null;                                   // ユーザーアカウント名
        String password = null;                               // パスワード
        String filepath = null;                               // ファイルパス
        boolean sjisEncode = true;                           // エンコード指定(true:Shif_JIS,false:UTF-8)
        boolean skip = false;                                // 先頭行の有無
        CoopLink grnLink = null;

        for ( int i = 0; i < args.length; i++ )    {
            if ( args[i].equals("-h") ) {                    // Print this message and exit.
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
            else if ( args[i].equals("-u") ) {                // ユーザーアカウント名
                if ( i == (args.length - 1) ) {
                    System.err.println("missing user name after -u.");
                    System.err.println();
                    usage();
                    return;
                }
                user = args[++i];
            }
            else if ( args[i].equals("-p") ) {                // ユーザーパスワード
                if ( i == (args.length - 1) ) {
                    System.err.println("missing password after -p.");
                    System.err.println();
                    usage();
                    return;
                }
                password = args[++i];
            }
            else if ( args[i].equals("-f") ) {                // ファイルパス
                if ( i == (args.length - 1) ) {
                    System.err.println("missing csv file after -f.");
                    System.err.println("");
                    usage();
                    return;
                }
                filepath = args[++i];
            }
            else if ( args[i].equals("-he") ) {                // 先頭行の有無
                skip = true;
            }
            else if ( args[i].equals("-utf8") ) {            // エンコード指定(true:Shif_JIS,false:UTF-8)
                
                sjisEncode = false;
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
            
            if ( url == null ) {                            // GaroonのURL
                do {
                    System.err.print("URL: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        url = inp;
                    }
                } while(url == null);
            }

            if ( user == null ) {                            // ユーザーアカウント名
                do {
                    System.err.print("User: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        user = inp;
                    }
                } while(user == null);
            }

            if ( password == null ) {                        // パスワード
                System.err.print("Password: ");
                password = in.readLine();
            }
            
            if ( filepath == null ) {                        // ファイルパス
                do {
                    System.err.print("File: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        filepath = inp;
                    }
                } while(filepath == null);
            }

            // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
            grnLink = new CoopLink( url,user,password );

            // Garoonへデータ送信
            grnLink.exportRoleUser( filepath,                // ファイルパス
                                    skip,                    // 先頭行の有無
                                    sjisEncode );            // エンコード指定(true:Shif_JIS,false:UTF-8)
            
            System.out.println("The download of the csv file was executed.(" + filepath + ")");
        }
        catch ( RemoteException e ) {
            System.err.println(e.toString());
        } 
        catch ( IOException e ) {
            System.err.println(e.toString());
        } 
        catch ( NullPointerException e ) {
            System.err.println(e.toString());
        }
        catch ( IllegalArgumentException e ) {
            System.err.println(e.toString());
        }
        finally {
            grnLink.logout();
        }
    }
}