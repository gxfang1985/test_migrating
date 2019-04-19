import java.io.File;
import jp.co.cybozu.garoon2.CoopLink;

public class TestCabinetUpload {
    public static void main ( String args[]) throws Exception{
        
        String url = null;                                  // GaroonのURL
        String user = null;                                 // ユーザーアカウント名
        String password = null;                             // パスワード
        String fid = null;                                  // ファイルID
        String registrant =null;                            // 更新者
        File file = new File("C:\\test.txt");                                   // ファイル
        String comment = null;                              // 更新コメント
        
        String fileId = null;                               // ファイルID(戻り値)
        CoopLink cabinetLink = null;                        // CoopLink代入用
        
        // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
        cabinetLink = new CoopLink( url, user, password );

        // Garoonへデータ送信
        fileId = cabinetLink.putCabinetUpload( Long.parseLong(fid), // ファイルID
                                               comment,             // 更新コメント                               
                                               file,                // ファイル
                                               registrant );        // 更新者
        System.out.println(fileId);
    }
}
