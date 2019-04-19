import java.io.IOException;

import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.RemoteException;

public class CmdCabinetModify {
    
    
    /**
     * ガイダンスを表示します。<BR>
     *
     */
    private static void usage ()
    {
        System.err.println("Usage: java CmdCabinetModify [OPTIONS]");
        System.err.println("");
        System.err.println("OPTIONS:");
        System.err.println("       -h               Display this help,then exit.");
        System.err.println("       -o   URL         The url of the garoon administration system.");
        System.err.println("       -u   USER        The user account to login garoon.");
        System.err.println("       -p   PASSWORD    The password of the user.");
        System.err.println("       -id  FILEID      The file id that you want to modify.");
        System.err.println("       -r   REGISTRANT  I appoint the user account which I registered an file with.");
        System.err.println("                        It is not necessary for a case same as a login user to input it.");
        System.err.println("       -t   TITLE       The title of file.");
        System.err.println("       -v   VERSION     The version of file.");
        System.err.println("       -m   MEMO        The memo of file.");
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

        String url =null;                                  //GaroonのURL
        String user =null;                                 //ユーザーアカウント名
        String password =null;                             //パスワード
        String fid =null;                                  //ファイルID
        String registrant =null;                           //情報変更者
        String title =null;                                //タイトル
        String version ="0";                               //バージョン
        String memo =null;                                 //メモ
        
        String fileId =null;                               //ファイルID(戻り値)
        CoopLink cabinetLink =null;                        //CoopLink代入用


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
            else if ( args[i].equals("-id") ) {               // ファイルID
                if ( i == (args.length - 1) ) {
                    System.err.println("missing file id after -id.");
                    System.err.println();
                    usage();
                    return;
                }
                fid = args[++i];
            }
            else if ( args[i].equals("-r") ) {                // 情報変更者
                if ( i == (args.length - 1) ) {
                    System.err.println("missing registrant of a file after -r.");
                    System.err.println();
                    usage();
                    return;
                }
                registrant = args[++i];
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
            else if ( args[i].equals("-v") ) {                // バージョン
                if ( i == (args.length - 1) ) {
                    System.err.println("missing version after -v.");
                    System.err.println();
                    usage();
                    return;
                }
                version = args[++i];
            }
            else if ( args[i].equals("-m") ) {                // メモ
                if ( i == (args.length - 1) ) {
                    System.err.println("missing explanation of a file after -m.");
                    System.err.println();
                    usage();
                    return;
                }
                memo = args[++i];
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
        if ( fid == null ) {                 // ファイルID
            System.err.println("[-id FILEID] is indispensable option.");
            usage();
            return;
        }


        try{
            // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
            cabinetLink = new CoopLink( url, user, password );

            // Garoonへデータ送信
            fileId = cabinetLink.putCabinetModify( Long.parseLong(fid),     // ファイルID
                                                   title,                   // タイトル
                                                   Long.parseLong(version), // バージョン管理
                                                   memo,                    // メモ                                                    
                                                   registrant );            // 情報変更者
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
            cabinetLink.logout();
            
            if ( fileId != null )                            // ファイルID
                System.out.println( fileId );                // 戻り値(ファイルID)
        }
    }
    

}
