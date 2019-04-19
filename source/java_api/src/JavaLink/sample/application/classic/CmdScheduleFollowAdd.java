import java.io.IOException;

import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.RemoteException;


public class CmdScheduleFollowAdd {

   /**
    * ガイダンスを表示します。<BR>
    *
    */
    public static void usage() {
        System.err.println("Usage: java CmdScheduleFollowAdd [OPTIONS]");
        System.err.println();
        System.err.println("OPTIONS:");
        System.err.println("       -h                 Display this help,then exit.");
        System.err.println("       -o   URL           The url of the garoon administration system.");
        System.err.println("       -u   USER          The user account to login garoon.");
        System.err.println("       -p   PASSWORD      The password of the user.");
        System.err.println("       -id  EVENTID       The event id that you want to add follow.");
        System.err.println("       -r   REGISTRANT    I appoint the user account which I registered follow of schedule with.");
        System.err.println("                          It is not necessary for a case same as a login user to input it.");
        System.err.println("       -d   DATA          The text of event follow.");
    }
 
   /**
    * メイン処理<BR>
    * @param args
    */
    public static void main(String[] args) 
    {
        if ( args.length == 0 ) {
            System.err.println("too few arguments.");
            System.err.println();
            usage();
            return;
        }
     
        String url = null;                          // GaroonのURL
        String user = null;                         // ログインユーザーアカウント
        String password = null;                     // ログインパスワード
        String registrant = null;                   // 登録者     
        String eid = null;                          // イベントID
        String data = null;                         // フォローの本文
        String followId =null;                      // ガルーン２のスケジュールフォローID(戻り値)
        CoopLink scheduleLink = null;               // CoopLink代入用
        

        for ( int i = 0; i < args.length; i++ ) {
            if ( args[i].equals("-h") ) {
                usage();
                return;
            }
            else if ( args[i].equals("-o") ) {      // URL
                if ( i == (args.length - 1) ) {
                    System.err.println("missing URL after -o.");
                    System.err.println();
                    usage();
                    return;
                }
                url =args[++i];
            }
            else if ( args[i].equals("-u") ) {      // ログインユーザーアカウント
                if ( i == (args.length - 1) ) {
                    System.err.println("missing user name after -u.");
                    System.err.println();
                    usage();
                    return;
                }
                user = args[++i];
            }
            else if ( args[i].equals("-p") ) {      // ログインパスワード
                if ( i == (args.length - 1) ) {
                    System.err.println("missing password after -p.");
                    System.err.println();
                    usage();
                    return;
                }
                password = args[++i];
            }
            else if ( args[i].equals("-id") ) {      // ガルーン２のスケジュールID
                if ( i == (args.length - 1) ) {
                    System.err.println("missing event ID after -id.");
                    System.err.println();
                    usage();
                    return;
                }
                eid = args[++i];
            }
            else if ( args[i].equals("-r") ) {      // 登録者
                if ( i == (args.length - 1) ) {
                    System.err.println("missing registrant after -r.");
                    System.err.println();
                    usage();
                    return;
                }
                registrant = args[++i];
            } 
            else if ( args[i].equals("-d") ) {      // フォローの本文
                if ( i == (args.length - 1) ) {
                    System.err.println("missing text after -d.");
                    System.err.println();
                    usage();
                    return;
                }
                data = args[++i];
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
        if ( eid == null ) {                 // イベントID
            System.err.println("[-id EVENTID] is indispensable option.");
            usage();
            return;
        }
        if ( data == null ) {                 // フォローの本文
            System.err.println("[-d DATA] is indispensable option.");
            usage();
            return;
        }
        
        try {
            // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
            scheduleLink = new CoopLink( url,user,password );
            
            // Garoonへスケジュールフォロー登録情報を送信
            followId = scheduleLink.putScheduleFollowAdd(Long.parseLong(eid),       // ガルーン２のイベントID
            	                                        data,                      // フォローの本文
            	                                        registrant);               // 登録者
        }
        catch ( RemoteException e ) {            //ガルーン上のエラー
            System.err.println(e.toString());
        } 
        catch ( IOException e ) {                // その他通信上のエラー
            System.err.println(e.toString());
        }
        catch ( NullPointerException e ) {
            System.err.println(e.toString());
        }
        catch (NumberFormatException e ) {       // その他エラー
            System.err.println(e.toString());
        }
        finally
        {
            scheduleLink.logout();   // ガルーンのログアウト
            
            if(followId!=null)
            System.out.println(followId); // 戻り値表示
    
        }
    }
}
