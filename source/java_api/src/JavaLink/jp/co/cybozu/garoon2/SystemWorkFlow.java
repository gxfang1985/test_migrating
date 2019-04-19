package jp.co.cybozu.garoon2;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;

import jp.co.cybozu.garoon2.util.GrnConnector;
import jp.co.cybozu.garoon2.util.Utils;


/**
 * コンストラクタの引数[grnCon] を使用して、ワークフローの各種操作の機能を実装します。<BR>
 *
 * @author サイボウズ 
 * @version    1.1.0
 * 
 */
public class SystemWorkFlow {

    private GrnConnector grnCon;
    
    /**
     * 指定の接続情報を使って、新しいSystemWorkFlow を作成します。<BR>
     * @param grnCon 接続情報
     * 
     */
    public SystemWorkFlow(GrnConnector grnCon){
        this.grnCon = grnCon;
    }
    
    /**
     * 引数 [attachedFileId]の添付ファイルをワークフローよりダウンロードし、<BR>
     * 引数 引数 [directoryPath]のディレクトリ に、引数 [fileName] のファイル名で保存します。<BR>
     * 
     * @param attachedFileId ワークフローの添付ファイルID
     * @param directoryPath ファイルを保存するディレクトリパス.null指定可能(カレントディレクトリに保存します。）
     * @param fileName ファイルを保存するファイル名.<BR>null指定可能(ワークフローに登録されている添付ファイル名で保存します。)
     * 
     * @throws IOException 接続が確立できない等通信上のエラーが発生した場合
     * @throws RemoteException ワークフロー連携用プログラム上でエラーが発生した場合
     */
    public void downloadSystemFile(long attachedFileId,
                                     String directoryPath,
                                     String fileName)
    throws IOException, RemoteException
    {
        HashMap hm = new HashMap();
        InputStream responseIn = null;
        Utils units = new Utils();
        
        String pid = null;
        
        if (fileName == null) {
            hm.put("system", "2");                           // 権限チェック用(System)
            hm.put("manage", "workflow" );                   // 権限チェック用Application名
            hm.put("ifid",Long.toString(attachedFileId));    // 添付ファイルID
            hm.put("title_flag","1");                        // ワークフローの添付ファイルのタイトル取得フラグ(タイトル取得 1:する,1以外:しない)
            
            responseIn = this.grnCon.getResponseStream("/coop/grnWorkflow_download",hm,"failed to download of the workflow attached file.");
            
            BufferedReader in = units.processBufferResult(responseIn);
            String line = in.readLine();
            
            int pointpos = line.indexOf(",");
            if ( pointpos != -1 ) {
                pid = line.substring(0, pointpos);
                fileName = line.substring(pointpos + 1);
            } else {
                throw new RemoteException("failed to download of the workflow attached file.");
            }
            
            responseIn.close();
        }
        
        hm.clear();
        hm.put("system", "2");                               // 権限チェック用(System)
        hm.put("manage", "workflow" );                       // 権限チェック用Application名
        hm.put("ifid",Long.toString(attachedFileId));        // 添付ファイルID
        hm.put( "pid", pid );                                // ワークフロー申請ID
        
        // リクエスト & レスポンスGET
        responseIn = this.grnCon.getResponseStream("/coop/grnWorkflow_download",hm,"failed to download of the workflow attached file.");
        
        // レスポンスデータをファイルに保存
        units.writeBynaryFile(responseIn,directoryPath,fileName);
    }
    
    /**
     * 引数 [attachedFileId]の添付ファイルをワークフローよりダウンロードし、<BR>
     * 引数 [directoryPath]のディレクトリに保存します。<BR>
     * ファイル名は、ワークフローで添付されているファイルの名前になります。<BR>
     * 
     * @param attachedFileId ワークフローの添付ファイルID
     * @param directoryPath ファイルを保存するディレクトリパス.null指定可能(カレントディレクトリに保存します。）
     *  
     * @throws IOException 接続が確立できない等通信上のエラーが発生した場合
     * @throws RemoteException ワークフロー連携用プログラム上でエラーが発生した場合
     */
    public void downloadSystemFile(long attachedFileId,
                                     String directoryPath)
    throws IOException, RemoteException
    {
        this.downloadSystemFile(attachedFileId,directoryPath,null);
    }
    
    /**
     * ワークフロー申請データ出力用共通メソッド
     * @param hm 申請ID,申請フォームID,申請フォームコードのいづれかのパラメータ(Key,Value)がセットされたHashMap
     * @param selectProperties 抽出条件
     * @param items 出力項目
     * @param filePath XMLファイルパス
     * 
     */
    private void exportXMLPetitionData(HashMap hm,
                                       WorkFlowdataSelectProperties selectProperties,
                                       WorkFlowdataItemProperties items,
                                       String filePath)
    throws IOException,RemoteException
    {
        if (hm ==null) hm = new HashMap();
        if (selectProperties != null)     hm.putAll(selectProperties.getParameters());
        if (items != null)                hm.putAll(items.getParameters());
        
        hm.put("system","2");
        hm.put("manage","workflow");
        
        // リクエスト & レスポンスGET
        InputStream in = grnCon.getResponseStream("/coop/grnWorkflow_petitiondata_exportXML",
                                                  hm,
                                                  "failed to export xmlfile of petitiondata");
        // ファイルの出力
        new Utils().writeBynaryFile(in,filePath);
    }

    
    /**
     * ワークフロー上の申請データID(引数 [petitionId]) について、引数 [items]で出力指定された項目を持つ
     * XMLファイルを引数 [filePath]  に出力します。
     * 
     * @param petitionId ワークフローの申請ID
     * @param items 出力項目.
     * @param filePath XMLファイルパス
     * 
     * @throws IOException 接続が確立できない等通信上のエラーが発生した場合
     * @throws RemoteException ガルーン２上でエラーが発生した場合
     */
    public void exportXMLPetitionData(long petitionId,
                                        WorkFlowdataItemProperties items,
                                        String filePath)
    throws IOException,RemoteException
    {
        HashMap hm = new HashMap();
        hm.put("pid",Long.toString(petitionId));
        exportXMLPetitionData(hm,null,items,filePath);
    }
    
