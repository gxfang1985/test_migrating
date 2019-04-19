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
        // �s��Ǘ�275 WorkFlowdataSelectProperties �s��(���������o�������w��ł��Ȃ�)
        // ������
        hm.clear();
        
        setParameters();
        return hm;
    }
    
    abstract protected void setParameters();    //�p�����[�^�̃Z�b�g���@�́A�T�u�N���X�ɔC����
}
