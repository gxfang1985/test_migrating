import java.io.File;

import jp.co.cybozu.garoon2.CoopLink;

public class TestCabinetDownload_1 {
    public static void main ( String args[]) throws Exception{
        
        String url = "http://haken-kreuz.corp.cybozu.co.jp/cgi-bin/cbgrn213/grn.cgi";                          // GaroonのURL
        String user = "Administrator";                         // ログインユーザーアカウント
        String password = "cybozu";                     // ログインパスワード
        String fid = "90";                           // ファイルID
        String registrant = null;                    // 実行者
        String dirPath = "";                       // ディレクトリパス
        CoopLink cabinetLink = null;                        // CoopLink代入用
        
        // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
        cabinetLink = new CoopLink( url, user, password );

        // Garoonへデータ送信
            // 最新バージョンのファイル 及び ファイル管理上のファイル名で保存する場合
            cabinetLink.putCabinetDownload( Long.parseLong(fid),     // ファイルID        
                                            dirPath,                 // ディレクトリパス
                                            registrant );            // 実行者
    }
}
