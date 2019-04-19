import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import jp.co.cybozu.garoon2.*;

public class CmdScheduleModify {

   /**
    * ガイダンスを表示します。<BR>
    *
    */
    public static void usage() {
        System.err.println("Usage: java CmdScheduleModify [OPTIONS]");
        System.err.println();
        System.err.println("OPTIONS:");
        System.err.println("       -h                 Display this help,then exit.");
        System.err.println("       -o   URL           The url of the garoon administration system.");
        System.err.println("       -u   USER          The user account to login garoon.");
        System.err.println("       -p   PASSWORD      The password of the user.");
        System.err.println("       -id  EVENTID       The event id that you want to modify.");
        System.err.println("       -r   REGISTRANT    I appoint the user account which I registered an schedule with.");
        System.err.println("                          It is not necessary for a case same as a login user to input it.");
        System.err.println("       -sd  STARTDATE     The start date of schedule.(Format:yyyy-mm-dd)");
        System.err.println("       -ed  ENDDATE       The end date of schedule.(Format:yyyy-mm-dd)");
        System.err.println("       -st  STARTTIME     The start time of schedule.(Format hh:mm)");
        System.err.println("       -et  ENDTIME       The end time of schedule.(Format hh:mm)");
        System.err.println("       -tm  TITLEMENU     The titlemenu of schedule.");
        System.err.println("       -t   TITLE         The title of schedule.");
        System.err.println("       -a   ACCOUNTS      The participant's user account.");
        System.err.println("                          Please apply the option at each [ACCOUNTS] when you specify the plural.");
        System.err.println("                          (ex.  -a \"user1\" -a \"user2\")");
        System.err.println("       -fc  FACILITYCODES The participant's facility code.");
        System.err.println("                          Please apply the option at each [FACILITYCODES] when you specify the plural.");
        System.err.println("                          (ex.  -fc \"roomA\" -fc \"roomB\")");
        System.err.println("       -pr                when you don't open this schedule to the public,specify this ");
        System.err.println("       -m   MEMO          The memo of schedule.");
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
     
        String event = null;                        // イベントID
        String eventID = null;                      // イベントID
        String url = null;                          // GaroonのURL
        String user = null;                         // ログインユーザーアカウント
        String password = null;                     // ログインパスワード
        String registrant = null;                   // 更新者(実行ユーザー)
        String titleMenu = null;                    // 予定メニュー
        String title = null;                        // 予定タイトル
        String eventPrivate = "0";                   // 公開/非公開
        String detail = null;                       // 予定メモ
        String sDate = null;                        // 予定開始日
        String eDate = null;                        // 予定終了日
        String sTime = null;                        // 予定開始時刻
        String eTime = null;                        // 予定終了時刻
        Collection userAccount = new ArrayList();   // 参加者のユーザーアカウント
        Collection facilityCode = new ArrayList();  // 施設コード

        for ( int i = 0; i < args.length; i++ ) {
            if ( args[i].equals("-h") ) {
                usage();
                return;
            }
            else if ( args[i].equals("-o") ) {             // URL
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
            else if ( args[i].equals("-r") ) {             // 更新者
                if ( i == (args.length - 1) ) {
                    System.err.println("missing registrant user after -r.");
                    System.err.println();
                    usage();
                    return;
                }
                registrant = args[++i];
            }
            else if ( args[i].equals("-tm") ) {             // 予定メニュー
                if ( i == (args.length - 1) ) {
                    System.err.println("missing title menu after -tm.");
                    System.err.println();
                    usage();
                    return;
                }
                titleMenu = args[++i];
            }
            else if ( args[i].equals("-t") ) {             // 予定タイトル
                if ( i == (args.length - 1) ) {
                    System.err.println("missing event title after -t.");
                    System.err.println();
                    usage();
                    return;
                }
                title = args[++i];
            }
            else if ( args[i].equals("-id") ) {             // イベントID
                if ( i == (args.length - 1) ) {
                    System.err.println("missing event ID after -id.");
                    System.err.println();
                    usage();
                    return;
                }
                eventID = args[++i];
            }   
            else if ( args[i].equals("-pr") ) {            // 公開/非公開

                eventPrivate = "1";
            }
            else if ( args[i].equals("-m") ) {             // 予定メモ
                if ( i == (args.length - 1) ) {
                    System.err.println("missing memo after -m.");
                    System.err.println();
                    usage();
                    return;
                }
                detail = args[++i];
            }
            else if ( args[i].equals("-a") ) {             // 参加者のユーザーアカウント
                if ( i == (args.length - 1) ) {
                    System.err.println("missing account after -a.");
                    System.err.println();
                    usage();
                    return;
                }
                userAccount.add(args[++i]);
            }
            else if ( args[i].equals("-sd") ) {             // 予定開始日
                if ( i == (args.length - 1) ) {
                    System.err.println("missing start date after -sd.");
                    System.err.println();
                    usage();
                    return;
                }
                sDate = args[++i];
            }
            else if ( args[i].equals("-st") ) {             // 予定開始時刻
                if ( i == (args.length - 1) ) {
                    System.err.println("missing start time after -st.");
                    System.err.println();
                    usage();
                    return;
                }
                sTime = args[++i];
            }
            else if ( args[i].equals("-ed") ) {             // 予定終了日
                if ( i == (args.length - 1) ) {
                    System.err.println("missing end date after -ed.");
                    System.err.println();
                    usage();
                    return;
                }
                eDate = args[++i];
            }
            else if ( args[i].equals("-et") ) {             // 予定終了時刻
                if ( i == (args.length - 1) ) {
                    System.err.println("missing end time after -et.");
                    System.err.println();
                    usage();
                    return;
                }
                eTime = args[++i];
            }
            else if ( args[i].equals("-fc") ) {             // 施設コード
                if ( i == (args.length - 1) ) {
                    System.err.println("missing facility code after -fc.");
                    System.err.println();
                    usage();
                    return;
                }
                facilityCode.add(args[++i]);
            }
            else {
                System.err.println("warning: unknown option " + args[i]);
                usage(); 
                return; 
            }
        }

        BufferedReader in = new BufferedReader( new InputStreamReader(System.in));
        CoopLink scheduleLink = null;
        try {
            String inp = null;

            if ( userAccount.isEmpty() ) {                 // 参加者のユーザーアカウント
                System.err.println("[-a ACCOUNTS] is indispensable option.");
                usage();
                return;
            }
            
            if ( url == null ) {                            // GaroonのURL
                do {
                    System.err.print("URL: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        url =inp;
                    }
                } while(url.length() == 0);
            }

            if ( user == null ) {                           // ログインユーザーアカウント
                do {
                    System.err.print("User: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        user = inp;
                    }
                } while(user == null);
            }

            if ( password == null ) {                       // ログインパスワード
                do {
                    System.err.print("Password: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        password = inp;
                    }
                } while(password == null);
            }
      
            if ( eventID == null ) {                        // イベントID
                do {
                    System.err.print("Event ID: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        eventID = inp;
                    }
                } while(eventID == null);
            }
            if ( sDate == null ) {                          // 予定開始日
                do {
                    System.err.print("Set date: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        sDate = inp;
                    }
                } while(sDate == null);
            }

            if ( eDate == null ) {                          // 予定終了日
                do {
                    System.err.print("End date: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        eDate = inp;
                    }
                } while(eDate == null);
            }
      
            // 引数生成
            Calendar sCal = null;         
            Calendar eCal = null;         
            Calendar stCal = null;         
            Calendar etCal = null;         
            SimpleDateFormat sdf = new SimpleDateFormat();
            sdf.setLenient( false );   
      
      
            sdf.applyPattern( "yyyy-MM-dd" );
            if (sDate != null){
                sCal = Calendar.getInstance();
                sCal.clear();
                sCal.setTime(sdf.parse(sDate));
            }
   
            if (eDate != null){
                eCal = Calendar.getInstance();
                eCal.clear();
                eCal.setTime(sdf.parse(eDate));
            }
    
            sdf.applyPattern( "H:mm" );
            if(sTime !=null){
                stCal = Calendar.getInstance();
                stCal.clear();
                stCal.setTime(sdf.parse(sTime));
            }
   
            if(eTime !=null){
                etCal = Calendar.getInstance();
                etCal.clear();
                etCal.setTime(sdf.parse(eTime));
            }
            
            // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
            scheduleLink = new CoopLink( url,user,password );           
   
            // スケジュール更新情報を送信
            event = scheduleLink.putScheduleModify(Long.parseLong(eventID), // イベントID
                                                   titleMenu,               // 予定メニュー
                                                   title,                   // 予定タイトル
                                                   eventPrivate,            // 公開/非公開
                                                   detail,                  // 予定メモ
                                                   sCal,                    // 開始日
                                                   eCal,                    // 終了日
                                                   stCal,                   // 開始時刻
                                                   etCal,                   // 終了時刻
                                                   userAccount,            // 参加者のユーザーアカウント
                                                   facilityCode,           // 施設コード
                                                   registrant);             // 更新者

        }
        catch( ParseException e ){
            System.err.println(e.toString());
        }
        catch ( RemoteException e ) {             //ガルーン上のエラー
            System.err.println(e.toString());
        } 
        catch ( IOException e ) {                 // その他通信上のエラー
            System.err.println(e.toString());
        }
        catch ( IllegalArgumentException e ) {    // 引数エラー 
            System.err.println(e.toString());
        }
        catch ( NullPointerException e ) {
            System.err.println(e.toString());
        }        
        finally
        {
            scheduleLink.logout();   // ガルーンのログアウト
            
            if(event!=null)
              System.out.println(event); // 戻り値表示
    
        }     
    }
}
