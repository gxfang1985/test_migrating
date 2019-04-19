package jp.co.cybozu.garoon2;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;

import jp.co.cybozu.garoon2.util.AbstractParameters;

/**
 * ���[�N�t���[�̐\���f�[�^�擾���ɂ�����i���ݏ����y�ѕ��я���ݒ肷��N���X�ł��B<BR>
 *
 * @author �T�C�{�E�Y
 * @version    1.1.0
 */
public class WorkFlowdataSelectProperties extends AbstractParameters {
    
    // �p�����[�^�l
    private String ParamOfPetitionNumber = "petitionnumber";
    private String ParamOfName           = "name";
    private String ParamOfCreator        = "creatorname";
    private String ParamOfStatus         = "status[]";
    
    private String ParamOfDateType       = "datetype";
    private String ParamOfFromDate       = "datefrom";
    private String ParamOfToDate         = "dateto";
    
    private String ParamOfSort           = "sort";
    
    private HashMap hm ;              // status[] �ȊO�p
    private ArrayList status;         // status[] �̔z��p

    // �X�e�[�^�X�p
    private Integer FIELD_STATUS_PROGRESSING = new Integer(0);
    private Integer FIELD_STATUS_ACCEPTANCE  = new Integer(1);
    private Integer FIELD_STATUS_REJECT      = new Integer(2);
    private Integer FIELD_STATUS_FINISH      = new Integer(3);
    private Integer FIELD_STATUS_CANCEL      = new Integer(4);
    
    // sort,datetype �p
    /**
     * get ����� set �̂��߂̃t�B�[���h�l�ŁA�\����������킵�܂��B
     */
    public static final Integer FIELD_TIME_CREATE     =  new Integer(0);
    
    /**
     * get ����� set �̂��߂̃t�B�[���h�l�ŁA���F��������킵�܂��B
     */
    public static final Integer FIELD_TIME_ACCEPTANCE =  new Integer(1);
    
    /**
     * get ����� set �̂��߂̃t�B�[���h�l�ŁA�p����������킵�܂��B
     */
    public static final Integer FIELD_TIME_REJECT     =  new Integer(2);
    
    /**
     * get ����� set �̂��߂̃t�B�[���h�l�ŁA������������킵�܂��B
     */
    public static final Integer FIELD_TIME_FINISH     =  new Integer(3);
    
    /**
     * get ����� set �̂��߂̃t�B�[���h�l�ŁA�����������킵�܂��B
     */
    public static final Integer FIELD_TIME_CANCEL     =  new Integer(4);
    
    // �R���X�g���N�^
    public  WorkFlowdataSelectProperties(){
        super();
        this.init();
    }
    

    // �f�t�H���g�l�Z�b�g
    /**
     * �\���f�[�^�̍i���ݏ����y�ѕ��я��ɂ��āA�����l���Z�b�g���܂��B<BR>
     * ���������́A���݃X�e�[�^�X���A�i�s���E���F�E�p���E�����E����̂����ꂩ�ɊY������\���f�[�^�ɂȂ�܂��B
     * �������я��́A�\��ID���ɂȂ�܂��B
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
     * �\���ԍ��ɂāA�\���f�[�^���i�荞�݂܂��B
     * @param val �i�荞�݂����\���ԍ��̕�����.null�w��,�󕶎��w��̏ꍇ�́A�i���݂���܂���B
     */
    public void setWherePetitionNumber(String val){
        hm.put(ParamOfPetitionNumber,"".equals(val)?null:val);    
    }
    
    /**
     * �i���ݏ����ɐݒ肳��Ă���\���ԍ��̕������Ԃ��܂��B
     * @return ������.�ݒ肳��Ă��Ȃ��ꍇ�́Anull��Ԃ��܂��B
     */
    public String getWherePetitionNumber(){        return (String)hm.get(ParamOfPetitionNumber);    }
    
    
    /**
     * �W��ɂāA�\���f�[�^���i�荞�݂܂��B
     * @param val �i�荞�݂����W��̕�����.null�w��,�󕶎��w��̏ꍇ�́A�i���݂���܂���B
     */
    public void setWhereTitle(String val){    
        hm.put(ParamOfName,"".equals(val)?null:val);
    }
    
    /**
     * �i���ݏ����ɐݒ肳��Ă���W��̕������Ԃ��܂��B
     * @return ������.�ݒ肳��Ă��Ȃ��ꍇ�́Anull��Ԃ��܂��B
     */
    public String getWhereTitle(){
        return (String)hm.get(ParamOfName);
    }
    
