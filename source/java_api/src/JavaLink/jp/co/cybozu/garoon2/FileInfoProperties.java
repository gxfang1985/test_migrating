package jp.co.cybozu.garoon2;

import java.util.ArrayList;
//import java.util.HashMap;

import jp.co.cybozu.garoon2.util.AbstractParameters;


/**
 * ファイル管理のファイル情報取得時に出力するXMLの項目群を設定するクラスです。<BR>
 *
 * @author サイボウズ
 * @version    1.1.0
 */
public class FileInfoProperties extends AbstractParameters {
    
    private String key = "items[]";
    private boolean[] value;

    public  FileInfoProperties(){
        super();
        this.value = new boolean[23];
        this.init();
        
    }
    
    /**
     * ファイルの出力項目群について、初期値をセットします。<BR>
     * 初期値は、履歴関連以外は表示、履歴関連は、非表示です。
     * 
     */
    // デフォルト値セット
    public void init(){    
        allDispSet(true);
        historyDispSet(false);
    }
    
    /**
     * ファイルの出力項目群の表示・非表示の設定値を一括設定します。
     * @param value trueの場合、表示します。
     */
    // 一括セット
    public void allDispSet(boolean value){
        int len = this.value.length;
        for (int i = 0; i < len; i++) {
            this.value[i] = value;
        }
    }
    
     /**
     * ファイルの出力項目群のうち、履歴関連の項目についての表示・非表示の設定値を一括設定します。
     * @param value trueの場合、表示します。
     */
    // 履歴関連一括セット
    public void historyDispSet(boolean value){
        int[] historyIndex = {14,15,16,17,18,19,20,21,22};
        int len = historyIndex.length;
        for (int i = 0; i < len; i++) {
            this.value[historyIndex[i]] = value;
        }
        
    }
    
    //protected HashMap getParameters(){    return super.getParameters();    }
    
    protected void setParameters(){
        int len = this.value.length;
        ArrayList items = new ArrayList();
        
        for (int i = 0; i < len; i++) {
            if(this.value[i]==true) items.add(Integer.toString(i));
        }
        
        super.Add(this.key,items);
    }
    
    
    /**
     * ファイルのタイトルの表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */    
    public void setDispTitle(boolean value){              this.value[0]=value;}  // タイトル
    
    
    /**
     * ファイルの説明の表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */
    public void setDispDescription(boolean value){        this.value[1]=value;}  // 説明
    
    /**
     * ファイルのバージョン上限値の表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */
    public void setDispMaxVersion(boolean value){         this.value[2]=value;}  // バージョン上限値
    
    /**
     * ファイルのファイル名の表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */
    public void setDispName(boolean value){               this.value[3]=value;}  // ファイル名
    
    /**
     * ファイルのファイルサイズの表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */
    public void setDispSize(boolean value){               this.value[4]=value;}  // ファイルサイズ
    
    /**
     * ファイルのマイムタイプの表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */
    public void setDispMimeType(boolean value){           this.value[5]=value;}  // マイムタイプ
    
    /**
     * ファイルの登録ユーザーIDの表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */
    public void setDispCreatorId(boolean value){          this.value[6]=value;}  // 登録ユーザーID
    
    /**
     * ファイルの登録ユーザーログイン名の表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */
    public void setDispCreatorLoginName(boolean value){   this.value[7]=value;}  // 登録ユーザーログイン名
    
    /**
     * ファイルの登録ユーザー表示名の表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */
    public void setDispCreatorDisplayName(boolean value){ this.value[8]=value;}  // 登録ユーザー表示名
    
    /**
     * ファイルの登録時間の表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */
    public void setDispCreateTime(boolean value){          this.value[9]=value;}  // 登録時間
    
    /**
     * ファイルの 更新ユーザーIDの表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */
    public void setDispModifierId(boolean value){         this.value[10]=value;}  // 更新ユーザーID
    
    /**
     * ファイルの更新ユーザーログイン名の表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */
    public void setDispModifierLoginName(boolean value){  this.value[11]=value;}  // 更新ユーザーログイン名
    
    /**
     * ファイルの更新ユーザー表示名の表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */
    public void setDispModifierDisplayName(boolean value){this.value[12]=value;}  // 更新ユーザー表示名
    
    /**
     * ファイルの更新時間の表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */
    public void setDispModifyTime(boolean value){         this.value[13]=value;}  // 更新時間
    
    /**
     * ファイルの履歴バージョンNoの表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */
    public void setDispHistoryVersion(boolean value){     this.value[14]=value;}  // 履歴バージョンNo

