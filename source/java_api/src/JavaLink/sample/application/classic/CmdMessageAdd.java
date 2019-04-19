import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Collection;
import jp.co.cybozu.garoon2.*;

public class CmdMessageAdd {

    /**
    * ガイダンスを表示します。<BR>
    * 
    */
    public static void usage() {
        System.err.println("Usage: java CmdMessageAdd [OPTIONS]");
        System.err.println();
        System.err.println("OPTIONS:");
        System.err.println("       -h                 Display this help,then exit.");
        System.err.println("       -o   URL           The url of the garoon administration system.");
        System.err.println("       -u   USER          The user account to login garoon.");
        System.err.println("       -p   PASSWORD      The password of the user.");
        System.err.println("       -r   REGISTRANT    I appoint the user account which I registered an message with.");
        System.err.println("                          It is not necessary for a case same as a login user to input it.");
        System.err.println("       -t   TITLE         The title of message.");
        System.err.println("       -d   DATA          The text of message.");
        System.err.println("       -f   ATTACHEDFILES The attached files. ");
        System.err.println("                          Please apply the option at each [ATTACHEDFILES] when you specify the plural.");
        System.err.println("                          (ex.  -f \"/var/tmp/test1.txt\" -f \"/var/tmp/text2.txt\")");
        System.err.println("       -a   ACCOUNTS      The accounts of message address.");
        System.err.println("                          Please apply the option at each [ACCOUNTS] when you specify the plural.");
        System.err.println("                          (ex.  -a user1 -a user2)");
        System.err.println("       -op  OPERATORS     The accounts of message operators.");
        System.err.println("                          Please apply the option at each [OPERATORS] when you specify the plural.");
        System.err.println("                          (ex.  -op user1 -op user2)");
        System.err.println("       -c                 You specify this,when you want to check \"Who already read message?\".");
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
        String registrant = null;                    // 差出人
        
        String title = null;                         // 標題
        String data = null;                          // 本文

        Collection accounts = new ArrayList();       // 宛先
        Collection operators = new ArrayList();      // 宛先(宛先変更の許可有り)
        Collection attachedFiles = new ArrayList();  // 添付ファイル
     
        boolean confirm = false;                    // 閲覧状況
        
        String mid = null;                           // 社内メールID(戻り値)

    
        for ( int i = 0; i < args.length; i++ ) {
            if ( args[i].equals("-h") ) {
                usage();
                return;
            }
            else if ( args[i].equals("-o") ) {   // GaroonのURL
                if ( i == (args.length - 1) ) {
                    System.err.println("missing URL after -o.");
                    System.err.println();
                    usage();
                    return;
                }
                url =args[++i];
            }
            else if ( args[i].equals("-u") ) {   // ログインユーザーアカウント
                if ( i == (args.length - 1) ) {
                    System.err.println("missing user name after -u.");
                    System.err.println();
                    usage();
                    return;
                }
                user = args[++i];
            }
            else if ( args[i].equals("-p") ) {   // ログインパスワード
                if ( i == (args.length - 1) ) {
                    System.err.println("missing password after -p.");
                    System.err.println();
                    usage();
                    return;
                }
                password = args[++i];
            }
            else if ( args[i].equals("-r") ) {   // 差出人
                if ( i == (args.length - 1) ) {
                    System.err.println("missing registrant after -r.");
                    System.err.println();
                    usage();
                    return;
                }
                registrant = args[++i];
            }
            else if ( args[i].equals("-t") ) {   // 標題
                if ( i == (args.length - 1) ) {
                    System.err.println("missing title after -t.");
                    System.err.println();
                    usage();
                    return;
                }
                title = args[++i];
            }
            else if ( args[i].equals("-d") ) {   // 本文
                if ( i == (args.length - 1) ) {
                    System.err.println("missing text after -d.");
                    System.err.println();
                    usage();
                    return;
                }
                data = args[++i];
            }
            else if ( args[i].equals("-a") ) {   // 宛先
                if ( i == (args.length - 1) ) {
                    System.err.println("missing receivers after -a.");
                    System.err.println();
                    usage();
                    return;
                }
                accounts.add(args[++i]);
            }
            else if ( args[i].equals("-op") ) {   // 宛先変更許可を持った宛先
                if ( i == (args.length - 1) ) {
                    System.err.println("missing receivers after -op.");
                    System.err.println();
                    usage();
                    return;
                }
                operators.add(args[++i]);
            }
            else if ( args[i].equals("-f") ) {   // 添付ファイル
                if ( i == (args.length - 1) ) {
                    System.err.println("missing attached file after -f.");
                    System.err.println();
                    usage();
                    return;
                }
                attachedFiles.add(args[++i]);
            }
            else if ( args[i].equals("-c") ) {   // 閲覧状況

                confirm = true;
            }
            else {
                System.err.println("warning: unknown option " + args[i]);
                System.err.println();
                usage(); 
                return; 
            }
        }

        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
        
        CoopLink messageLink = null;
        try 
        {
            String inp = null;
            
            if ( accounts.isEmpty() && operators.isEmpty() ) {          // 宛先
                System.err.println("Neither [-a ACCOUNTS] nor [-op OPERATORS] is entered.");
                usage();
                return;
            }
      
            if ( url == null ) {                 // GaroonのURL
                do {
                    System.err.print("URL: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        url =inp;
                    }
                } while(url.length() == 0);
            }

            if ( user == null ) {                // ログインユーザーアカウント
                do {
                    System.err.print("User: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        user = inp;
                    }
                } while(user == null);
            }
                
            if ( password == null ) {            // ログインパスワード
                do {
                    System.err.print("Password: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                       password = inp;
                    }
                } while(password == null);
            }
      
            if ( title == null ) {               // 標題
                do {
                    System.err.print("Title: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        title = inp;
                    }
                } while(title == null);
            }
      
            
            //  Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
            messageLink = new CoopLink(url,user, password);

            // Garoonに社内メール情報を送信
            mid =messageLink.putMessageAdd(title,           // 標題 
                                           data,            // 本文
                                           confirm,         // 閲覧状況
                                           accounts,        // 宛先
                                           operators,       // 宛先変更許可の有る宛先
                                           attachedFiles,   // 添付ファイル
                                           registrant);     // 差出人      

        }
        catch ( RemoteException e ) {            //ガルーン上のエラー
            System.err.println(e.toString());
        } 
        catch ( IOException e ) {                // その他通信上のエラー
            System.err.println(e.toString());
        }
        catch ( IllegalArgumentException e ) {   // 引数エラー 
            System.err.println(e.toString());
        }
        catch ( NullPointerException e ) {
            System.err.println(e.toString());
        }        
        finally
        {
            messageLink.logout();   // ガルーンのログアウト
            
            if(mid!=null)
            System.out.println(mid); // 戻り値表示
        }      
    }
}
