import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.FolderInfoProperties;

public class TestFolderInfoProperties {
    public static void main ( String args[]) throws Exception{
        String url = null;                                  // GaroonのURL
        String user = null;                                 // ユーザーアカウント名
        String password = null;                             // パスワード
        String registrant = null;                           // 実行者
        String hid = null;                                 // フォルダID
        String dirPath = null;                              // ディレクトリパス
    
    FolderInfoProperties items = null;                  // 出力項目
    

    // FolderInfoProperties  生成
    items = new FolderInfoProperties();

    //試験時，以下適宜変更のこと///////////////////////////////////////////////////////////
    
    //一括設定
    //items.allDispSet(true);
    
    //デフォルト値セット
    //items.init();
    
    // 一旦項目を全部非表示にセット
    items.allDispSet(false);
 
    //set系
    //各項目設定,コメントアウトを外すと項目を出力するかどうかをtrue,falseで設定できます．
    items.setDispTitle(true);// フォルダ名            
    items.setDispDescription(true);// フォルダメモ                 
    items.setDispCreatorId(true);// 登録ユーザーID           
    items.setDispCreatorLoginName(true);// 登録ユーザーログイン名          
    items.setDispCreatorDisplayName(true);// 登録ユーザー表示ID                 
    items.setDispCreateTime(true); // 登録日時                 
    items.setDispModifierId(true);// 更新ユーザーID          
    items.setDispModifierLoginName(true);// 更新ユーザーログイン名         
    items.setDispModifierDisplayName(true);// 更新ユーザー表示名                  
    items.setDispModifyTime(true);// 更新時間
  
    //get系
    //各項目設定,コメントアウトを外すと項目を出力するかどうかを,falseで設定できます．
    //System.out.println(items.getDispTitle());// フォルダ名            
    //System.out.println(items.getDispDescription());// フォルダメモ                 
    //System.out.println(items.getDispCreatorId());// 登録ユーザーID           
    //System.out.println(items.getDispCreatorLoginName());// 登録ユーザーログイン名          
    //System.out.println(items.getDispCreatorDisplayName());// 登録ユーザー表示ID                 
    //System.out.println(items.getDispCreateTime()); // 登録日時                 
    //System.out.println(items.getDispModifierId());// 更新ユーザーID          
    //System.out.println(items.getDispModifierLoginName());// 更新ユーザーログイン名         
    //System.out.println(items.getDispModifierDisplayName());// 更新ユーザー表示名                  
    //System.out.println(items.getDispModifyTime());// 更新時間
    
    // set系でのみ使用
    // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
    CoopLink cabinetLink = new CoopLink( url, user, password );
    cabinetLink.exportXMLCabinetFolderInfo(Long.parseLong(hid),items,dirPath,registrant);
    
    }
}
