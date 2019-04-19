import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.Iterator;
import java.util.Map;
import java.util.TreeMap;

import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.RemoteException;
import jp.co.cybozu.text.CSVWriter;

public class CmdGroupIdListCSVExport {
    
    /**
     * ガイダンスを表示します。<BR>    
     *
     */
    private static void usage ()
    {
        System.err.println("Usage: java CmdGroupIdListCSVExport [OPTIONS]");
        System.err.println();
        System.err.println("OPTIONS:");
        System.err.println("       -h                 Display this help,then exit.");
        System.err.println("       -o   URL           The url of the garoon administration system.");
        System.err.println("       -u   USER          The user account to login garoon administration system.");
        System.err.println("       -p   PASSWORD      The password of the user.");
        System.err.println("       -f   FILE          The csv file to write.");
        System.err.println("       -utf8              The character-code of the file is utf8.");
        System.err.println("                          When not specifying this.The character-code of the file is shift_jis.");
        System.err.println("       -he                There is the header.");
    }
    
    /**
     * メイン処理<BR>
     * 
     * @param args
     */
    public static void main(String[] args) {      
        
        if ( args.length == 0 )    {
            System.err.println("too few arguments.");
            System.err.println();
            usage();
            return;
        }

        String url = null;                                    // GaroonのURL
        String user = null;                                   // ユーザーアカウント名
        String password = null;                               // パスワード
        String filePath = null;                               // ファイルパス
        String encode = "MS932";                              // エンコード
        String[] title = null;                                // 先頭行
        
        CoopLink grnLink = null;
        CSVWriter groupCSV = null;
        
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
            else if ( args[i].equals("-f") ) {                // ファイルパス
                if ( i == (args.length - 1) ) {
                    System.err.println("missing csv file after -f.");
                    System.err.println("");
                    usage();
                    return;
                }
                filePath = args[++i];
            }
            else if ( args[i].equals("-he") ) {                // 先頭行
                title =  new String[]{"組織ID","組織コード"};
            }
            else if ( args[i].equals("-utf8") ) {              // エンコード
                encode = "UTF-8";
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
        if ( filePath == null ) {            // CSVファイルパス
            System.err.println("[-f FILE] is indispensable option.");
            usage();
            return;
        }
        
        try {
            // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
            grnLink = new CoopLink( url, user, password );

            // Garoonへデータ送信/取得
            TreeMap maps = grnLink.getGroupIdList();
            
            // TreeMapをCSVで書き出す
            // Writerの準備
            groupCSV = new CSVWriter(new OutputStreamWriter(new FileOutputStream(filePath), encode));
            
            // タイトル行の書出
            if(title !=null){
                groupCSV.println(title);
            }
            
            // データ行の書出
            Iterator it = maps.entrySet().iterator();
            Map.Entry entry;
            String[] line = new String[2];
            while (it.hasNext()) {
                entry = (Map.Entry) it.next();
                line[0] = ((Long) entry.getKey()).toString();  // 組織ID
                line[1] = (String) entry.getValue();           // 組織コード
                
                groupCSV.println(line);
            }
            groupCSV.close();
            
            System.out.println("The download of the csv file was executed.(" + filePath + ")");
            
        }
        catch ( RemoteException e ) {           //ガルーン上のエラー
            System.err.println(e.toString());
        } 
        catch ( IOException e ) {               // その他通信上のエラー
            System.err.println(e.toString());
        }
        finally {
            grnLink.logout();
            
        }
    }
}
