import java.io.IOException;

import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.RemoteException;



public class CmdScheduleFollowDelete {

   /**
    * ガイダンスを表示します。<BR>
    *
    */
    public static void usage() {
        System.err.println("Usage: java CmdScheduleFollowDelete [OPTIONS]");
        System.err.println();
        System.err.println("OPTIONS:");
        System.err.println("       -h                 Display this help,then exit.");
        System.err.println("       -o   URL           The url of the garoon administration system.");
        System.err.println("       -u   USER          The user account to login garoon.");
        System.err.println("       -p   PASSWORD      The password of the user.");
        System.err.println("       -id  FOLLOWID      The follow id that you want to delete.");
        System.err.println("       -r   REGISTRANT    I appoint the user account which I registered follow of schedule with.");
        System.err.println("                          It is not necessary for a case same as a login user to input it.");
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
     
        String url = null;                                // GaroonのURL
        String user = null;                               // ログインユーザーアカウント
        String password = null;                           // ログインパスワード
        String registrant = null;                         // 削除者
        String fid = null;                                // ガルーン２のスケジュールフォローID
        String followId = null;                           // ガルーン２のスケジュールフォローID（戻り値）
        CoopLink scheduleLink = null;                     // CoopLink代入用

        for ( int i = 0; i < args.length; i++ ) {
            if ( args[i].equals("-h") ) {
                usage();
                return;
            }
            else if ( args[i].equals("-o") ) {             // GaroonのURL
                if ( i == (args.length - 1) ) {
                    System.err.println("missing URL after -o.");
                    System.err.println();
                    usage();
                    return;
                }
                url=args[++i];
            }
            else if ( args[i].equals("-u") ) {             // ログインユーザーアカウント
                if ( i == (args.length - 1) ) {
                    System.err.println("missing user name after -u.");
                    System.err.println();
                    usage();
                    return;
                }
                user = args[++i];
            }
            else if ( args[i].equals("-p") ) {             // ログインパスワード
                if ( i == (args.length - 1) ) {
                    System.err.println("missing password after -p.");
                    System.err.println();
                    usage();
                    return;
                }
                password = args[++i];
            }
            else if ( args[i].equals("-id") ) {             // ガルーン２のスケジュールフォローID
                if ( i == (args.length - 1) ) {
                    System.err.println("missing follow ID after -id.");
                    System.err.println();
                    usage();
                    return;
                }
                fid = args[++i];
            }
            else if ( args[i].equals("-r") ) {              // 削除者
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
        if ( fid == null ) {                 // ガルーン２のスケジュールフォローID
            System.err.println("[-id FOLLOWID] is indispensable option.");
            usage();
            return;
        }
        
        try {
            // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
            scheduleLink = new CoopLink( url,user,password );
            
            // Garoonにスケジュールフォロー削除情報を送信
            followId = scheduleLink.putScheduleFollowDelete(Long.parseLong(fid),  // ガルーン２のスケジュールフォローID
                                                           registrant);          // 削除者
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