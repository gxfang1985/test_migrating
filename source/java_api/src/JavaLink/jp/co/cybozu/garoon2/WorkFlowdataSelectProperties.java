package jp.co.cybozu.garoon2;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;

import jp.co.cybozu.garoon2.util.AbstractParameters;

/**
 * ワークフローの申請データ取得時における絞込み条件及び並び順を設定するクラスです。<BR>
 *
 * @author サイボウズ
 * @version    1.1.0
 */
public class WorkFlowdataSelectProperties extends AbstractParameters {
    
    // パラメータ値
    private String ParamOfPetitionNumber = "petitionnumber";
    private String ParamOfName           = "name";
    private String ParamOfCreator        = "creatorname";
    private String ParamOfStatus         = "status[]";
    
    private String ParamOfDateType       = "datetype";
    private String ParamOfFromDate       = "datefrom";
    private String ParamOfToDate         = "dateto";
    
    private String ParamOfSort           = "sort";
    
    private HashMap hm ;              // status[] 以外用
    private ArrayList status;         // status[] の配列用

    // ステータス用
    private Integer FIELD_STATUS_PROGRESSING = new Integer(0);
    private Integer FIELD_STATUS_ACCEPTANCE  = new Integer(1);
    private Integer FIELD_STATUS_REJECT      = new Integer(2);
    private Integer FIELD_STATUS_FINISH      = new Integer(3);
    private Integer FIELD_STATUS_CANCEL      = new Integer(4);
    
    // sort,datetype 用
    /**
     * get および set のためのフィールド値で、申請日をあらわします。
     */
    public static final Integer FIELD_TIME_CREATE     =  new Integer(0);
    
    /**
     * get および set のためのフィールド値で、承認日をあらわします。
     */
    public static final Integer FIELD_TIME_ACCEPTANCE =  new Integer(1);
    
    /**
     * get および set のためのフィールド値で、却下日をあらわします。
     */
    public static final Integer FIELD_TIME_REJECT     =  new Integer(2);
    
    /**
     * get および set のためのフィールド値で、完了日をあらわします。
     */
    public static final Integer FIELD_TIME_FINISH     =  new Integer(3);
    
    /**
     * get および set のためのフィールド値で、取消日をあらわします。
     */
    public static final Integer FIELD_TIME_CANCEL     =  new Integer(4);
    
    // コンストラクタ
    public  WorkFlowdataSelectProperties(){
        super();
        this.init();
    }
    

    // デフォルト値セット
    /**
     * 申請データの絞込み条件及び並び順について、初期値をセットします。<BR>
     * 初期条件は、現在ステータスが、進行中・承認・却下・完了・取消のいずれかに該当する申請データになります。
     * 初期並び順は、申請ID順になります。
     */
    public void init(){
        if (status!=null) 
            status.clear();
        else
            status = new ArrayList();
        
        status.add(FIELD_STATUS_PROGRESSING);
        status.add(FIELD_STATUS_ACCEPTANCE);
        status.add(FIELD_STATUS_REJECT);
        status.add(FIELD_STATUS_FINISH);
        status.add(FIELD_STATUS_CANCEL);
        
        if (hm!=null)    
            hm.clear();
        else
            hm = new HashMap();
    }
    
    /**
     * 申請番号にて、申請データを絞り込みます。
     * @param val 絞り込みたい申請番号の文字列.null指定,空文字指定の場合は、絞込みされません。
     */
    public void setWherePetitionNumber(String val){
        hm.put(ParamOfPetitionNumber,"".equals(val)?null:val);    
    }
    
    /**
     * 絞込み条件に設定されている申請番号の文字列を返します。
     * @return 文字列.設定されていない場合は、nullを返します。
     */
    public String getWherePetitionNumber(){        return (String)hm.get(ParamOfPetitionNumber);    }
    
    
    /**
     * 標題にて、申請データを絞り込みます。
     * @param val 絞り込みたい標題の文字列.null指定,空文字指定の場合は、絞込みされません。
     */
    public void setWhereTitle(String val){    
        hm.put(ParamOfName,"".equals(val)?null:val);
    }
    
    /**
     * 絞込み条件に設定されている標題の文字列を返します。
     * @return 文字列.設定されていない場合は、nullを返します。
     */
    public String getWhereTitle(){
        return (String)hm.get(ParamOfName);
    }
    
