import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import jp.co.cybozu.garoon2.*;


public class CmdBulletinModify {
 
    /**
    * ガイダンスを表示します。<BR>
    *
    */
    public static void usage() {
        System.err.println("Usage: java CmdBulletinModify [OPTIONS]");
        System.err.println();
        System.err.println("OPTIONS:");
        System.err.println("       -h                 Display this help,then exit.");
        System.err.println("       -o   URL           The url of the garoon administration system.");
        System.err.println("       -u   USER          The user account to login garoon.");
        System.err.println("       -p   PASSWORD      The password of the user.");
        System.err.println("       -id  ARTICLEID     The article id that you want to modify");
        System.err.println("       -r   REGISTRANT    I appoint the user account which I registered an bulletin board with.");
        System.err.println("                          It is not necessary for a case same as a login user to input it.");
        System.err.println("       -t   TITLE         The title of bulletin.");
        System.err.println("       -sd  STARTDATE     The start date of bulletin.(Format:yyyy-mm-dd)");
        System.err.println("                          Please specify neither start date nor end date when you do not specify the notice period.");     
        System.err.println("       -ed  ENDDATE       The bulletin end date. (Format:yyyy-mm-dd)");
        System.err.println("       -d   DATA          The text of bulletin.");
        System.err.println("       -f   ATTACHEDFILES The attached files.");
        System.err.println("                          Please apply the option at each [ATTACHEDFILES] when you specify the plural.");
        System.err.println("                          (ex.  -f /var/tmp/test1.txt -f /var/tmp/text2.txt)");
        System.err.println("       -uf                when you don't permit \"writing follow\",specify this ");
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
        
        String aid = null;                           // 掲示板ID
        String title = null;                         // タイトル
        String registrant = null;                    // 差出人
        String sdate = null;                         // 掲示期間開始日
        String edate = null;                         // 掲示期間終了日
        String data = null;                          // 本文
        boolean canFollow = true;                   // フォロー許可
        Collection attachedFiles = new ArrayList();  // 添付ファイル                  
        String bulletinId = null;                    // 登録できた掲示板ID(戻り値)

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
                url = args[++i];
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
            else if ( args[i].equals("-r") ) {             // 差出人
                if ( i == (args.length - 1) ) {
                    System.err.println("missing registrant after -r.");
                    System.err.println();
                    usage();
                    return;
                }
                registrant = args[++i];
            }
            else if ( args[i].equals("-id") ) {             // 掲示板ID
                if ( i == (args.length - 1) ) {
                    System.err.println("missing Article ID after -id.");
                    System.err.println();
                    usage();
                    return;
                }
                aid =  args[++i];
            }
            else if ( args[i].equals("-t") ) {             // タイトル
                if ( i == (args.length - 1) ) {
                    System.err.println("missing title after -t.");
                    System.err.println();
                    usage();
                    return;
                }
                title = args[++i];
            }
            else if ( args[i].equals("-sd") ) {             // 掲示期間開始日
                if ( i == (args.length - 1) ) {
                    System.err.println("missing The bulletin start date after -sd.");
                    System.err.println();
                    usage();
                    return;
                }
                sdate =  args[++i];
            }
            else if ( args[i].equals("-ed") ) {             // 掲示期間終了日
                if ( i == (args.length - 1) ) {
                    System.err.println("missing The bulletin end date after -ed.");
                    System.err.println();
                    usage();
                    return;
                }
                edate = args[++i];
            }
            else if ( args[i].equals("-d") ) {             // 備考
                if ( i == (args.length - 1) ) {
                    System.err.println("missing text after -d.");
                    System.err.println();
                    usage();
                    return;
                }
                data = args[++i];                   
            }
            else if ( args[i].equals("-uf") ) {            // フォロー許可

                canFollow = false;

            }
            else if ( args[i].equals("-f") ) {             // 添付ファイル's
                if ( i == (args.length - 1) ) {
                    System.err.println("missing The attached file after -f.");
                    System.err.println();
                    usage();
                    return;
                }
             
                attachedFiles.add(args[++i]);
            }
            else {
                System.err.println("warning: unknown option " + args[i]);
                System.err.println();
                usage();
                return;
            }
        }

        BufferedReader in = new BufferedReader( new InputStreamReader(System.in));
        CoopLink bulletinLink = null;
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
      
            if ( aid == null ) {                           // カテゴリコード
                do {
                    System.err.print("Article ID: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        aid = inp;
                    }
                } while(aid == null);
            }
            
            if ( title == null ) {                           // タイトル
                do {
                    System.err.print("Title: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        title = inp;
                    }
                } while(title == null);
            }   

            Calendar sCal =null;       
            Calendar eCal = null;          
     
            SimpleDateFormat sdf = new SimpleDateFormat();      
            sdf.setLenient( false );

            sdf.applyPattern( "yyyy-MM-dd" );
 
            if(sdate!=null){
                sCal = Calendar.getInstance();          
                sCal.clear();
                sCal.setTime(sdf.parse(sdate));
     
            }
            if(edate!=null){
                eCal = Calendar.getInstance();          
                eCal.clear();
                eCal.setTime(sdf.parse(edate));
            }   

            // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
            bulletinLink = new CoopLink(url,user,password);

            // Garoonに掲示情報を送信
            bulletinId=bulletinLink.putBulletinModify(Long.parseLong(aid),  // 掲示記事ID
                                                       title,               // タイトル
                                                       sCal,                // 掲示期間開始日
                                                       eCal,                // 掲示期間終了日
                                                       data,                // 本文
                                                       attachedFiles,       // 添付ファイル
                                                       canFollow,           // フォロー書込許可
                                                       registrant);         // 差出人

        }
        catch ( ParseException e){              // 日付パースエラー
            System.err.println(e.toString()); 
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
        finally
        {
            bulletinLink.logout();                                          // ガルーンのログアウト
            
            if(bulletinId!=null)
            System.out.println(bulletinId);                                 // 戻り値表示
    
        }
     
    }
}