    /**
     * �\���҂ɂāA�\���f�[�^���i�荞�݂܂��B
     * @param val �i�荞�݂����\����(�\����)�̕�����.null�w��,�󕶎��w��̏ꍇ�́A�i���݂���܂���B
     */    
    public void setWhereCreatorName(String val){
        hm.put(ParamOfCreator,"".equals(val)?null:val);
        
    }
    /**
     * �i���ݏ����ɐݒ肳��Ă���\����(�\����)�̕������Ԃ��܂��B
     * @return ������.�ݒ肳��Ă��Ȃ��ꍇ�́Anull��Ԃ��܂��B
     */    
    public String getWhereCreatorName(){
        return (String)hm.get(ParamOfCreator);
    }
    
    
    /**
     * ����(�\���E�ŏI���F�E�p���E�����E���)�ɂāA�\���f�[�^���i�荞�݂܂��B<br>
     * field�ɂ��āA�t�B�[���h�l�̌��؂͊܂܂�܂���B<br>
     * from�ɂ��āA�w�肳�ꂽ���t�ȍ~�̐\���f�[�^���i�荞�݂܂��B<br>
     * to  �ɂ��āA�w�肳�ꂽ���t�ȑO�̐\���f�[�^���i�荞�݂܂��B<br>
     * @param field �i�荞�݂������Ԃ̃^�C�v�t�B�[���h.null�w��̏ꍇ�́A���Ԃ̂ōi���݂͍s���܂���B
     * @param from �i�荞�݂�������FROM.null�w��̏ꍇ�́Afrom�l�ł̍i���݂͂���܂���B
     * @param to �i�荞�݂�������TO.null�w��̏ꍇ�́Ato�l�ł̍i���݂͂���܂���B
     */    
    public void setWhereDate(Integer field,Date from,Date to){
        
        hm.put(ParamOfFromDate,from);
        hm.put(ParamOfToDate,to);
        hm.put(ParamOfDateType, field);

    }
    
    /**
     * �i���ݏ����ɐݒ肳��Ă�����Ԃ̃^�C�v��Ԃ��܂��B
     * @return ���̃N���X�̃t�B�[���h�l��Ԃ��܂��B.�ݒ肳��Ă��Ȃ��ꍇ�́Anull��Ԃ��܂��B
     */    
    public Integer getWhereDateType(){
        return (Integer)hm.get(ParamOfDateType);
    }
    
    /**
     * �i���ݏ����ɐݒ肳��Ă������FROM��Ԃ��܂��B
     * @return ����.�ݒ肳��Ă��Ȃ��ꍇ�́Anull��Ԃ��܂��B
     */    
    public Date getWhereDateFrom(){
        
        
        return (Date)hm.get(ParamOfFromDate);
    }
    
    /**
     * �i���ݏ����ɐݒ肳��Ă������TO��Ԃ��܂��B
     * @return ����.�ݒ肳��Ă��Ȃ��ꍇ�́Anull��Ԃ��܂��B
     */
    public Date getWhereDateTo(){       
        return (Date)hm.get(ParamOfToDate);
    }
    
    /**
     * �\���f�[�^�̕��я���ݒ肵�܂��B<br>
     * ����[fild] �̏����ɂāA�\���f�[�^����ёւ��܂��B
     * field�ɂ��āA�t�B�[���h�l�̌��؂͊܂܂�܂���B<br>
     * @param field ���я�.null�w��̏ꍇ�́A���ёւ����s���܂���B
     */    
    public void setSortAsc(Integer field){
        if (field==null)
            hm.put(ParamOfSort,field);
        else {
            hm.put(ParamOfSort,new Integer(field.intValue()*2+0));
        }            
    }
    
    /**
     * �\���f�[�^�̕��я���ݒ肵�܂��B<br>
     * ����[fild] �̍~���ɂāA�\���f�[�^����ёւ��܂��B
     * field�ɂ��āA�t�B�[���h�l�̌��؂͊܂܂�܂���B<br>
     * @param field ���я�.null�w��̏ꍇ�́A���ёւ����s���܂���B
     */    
    public void setSortDesc(Integer field){
        if (field==null)
            hm.put(ParamOfSort,field);
        else 
            hm.put(ParamOfSort,new Integer(field.intValue() *2+1));
    }
    
    /**
     * ���я��ɐݒ肳��Ă���t�B�[���h��Ԃ��܂��B�B
     * @return �t�B�[���h.�ݒ肳��Ă��Ȃ��ꍇ�́Anull��Ԃ��܂��B
     */    
    public Integer getSortField(){
        if (hm.get(ParamOfSort) == null) return null;
        return new Integer(((Integer)hm.get(ParamOfSort)).intValue() /2);
    }
    