    /**
     * 申請者にて、申請データを絞り込みます。
     * @param val 絞り込みたい申請者(表示名)の文字列.null指定,空文字指定の場合は、絞込みされません。
     */    
    public void setWhereCreatorName(String val){
        hm.put(ParamOfCreator,"".equals(val)?null:val);
        
    }
    /**
     * 絞込み条件に設定されている申請者(表示名)の文字列を返します。
     * @return 文字列.設定されていない場合は、nullを返します。
     */    
    public String getWhereCreatorName(){
        return (String)hm.get(ParamOfCreator);
    }
    
    
    /**
     * 期間(申請・最終承認・却下・完了・取消)にて、申請データを絞り込みます。<br>
     * fieldについて、フィールド値の検証は含まれません。<br>
     * fromについて、指定された日付以降の申請データを絞り込みます。<br>
     * to  について、指定された日付以前の申請データを絞り込みます。<br>
     * @param field 絞り込みたい期間のタイプフィールド.null指定の場合は、期間ので絞込みは行われません。
     * @param from 絞り込みたい期間FROM.null指定の場合は、from値での絞込みはされません。
     * @param to 絞り込みたい期間TO.null指定の場合は、to値での絞込みはされません。
     */    
    public void setWhereDate(Integer field,Date from,Date to){
        
        hm.put(ParamOfFromDate,from);
        hm.put(ParamOfToDate,to);
        hm.put(ParamOfDateType, field);

    }
    
    /**
     * 絞込み条件に設定されている期間のタイプを返します。
     * @return このクラスのフィールド値を返します。.設定されていない場合は、nullを返します。
     */    
    public Integer getWhereDateType(){
        return (Integer)hm.get(ParamOfDateType);
    }
    
    /**
     * 絞込み条件に設定されている期間FROMを返します。
     * @return 日時.設定されていない場合は、nullを返します。
     */    
    public Date getWhereDateFrom(){
        
        
        return (Date)hm.get(ParamOfFromDate);
    }
    
    /**
     * 絞込み条件に設定されている期間TOを返します。
     * @return 日時.設定されていない場合は、nullを返します。
     */
    public Date getWhereDateTo(){       
        return (Date)hm.get(ParamOfToDate);
    }
    
    /**
     * 申請データの並び順を設定します。<br>
     * 引数[fild] の昇順にて、申請データを並び替えます。
     * fieldについて、フィールド値の検証は含まれません。<br>
     * @param field 並び順.null指定の場合は、並び替えを行いません。
     */    
    public void setSortAsc(Integer field){
        if (field==null)
            hm.put(ParamOfSort,field);
        else {
            hm.put(ParamOfSort,new Integer(field.intValue()*2+0));
        }            
    }
    
    /**
     * 申請データの並び順を設定します。<br>
     * 引数[fild] の降順にて、申請データを並び替えます。
     * fieldについて、フィールド値の検証は含まれません。<br>
     * @param field 並び順.null指定の場合は、並び替えを行いません。
     */    
    public void setSortDesc(Integer field){
        if (field==null)
            hm.put(ParamOfSort,field);
        else 
            hm.put(ParamOfSort,new Integer(field.intValue() *2+1));
    }
    
    /**
     * 並び順に設定されているフィールドを返します。。
     * @return フィールド.設定されていない場合は、nullを返します。
     */    
    public Integer getSortField(){
        if (hm.get(ParamOfSort) == null) return null;
        return new Integer(((Integer)hm.get(ParamOfSort)).intValue() /2);
    }
    
    /**
     * 設定されている並び順が昇順であるかを返します。。
     * @return true の場合は、昇順.falseの場合は、降順. 設定され邸内場合は、nullを返します。
     */
    public Boolean isSortAsc(){
        if (hm.get(ParamOfSort) == null) return null;
        
        int sort = ((Integer)hm.get(ParamOfSort)).intValue() %2;
        if (sort == 0)
            return    Boolean.TRUE;
        else
            return    Boolean.FALSE;
    }

    /**
     * 現在ステータスについて進行中の申請データを絞り込みます。
     * @param bl trueの場合、絞込み条件に加えます。
     */    
    public void setWhereStatusProgressing(boolean bl){
        if (bl && !status.contains(FIELD_STATUS_PROGRESSING))
            status.add(FIELD_STATUS_PROGRESSING);
        else if(!bl && status.contains(FIELD_STATUS_PROGRESSING))
            status.remove(FIELD_STATUS_PROGRESSING);
        
    }
    /**
     * 絞込み条件「現在ステータス(進行中)」を取得します。
     * @return trueの場合、絞込み条件に設定されています。
     */    
    public boolean getWhereStatusProgressing(){
        return status.contains(FIELD_STATUS_PROGRESSING);
    }

    

