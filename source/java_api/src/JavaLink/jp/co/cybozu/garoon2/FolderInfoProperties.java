package jp.co.cybozu.garoon2;

import java.util.ArrayList;

import jp.co.cybozu.garoon2.util.AbstractParameters;

/**
 * ファイル管理のフォルダ情報取得時に出力するXMLの項目群を設定するクラスです。<BR>
 *
 * @author サイボウズ
 * @version    1.1.0
 * 
 */
public class FolderInfoProperties extends AbstractParameters {
	
    private String key = "items[]";
    private boolean[] value;
	
    public  FolderInfoProperties(){
        super();
        this.value = new boolean[10];
        this.init();
    }
    
    /**
     * フォルダの出力項目群について、初期値をセットします。<BR>
     * 初期値は、フォルダ名・フォルダメモは表示、それ以外は、非表示です。
     * 
     */
    // デフォルト値セット
	public void init() {
        allDispSet(false);
        setDispTitle(true);
        setDispDescription(true);
	}
	
    /**
     * フォルダの出力項目群の表示・非表示の設定値を一括設定します。
     * @param value trueの場合、表示します。
     */
	public void allDispSet(boolean value) {
        int len = this.value.length;
        for (int i = 0; i < len; i++) {
            this.value[i] = value;
        }
	}
	
	public void setParameters() {
        int len = this.value.length;
        ArrayList items = new ArrayList();
        
        for (int i = 0; i < len; i++) {
            if(this.value[i]==true) items.add(Integer.toString(i));
        }
        
        super.Add(this.key,items);
	}
	
    /**
     * フォルダ名の表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */    
	public void setDispTitle(boolean value) {                this.value[0]=value;}  // フォルダ名
	
    /**
     * フォルダメモの表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */    
	public void setDispDescription(boolean value) {          this.value[1]=value;}  // フォルダメモ
	
    /**
     * 登録ユーザーIDの表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */    
	public void setDispCreatorId(boolean value) {            this.value[2]=value;}  // 登録ユーザーID
	
    /**
     * 登録ユーザーログイン名の表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */    
	public void setDispCreatorLoginName(boolean value) {     this.value[3]=value;}  // 登録ユーザーログイン名
	
    /**
     * 登録ユーザー表示IDの表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */    
	public void setDispCreatorDisplayName(boolean value) {   this.value[4]=value;}  // 登録ユーザー表示ID
	
    /**
     * 登録日時の表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */    
	public void setDispCreateTime(boolean value) {            this.value[5]=value;}  // 登録日時
	
    /**
     * 更新ユーザーIDの表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */    
	public void setDispModifierId(boolean value) {           this.value[6]=value;}  // 更新ユーザーID
	
    /**
     * 更新ユーザーログイン名の表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */    
	public void setDispModifierLoginName(boolean value) {    this.value[7]=value;}  // 更新ユーザーログイン名
	
    /**
     * 更新ユーザー表示名の表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */    
	public void setDispModifierDisplayName(boolean value) {  this.value[8]=value;}  // 更新ユーザー表示名
	
    /**
     * 更新時間の表示・非表示を設定します。
     * @param value trueの場合、表示します。
     */    
	public void setDispModifyTime(boolean value) {           this.value[9]=value;}  // 更新時間
	
	
    /**
     * フォルダ名の表示・非表示を取得します。
     * @return trueの場合、表示します。
     */    
	public boolean getDispTitle() {                return this.value[0];}  // フォルダ名
	
    /**
     * フォルダメモの表示・非表示を取得します。
     * @return trueの場合、表示します。
     */   
	public boolean getDispDescription() {          return this.value[1];}  // フォルダメモ
	
    /**
     * 登録ユーザーIDの表示・非表示を取得します。
     * @return trueの場合、表示します。
     */    
	public boolean getDispCreatorId() {            return this.value[2];}  // 登録ユーザーID
	
    /**
     * 登録ユーザーログイン名の表示・非表示を取得します。
     * @return trueの場合、表示します。
     */    
	public boolean getDispCreatorLoginName() {     return this.value[3];}  // 登録ユーザーログイン名
	
    /**
     * 登録ユーザー表示IDの表示・非表示を取得します。
     * @return trueの場合、表示します。
     */    
	public boolean getDispCreatorDisplayName() {   return this.value[4];}  // 登録ユーザー表示ID
	
    /**
     * 登録日時の表示・非表示を取得します。
     * @return trueの場合、表示します。
     */
	public boolean getDispCreateTime() {            return this.value[5];}  // 登録日時
	
    /**
     * 更新ユーザーIDの表示・非表示を取得します。
     * @return trueの場合、表示します。
     */    
	public boolean getDispModifierId() {           return this.value[6];}  // 更新ユーザーID
	
    /**
     * 更新ユーザーログイン名の表示・非表示を取得します。
     * @return trueの場合、表示します。
     */    
	public boolean getDispModifierLoginName() {    return this.value[7];}  // 更新ユーザーログイン名
	
    /**
     * 更新ユーザー表示名の表示・非表示を取得します。
     * @return trueの場合、表示します。
     */    
	public boolean getDispModifierDisplayName() {  return this.value[8];}  // 更新ユーザー表示名
	
    /**
     * 更新時間の表示・非表示を取得します。
     * @return trueの場合、表示します。
     */   
	public boolean getDispModifyTime() {           return this.value[9];}  // 更新時間
}