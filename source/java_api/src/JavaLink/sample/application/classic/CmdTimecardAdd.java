import java.io.*;
import java.text.*;
import java.util.Calendar;
import jp.co.cybozu.garoon2.*;


public class CmdTimecardAdd {

    /**
     * ガイダンスを表示します。<BR>
     *
     */
    public static void usage() {
        System.err.println("Usage: java CmdTimecardAdd [OPTIONS]");
        System.err.println();
        System.err.println("OPTIONS:");
        System.err.println("       -h                 Display this help,then exit.");
        System.err.println("       -o   URL           The url of the garoon administration system.");
        System.err.println("       -u   USER          The user account to login garoon administration system.");
        System.err.println("       -p   PASSWORD      The password of the user.");
        System.err.println("       -r   REGISTRANT    I appoint the user account which I registered an timecard with.");
        System.err.println("       -d   DATE          The date of timecard.");
        System.err.println("       -st  STARTTIME     Time of going to the office.(Format hh:mm or \"\" or \"*\")");
        System.err.println("                          The start time is initialized when you input ''. ");
        System.err.println("                          The start time is not changed when you input '*'. ");
        System.err.println("       -et  ENDTIME       Time of leaving the office.(Format hh:mm or \"\" or \"*\")");
        System.err.println("                          The end time is initialized when you input ''. ");  
        System.err.println("                          The end time is not changed when you input '*'. ");
        System.err.println("       -tt  TRIPTIME      when you  went out of an office.(Format hh:mm or \"\" or \"*\")");
        System.err.println("                          The triptime is initialized when you input ''. ");    
        System.err.println("                          The triptime is not changed when you input '*'. ");
        System.err.println("       -bt  BACKTIME      The time when you came back.(Format hh:mm or \"\" or \"*\")");
        System.err.println("                          The backtime is initialized when you input ''. "); 
        System.err.println("                          The backtime is not changed when you input '*'. ");
        System.err.println("       -ab  OLD TRIPTIME,NEW TRIPTIME,NEW BACKTIME");
        System.err.println("                          The time when you  went out of an office and the time when you came back.");
        System.err.println("       -m   MEMO          The memo of timecard.");
        System.err.println("       -c                 The specified timecard at the 'DATE' is initialized. ");
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
        
        String url = null;                           // GaroonのURL
        String user = null;                          // ログインユーザーアカウント
        String password = null;                      // ログインパスワード
        String registrant = null;                    // 対象ユーザー
        
        String iDate = null;                         // 入力日付
        String sTime = null;                         // 出社時刻
        String eTime =null;                          // 退社時刻
        String tTime = null;                         // 外出時刻  
        String bTime = null;                         // 帰社時刻
        String memo = null;                          // 備考
        boolean clearFlg = false;                  // クリアフラグ
        
        int oneDimensionSize = 3;
        int twoDimensionSize = 6;                   // 外出/復帰の最大数は6回が上限 by Garoon
        String[][] abcenscesTimes = new String[twoDimensionSize][oneDimensionSize]; //不在情報
        int abcenscesTimesCount =0;
 
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
                url =args[++i];
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
            else if ( args[i].equals("-r") ) {             //対象ユーザー
                if ( i == (args.length - 1) ) {
                    System.err.println("missing registrant user after -r.");
                    System.err.println();
                    usage();
                    return;
                }
                registrant = args[++i];
            }
            else if ( args[i].equals("-d") ) {             // 入力日付
                if ( i == (args.length - 1) ) {
                    System.err.println("missing date after -d.");
                    System.err.println();
                    usage();
                    return;
                }
                iDate = args[++i];
            }
            else if ( args[i].equals("-st") ) {            // 出社時刻
                if ( i == (args.length - 1) ) {
                    System.err.println("missing Time of going to the office after -st.");
                    System.err.println();
                    usage();
                    return;
                }
                sTime =  args[++i];
            }      
            else if ( args[i].equals("-et") ) {            // 帰社時刻
                if ( i == (args.length - 1) ) {
                    System.err.println("missing Time of leaving the office after -et.");
                    System.err.println();
                    usage();
                    return;
                }
                 eTime = args[++i];
            }
            else if(args[i].equals("-ab")){               // 不在時刻
                if ( i == (args.length - 1) ) {
                    System.err.println("missing Absent information time after -ab.");
                    System.err.println();
                    usage();
                    return;
                }
                String strTmp = args[++i];
                String[] arrayTmp = new String[oneDimensionSize];
                // 形式 (H:mm形式、"*","" いずれか、カンマ区切り必須)のチェック
                if(!strTmp.matches("((\\*|([0-9]|[01][0-9]|2[0-3]):([0-9]|[0-5][0-9]))?,){2}(\\*|([0-9]|[01][0-9]|2[0-3]):([0-9]|[0-5][0-9]))?" ))
                {
                    System.err.println("The Input pattern of '-ab' is wrong.");
                    System.err.println();
                    usage();
                    return;        
                }
                // 6回以上の入力はおかしい
                if(abcenscesTimesCount > twoDimensionSize){
                    System.err.println("option 【-ab】is too much.");
                    System.err.println();
                    return;
                }
                
                arrayTmp = strTmp.split(",",oneDimensionSize);          
                if(arrayTmp.length==oneDimensionSize)
                {                  
                    abcenscesTimes[abcenscesTimesCount] = arrayTmp;
                    abcenscesTimesCount++;
                }else {
                    System.err.println("the input pattern of of '-ab' is wrong.");
                    System.err.println();
                    usage();
                    return;        
                }
            }
            else if ( args[i].equals("-tt") ) {            // 外出時刻
                if ( i == (args.length - 1) ) {
                    System.err.println("missing The going out time after -tt.");
                    System.err.println();
                    usage();
                    return;
                }
                tTime = args[++i];
            }
            else if ( args[i].equals("-bt") ) {            // 退社時刻
                if ( i == (args.length - 1) ) {
                    System.err.println("missing Time of back the office after -bt.");
                    System.err.println();
                    usage();
                    return;
                }
                bTime = args[++i];
            }
            else if ( args[i].equals("-m") ) {             // 備考
                if ( i == (args.length - 1) ) {
                    System.err.println("missing memo after -m.");
                    System.err.println();
                    usage();
                    return;
                }
                memo = args[++i];
            }
            else if ( args[i].equals("-c") ) {             // クリア
      
                clearFlg = true;
             
            }      
            else {
                System.err.println("warning: unknown option " + args[i]);
                System.err.println();
                usage();
                return;
            }
        }

        
        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
        CoopLink timecardGrnLink = null;

