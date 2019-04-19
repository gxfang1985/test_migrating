import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Collection;
import jp.co.cybozu.garoon2.*;

public class CmdBulletinFollowAdd {
 
    /**
     * ガイダンスを表示します。<BR>
     *
     */
    public static void usage() {
        System.err.println("Usage: java CmdBulletinFollowAdd [OPTIONS]");
        System.err.println();
        System.err.println("OPTIONS:");
        System.err.println("       -h                 Display this help,then exit.");
        System.err.println("       -o   URL           The url of the garoon administration system.");
        System.err.println("       -u   USER          The user account to login garoon.");
        System.err.println("       -p   PASSWORD      The password of the user.");
        System.err.println("       -id  ARTICLEID     The article id that you want to add the follow.");
        System.err.println("       -r   REGISTRANT    I appoint the user account which I registered an follow of bulletin board with.");
        System.err.println("                          It is not necessary for a case same as a login user to input it.");
        System.err.println("       -d   DATA          The text of bulletin follow.");
        System.err.println("       -f   ATTACHEDFILES The attached files.");
        System.err.println("                          Please apply the option at each [ATTACHEDFILES] when you specify the plural.");
        System.err.println("                          (ex.  -f /var/tmp/test1.txt -f /var/tmp/text2.txt)");
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
        
        String fid = null;                            // 登録できた掲示板フォローのID
        String url = null;                            // GaroonのURL
        String user = null;                           // ログインユーザーアカウント
        String password = null;                       // ログインパスワード
        String aid = null;                            // 記事ID
        String registrant = null;                     // フォロー登録者(実行ユーザー)
        String data = null;                           // 本文
        Collection attachedFiles = new ArrayList();   // 添付ファイル
       
        for ( int i = 0; i < args.length; i++ ) {
            if ( args[i].equals("-h") ) {
                usage();
                return;
            }
            else if ( args[i].equals("-o") ) {        // GaroonのURL
                if ( i == (args.length - 1) ) {
                    System.err.println("missing URL after -o.");
                    System.err.println();
                    usage();
                    return;
                }
                url =args[++i];
            }
            else if ( args[i].equals("-u") ) {        // ログインユーザーアカウント
                if ( i == (args.length - 1) ) {
                    System.err.println("missing user name after -u.");
                    System.err.println();
                    usage();
                    return;
                }
                user = args[++i];
            }
            else if ( args[i].equals("-p") ) {        // ログインパスワード
                if ( i == (args.length - 1) ) {
                    System.err.println("missing password after -p.");
                    System.err.println();
                    usage();
                    return;
                }
                password = args[++i];
            }
            else if ( args[i].equals("-r") ) {        // 登録者
                if ( i == (args.length - 1) ) {
                    System.err.println("missing registrant user after -r.");
                    System.err.println();
                    usage();
                    return;
                }
                registrant = args[++i];
            }
            else if ( args[i].equals("-id") ) {       // 記事ID
                if ( i == (args.length - 1) ) {
                    System.err.println("missing article id after -id.");
                    System.err.println();
                    usage();
                    return;
                }
                aid = args[++i];
            }      
            else if ( args[i].equals("-d") ) {        // 本文
                if ( i == (args.length - 1) ) {
                    System.err.println("missing text after -d.");
                    System.err.println();
                    usage();
                    return;
                }
                data = args[++i];
            }      
            else if ( args[i].equals("-f") ) {        // 添付ファイル
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
      
            if ( url == null ) {       // GaroonのURL
                do {
                    System.err.print("URL: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                         url =inp;
                    }
                } while(url.length() == 0);
            }

            if ( user == null ) {       // ログインユーザーアカウント
                do {
                    System.err.print("User: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        user = inp;
                    }
                } while(user == null);
            }

            if ( password == null ) {    // ログインパスワード
                do {
                    System.err.print("Password: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        password = inp;
                    }
                } while(password == null);
            }
      
            if ( aid == null ) {       // 記事ID
                do {
                    System.err.print("Article ID: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        aid = inp;
                    }
                } while(aid == null);
            }

            // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
            bulletinLink = new CoopLink(url,user,password); 

            // Garoonにフォロー情報を送信
            fid = bulletinLink.putBulletinFollowAdd(Long.parseLong(aid),// 掲示板ID
                                                    data,               // 本文
                                                    attachedFiles,      // 添付ファイル
                                                    registrant);        // 登録者


        }
        catch ( RemoteException e ) {                         //ガルーン上のエラー
            System.err.println(e.toString());
        } 
        catch ( IOException e ) {                             // その他通信上のエラー
            System.err.println(e.toString());
        }
        catch ( IllegalArgumentException e ) {                // 引数エラー 
            System.err.println(e.toString());
        }
        catch ( NullPointerException e ) {
            System.err.println(e.toString());
        }
        finally
        {
            bulletinLink.logout();                            // ガルーンのログアウト
            
            if(fid!=null)
            System.out.println(fid);                          // 戻り値表示
    
        }
     
    }
}