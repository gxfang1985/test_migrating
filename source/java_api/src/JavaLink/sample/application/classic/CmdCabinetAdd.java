import java.io.*;
import jp.co.cybozu.garoon2.*;


public class CmdCabinetAdd
{
    /**
     * ガイダンスを表示します。<BR>
     *
     */
    private static void usage ()
    {
        System.err.println("Usage: java CmdCabinetAdd [OPTIONS]");
        System.err.println("");
        System.err.println("OPTIONS:");
        System.err.println("       -h                 Display this help,then exit.");
        System.err.println("       -o   URL           The url of the garoon administration system.");
        System.err.println("       -u   USER          The user account to login garoon.");
        System.err.println("       -p   PASSWORD      The password of the user.");
        System.err.println("       -r   REGISTRANT    I appoint the user account which I registered an file with.");
        System.err.println("                          It is not necessary for a case same as a login user to input it.");
        System.err.println("       -fc  FOLDERCODE    The folder code of file management.");
        System.err.println("       -f   FILE          The file to upload.");
        System.err.println("       -t   TITLE         The title of file.");
        System.err.println("       -v   VERSION       The version of file.");
        System.err.println("       -m   MEMO          The memo of file.");
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
        String title = null;                                // タイトル
        String folder = null;                               // フォルダコード
        String version = "0";                                // バージョン管理
        String memo = null;                                  // ファイルの説明
        String registrant = null;                            // 登録者
        File file = null;                                    // ファイル
        String fileId = null;                                // ファイルID
        CoopLink cabinetLink = null;

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
            else if ( args[i].equals("-t") ) {                // タイトル
                if ( i == (args.length - 1) ) {
                    System.err.println("missing title after -t.");
                    System.err.println();
                    usage();
                    return;
                }
                title = args[++i];
            }
            else if ( args[i].equals("-fc") ) {                // フォルダコード
                if ( i == (args.length - 1) ) {
                    System.err.println("missing folder after -fo.");
                    System.err.println();
                    usage();
                    return;
                }
                folder = args[++i];
            }
            else if ( args[i].equals("-v") ) {                // バージョン管理
                if ( i == (args.length - 1) ) {
                    System.err.println("missing version after -v.");
                    System.err.println();
                    usage();
                    return;
                }
                
                version = args[++i];
            }
            else if ( args[i].equals("-m") ) {                // ファイルの説明
                if ( i == (args.length - 1) ) {
                    System.err.println("missing explanation of a file after -m.");
                    System.err.println();
                    usage();
                    return;
                }
                memo = args[++i];
            }
            else if ( args[i].equals("-r") ) {                // 登録者
                if ( i == (args.length - 1) ) {
                    System.err.println("missing registrant of a file after -r.");
                    System.err.println();
                    usage();
                    return;
                }
                registrant = args[++i];
            }
            else if ( args[i].equals("-f") ) {                // ファイル
                if ( i == (args.length - 1) ) {
                    System.err.println("missing a file to add after -f.");
                    System.err.println("");
                    usage();
                    return;
                }
                file = new File(args[++i]);
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
            
            if ( folder == null ) {                          // フォルダコード
                do {
                    System.err.print("Folder: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        folder = inp;
                    }
                } while(folder == null);
            }
            
            if ( file == null ) {                            // ファイルパス
                do {
                    System.err.print("File: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        file = new File(inp);
                    }
                } while(file == null);
            }

            // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
            cabinetLink = new CoopLink( url, user, password );

            // Garoonへデータ送信
            fileId = cabinetLink.putCabinetAdd( title,                     // タイトル
                                                folder,                    // フォルダコード
                                                Long.parseLong(version),   // バージョン管理
                                                memo,                      // ファイルの説明
                                                registrant,                // 登録者
                                                file );                    // ファイル
        }
        catch ( RemoteException e ) {           //ガルーン上のエラー
            System.err.println(e.toString());
        } 
        catch ( IOException e ) {               // その他通信上のエラー
            System.err.println(e.toString());
        }
        catch ( IllegalArgumentException e ) {  // 引数エラー 
            System.err.println(e.toString());
        } 
        catch ( NullPointerException e ) {
            System.err.println(e.toString());
        }
        finally {
            cabinetLink.logout();
            
            if ( fileId != null )                            // ファイルID
                System.out.println( fileId );                 // 戻り値(ファイルID)
        }
    }
}