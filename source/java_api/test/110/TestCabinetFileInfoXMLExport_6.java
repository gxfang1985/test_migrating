import jp.co.cybozu.garoon2.CoopLink;

public class TestCabinetFileInfoXMLExport_6 {
    public static void main ( String args[]) throws Exception{
        String url = "http://haken-kreuz.corp.cybozu.co.jp/cgi-bin/cbgrn213/grn.cgi";                          // GaroonのURL
        String user = "Administrator";                         // ログインユーザーアカウント
        String password = "cybozu";                     // ログインパスワード
        String registrant = null;              // 実行者
        String folderCode = "test";                    // フォルダID
        String filePath = "C:\\test.xml";                 // ディレクトリパス
    
        // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
        CoopLink cabinetLink = new CoopLink( url, user, password );
        cabinetLink.exportXMLCabinetFileInfoFolderChild(folderCode,filePath,registrant);

    }
}