    /**
     * ファイルの履歴バージョン管理有・無効の表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */
    public void setDispHistoryActive(boolean value){      this.value[15]=value;}  // 履歴バージョン管理有・無効
        
    /**
     * ファイルの履歴ファイル名の表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */
    public void setDispHistoryName(boolean value){        this.value[16]=value;}  // 履歴ファイル名
    
    /**
     * ファイルの履歴操作の表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */
    public void setDispHistoryAction(boolean value){      this.value[17]=value;}  // 履歴操作
    
    /**
     * ファイルの履歴更新コメントの表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */
    public void setDispHistoryComment(boolean value){     this.value[18]=value;}  // 履歴更新コメント
    
    /**
     * ファイルの履歴更新ユーザーIDの表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */
    public void setDispHistoryModifierId(boolean value){  this.value[19]=value;}  // 履歴更新ユーザーID
    
    /**
     * ファイルの履歴更新ユーザーログイン名の表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */
    public void setDispHistoryModifierLoginName(boolean value){  this.value[20]=value;}  // 履歴更新ユーザーログイン名
    
    /**
     * ファイルの履歴更新ユーザー表示名の表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */
    public void setDispHistoryModifierDisplayName(boolean value){this.value[21]=value;}  // 履歴更新ユーザー表示名
    
    /**
     * ファイルの履歴更新時間の表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */
    public void setDispHistoryModifyTime(boolean value){         this.value[22]=value;}  // 履歴更新時間

    
    
    /**
     * ファイルのタイトルの表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispTitle(){              return this.value[0];}  // タイトル
    
    /**
     * ファイルの説明の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispDescription(){        return this.value[1];}  // 説明
    
    /**
     * ファイルのバージョン上限値の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispMaxVersion(){         return this.value[2];}  // バージョン上限値
    
    /**
     * ファイルのファイル名の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispName(){               return this.value[3];}  // ファイル名
    
    /**
     * ファイルのファイルサイズの表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispSize(){               return this.value[4];}  // ファイルサイズ
    
    /**
     * ファイルのマイムタイプの表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispMimeType(){           return this.value[5];}  // マイムタイプ
    
    /**
     * ファイルの登録ユーザーIDの表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispCreatorId(){          return this.value[6];}  // 登録ユーザーID
    
    /**
     * ファイルの登録ユーザーログイン名の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispCreatorLoginName(){   return this.value[7];}  // 登録ユーザーログイン名
    
    /**
     * ファイルの登録ユーザー表示名の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispCreatorDisplayName(){ return this.value[8];}  // 登録ユーザー表示名
    
    /**
     * ファイルの登録時間の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispCreateTime(){          return this.value[9];}  // 登録時間
    
    /**
     * ファイルの更新ユーザーIDの表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispModifierId(){         return this.value[10];}  // 更新ユーザーID
    
    /**
     * ファイルの更新ユーザーログイン名の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispModifierLoginName(){  return this.value[11];}  // 更新ユーザーログイン名
    
    /**
     * ファイルの更新ユーザー表示名の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispModifierDisplayName(){return this.value[12];}  // 更新ユーザー表示名
    
    /**
     * ファイルの更新時間の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispModifyTime(){         return this.value[13];}  // 更新時間
    
    /**
     * ファイルの履歴バージョンNoの表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispHistoryVersion(){     return this.value[14];}  // 履歴バージョンNo

    /**
     * ファイルの履歴バージョン管理有・無効の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispHistoryActive(){      return this.value[15];}  // 履歴バージョン管理有・無効
        
    /**
     * ファイルの履歴ファイル名の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispHistoryName(){        return this.value[16];}  // 履歴ファイル名
    
    /**
     * ファイルの履歴操作の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispHistoryAction(){      return this.value[17];}  // 履歴操作
    
    /**
     * ファイルの履歴更新コメントの表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispHistoryComment(){     return this.value[18];}  // 履歴更新コメント
    
    /**
     * ファイルの履歴更新ユーザーIDの表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispHistoryModifierId(){  return this.value[19];}  // 履歴更新ユーザーID
    
    /**
     * ファイルの履歴更新ユーザーログイン名の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispHistoryModifierLoginName(){  return this.value[20];}  // 履歴更新ユーザーログイン名
    
    /**
     * ファイルの履歴更新ユーザー表示名の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispHistoryModifierDisplayName(){return this.value[21];}  // 履歴更新ユーザー表示名
    
    /**
     * ファイルの履歴更新時間の表示・非表示の設定値を取得します。
     * @return trueの場合、表示します。
     */
    public boolean getDispHistoryModifyTime(){         return this.value[22];}  // 履歴更新時間
    
    
    
    
    

}
