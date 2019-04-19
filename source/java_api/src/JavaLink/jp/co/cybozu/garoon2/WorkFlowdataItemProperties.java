package jp.co.cybozu.garoon2;

import java.util.ArrayList;

import jp.co.cybozu.garoon2.util.AbstractParameters;

/**
 * ワークフローの申請データ取得用に出力するXMLの項目群を設定するクラスです。<BR>
 *
 * @author サイボウズ
 * @version    1.1.0
 */
public class WorkFlowdataItemProperties extends AbstractParameters{
    private String key = "items[]";
    private boolean[] value;

    public  WorkFlowdataItemProperties(){
        super();
        this.value = new boolean[30];
        this.init();
    }

    // デフォルト値セット
    /**
     * 申請データの出力項目群について、初期値をセットします。<BR>
     * 初期値は、経路情報関連以外は表示、経路情報は、非表示です。
     */
    public void init(){    
        allDispSet(true);
        stepDispSet(false);
    }
    
    /**
     * 申請データの出力項目群の表示・非表示の設定値を一括設定します。
     * @param value trueの場合、表示します。
     */
    public void allDispSet(boolean value){
        int len = this.value.length;
        for (int i = 0; i < len; i++) {
            this.value[i] = value;
        }
    }
    
     /**
     * 申請データの出力項目群のうち、経路情報関連の項目についての表示・非表示の設定値を一括設定します。
     * @param  value trueの場合、表示します。
     */
    // ステップ関連一括セット
    public void stepDispSet(boolean value){
        int[] historyIndex = {23,24,25,26,27,28,29};
        int len = historyIndex.length;
        for (int i = 0; i < len; i++) {
            this.value[historyIndex[i]] = value;
        }
    }
    
    
    protected void setParameters(){
        int len = this.value.length;
        ArrayList items = new ArrayList();
        
        for (int i = 0; i < len; i++) {
            if(this.value[i]==true) items.add(Integer.toString(i));
        }
        
        super.Add(this.key,items);
    }
    /**
     * 申請データの申請番号の表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispPetitionNumber(boolean value){                this.value[0]=value;}
    
    /**
     * 申請データの現在ステータスの表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispStatus(boolean value){                        this.value[1]=value;}
    
    /**
     * 申請データの申請者IDの表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispCreatorId(boolean value){                     this.value[2]=value;}
    
    /**
     * 申請データの申請者ログイン名の表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispCreatorLoginName(boolean value){              this.value[3]=value;}
    
    /**
     * 申請データの申請者表示名の表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispCreatorDisplayName(boolean value){            this.value[4]=value;}
    
    /**
     * 申請データの申請時間の表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispCreateTime(boolean value){                    this.value[5]=value;}
    
    /**
     * 申請データの最終承認者IDの表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispAcceptanceHandlerId(boolean value){           this.value[6]=value;}
    
    /**
     * 申請データの最終承認者ログイン名の表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispAcceptanceHandlerLoginName(boolean value){    this.value[7]=value;}
    
    /**
     * 申請データの最終承認者表示名の表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispAcceptanceHandlerDisplayName(boolean value){  this.value[8]=value;}
    
    /**
     * 申請データの最終承認時間の表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispAcceptanceTime(boolean value){                this.value[9]=value;}
    
    /**
     * 申請データの却下者IDの表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispRejectHandlerId(boolean value){               this.value[10]=value;}
    
    /**
     * 申請データの却下者ログイン名の表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispRejectHandlerLoginName(boolean value){        this.value[11]=value;}
    
    /**
     * 申請データの却下者表示名の表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispRejectHandlerDisplayName(boolean value){      this.value[12]=value;}
    
    /**
     * 申請データの却下時間の表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */    
    public void setDispRejectTime(boolean value){                    this.value[13]=value;}
    
