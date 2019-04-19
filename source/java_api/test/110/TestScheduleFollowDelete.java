import jp.co.cybozu.garoon2.CoopLink;

public class TestScheduleFollowDelete {
    public static void main ( String args[]) throws Exception{
        
        String url = null;                                // GaroonのURL
        String user = null;                               // ログインユーザーアカウント
        String password = null;                           // ログインパスワード
        String registrant = null;                         // 削除者
        String fid = null;                                // ガルーン２のスケジュールフォローID
        String followId = null;                           // ガルーン２のスケジュールフォローID（戻り値）
        CoopLink scheduleLink = null;                     // CoopLink代入用
        
        // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
        scheduleLink = new CoopLink( url,user,password );
        
        // Garoonにスケジュール削除情報を送信(通常予定/バナー予定のみ対応)
        followId = scheduleLink.putScheduleFollowDelete(Long.parseLong(fid),  // ガルーン２のスケジュールフォローID
                                                       registrant);          // 削除者
        System.out.println(followId); // 戻り値表示
    }
}
