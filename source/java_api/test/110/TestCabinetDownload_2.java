import jp.co.cybozu.garoon2.CoopLink;

public class TestCabinetDownload_2 {
    public static void main ( String args[]) throws Exception{
        
        String url = null;                          // GaroonのURL
        String user = null;                         // ログインユーザーアカウント
        String password = null;                     // ログインパスワード
        String fid = null;                           // ファイルID
        String registrant = null;                    // 実行者
        String dirPath = null;                       // ディレクトリパス
        String fileName = null;                      // ファイル名
        String version = null;                       // 取得バージョン
        CoopLink cabinetLink = null;                        // CoopLink代入用
        
        // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
        cabinetLink = new CoopLink( url, user, password );

        // バージョンを指定又はファイル名を別名で保存する場合
        cabinetLink.putCabinetDownload( Long.parseLong(fid),     // ファイルID    
                                        dirPath,                 // ディレクトリパス
                                        fileName,                // ファイル名
                                        version==null?null:Long.decode(version), // バージョン
                                        registrant );            // 実行者    
    }
}
