import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.WorkFlowdataItemProperties;
import jp.co.cybozu.garoon2.WorkFlowdataSelectProperties;

public class TestWorkFlowPetitionDataXMLExport_1 {
	public static void main ( String args[]) throws Exception{
        String url = null;                                      // GaroonのURL
        String user = null;                                     // ユーザーアカウント名
        String password = null;                                 // パスワード
        String pid = null;                                      // 申請ID
        String filePath = null;                                 // XMLファイルパス
        WorkFlowdataItemProperties items = new WorkFlowdataItemProperties();
        
        // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
        CoopLink workflowLink = new CoopLink( url, user, password );
        workflowLink.exportXMLSystemWorkFlowPetitionData(Long.parseLong(pid),items,filePath);
	}
}