    /**
     * �ݒ肳��Ă�����я��������ł��邩��Ԃ��܂��B�B
     * @return true �̏ꍇ�́A����.false�̏ꍇ�́A�~��. �ݒ肳��@���ꍇ�́Anull��Ԃ��܂��B
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
     * ���݃X�e�[�^�X�ɂ��Đi�s���̐\���f�[�^���i�荞�݂܂��B
     * @param bl true�̏ꍇ�A�i���ݏ����ɉ����܂��B
     */    
    public void setWhereStatusProgressing(boolean bl){
        if (bl && !status.contains(FIELD_STATUS_PROGRESSING))
            status.add(FIELD_STATUS_PROGRESSING);
        else if(!bl && status.contains(FIELD_STATUS_PROGRESSING))
            status.remove(FIELD_STATUS_PROGRESSING);
        
    }
    /**
     * �i���ݏ����u���݃X�e�[�^�X(�i�s��)�v���擾���܂��B
     * @return true�̏ꍇ�A�i���ݏ����ɐݒ肳��Ă��܂��B
     */    
    public boolean getWhereStatusProgressing(){
        return status.contains(FIELD_STATUS_PROGRESSING);
    }

    

    /**
     * ���݃X�e�[�^�X�ɂ��ď��F�̐\���f�[�^���i�荞�݂܂��B
     * @param bl true�̏ꍇ�A�i���ݏ����ɉ����܂��B
     */    
    public void setWhereStatusAcceptance(boolean bl){
        if (bl && !status.contains(FIELD_STATUS_ACCEPTANCE))
            status.add(FIELD_STATUS_ACCEPTANCE);
        else if(!bl && status.contains(FIELD_STATUS_ACCEPTANCE))
            status.remove(FIELD_STATUS_ACCEPTANCE);
    }
    /**
     * �i���ݏ����u���݃X�e�[�^�X(���F)�v���擾���܂��B
     * @return true�̏ꍇ�A�i���ݏ����ɐݒ肳��Ă��܂��B
     */    
    public boolean getWhereStatusAcceptance(){
        return status.contains(FIELD_STATUS_ACCEPTANCE);
    }


    /**
     * ���݃X�e�[�^�X�ɂ��ċp���̐\���f�[�^���i�荞�݂܂��B
     * @param bl true�̏ꍇ�A�i���ݏ����ɉ����܂��B
     */    
    public void setWhereStatusReject(boolean bl){
        if (bl && !status.contains(FIELD_STATUS_REJECT))
            status.add(FIELD_STATUS_REJECT);
        else if(!bl && status.contains(FIELD_STATUS_REJECT))
            status.remove(FIELD_STATUS_REJECT);
    }
    /**
     * �i���ݏ����u���݃X�e�[�^�X(�p��)�v���擾���܂��B
     * @return true�̏ꍇ�A�i���ݏ����ɐݒ肳��Ă��܂��B
     */    
    public boolean getWhereStatusReject(){
        return status.contains(FIELD_STATUS_REJECT);
    }

    /**
     * ���݃X�e�[�^�X�ɂ��Ċ����̐\���f�[�^���i�荞�݂܂��B
     * @param bl true�̏ꍇ�A�i���ݏ����ɉ����܂��B
     */    
    public void setWhereStatusFinish(boolean bl){
        if (bl && !status.contains(FIELD_STATUS_FINISH))
            status.add(FIELD_STATUS_FINISH);
        else if(!bl && status.contains(FIELD_STATUS_FINISH))
            status.remove(FIELD_STATUS_FINISH);
    }
    /**
     * �i���ݏ����u���݃X�e�[�^�X(����)�v���擾���܂��B
     * @return true�̏ꍇ�A�i���ݏ����ɐݒ肳��Ă��܂��B
     */    
    public boolean getWhereStatusFinish(){
        return status.contains(FIELD_STATUS_FINISH);
    }

    /**
     * ���݃X�e�[�^�X�ɂ��Ď���̐\���f�[�^���i�荞�݂܂��B
     * @param bl true�̏ꍇ�A�i���ݏ����ɉ����܂��B
     */    
    public void setWhereStatusCancel(boolean bl){
        if (bl && !status.contains(FIELD_STATUS_CANCEL))
            status.add(FIELD_STATUS_CANCEL);
        else if(!bl && status.contains(FIELD_STATUS_CANCEL))
            status.remove(FIELD_STATUS_CANCEL);
    }
    /**
     * �i���ݏ����u���݃X�e�[�^�X(���)�v���擾���܂��B
     * @return true�̏ꍇ�A�i���ݏ����ɐݒ肳��Ă��܂��B
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
