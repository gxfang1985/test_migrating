import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import java.util.Enumeration;
import java.util.Properties;

import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.FileInfoProperties;
import jp.co.cybozu.garoon2.RemoteException;
import jp.co.cybozu.text.ConfigParser;
import jp.co.cybozu.text.ParseException;



public class CmdCabinetFileInfoXMLExport {
    
    
    
    /**
     * ガイダンスを表示します。<BR>
     *
     */
    private static void usage ()
    {
        System.err.println("Usage: java CmdCabinetFileInfoXMLExport [OPTIONS]");
        System.err.println("");
        System.err.println("OPTIONS:");
        System.err.println("       -h                  Display this help,then exit.");
        System.err.println("       -o   URL            The url of the garoon administration system.");
        System.err.println("       -u   USER           The user account to login garoon.");
        System.err.println("       -p   PASSWORD       The password of the user.");
        System.err.println("       -r   REGISTRANT     I appoint the user account which I got a file information with.");
        System.err.println("                           It is not necessary for a case same as a login user to input it.");
        System.err.println("       -ty  TYPE           The type of tartget.");
        System.err.println("                             0 : File ID");
        System.err.println("                             1 : Folder ID");
        System.err.println("                             2 : Folder Code");
        System.err.println("       -ta  TARGET         The target of file Information that you want to know.");
        System.err.println("       -c   CONFIGFILE     The file path of configuration file.");
        System.err.println("       -f   FILE           The xml file to write.");

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
        
        String url = null;                     // GaroonのURL
        String user = null;                    // ユーザーアカウント名
        String password = null;                // パスワード
        String registrant = null;              // 実行者
        String type = null;                    // 表示対象指定方法(0:fid,1:hid,2:foldercode)
        String target = null;                  // 表示対象
        String config = null;                  // 設定ファイル
        String filePath = null;                // ファイルパス
        
        FileInfoProperties items = null;       // 出力項目
        
        CoopLink cabinetLink = null;           // CoopLink代入用
        

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
            else if ( args[i].equals("-r") ) {                // 実行者
                if ( i == (args.length - 1) ) {
                    System.err.println("missing registrant after -r.");
                    System.err.println();
                    usage();
                    return;
                }
                registrant = args[++i];
            }
            else if ( args[i].equals("-ty") ) {                // 表示対象指定方法(0:fid,1:hid,2:foldercode)
                if ( i == (args.length - 1) ) {
                    System.err.println("missing type after -ty.");
                    System.err.println();
                    usage();
                    return;
                }
                type = args[++i];
            }
            else if ( args[i].equals("-ta") ) {                // 表示対象
                if ( i == (args.length - 1) ) {
                    System.err.println("missing target after -ta.");
                    System.err.println();
                    usage();
                    return;
                }
                target = args[++i];
            }else if ( args[i].equals("-c") ) {                // 設定ファイル
                if ( i == (args.length - 1) ) {
                    System.err.println("missing config file after -c.");
                    System.err.println();
                    usage();
                    return;
                }
                config = args[++i];
            }else if ( args[i].equals("-f") ) {                // ファイルパス
                if ( i == (args.length - 1) ) {
                    System.err.println("missing xml file after -f.");
                    System.err.println();
                    usage();
                    return;
                }
                filePath = args[++i];
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
        if ( filePath == null ) {            // XMLファイルパス
            System.err.println("[-f FILE] is indispensable option.");
            usage();
            return;
        }
        if ( type == null && target ==null ) {                
            System.err.println("[-ty TYPE]  and [-ta TARGET] is indispensable option.");
            usage();
            return;
        }
        if ( type == null ) {                
            System.err.println("[-ty TYPE]  is indispensable option.");
            usage();
            return;
        }
        if (!type.matches("[012]") ) {                
            System.err.println("[-ty TYPE]  is illegal value.");
            usage();
            return;
        }
        if (target ==null ) {                
            System.err.println("[-ta TARGET]  is indispensable option.");
            usage();
            return;
        }


        if (config !=null){
            try {
                items = getProperties(config,"MS932");
            }catch (Exception e){
                System.err.println(e.toString());
                System.err.println("It failed to load the config file.");
                usage();
                return;
            }
        }
        
        try{
            // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
            cabinetLink = new CoopLink( url, user, password );

            // Garoonへデータ送信
            if (type.equals("0")){         // ファイルIDを指定
                if (items != null)
                    cabinetLink.exportXMLCabinetFileInfo(Long.parseLong(target),items,filePath,registrant);
                else
                    cabinetLink.exportXMLCabinetFileInfo(Long.parseLong(target),filePath,registrant);
                
            }else if (type.equals("1")){  //フォルダIDを指定
                if (items != null)
                    cabinetLink.exportXMLCabinetFileInfoFolderChild(Long.parseLong(target),items,filePath,registrant);
                else
                    cabinetLink.exportXMLCabinetFileInfoFolderChild(Long.parseLong(target),filePath,registrant);
                
            }else if (type.equals("2")){  // フォルダコードを指定
                if (items != null)
                    cabinetLink.exportXMLCabinetFileInfoFolderChild(target,items,filePath,registrant);
                else
                    cabinetLink.exportXMLCabinetFileInfoFolderChild(target,filePath,registrant);
            }
            
            System.out.println("The export of the xml file was executed.(" + filePath + ")");
        }
        catch ( RemoteException e ) {                        //ガルーン上のエラー
            System.err.println(e.toString());
        }
        catch ( IOException e ) {                            // その他通信上のエラー
            System.err.println(e.toString());
        }
        catch (NumberFormatException e ) {                   // その他エラー
            System.err.println(e.toString());
        }     
        finally {
            cabinetLink.logout();
           
        }
        
        
    }
    
    // コンフィグファイルを読込・解析後、FileInfoProperties を返す
    public static FileInfoProperties getProperties(String ConfigPath,String enc) throws Exception {
        FileInfoProperties  fp = null;
                
        // コンフィグファイルの読込
        InputStream configIn = new FileInputStream(ConfigPath);
        Properties    config = new ConfigParser( configIn ,enc).getProperties();
    
        // FileInfoProperties　生成
        fp = new FileInfoProperties();
        // 一旦項目を全部非表示にセット
        fp.allDispSet(false);
        
        StringBuffer errMsg = null;
        String key;
        boolean value;
        Enumeration en = config.propertyNames();
        while ( en.hasMoreElements() ) {
            key = (String)en.nextElement();
            value = Boolean.valueOf(config.getProperty(key)).booleanValue();    
            
            if(key.equals("title")){                             // タイトル
                fp.setDispTitle(value);

            }else if(key.equals("description")){                 // メモ
                fp.setDispDescription(value);

            }else if(key.equals("maxversion")){                  // バージョン上限値
                fp.setDispMaxVersion(value);

            }else if(key.equals("name")){                        // ファイル名
                fp.setDispName(value);

            }else if(key.equals("size")){                        // ファイルサイズ
                fp.setDispSize(value);

            }else if(key.equals("mimetype")){                    // ファイルのMIME TYPE
                fp.setDispMimeType(value);

            }else if(key.equals("creatorid")){                   // 作成者ID
                fp.setDispCreatorId(value);

            }else if(key.equals("creatorloginname")){            // 作成者ログイン名
                fp.setDispCreatorLoginName(value);

            }else if(key.equals("creatordisplayname")){          // 作成者表示名
                fp.setDispCreatorDisplayName(value);

            }else if(key.equals("createtime")){                  // 作成日時
                fp.setDispCreateTime(value);

            }else if(key.equals("modifierid")){                  // 更新者ID
                fp.setDispModifierId(value);

            }else if(key.equals("modifierloginname")){           // 更新者ログイン名
                fp.setDispModifierLoginName(value);

            }else if(key.equals("modifierdisplayname")){        // 更新者表示名
                fp.setDispModifierDisplayName(value);

            }else if(key.equals("modifytime")){                  // 更新日時
                fp.setDispModifyTime(value);
                
            }else if(key.equals("historyversion")){              // バージョンNo
                fp.setDispHistoryVersion(value);
                
            }else if(key.equals("historyactive")){               // 履歴管理されているか
                fp.setDispHistoryActive(value);

            }else if(key.equals("historyname")){                 // 履歴のファイル名
                fp.setDispHistoryName(value);

            }else if(key.equals("historyaction")){               // 操作
                fp.setDispHistoryAction(value);

            }else if(key.equals("historycomment")){              // 更新コメント
                fp.setDispHistoryComment(value);

            }else if(key.equals("historymodifierid")){           // 更新者ID
                fp.setDispHistoryModifierId(value);

            }else if(key.equals("historymodifierloginname")){    // 更新者ログイン名
                fp.setDispHistoryModifierLoginName(value);

            }else if(key.equals("historymodifierdisplayname")){  // 更新者表示名
                fp.setDispHistoryModifierDisplayName(value);

            }else if(key.equals("historymodifytime")){           // 更新日時
                fp.setDispHistoryModifyTime(value);

            } else {
                if (errMsg == null) errMsg = new StringBuffer("");
                else                  errMsg.append(",");
                
                errMsg.append(key).append("=").append(value);
            }
        }

        if (errMsg != null){
            StringBuffer sb = new StringBuffer();
            sb.append("illegal value is included in the configuration file.");
            sb.append("(");
            sb.append(errMsg);
            sb.append(")");
            
            throw new ParseException(sb.toString());
        }
        
        return fp;
    }
}
