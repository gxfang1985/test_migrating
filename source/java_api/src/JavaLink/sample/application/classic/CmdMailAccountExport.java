import java.io.IOException;
import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.RemoteException;

public class CmdMailAccountExport
{
    /**
     * ガイダンスを表示します。<BR>
     *
     */
    private static void usage ()
    {
        System.err.println("Usage: java CmdMailAccountExport [OPTIONS]");
        System.err.println("");
        System.err.println("OPTIONS:");
        System.err.println("       -h                  Display this help,then exit.");
        System.err.println("       -o    URL           The url of the garoon administration system.");
        System.err.println("       -u    USER          The user account to login garoon.");
        System.err.println("       -p    PASSWORD      The password of the user.");
        System.err.println("       -f    FILE          The csv file to write.");
        System.err.println("       -utf8               The character-code of the file is utf8.");
        System.err.println("       -he                 There is the header.");
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

        String url = null;                                  // GaroonのURL
        String user = null;                                 // ユーザーアカウント名
        String password = null;                             // パスワード
        String filePath = null;                             // CSVファイルパス
        boolean sjisEncoding = true;                       // ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
        boolean skip = false;                              // 先頭行の有無(true:有 false:無)
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
            else if ( args[i].equals("-f") ) {                // CSVファイルパス

                if ( i == (args.length - 1) ) {
                    System.err.println("missing csv file after -f.");
                    System.err.println();
                    usage();
                    return;
                }
                filePath = args[++i];
            }
            else if ( args[i].equals("-utf8") ) {              // ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)

                sjisEncoding = false;
            }
            else if ( args[i].equals("-he") ) {                // 先頭行の有無(true:有 false:無)

                skip = true;
            }
            else {
                System.err.println("warning: unknown option " + args[i]);
                usage(); 
                return; 
            }
        }
        
        // 必須オプションチェック
        if ( url == null ) {                 // URL
            System.err.println("[-o URL] is indispensable option.");
            usage();
            return;
        }
        if ( user == null ) {                // ログイン名
            System.err.println("[-u USER] is indispensable option.");
            usage();
            return;
        }
        if ( password == null ) {            // パスワード
            System.err.println("[-p PASSWORD] is indispensable option.");
            usage();
            return;
        }
        if ( filePath == null ) {            // CSVファイルパス
            System.err.println("[-f FILE] is indispensable option.");
            usage();
            return;
        }
        
        try {
            // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
            grnLink = new CoopLink( url, user, password );

            // Garoonへデータ送信
            grnLink.exportMailAccount( filePath,                // CSVファイルパス
                                       skip,                    // 先頭行の有無(true:有 false:無)
                                       sjisEncoding);           // ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
            
            System.out.println("The export of the csv file was executed.(" + filePath + ")");
        }
        catch ( RemoteException e ) {           //ガルーン上のエラー
            System.err.println(e.toString());
        } 
        catch ( IOException e ) {               // その他通信上のエラー
            System.err.println(e.toString());
        }
        catch ( NullPointerException e ) {
            System.err.println(e.toString());
        }
        finally {
            grnLink.logout();
        }
    }
}