    /**
     * 申請データの完了者IDの表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispFinishHandlerId(boolean value){               this.value[14]=value;}
    
    /**
     * 申請データの完了者ログイン名の表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispFinishHandlerLoginName(boolean value){        this.value[15]=value;}
    
    /**
     * 申請データの完了者表示名の表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispFinishHandlerDisplayName(boolean value){      this.value[16]=value;}
    
    /**
     * 申請データの完了時間の表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispFinishTime(boolean value){                    this.value[17]=value;}
    
    /**
     * 申請データの取消者IDの表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispCancelHandlerId(boolean value){               this.value[18]=value;}
    
    /**
     * 申請データの取消者ログイン名の表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispCancelHandlerLoginName(boolean value){        this.value[19]=value;}
    
    /**
     * 申請データの取消者表示名の表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispCancelHandlerDisplayName(boolean value){      this.value[20]=value;}
    
    /**
     * 申請データの取消時間の表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispCancelTime(boolean value){                    this.value[21]=value;}
    
    /**
     * 申請データの項目値の表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispItemData(boolean value){                      this.value[22]=value;}
    
    /**
     * 申請データの経路ステータスの表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispStepStatus(boolean value){                    this.value[23]=value;}
    
    /**
     * 申請データの経路処理結果の表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispStepHandleResult(boolean value){              this.value[24]=value;}
    
    /**
     * 申請データの経路処理コメントの表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispStepHandleComment(boolean value){             this.value[25]=value;}
    
    /**
     * 申請データの経路処理者IDの表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispStepHandlerId(boolean value){                 this.value[26]=value;}
    
    /**
     * 申請データの経路処理者ログイン名の表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispStepHandlerLoginName(boolean value){          this.value[27]=value;}
    
    /**
     * 申請データの経路処理者表示名の表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispStepHandlerDisplayName(boolean value){        this.value[28]=value;}
    
    /**
     * 申請データの経路処理時間の表示・非表示を設定します。
     * @param  value trueの場合、表示します。
     */    
    public void setDispStepHandleTime(boolean value){               this.value[29]=value;}

    /**
     * 申請データの申請番号の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispPetitionNumber(){                          return this.value[0];}
    
    /**
     * 申請データの現在ステータスの表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispStatus(){                                  return this.value[1];}
    
    /**
     * 申請データの申請者IDの表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispCreatorId(){                               return this.value[2];}
    
    /**
     * 申請データの申請者ログイン名の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispCreatorLoginName(){                        return this.value[3];}
    
    /**
     * 申請データの申請者表示名の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispCreatorDisplayName(){                      return this.value[4];}
    
    /**
     * 申請データの申請時間の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispCreateTime(){                              return this.value[5];}
    
    /**
     * 申請データの最終承認者IDの表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispAcceptanceHandlerId(){                     return this.value[6];}
    
    /**
     * 申請データの最終承認者ログイン名の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispAcceptanceHandlerLoginName(){              return this.value[7];}
    
    /**
     * 申請データの最終承認者表示名の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispAcceptanceHandlerDisplayName(){            return this.value[8];}
    
    /**
     * 申請データの最終承認時間の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispAcceptanceTime(){                          return this.value[9];}
    
    /**
     * 申請データの却下者IDの表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispRejectHandlerId(){                         return this.value[10];}
    
    /**
     * 申請データの却下者ログイン名の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispRejectHandlerLoginName(){                  return this.value[11];}
    
    /**
     * 申請データの却下者表示名の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispRejectHandlerDisplayName(){                return this.value[12];}
    
    /**
     * 申請データの却下時間の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispRejectTime(){                              return this.value[13];}
    
    /**
     * 申請データの完了者IDの表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispFinishHandlerId(){                         return this.value[14];}
    
    /**
     * 申請データの完了者ログイン名の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispFinishHandlerLoginName(){                  return this.value[15];}
    
    /**
     * 申請データの完了者表示名の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispFinishHandlerDisplayName(){                return this.value[16];}
    
    /**
     * 申請データの完了時間の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispFinishTime(){                              return this.value[17];}
    
    /**
     * 申請データの取消者IDの表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispCancelHandlerId(){                         return this.value[18];}
    
    /**
     * 申請データの取消者ログイン名の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispCancelHandlerLoginName(){                  return this.value[19];}
    
    /**
     * 申請データの取消者表示名の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispCancelHandlerDisplayName(){                return this.value[20];}
    
    /**
     * 申請データの取消時間の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispCancelTime(){                              return this.value[21];}
    
    /**
     * 申請データの項目値の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispItemData(){                                return this.value[22];}
    
    /**
     * 申請データの経路ステータスの表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispStepStatus(){                              return this.value[23];}
    
    /**
     * 申請データの経路処理結果の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispStepHandleResult(){                        return this.value[24];}
    
    /**
     * 申請データの経路処理コメントの表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispStepHandleComment(){                       return this.value[25];}
    
    /**
     * 申請データの経路処理者IDの表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispStepHandlerId(){                           return this.value[26];}
    
    /**
     * 申請データの経路処理者ログイン名の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispStepHandlerLoginName(){                    return this.value[27];}
    
    /**
     * 申請データの経路処理者表示名の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispStepHandlerDisplayName(){                  return this.value[28];}
    
    /**
     * 申請データの経路処理時間の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispStepHandleTime(){                         return this.value[29];}

    
}
