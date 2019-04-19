import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.FileInfoProperties;

public class TestCabinetFileInfoXMLExport_1 {
    public static void main ( String args[]) throws Exception{
        
        String url = "http://haken-kreuz.corp.cybozu.co.jp/cgi-bin/cbgrn213/grn.cgi";                          // GaroonのURL
        String user = "Administrator";                         // ログインユーザーアカウント
        String password = "cybozu";                     // ログインパスワード
        String registrant = null;              // 実行者
        String fid = "24";                    // ファイルID
        String filePath = "C:\\test.xml";                 // ディレクトリパス
    
        FileInfoProperties items = null;       // 出力項目

    
        // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
        CoopLink cabinetLink = new CoopLink( url, user, password );
        cabinetLink.exportXMLCabinetFileInfo(Long.parseLong(fid),items,filePath,registrant);

    }
}
