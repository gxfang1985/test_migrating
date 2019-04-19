package jp.co.cybozu.garoon2.util;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;


public abstract class AbstractParameters {
    private HashMap hm;
    
    protected AbstractParameters(){
        hm = new HashMap();
    }
    protected AbstractParameters(HashMap hm){
        this.hm = new HashMap(hm);
    }
    
    protected void Add(String key,String value){
        hm.put(key,value);
    }
    protected void Add(String key,File value){
        hm.put(key,value);
    }
    protected void Add(String key,ArrayList value){
        hm.put(key,value);
    }

    public HashMap getParameters(){
        // 不具合管理275 WorkFlowdataSelectProperties 不備(正しく抽出条件を指定できない)
        // 初期化
        hm.clear();
        
        setParameters();
        return hm;
    }
    
    abstract protected void setParameters();    //パラメータのセット方法は、サブクラスに任せる
}