        try 
        {           

            String inp = null;
      
            if ( url == null ) {                           // GaroonのURL
                do {
                    System.err.print("URL: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        url =inp;
                    }
                } while(url.length() == 0);
            }

            if ( user == null ) {                          // ログインユーザーアカウント
                do {
                    System.err.print("User: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        user = inp;
                    }
                } while(user == null);
            }

            if ( password == null ) {                      // ログインパスワード
                do {
                    System.err.print("Password: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        password = inp;
                    }
                } while(password == null);
            }
      
            if ( iDate == null ) {                         // 入力日付
                do {
                    System.err.print("Date: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        iDate = inp;
                    }
                } while(iDate == null);
            }
               
            if(!(bTime==null && tTime==null)){             // 外出・退社 
                tTime = tTime==null?"*":tTime;
                bTime = bTime==null?"*":bTime;
                abcenscesTimes[abcenscesTimesCount] = new String[]{"",tTime,bTime};                          
            }
      
     
            Calendar myCal = Calendar.getInstance();
            myCal.clear();
            SimpleDateFormat sdf = new SimpleDateFormat();
            sdf.setLenient( false );          
            sdf.applyPattern( "yyyy-MM-dd" );
            myCal.setTime(sdf.parse(iDate));

            // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
            timecardGrnLink = new CoopLink( url,user,password );

            // Garoonにタイムカード情報を送信
            timecardGrnLink.putTimecard(myCal,        // 入力日付 
                                       sTime,         // 出社時刻("H:mm","","*"のいずれかの値)
                                       eTime,         // 退社時刻("H:mm","","*"のいずれかの値)
                                       abcenscesTimes,// 不在情報({[修正前外出時刻],[修正後外出時刻],[修正後復帰時刻]}の多次元配列)
                                       memo,          // メモ
                                       clearFlg,      // クリアフラグ(true:クリアする,false:クリアしない)
                                       registrant);   // 登録対象ユーザー(実行ユーザー) 
        }
        catch( ParseException e ){                 // 日付変換エラー
            System.err.println(e.toString());
        }
        catch ( RemoteException e ) {              //ガルーン上のエラー
            System.err.println(e.toString());
        } 
        catch ( IOException e ) {                  // その他通信上のエラー
            System.err.println(e.toString());
        }
        catch ( IllegalArgumentException e ) {     // 引数エラー 
            System.err.println(e.toString());
        }
        catch ( NullPointerException e ) {
            System.err.println(e.toString());
        }
        finally
        {
            timecardGrnLink.logout();               // ガルーンのログアウト
        } 
     
    }
}