    /**
     * ワークフロー上の申請データID(引数 [petitionId]) について、経路情報以外の項目を持つ
     * XMLファイルを引数 [filePath] に出力します。
     * 
     * @param petitionId ワークフローの申請ID
     * @param filePath XMLファイルパス
     * 
     * @throws IOException 接続が確立できない等通信上のエラーが発生した場合
     * @throws RemoteException ガルーン２上でエラーが発生した場合
     */
    public void exportXMLPetitionData(long petitionId,
                                      String filePath)
    throws IOException,RemoteException
    {
        exportXMLPetitionData(petitionId,new WorkFlowdataItemProperties(),filePath);
    }
    
    
    /**
     * ワークフロー上の申請フォームID(引数 [formId]) 内において、
     * 引数[selectProperties]で指定される抽出条件に合致する
     * 申請データの一覧について、引数 [items]で出力指定された項目を持つ
     * XMLファイルを引数 [filePath] に出力します。
     * 
     * @param formId ワークフローの申請フォームID
     * @param selectProperties 抽出条件
     * @param items 出力項目
     * @param filePath XMLファイルパス
     * 
     * @throws IOException 接続が確立できない等通信上のエラーが発生した場合
     * @throws RemoteException ガルーン２上でエラーが発生した場合
     */
    public void exportXMLFormPetitionData(long formId,
                                          WorkFlowdataSelectProperties selectProperties,
                                          WorkFlowdataItemProperties items,
                                          String filePath)
    throws IOException,RemoteException
    {
        HashMap hm = new HashMap();
        hm.put("fid",Long.toString(formId));
        exportXMLPetitionData(hm,selectProperties,items,filePath);
    }
    
    /**
     *  ワークフロー上の申請フォームID(引数 [formId]) 内において、
     *  引数[selectProperties]で指定される抽出条件に合致する
     *  申請データの一覧について、経路情報以外の項目を持つ
     *  XMLファイルを引数 [filePath]  に出力します。
     * 
     * @param formId ワークフローの申請フォームID
     * @param selectProperties 抽出条件
     * @param filePath XMLファイルパス
     * 
     * @throws IOException 接続が確立できない等通信上のエラーが発生した場合
     * @throws RemoteException ガルーン２上でエラーが発生した場合
     */
    public void exportXMLFormPetitionData(long formId,
                                          WorkFlowdataSelectProperties selectProperties,
                                          String filePath)
    throws IOException,RemoteException
    {
        exportXMLFormPetitionData(formId,
                                  selectProperties,
                                  new WorkFlowdataItemProperties(),
                                  filePath);
    }
    
    /**
     *  ワークフロー上の申請フォームコード(引数 [formCode]) 内において、
     *  引数[selectProperties]で指定される抽出条件に合致する
     *  申請データの一覧について、引数 [items]で出力指定された項目を持つ
     *  XMLファイルを引数 [filePath]  に出力します。
     * 
     * @param formCode ワークフローの申請フォームコード
     * @param selectProperties 抽出条件
     * @param items 出力項目
     * @param filePath XMLファイルパス
     * 
     * @throws IOException 接続が確立できない等通信上のエラーが発生した場合
     * @throws RemoteException ガルーン２上でエラーが発生した場合
     */
    public void exportXMLFormPetitionData(String formCode,
                                          WorkFlowdataSelectProperties selectProperties,
                                          WorkFlowdataItemProperties items,
                                          String filePath)
    throws IOException,RemoteException
    {
        HashMap hm = new HashMap();
        hm.put("formcode",formCode);
        exportXMLPetitionData(hm,selectProperties,items,filePath);
    }

    /**
     * ワークフロー上の申請フォームコード(引数 [formCode]) 内において、
     * 引数[selectProperties]で指定される抽出条件に合致する
     * 申請データの一覧について、経路情報以外の項目を持つ
     * XMLファイルを引数 [filePath]  に出力します。
     * 
     * @param formCode  ワークフローの申請フォームコード
     * @param selectProperties 抽出条件
     * @param filePath XMLファイルパス
     * 
     * @throws IOException 接続が確立できない等通信上のエラーが発生した場合
     * @throws RemoteException ガルーン２上でエラーが発生した場合
     */    
    public void exportXMLFormPetitionData(String formCode,
                                          WorkFlowdataSelectProperties selectProperties,
                                          String filePath)
    throws IOException,RemoteException
    {
        exportXMLFormPetitionData(formCode,
                                  selectProperties,
                                  new WorkFlowdataItemProperties(),
                                  filePath);
    }



}
