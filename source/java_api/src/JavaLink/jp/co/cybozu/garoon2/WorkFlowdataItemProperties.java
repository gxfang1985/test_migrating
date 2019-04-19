package jp.co.cybozu.garoon2;

import java.util.ArrayList;

import jp.co.cybozu.garoon2.util.AbstractParameters;

/**
 * ���[�N�t���[�̐\���f�[�^�擾�p�ɏo�͂���XML�̍��ڌQ��ݒ肷��N���X�ł��B<BR>
 *
 * @author �T�C�{�E�Y
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

    // �f�t�H���g�l�Z�b�g
    /**
     * �\���f�[�^�̏o�͍��ڌQ�ɂ��āA�����l���Z�b�g���܂��B<BR>
     * �����l�́A�o�H���֘A�ȊO�͕\���A�o�H���́A��\���ł��B
     */
    public void init(){    
        allDispSet(true);
        stepDispSet(false);
    }
    
    /**
     * �\���f�[�^�̏o�͍��ڌQ�̕\���E��\���̐ݒ�l���ꊇ�ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    public void allDispSet(boolean value){
        int len = this.value.length;
        for (int i = 0; i < len; i++) {
            this.value[i] = value;
        }
    }
    
     /**
     * �\���f�[�^�̏o�͍��ڌQ�̂����A�o�H���֘A�̍��ڂɂ��Ă̕\���E��\���̐ݒ�l���ꊇ�ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */
    // �X�e�b�v�֘A�ꊇ�Z�b�g
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
     * �\���f�[�^�̐\���ԍ��̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispPetitionNumber(boolean value){                this.value[0]=value;}
    
    /**
     * �\���f�[�^�̌��݃X�e�[�^�X�̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispStatus(boolean value){                        this.value[1]=value;}
    
    /**
     * �\���f�[�^�̐\����ID�̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispCreatorId(boolean value){                     this.value[2]=value;}
    
    /**
     * �\���f�[�^�̐\���҃��O�C�����̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispCreatorLoginName(boolean value){              this.value[3]=value;}
    
    /**
     * �\���f�[�^�̐\���ҕ\�����̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispCreatorDisplayName(boolean value){            this.value[4]=value;}
    
    /**
     * �\���f�[�^�̐\�����Ԃ̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispCreateTime(boolean value){                    this.value[5]=value;}
    
    /**
     * �\���f�[�^�̍ŏI���F��ID�̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispAcceptanceHandlerId(boolean value){           this.value[6]=value;}
    
    /**
     * �\���f�[�^�̍ŏI���F�҃��O�C�����̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispAcceptanceHandlerLoginName(boolean value){    this.value[7]=value;}
    
    /**
     * �\���f�[�^�̍ŏI���F�ҕ\�����̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispAcceptanceHandlerDisplayName(boolean value){  this.value[8]=value;}
    
    /**
     * �\���f�[�^�̍ŏI���F���Ԃ̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispAcceptanceTime(boolean value){                this.value[9]=value;}
    
    /**
     * �\���f�[�^�̋p����ID�̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispRejectHandlerId(boolean value){               this.value[10]=value;}
    
    /**
     * �\���f�[�^�̋p���҃��O�C�����̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispRejectHandlerLoginName(boolean value){        this.value[11]=value;}
    
    /**
     * �\���f�[�^�̋p���ҕ\�����̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispRejectHandlerDisplayName(boolean value){      this.value[12]=value;}
    
    /**
     * �\���f�[�^�̋p�����Ԃ̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispRejectTime(boolean value){                    this.value[13]=value;}
    
    /**
     * �\���f�[�^�̊�����ID�̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispFinishHandlerId(boolean value){               this.value[14]=value;}
    
    /**
     * �\���f�[�^�̊����҃��O�C�����̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispFinishHandlerLoginName(boolean value){        this.value[15]=value;}
    
    /**
     * �\���f�[�^�̊����ҕ\�����̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispFinishHandlerDisplayName(boolean value){      this.value[16]=value;}
    
    /**
     * �\���f�[�^�̊������Ԃ̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispFinishTime(boolean value){                    this.value[17]=value;}
    
    /**
     * �\���f�[�^�̎����ID�̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispCancelHandlerId(boolean value){               this.value[18]=value;}
    
    /**
     * �\���f�[�^�̎���҃��O�C�����̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispCancelHandlerLoginName(boolean value){        this.value[19]=value;}
    
    /**
     * �\���f�[�^�̎���ҕ\�����̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispCancelHandlerDisplayName(boolean value){      this.value[20]=value;}
    
    /**
     * �\���f�[�^�̎�����Ԃ̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispCancelTime(boolean value){                    this.value[21]=value;}
    
    /**
     * �\���f�[�^�̍��ڒl�̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispItemData(boolean value){                      this.value[22]=value;}
    
    /**
     * �\���f�[�^�̌o�H�X�e�[�^�X�̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispStepStatus(boolean value){                    this.value[23]=value;}
    
    /**
     * �\���f�[�^�̌o�H�������ʂ̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispStepHandleResult(boolean value){              this.value[24]=value;}
    
    /**
     * �\���f�[�^�̌o�H�����R�����g�̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispStepHandleComment(boolean value){             this.value[25]=value;}
    
    /**
     * �\���f�[�^�̌o�H������ID�̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispStepHandlerId(boolean value){                 this.value[26]=value;}
    
    /**
     * �\���f�[�^�̌o�H�����҃��O�C�����̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispStepHandlerLoginName(boolean value){          this.value[27]=value;}
    
    /**
     * �\���f�[�^�̌o�H�����ҕ\�����̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispStepHandlerDisplayName(boolean value){        this.value[28]=value;}
    
    /**
     * �\���f�[�^�̌o�H�������Ԃ̕\���E��\����ݒ肵�܂��B
     * @param  value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispStepHandleTime(boolean value){               this.value[29]=value;}

    /**
     * �\���f�[�^�̐\���ԍ��̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispPetitionNumber(){                          return this.value[0];}
    
    /**
     * �\���f�[�^�̌��݃X�e�[�^�X�̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispStatus(){                                  return this.value[1];}
    
    /**
     * �\���f�[�^�̐\����ID�̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispCreatorId(){                               return this.value[2];}
    
    /**
     * �\���f�[�^�̐\���҃��O�C�����̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispCreatorLoginName(){                        return this.value[3];}
    
    /**
     * �\���f�[�^�̐\���ҕ\�����̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispCreatorDisplayName(){                      return this.value[4];}
    
    /**
     * �\���f�[�^�̐\�����Ԃ̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispCreateTime(){                              return this.value[5];}
    
    /**
     * �\���f�[�^�̍ŏI���F��ID�̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispAcceptanceHandlerId(){                     return this.value[6];}
    
    /**
     * �\���f�[�^�̍ŏI���F�҃��O�C�����̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispAcceptanceHandlerLoginName(){              return this.value[7];}
    
    /**
     * �\���f�[�^�̍ŏI���F�ҕ\�����̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispAcceptanceHandlerDisplayName(){            return this.value[8];}
    
    /**
     * �\���f�[�^�̍ŏI���F���Ԃ̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispAcceptanceTime(){                          return this.value[9];}
    
    /**
     * �\���f�[�^�̋p����ID�̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispRejectHandlerId(){                         return this.value[10];}
    
    /**
     * �\���f�[�^�̋p���҃��O�C�����̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispRejectHandlerLoginName(){                  return this.value[11];}
    
    /**
     * �\���f�[�^�̋p���ҕ\�����̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispRejectHandlerDisplayName(){                return this.value[12];}
    
    /**
     * �\���f�[�^�̋p�����Ԃ̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispRejectTime(){                              return this.value[13];}
    
    /**
     * �\���f�[�^�̊�����ID�̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispFinishHandlerId(){                         return this.value[14];}
    
    /**
     * �\���f�[�^�̊����҃��O�C�����̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispFinishHandlerLoginName(){                  return this.value[15];}
    
    /**
     * �\���f�[�^�̊����ҕ\�����̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispFinishHandlerDisplayName(){                return this.value[16];}
    
    /**
     * �\���f�[�^�̊������Ԃ̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispFinishTime(){                              return this.value[17];}
    
    /**
     * �\���f�[�^�̎����ID�̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispCancelHandlerId(){                         return this.value[18];}
    
    /**
     * �\���f�[�^�̎���҃��O�C�����̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispCancelHandlerLoginName(){                  return this.value[19];}
    
    /**
     * �\���f�[�^�̎���ҕ\�����̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispCancelHandlerDisplayName(){                return this.value[20];}
    
    /**
     * �\���f�[�^�̎�����Ԃ̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispCancelTime(){                              return this.value[21];}
    
    /**
     * �\���f�[�^�̍��ڒl�̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispItemData(){                                return this.value[22];}
    
    /**
     * �\���f�[�^�̌o�H�X�e�[�^�X�̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispStepStatus(){                              return this.value[23];}
    
    /**
     * �\���f�[�^�̌o�H�������ʂ̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispStepHandleResult(){                        return this.value[24];}
    
    /**
     * �\���f�[�^�̌o�H�����R�����g�̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispStepHandleComment(){                       return this.value[25];}
    
    /**
     * �\���f�[�^�̌o�H������ID�̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispStepHandlerId(){                           return this.value[26];}
    
    /**
     * �\���f�[�^�̌o�H�����҃��O�C�����̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispStepHandlerLoginName(){                    return this.value[27];}
    
    /**
     * �\���f�[�^�̌o�H�����ҕ\�����̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispStepHandlerDisplayName(){                  return this.value[28];}
    
    /**
     * �\���f�[�^�̌o�H�������Ԃ̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispStepHandleTime(){                         return this.value[29];}

    
}
