import java.io.IOException;

import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.RemoteException;

public class CmdWorkFlowDownloadSystemFile {
    
    
    /**
     * ガイダンスを表示します。<BR>
     *
     */
    private static void usage ()
    {
        System.err.println("Usage: java CmdWorkFlowDownloadSystemFile [OPTIONS]");
        System.err.println("");
        System.err.println("OPTIONS:");
        System.err.println("       -h                   Display this help,then exit.");
        System.err.println("       -o   URL             The url of the garoon administration system.");
        System.err.println("       -u   USER            The user account to login garoon.");
        System.err.println("       -p   PASSWORD        The password of the user.");
        System.err.println("       -id  ATTACHEDFILEID  The attached file id that you want to download.");
        System.err.println("       -d   DIRECTORYPATH   The saved directory of attached file.");
        System.err.println("       -f   FILENAME        The name of attached file.");
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

        String url = null;                           // GaroonのURL
        String user = null;                          // ユーザーアカウント名
        String password = null;                      // パスワード
        String afid = null;                          // ワークフローの添付ファイルID
        String dirPath = null;                       // ディレクトリパス
        String fileName = null;                      // 添付ファイル名
        
        CoopLink workflowLink = null;                 // CoopLink代入用

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
            else if ( args[i].equals("-id") ) {                // ワークフローの添付ファイルID
                if ( i == (args.length - 1) ) {
                    System.err.println("missing attached file id after -id.");
                    System.err.println();
                    usage();
                    return;
                }
                afid = args[++i];
            }
            else if ( args[i].equals("-d") ) {                // ディレクトリパス
                if ( i == (args.length - 1) ) {
                    System.err.println("missing directory path after -d.");
                    System.err.println();
                    usage();
                    return;
                }
                dirPath = args[++i];
            } 
            else if ( args[i].equals("-f") ) {                // 添付ファイル名
                if ( i == (args.length - 1) ) {
                    System.err.println("missing attached file name after -f.");
                    System.err.println();
                    usage();
                    return;
                }
                fileName = args[++i];
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
        if (afid == null ) {                 // ワークフローの添付ファイルIDの指定
            System.err.println("[-id ATTACHEDFILEID] is indispensable option.");
            usage();
            return;
        }

        try{
            // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
            workflowLink = new CoopLink( url, user, password );
            
            // Garoonへデータ送信
            if(fileName == null){
                // ガルーン２ ワークフロー上の添付ファイル名で保存する場合
                workflowLink.downloadSystemWorkFlowAttachedFile( Long.parseLong(afid),     // ワークフローの添付ファイルID      
                                                                 dirPath );               // ディレクトリパス
            }else{                         
                // ファイル名を別名で保存する場合
                workflowLink.downloadSystemWorkFlowAttachedFile( Long.parseLong(afid),     // ワークフローの添付ファイルID
                                                                 dirPath,                 // ディレクトリパス
                                                                 fileName );              // 添付ファイル名
            }
            
            // dirPath が null の場合、カレントディレクトリに書き出し
            if ( dirPath == null )
            {
                dirPath = "./";
            }
            System.out.println("The download of the file was executed.(" + dirPath + ")");
        }
        catch ( RemoteException e ) {                        //ガルーン上のエラー
            System.err.println(e.toString());
        }
        catch ( IOException e ) {                            // その他通信上のエラー
            System.err.println(e.toString());
        }
        catch (NumberFormatException e ) {                   // その他エラー
            System.err.println(e.toString());
        }
        
        finally {
            workflowLink.logout();

        }
    }
}
