import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import java.text.SimpleDateFormat;
import jp.co.cybozu.text.ConfigParser;
import jp.co.cybozu.text.ParseException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Properties;

import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.WorkFlowdataItemProperties;
import jp.co.cybozu.garoon2.WorkFlowdataSelectProperties;
import jp.co.cybozu.garoon2.RemoteException;

public class CmdWorkFlowPetitionDataXMLExport {
    
    public static WorkFlowdataSelectProperties selectProperties;   // 出力条件
    public static WorkFlowdataItemProperties items;                // 出力項目
    /**
     * ガイダンスを表示します。<BR>
     *
     */
    private static void usage ()
    {
        System.err.println("Usage: java CmdWorkFlowPetitionDataXMLExport [OPTIONS]");
        System.err.println("");
        System.err.println("OPTIONS:");
        System.err.println("    -h                  Display this help,then exit.");
        System.err.println("    -o   URL            The url of the garoon administration system.");
        System.err.println("    -u   USER           The user account to login garoon.");
        System.err.println("    -p   PASSWORD       The password of the user.");
        System.err.println("    -ty  TYPE           The type of tartget.");
        System.err.println("                          0 : PetitionData ID");
        System.err.println("                          1 : PetitionForm ID");
        System.err.println("                          2 : PetitionForm Code");
        System.err.println("    -ta  TARGET         The target of petition data that you want to know.");
        System.err.println("    -c   CONFIGFILE     The file path of configuration file.");
        System.err.println("    -f   FILE           The xml file to write.");
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
        
        String url = null;                                      // GaroonのURL
        String user = null;                                     // ユーザーアカウント名
        String password = null;                                 // パスワード
        String config = null;                                   // 設定ファイル
        String type = null;                                     // 表示対象指定方法(0:pid,1:formid,2:formCode)
        String target = null;                                   // 表示対象
        String filePath = null;                                 // XMLファイルパス
                
        CoopLink workflowLink = null;                           // CoopLink代入用

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
            else if ( args[i].equals("-ty") ) {                // 表示対象指定方法(0:pid,1:formid,2:formCode)
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
            }else if ( args[i].equals("-f") ) {                // XMLファイルパス
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
        if ( url == null ) {                   // URL
            System.err.println("[-o URL] is indispensable option.");
            usage();
            return;
        }
        if ( user == null ) {                  // ログイン名
            System.err.println("[-u USER] is indispensable option.");
            usage();
            return;
        }
        if ( password == null ) {              // パスワード
            System.err.println("[-p PASSWORD] is indispensable option.");
            usage();
            return;
        }
        if ( filePath == null ) {              // XMLファイルパス
            System.err.println("[-f FILE] is indispensable option.");
            usage();
            return;
        }
        if ( type == null && target ==null ) { // 表示対象指定方法 & 表示対象              
            System.err.println("[-ty TYPE]  and [-ta TARGET] is indispensable option.");
            usage();
            return;
        }
        if ( type == null ) {                  // 表示対象指定方法      
            System.err.println("[-ty TYPE]  is indispensable option.");
            usage();
            return;
        }
        if (!type.matches("[012]") ) {         // 表示対象指定方法              
            System.err.println("[-ty TYPE]  is illegal value.");
            usage();
            return;
        }
        if (target ==null ) {                  // 表示対象
            System.err.println("[-ta TARGET]  is indispensable option.");
            usage();
            return;
        }


        if (config !=null){
            try {
                getProperties(config,"MS932");
            }catch (Exception e){
                System.err.println(e.toString());
                System.err.println("It failed to load the config file.");
                usage();
                return;
            }

        }
        
        try{
            // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
            workflowLink = new CoopLink( url, user, password );

            // Garoonへデータ送信
            if (type.equals("0")){         // 申請IDを指定
                if (items != null)
                    // 表示項目の指定がある場合 (コンフィグファイルを読込んだ場合)
                    workflowLink.exportXMLSystemWorkFlowPetitionData(Long.parseLong(target),items,filePath);
                else
                    // 表示項目の指定がない場合
                    workflowLink.exportXMLSystemWorkFlowPetitionData(Long.parseLong(target),filePath);
                
            }else if (type.equals("1")){  //フォームIDを指定
                if(selectProperties==null)  selectProperties = new WorkFlowdataSelectProperties();
                
                if (items != null)
                    // 表示項目の指定がある場合 (コンフィグファイルを読込んだ場合)
                    workflowLink.exportXMLSystemWorkFlowFormPetitionData(Long.parseLong(target),selectProperties,items,filePath);
                else
                    // 表示項目の指定がない場合                    
                    workflowLink.exportXMLSystemWorkFlowFormPetitionData(Long.parseLong(target),selectProperties,filePath);
                
                
            }else if (type.equals("2")){  // フォームコードを指定
                if(selectProperties==null)  selectProperties = new WorkFlowdataSelectProperties();
                
                if (items != null)
                    // 表示項目の指定がある場合 (コンフィグファイルを読込んだ場合)                    
                    workflowLink.exportXMLSystemWorkFlowFormPetitionData(target,selectProperties,items,filePath);
                else
                    // 表示項目の指定がない場合                    
                    workflowLink.exportXMLSystemWorkFlowFormPetitionData(target,selectProperties,filePath);
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
            workflowLink.logout();
           
        }
    }
        
        // コンフィグファイルを読込・解析を行う、
        // クラスフィールド
        //  (WorkFlowdataSelectProperties) selectProperties 及び (WorkFlowdataItemProperties) items に値をセットする
        public static void getProperties(String ConfigPath,String enc) throws Exception {
                       
            // コンフィグファイルの読込
            InputStream configIn = new FileInputStream(ConfigPath);
            Properties    config = new ConfigParser( configIn ,enc).getProperties();
        
            // WorkFlowdataSelectProperties　生成 (出力条件、出力並び順の設定）/////
            selectProperties = new WorkFlowdataSelectProperties();
            // ステータスの絞込み条件が、初期値でONになっているので、一旦全てOFFにする
            selectProperties.setWhereStatusProgressing(false);
            selectProperties.setWhereStatusAcceptance(false);
            selectProperties.setWhereStatusReject(false);
            selectProperties.setWhereStatusFinish(false);
            selectProperties.setWhereStatusCancel(false);

            // WorkFlowdataItemProperties　生成(出力項目の設定）  /////////////////
            items = new WorkFlowdataItemProperties();
            // 一旦項目を全部非表示にセット
            items.allDispSet(false);
            
            StringBuffer errMsg = null;
            String key;
            String value;
            boolean bvalue;
            Enumeration en = config.propertyNames();
            while ( en.hasMoreElements() ) {
                key = (String)en.nextElement();
                value = (String)config.getProperty(key);    
                bvalue = Boolean.valueOf(config.getProperty(key)).booleanValue(); 
                
                if(key.equals("where_petitionnumber") ){               
                    // 値がある場合のみセット
                    if(!"".equals(value))
                    selectProperties.setWherePetitionNumber(value);           // 出力条件(申請番号)
                    
                }else if(key.equals("where_title")){
                    // 値がある場合のみセット
                    if(!"".equals(value))
                    selectProperties.setWhereTitle(value);                    // 出力条件(標題)
                    
                }else if (key.equals("where_creatordisplayname")){    
                    // 値がある場合のみセット
                    if(!"".equals(value))
                    selectProperties.setWhereCreatorName(value);              // 出力条件(申請者名(表示名))
                    
                }else if (key.equals("where_statusprogressing")){                                
                    selectProperties.setWhereStatusProgressing(bvalue);       // 出力条件(ステータス(進行中))
                    
                }else if (key.equals("where_statusacceptance")){                                
                    selectProperties.setWhereStatusAcceptance(bvalue);        // 出力条件(ステータス(承認))
                    
                }else if (key.equals("where_statusreject")){                                    
                    selectProperties.setWhereStatusReject(bvalue);            // 出力条件(ステータス(却下))
                    
                }else if (key.equals("where_statusfinish")){                                      
                    selectProperties.setWhereStatusFinish(bvalue);            // 出力条件(ステータス(完了))  
                    
                }else if (key.equals("where_statuscancel")){                                    
                    selectProperties.setWhereStatusCancel(bvalue);            // 出力条件(ステータス(取消))
                    
                }else if (key.equals("where_datetype") && ("".equals(value) || value.matches("[0-4]"))){                    
                    if(!"".equals(value)){
                        String FromDate = config.getProperty("where_datefrom","");
                        String ToDate = config.getProperty("where_dateto","");
                        
                        SimpleDateFormat sdf = new SimpleDateFormat();
                        sdf.setLenient( false );
                        sdf.applyPattern( "yyyy-MM-dd" );
                        Date from =null;
                        Date to = null;
                        if (! FromDate.equals("")){
                            if(FromDate.matches("\\d{4}-\\d{1,2}-\\d{1,2}"))
                                from = sdf.parse( FromDate );
                            else    
                                throw new java.text.ParseException(FromDate,0);
                        }
                        
                        if (! ToDate.equals("")){
                            if(ToDate.matches("\\d{4}-\\d{1,2}-\\d{1,2}"))
                                to   = sdf.parse(ToDate); 
                            else    
                                throw new java.text.ParseException(ToDate,0);
                        }
                        
                       
                        // where_datefrom とwhere_dateto どちらかに日付があれば条件をセット
                        if(from!=null || to !=null )
                        selectProperties.setWhereDate(Integer.valueOf(value),from,to);    // 出力条件(期間)
                    }
                        
                
                }else if (key.equals("sort") && ("".equals(value) || value.matches("[0-9]"))){        
                    if(!"".equals(value)){
                        // 値を2で割ってあまりが0なら昇順、1なら降順
                        int sortvalue =Integer.parseInt(value);                        
                        if(sortvalue%2 == 0)
                            selectProperties.setSortAsc(new Integer(sortvalue/2));        // 並び順
                        else
                            selectProperties.setSortDesc(new Integer(sortvalue/2));
                    }
                }else if (key.equals("petitionnumber")){                 
                    items.setDispPetitionNumber(bvalue);                        // 表示項目(申請番号)
                    
                }else if (key.equals("status")){                         
                    items.setDispStatus(bvalue);                                // 表示項目(現在ステータス)
                    
                }else if (key.equals("creatorid")){                         
                    items.setDispCreatorId(bvalue);                             // 表示項目(申請者ID)
                    
                }else if (key.equals("creatorloginname")){                 
                    items.setDispCreatorLoginName(bvalue);                      // 表示項目(申請者ログイン名)
                    
                }else if (key.equals("creatordisplayname")){             
                    items.setDispCreatorDisplayName(bvalue);                    // 表示項目(申請者表示名)
                    
                }else if (key.equals("createtime")){                     
                    items.setDispCreateTime(bvalue);                            // 表示項目(申請時間)
                    
                }else if (key.equals("acceptancehandlerid")){             
                    items.setDispAcceptanceHandlerId(bvalue);                   // 表示項目(承認者ID)
                    
                }else if (key.equals("acceptancehandlerloginname")){     
                    items.setDispAcceptanceHandlerLoginName(bvalue);            // 表示項目(承認者ログイン名)
                    
                }else if (key.equals("acceptancehandlerdisplayname")){     
                    items.setDispAcceptanceHandlerDisplayName(bvalue);          // 表示項目(承認者表示名)
                    
                }else if (key.equals("acceptancetime") ){                 
                    items.setDispAcceptanceTime(bvalue);                        // 表示項目(承認時間)
                    
                }else if (key.equals("rejecthandlerid")){                 
                    items.setDispRejectHandlerId(bvalue);                       // 表示項目(却下者ID)
                    
                }else if (key.equals("rejecthandlerloginname") ){         
                    items.setDispRejectHandlerLoginName(bvalue);                // 表示項目(却下者ログイン名)
                    
                }else if (key.equals("rejecthandlerdisplayname")){         
                    items.setDispRejectHandlerDisplayName(bvalue);              // 表示項目(却下者表示名)
                    
                }else if (key.equals("rejecttime")){                     
                    items.setDispRejectTime(bvalue);                            // 表示項目(却下時間)
                    
                }else if (key.equals("finishhandlerid")){                 
                    items.setDispFinishHandlerId(bvalue);                       // 表示項目(完了者ID)
                    
                }else if (key.equals("finishhandlerloginname")){         
                    items.setDispFinishHandlerLoginName(bvalue);                // 表示項目(完了者ログイン名)
                    
                }else if (key.equals("finishhandlerdisplayname")){         
                    items.setDispFinishHandlerDisplayName(bvalue);              // 表示項目(完了者表示名)
                    
                }else if (key.equals("finishtime")){                     
                    items.setDispFinishTime(bvalue);                            // 表示項目(完了時間)
                    
                }else if (key.equals("cancelhandlerid")){                 
                    items.setDispCancelHandlerId(bvalue);                       // 表示項目(取消者ID)
                    
                }else if (key.equals("cancelhandlerloginname")){         
                    items.setDispCancelHandlerLoginName(bvalue);                // 表示項目(取消者ログイン名)
                    
                }else if (key.equals("cancelhandlerdisplayname")){         
                    items.setDispCancelHandlerDisplayName(bvalue);              // 表示項目(取消者表示名)
                    
                }else if (key.equals("canceltime")){                     
                    items.setDispCancelTime(bvalue);                            // 表示項目(取消時間)
                    
                }else if (key.equals("itemdata")){                         
                    items.setDispItemData(bvalue);                              // 表示項目(項目値)
                    
                }else if (key.equals("stepstatus")){                     
                    items.setDispStepStatus(bvalue);                            // 表示項目(経路ステータス)
                    
                }else if (key.equals("stephandleresult")){                 
                    items.setDispStepHandleResult(bvalue);                      // 表示項目(経路処理結果)
                    
                }else if (key.equals("stephandlecomment")){                 
                    items.setDispStepHandleComment(bvalue);                     // 表示項目(経路処理コメント)
                    
                }else if (key.equals("stephandlerid")){                     
                    items.setDispStepHandlerId(bvalue);                         // 表示項目(経路処理者ID)
                    
                }else if (key.equals("stephandlerloginname")){             
                    items.setDispStepHandlerLoginName(bvalue);                  // 表示項目(経路処理者ログイン名)
                    
                }else if (key.equals("stephandlerdisplayname")){         
                    items.setDispStepHandlerDisplayName(bvalue);                // 表示項目(経路処理者表示名)
                    
                }else if (key.equals("stephandletime")){                 
                    items.setDispStepHandleTime(bvalue);                        // 表示項目(経路処理時間)
                    
                }else{ 
                    
                    // 上記及び
                    // where_datefrom,where_dateto 以外で当てはまるものがない場合はエラーとする
                    if(!key.equals("where_datefrom") && !key.equals("where_dateto")){
                        if (errMsg == null) errMsg = new StringBuffer("");
                        else                  errMsg.append(",");
                        
                        errMsg.append(key).append("=").append(value);
                        
                    }
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

        }

}
