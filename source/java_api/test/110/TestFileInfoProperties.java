import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.FileInfoProperties;

public class TestFileInfoProperties {
    public static void main ( String args[]) throws Exception{
        String url = null;                     // GaroonのURL
        String user = null;                    // ユーザーアカウント名
        String password = null;                // パスワード
        String registrant = null;              // 実行者
        String fid = null;                    // ファイルID
        String dirPath = null;                 // ディレクトリパス
    
        FileInfoProperties items = null;       // 出力項目
    
        
        // FileInfoProperties　生成
        items = new FileInfoProperties();
        
        //試験時，以下適宜変更のこと///////////////////////////////////////////////////////////
        
        //一括設定
        //items.allDispSet(true);
    
        //  デフォルト値セット
        //items.init();
    
        //  履歴関連一括セット
        //items.historyDispSet(false);
        
        // 一旦項目を全部非表示にセット
        //items.allDispSet(false);    
        
        //set系
        //各項目設定,コメントアウトを外すと項目を出力するかどうかをtrue,falseで設定できます．
        //items.setDispTitle(true);// タイトル
        //items.setDispDiscriptoin(true);// メモ
        //items.setDispMaxVersion(true);// バージョン上限値
        //items.setDispName(true);// ファイル名
        //items.setDispSize(true);// ファイルサイズ
        //items.setDispMimeType(true);// ファイルのMIMETYPE
        //items.setDispCreatorId(true);// 作成者ID
        //items.setDispCreatorLoginName(true);// 作成者ログイン名
        //items.setDispCreatorDisplayName(true);// 作成者表示名
        //items.setDispCreateTime(true);// 作成日時
        //items.setDispModifierId(true);// 更新者ID
        //items.setDispModifierLoginName(true);// 更新者ログイン名
        //items.setDispModifierDisplayName(true);// 更新者表示名
        //items.setDispModifyTime(true);// 更新日時
        //items.setDispHistoryVersion(true);// バージョンNO
        //items.setDispHistoryActive(true);// 履歴管理されているか
        //items.setDispHistoryName(true);// 履歴のファイル名
        //items.setDispHistoryAction(true);// 操作
        //items.setDispHistoryComment(true);// 更新コメント
        //items.setDispHistoryModifierId(true);// 更新者ID
        //items.setDispHistoryModifierLoginName(true);// 更新者ログイン名
        //items.setDispHistoryModifierDisplayName(true);// 更新者表示名
        //items.setDispHistoryModifyTime(true);// 更新日時
       
        //get系
        //各設定項目取得,コメントアウトを外すとtrueかfalseが返ってきます．
        //System.out.println(items.getDispTitle());// タイトル
        //System.out.println(items.getDispDiscriptoin());// メモ
        //System.out.println(items.getDispMaxVersion());// バージョン上限値
        //System.out.println(items.getDispName());// ファイル名
        //System.out.println(items.getDispSize());// ファイルサイズ
        //System.out.println(items.getDispMimeType());// ファイルのMIMETYPE
        //System.out.println(items.getDispCreatorId());// 作成者ID
        //System.out.println(items.getDispCreatorLoginName());// 作成者ログイン名
        //System.out.println(items.getDispCreatorDisplayName());// 作成者表示名
        //System.out.println(items.getDispCreateTime());// 作成日時
        //System.out.println(items.getDispModifierId());// 更新者ID
        //System.out.println(items.getDispModifierLoginName());// 更新者ログイン名
        //System.out.println(items.getDispModifierDisplayName());// 更新者表示名
        //System.out.println(items.getDispModifyTime());// 更新日時
        //System.out.println(items.getDispHistoryVersion());// バージョンNO
        //System.out.println(items.getDispHistoryActive());// 履歴管理されているか
        //System.out.println(items.getDispHistoryName());// 履歴のファイル名
        //System.out.println(items.getDispHistoryAction());// 操作
        //System.out.println(items.getDispHistoryComment());// 更新コメント
        //System.out.println(items.getDispHistoryModifierId());// 更新者ID
        //System.out.println(items.getDispHistoryModifierLoginName());// 更新者ログイン名
        //System.out.println(items.getDispHistoryModifierDisplayName());// 更新者表示名
        //System.out.println(items.getDispHistoryModifyTime());// 更新日時
       
        //set系でのみ使用
        //Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
        //CoopLink cabinetLink = new CoopLink( url, user, password );
        //cabinetLink.exportXMLCabinetFileInfo(Long.parseLong(fid),items,dirPath,registrant);
    }
}
