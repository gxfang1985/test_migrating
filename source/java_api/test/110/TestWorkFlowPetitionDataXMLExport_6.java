import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.WorkFlowdataItemProperties;
import jp.co.cybozu.garoon2.WorkFlowdataSelectProperties;

public class TestWorkFlowPetitionDataXMLExport_6 {
	public static void main ( String args[]) throws Exception{
        String url = null;                                      // GaroonのURL
        String user = null;                                     // ユーザーアカウント名
        String password = null;                                 // パスワード
        String formCode = null;                                 // フォームコード
        String filePath = null;                                 // XMLファイルパス
        WorkFlowdataSelectProperties selectProperties = new WorkFlowdataSelectProperties();
        // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
        CoopLink workflowLink = new CoopLink( url, user, password );
        workflowLink.exportXMLSystemWorkFlowFormPetitionData(formCode,selectProperties,filePath);
	}
}