    /**
     * 現在ステータスについて承認の申請データを絞り込みます。
     * @param bl trueの場合、絞込み条件に加えます。
     */    
    public void setWhereStatusAcceptance(boolean bl){
        if (bl && !status.contains(FIELD_STATUS_ACCEPTANCE))
            status.add(FIELD_STATUS_ACCEPTANCE);
        else if(!bl && status.contains(FIELD_STATUS_ACCEPTANCE))
            status.remove(FIELD_STATUS_ACCEPTANCE);
    }
    /**
     * 絞込み条件「現在ステータス(承認)」を取得します。
     * @return trueの場合、絞込み条件に設定されています。
     */    
    public boolean getWhereStatusAcceptance(){
        return status.contains(FIELD_STATUS_ACCEPTANCE);
    }


    /**
     * 現在ステータスについて却下の申請データを絞り込みます。
     * @param bl trueの場合、絞込み条件に加えます。
     */    
    public void setWhereStatusReject(boolean bl){
        if (bl && !status.contains(FIELD_STATUS_REJECT))
            status.add(FIELD_STATUS_REJECT);
        else if(!bl && status.contains(FIELD_STATUS_REJECT))
            status.remove(FIELD_STATUS_REJECT);
    }
    /**
     * 絞込み条件「現在ステータス(却下)」を取得します。
     * @return trueの場合、絞込み条件に設定されています。
     */    
    public boolean getWhereStatusReject(){
        return status.contains(FIELD_STATUS_REJECT);
    }

    /**
     * 現在ステータスについて完了の申請データを絞り込みます。
     * @param bl trueの場合、絞込み条件に加えます。
     */    
    public void setWhereStatusFinish(boolean bl){
        if (bl && !status.contains(FIELD_STATUS_FINISH))
            status.add(FIELD_STATUS_FINISH);
        else if(!bl && status.contains(FIELD_STATUS_FINISH))
            status.remove(FIELD_STATUS_FINISH);
    }
    /**
     * 絞込み条件「現在ステータス(完了)」を取得します。
     * @return trueの場合、絞込み条件に設定されています。
     */    
    public boolean getWhereStatusFinish(){
        return status.contains(FIELD_STATUS_FINISH);
    }

    /**
     * 現在ステータスについて取消の申請データを絞り込みます。
     * @param bl trueの場合、絞込み条件に加えます。
     */    
    public void setWhereStatusCancel(boolean bl){
        if (bl && !status.contains(FIELD_STATUS_CANCEL))
            status.add(FIELD_STATUS_CANCEL);
        else if(!bl && status.contains(FIELD_STATUS_CANCEL))
            status.remove(FIELD_STATUS_CANCEL);
    }
    /**
     * 絞込み条件「現在ステータス(取消)」を取得します。
     * @return trueの場合、絞込み条件に設定されています。
     */    
    public boolean getWhereStatusCancel(){
        return status.contains(FIELD_STATUS_CANCEL);
    }
    
    protected void setParameters(){
        if(! status.isEmpty()){
            super.Add(ParamOfStatus,status);
        }
        
        Iterator  it = hm.keySet().iterator();
        while (it.hasNext()) {
            Object key = it.next();
            Object val = hm.get(key);
               
            if (key ==null)  continue;         
            if (val ==null)  continue; 
      
            if( "java.util.Date".equals(val.getClass().getName())) {
                long varTime ;
                Calendar cal = Calendar.getInstance(); 
                
                if(key == ParamOfFromDate){

                    
                    cal.setTime((Date)val);
                    cal.set(Calendar.HOUR_OF_DAY,0);
                    cal.set(Calendar.MINUTE,0);
                    cal.set(Calendar.SECOND,0);
                    varTime =cal.getTimeInMillis()/1000;
                    
                    super.Add(key.toString(),Long.toString(varTime));
                } else if(key == ParamOfToDate){

                    
                    cal.setTime((Date)val);
                    cal.set(Calendar.HOUR_OF_DAY,23);
                    cal.set(Calendar.MINUTE,59);
                    cal.set(Calendar.SECOND,59);
                    varTime =cal.getTimeInMillis()/1000;
                    
                    super.Add(key.toString(),Long.toString(varTime));
                } else {
                    Date dat = (Date)val;
                    super.Add(key.toString(),Long.toString(dat.getTime()));
                }

            }else{
                super.Add(key.toString(),val.toString());
            }
        }
    }
}
