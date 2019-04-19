import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.RemoteException;

public class CmdMessageDelete {

    /**
     * ガイダンスを表示します。<BR>
     * 
     */
    public static void usage() {
        System.err.println("Usage: java CmdMessageDelete [OPTIONS]");
        System.err.println();
        System.err.println("OPTIONS:");
        System.err.println("       -h                 Display this help,then exit.");
        System.err.println("       -o   URL           The url of the garoon administration system.");
        System.err.println("       -u   USER          The user account to login garoon.");
        System.err.println("       -p   PASSWORD      The password of the user.");
        System.err.println("       -id  MESSAGEID     The message id that you want to delete.");
        System.err.println("       -r   REGISTRANT    I appoint the user account which I registered an message with.");
        System.err.println("                          It is not necessary for a case same as a login user to input it.");
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
        String mid = null;                                  // メッセージID
        String messageId = null;                            // メッセージID
        String registrant= null;                            // 登録者
        CoopLink messageLink = null;
        
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
            else if ( args[i].equals("-id") ) {                // メッセージID
                if ( i == (args.length - 1) ) {
                    System.err.println("missing message id after -id.");
                    System.err.println();
                    usage();
                    return;
                }
                mid = args[++i];
            }
            else if ( args[i].equals("-r") ) {                // 登録者
                if ( i == (args.length - 1) ) {
                    System.err.println("missing registrant after -r.");
                    System.err.println();
                    usage();
                    return;
                }
                registrant = args[++i];
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
                } while( url == null );
            }

            if ( user == null ) {                            // ユーザーアカウント名
                do {
                    System.err.print("User: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        user = inp;
                    }
                } while( user == null );
            }

            if ( password == null ) {                        // パスワード
                System.err.print("Password: ");
                password = in.readLine();
            }

            if ( mid == null ) {                            // メッセージID
                do {
                    System.err.print("Message ID: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        mid = inp;
                    }
                } while( mid == null );
            }
       
            // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
            messageLink = new CoopLink( url,user, password );
            
            // Garoonに社内メール削除情報を送信
            messageId = messageLink.putMessageDelete( Long.parseLong(mid),    // メッセージID
                                                      registrant );           // 登録者
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
        catch ( NumberFormatException e ) {    
            System.err.println(e.toString());
        }
        catch ( IllegalArgumentException e ) {  // 引数エラー
            System.err.println(e.toString());
        }
        finally {
            messageLink.logout();
            
            if ( messageId != null )                        // メッセージID
                System.out.println( messageId );            // 戻り値(メッセージID)
        }
    }
}
