import jp.co.cybozu.garoon2.CoopLink;

public class TestCabinetFolderInfoXMLExport_4 {
	public static void main ( String args[]) throws Exception{
        String url = null;                                  // GaroonのURL
        String user = null;                                 // ユーザーアカウント名
        String password = null;                             // パスワード
        String registrant = null;                           // 実行者
        String folderCode = null;                               // フォルダID
        String filePath = null;                              // ディレクトリパス

        // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
        CoopLink cabinetLink = new CoopLink( url, user, password );
        cabinetLink.exportXMLCabinetFolderInfo(folderCode,filePath,registrant);

	}
}
