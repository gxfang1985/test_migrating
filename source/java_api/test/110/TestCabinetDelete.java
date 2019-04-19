import jp.co.cybozu.garoon2.CoopLink;

public class TestCabinetDelete {
    
    public static void main ( String args[]) throws Exception{
        
        String url = null;                          // GaroonのURL
        String user = null;                         // ログインユーザーアカウント
        String password = null;                     // ログインパスワード
        String fid = null;                                  //ファイルID
        String registrant = null;                           //削除者
        
        CoopLink cabinetLink = new CoopLink( url, user, password );
        String fileId = cabinetLink.putCabinetDelete( Long.parseLong(fid),registrant);
        System.out.println(fileId);
    }
}
