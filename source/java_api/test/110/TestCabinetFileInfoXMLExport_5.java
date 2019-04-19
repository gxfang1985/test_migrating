import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.FileInfoProperties;

public class TestCabinetFileInfoXMLExport_5 {
    public static void main ( String args[]) throws Exception{
        String url = null;                     // GaroonのURL
        String user = null;                    // ユーザーアカウント名
        String password = null;                // パスワード
        String registrant = null;              // 実行者
        String hid = null;                    // フォルダID
        String filePath = null;                 // ディレクトリパス
    
        // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
        CoopLink cabinetLink = new CoopLink( url, user, password );
        cabinetLink.exportXMLCabinetFileInfoFolderChild(Long.parseLong(hid),filePath,registrant);

    }
}
