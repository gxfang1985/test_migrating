import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import jp.co.cybozu.garoon2.*;


public class CmdBulletinDelete {

    /**
     * ガイダンスを表示します。<BR>
     *
     */
    public static void usage() {
         System.err.println("Usage: java CmdBulletinDelete [OPTIONS]");
         System.err.println();
         System.err.println("OPTIONS:");
         System.err.println("       -h                 Display this help,then exit.");
         System.err.println("       -o   URL           The url of the garoon administration system.");
         System.err.println("       -u   USER          The user account to login garoon.");
         System.err.println("       -p   PASSWORD      The password of the user.");
         System.err.println("       -id  ARTICLEID     The article id that you want to delete.");
         System.err.println("       -r   REGISTRANT    I appoint the user account which I registered an bulletin board with.");
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
     
        String url = null;                                  // GaroonのURL
        String user = null;                                 // ログインユーザーアカウント
        String password = null;                             // ログインパスワード
        String articleID = null;                            // 記事ID
        String registrant = null;                           // 削除実行者
        long lngArticleID = 0;
        String article = null;                              // 記事ID(戻り値)

        for ( int i = 0; i < args.length; i++ ) {
            if ( args[i].equals("-h") ) {
                usage();
                return;
            }
            else if ( args[i].equals("-o") ) {               // GaroonのURL
                if ( i == (args.length - 1) ) {
                    System.err.println("missing URL after -o.");
                    System.err.println();
                    usage();
                    return;
                }
                url=args[++i];
            }
            else if ( args[i].equals("-u") ) {              // ログインユーザーアカウント
                if ( i == (args.length - 1) ) {
                    System.err.println("missing user name after -u.");
                    System.err.println();
                    usage();
                    return;
                }
                user = args[++i];
            }
            else if ( args[i].equals("-p") ) {               // ログインパスワード
                if ( i == (args.length - 1) ) {
                    System.err.println("missing password after -p.");
                    System.err.println();
                    usage();
                   return;
                }
                password = args[++i];
            }
            else if ( args[i].equals("-r") ) {              // 削除実行者
                if ( i == (args.length - 1) ) {
                    System.err.println("missing registrant user after -r.");
                    System.err.println();
                    usage();
                    return;
                }
                registrant = args[++i];
            }
            else if ( args[i].equals("-id") ) {             // 記事ID
                if ( i == (args.length - 1) ) {
                    System.err.println("missing Article ID after -id.");
                    System.err.println();
                    usage();
                    return;
                }
                articleID = args[++i];
            }
            else {
                System.err.println("warning: unknown option " + args[i]);
                usage(); 
                return; 
            }
        }

        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
        CoopLink bulletinLink = null;
        try 
        {
          
            String inp = null;

            if ( url == null) {                             // GaroonのURL
                do {
                    System.err.print("URL: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        url= inp;
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
               
            if ( articleID == null ) {                      // 記事ID
                do {
                    System.err.print("ArticleID: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        articleID = inp;
                    }
                } while(articleID == null);
            }

            lngArticleID = Long.parseLong(articleID);

            // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
            bulletinLink = new CoopLink(url,user, password);

            // Garoonに掲示板削除情報を送信
            article = bulletinLink.putBulletinDelete(lngArticleID,  // 掲示板記事ID
                                                     registrant);   // 更新者

            
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
            bulletinLink.logout();                 // ガルーンのログアウト
            
            if(article!=null)
            System.out.println(article);           // 戻り値表示
    
        }
     
    }
}