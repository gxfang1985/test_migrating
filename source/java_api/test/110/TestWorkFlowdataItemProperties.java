import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.WorkFlowdataItemProperties;

public class TestWorkFlowdataItemProperties {
	public static void main ( String args[]) throws Exception{
        String url = null;                                      // GaroonのURL
        String user = null;                                     // ユーザーアカウント名
        String password = null;                                 // パスワード
        String pid = null;                                      // 申請ID
        String filePath = null;                                 // XMLファイルパス
        
        WorkFlowdataItemProperties items = new WorkFlowdataItemProperties();
        
        //試験時，以下適宜変更のこと///////////////////////////////////////////////////////////
        
        //一括設定
        //items.allDispSet(true);
    
        //  デフォルト値セット
        //items.init();
        
        //ステップ関連一括セット
        //items.stepDispSet(true);
        
        //get系の試験時は一旦項目を全部非表示にセット
        //items.allDispSet(false);   
        
        //set系
        //各項目設定,コメントアウトを外すと項目を出力するかどうかをtrue,falseで設定できます．
        //items.setDispPetitionNumber(true);                        // 表示項目(申請番号)                       
        //items.setDispStatus(true);                                // 表示項目(現在ステータス)                                
        //items.setDispCreatorId(true);                             // 表示項目(申請者ID)                       
        //items.setDispCreatorLoginName(true);                      // 表示項目(申請者ログイン名)                
        //items.setDispCreatorDisplayName(true);                    // 表示項目(申請者表示名)                          
        //items.setDispCreateTime(true);                            // 表示項目(申請時間)                   
        //items.setDispAcceptanceHandlerId(true);                   // 表示項目(承認者ID)           
        //items.setDispAcceptanceHandlerLoginName(true);            // 表示項目(承認者ログイン名)           
        //items.setDispAcceptanceHandlerDisplayName(true);          // 表示項目(承認者表示名)                      
        //items.setDispAcceptanceTime(true);                        // 表示項目(承認時間)                        
        //items.setDispRejectHandlerId(true);                       // 表示項目(却下者ID)              
        //items.setDispRejectHandlerLoginName(true);                // 表示項目(却下者ログイン名)                
        //items.setDispRejectHandlerDisplayName(true);              // 表示項目(却下者表示名)                             
        //items.setDispRejectTime(true);                            // 表示項目(却下時間)                   
        //items.setDispFinishHandlerId(true);                       // 表示項目(完了者ID)              
        //items.setDispFinishHandlerLoginName(true);                // 表示項目(完了者ログイン名)               
        //items.setDispFinishHandlerDisplayName(true);              // 表示項目(完了者表示名)                    
        //items.setDispFinishTime(true);                            // 表示項目(完了時間)                       
        //items.setDispCancelHandlerId(true);                       // 表示項目(取消者ID)              
        //items.setDispCancelHandlerLoginName(true);                // 表示項目(取消者ログイン名)                
        //items.setDispCancelHandlerDisplayName(true);              // 表示項目(取消者表示名)                           
        //items.setDispCancelTime(true);                            // 表示項目(取消時間)                             
        //items.setDispItemData(true);                              // 表示項目(項目値)                            
        //items.setDispStepStatus(true);                            // 表示項目(経路ステータス)                      
        //items.setDispStepHandleResult(true);                      // 表示項目(経路処理結果)                       
        //items.setDispStepHandleComment(true);                     // 表示項目(経路処理コメント)                          
        //items.setDispStepHandlerId(true);                         // 表示項目(経路処理者ID)                  
        //items.setDispStepHandlerLoginName(true);                  // 表示項目(経路処理者ログイン名)               
        //items.setDispStepHandlerDisplayName(true);                // 表示項目(経路処理者表示名)                    
        //items.setDispStepHandleTime(true);                        // 表示項目(経路処理時間)
        
        //get系
        //各設定項目取得,コメントアウトを外すとtrueかfalseが返ってきます．
        //System.out.println(items.getDispPetitionNumber());                       // 表示項目(申請番号)                       
        //System.out.println(items.getDispStatus());                               // 表示項目(現在ステータス)                            
        //System.out.println(items.getDispCreatorId());                            // 表示項目(申請者ID)                       
        //System.out.println(items.getDispCreatorLoginName());                     // 表示項目(申請者ログイン名)                
        //System.out.println(items.getDispCreatorDisplayName());                   // 表示項目(申請者表示名)                          
        //System.out.println(items.getDispCreateTime());                           // 表示項目(申請時間)                   
        //System.out.println(items.getDispAcceptanceHandlerId());                  // 表示項目(承認者ID)           
        //System.out.println(items.getDispAcceptanceHandlerLoginName());           // 表示項目(承認者ログイン名)           
        //System.out.println(items.getDispAcceptanceHandlerDisplayName());         // 表示項目(承認者表示名)                      
        //System.out.println(items.getDispAcceptanceTime());                       // 表示項目(承認時間)                        
        //System.out.println(items.getDispRejectHandlerId());                      // 表示項目(却下者ID)              
        //System.out.println(items.getDispRejectHandlerLoginName());               // 表示項目(却下者ログイン名)                
        //System.out.println(items.getDispRejectHandlerDisplayName());             // 表示項目(却下者表示名)                             
        //System.out.println(items.getDispRejectTime());                           // 表示項目(却下時間)                   
        //System.out.println(items.getDispFinishHandlerId());                      // 表示項目(完了者ID)              
        //System.out.println(items.getDispFinishHandlerLoginName());               // 表示項目(完了者ログイン名)               
        //System.out.println(items.getDispFinishHandlerDisplayName());             // 表示項目(完了者表示名)                    
        //System.out.println(items.getDispFinishTime());                           // 表示項目(完了時間)                       
        //System.out.println(items.getDispCancelHandlerId());                      // 表示項目(取消者ID)              
        //System.out.println(items.getDispCancelHandlerLoginName());               // 表示項目(取消者ログイン名)                
        //System.out.println(items.getDispCancelHandlerDisplayName());             // 表示項目(取消者表示名)                           
        //System.out.println(items.getDispCancelTime());                           // 表示項目(取消時間)                             
        //System.out.println(items.getDispItemData());                             // 表示項目(項目値)                            
        //System.out.println(items.getDispStepStatus());                           // 表示項目(経路ステータス)                      
        //System.out.println(items.getDispStepHandleResult());                     // 表示項目(経路処理結果)                       
        //System.out.println(items.getDispStepHandleComment());                    // 表示項目(経路処理コメント)                          
        //System.out.println(items.getDispStepHandlerId());                        // 表示項目(経路処理者ID)                  
        //System.out.println(items.getDispStepHandlerLoginName());                 // 表示項目(経路処理者ログイン名)               
        //System.out.println(items.getDispStepHandlerDisplayName());               // 表示項目(経路処理者表示名)                    
        //System.out.println(items.getDispStepHandleTime());                       // 表示項目(経路処理時間)
        
        // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
        CoopLink workflowLink = new CoopLink( url, user, password );
        workflowLink.exportXMLSystemWorkFlowPetitionData(Long.parseLong(pid),items,filePath);
	}
}
