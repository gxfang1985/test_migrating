import jp.co.cybozu.garoon2.CoopLink;

public class TestCabinetModify {
    public static void main ( String args[]) throws Exception{
        
        String url = null;                                  //GaroonのURL
        String user = null;                                 //ユーザーアカウント名
        String password = null;                             //パスワード
        String fid = null;                                  //ファイルID
        String registrant = null;                           //情報変更者
        String title = null;                                //タイトル
        String version = null;                               //バージョン
        String memo =null;                                 //メモ
        
        String fileId =null;                               //ファイルID(戻り値)
        CoopLink cabinetLink =null;                        //CoopLink代入用
        
        // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
        cabinetLink = new CoopLink( url, user, password );

        // Garoonへデータ送信
        fileId = cabinetLink.putCabinetModify( Long.parseLong(fid),     // ファイルID
                                               title,                   // タイトル
                                               Long.parseLong(version), // バージョン管理
                                               memo,                    // メモ                                                    
                                               registrant );            // 情報変更者
        System.out.println(fileId);
    }
}
