package jp.co.cybozu.garoon2;

import java.util.ArrayList;
//import java.util.HashMap;

import jp.co.cybozu.garoon2.util.AbstractParameters;


/**
 * �t�@�C���Ǘ��̃t�@�C�����擾���ɏo�͂���XML�̍��ڌQ��ݒ肷��N���X�ł��B<BR>
 *
 * @author �T�C�{�E�Y
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
     * �t�@�C���̏o�͍��ڌQ�ɂ��āA�����l���Z�b�g���܂��B<BR>
     * �����l�́A�����֘A�ȊO�͕\���A�����֘A�́A��\���ł��B
     * 
     */
    // �f�t�H���g�l�Z�b�g
    public void init(){    
        allDispSet(true);
        historyDispSet(false);
    }
    
    /**
     * �t�@�C���̏o�͍��ڌQ�̕\���E��\���̐ݒ�l���ꊇ�ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    // �ꊇ�Z�b�g
    public void allDispSet(boolean value){
        int len = this.value.length;
        for (int i = 0; i < len; i++) {
            this.value[i] = value;
        }
    }
    
     /**
     * �t�@�C���̏o�͍��ڌQ�̂����A�����֘A�̍��ڂɂ��Ă̕\���E��\���̐ݒ�l���ꊇ�ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    // �����֘A�ꊇ�Z�b�g
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
     * �t�@�C���̃^�C�g���̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */    
    public void setDispTitle(boolean value){              this.value[0]=value;}  // �^�C�g��
    
    
    /**
     * �t�@�C���̐����̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    public void setDispDescription(boolean value){        this.value[1]=value;}  // ����
    
    /**
     * �t�@�C���̃o�[�W��������l�̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    public void setDispMaxVersion(boolean value){         this.value[2]=value;}  // �o�[�W��������l
    
    /**
     * �t�@�C���̃t�@�C�����̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    public void setDispName(boolean value){               this.value[3]=value;}  // �t�@�C����
    
    /**
     * �t�@�C���̃t�@�C���T�C�Y�̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    public void setDispSize(boolean value){               this.value[4]=value;}  // �t�@�C���T�C�Y
    
    /**
     * �t�@�C���̃}�C���^�C�v�̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    public void setDispMimeType(boolean value){           this.value[5]=value;}  // �}�C���^�C�v
    
    /**
     * �t�@�C���̓o�^���[�U�[ID�̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    public void setDispCreatorId(boolean value){          this.value[6]=value;}  // �o�^���[�U�[ID
    
    /**
     * �t�@�C���̓o�^���[�U�[���O�C�����̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    public void setDispCreatorLoginName(boolean value){   this.value[7]=value;}  // �o�^���[�U�[���O�C����
    
    /**
     * �t�@�C���̓o�^���[�U�[�\�����̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    public void setDispCreatorDisplayName(boolean value){ this.value[8]=value;}  // �o�^���[�U�[�\����
    
    /**
     * �t�@�C���̓o�^���Ԃ̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    public void setDispCreateTime(boolean value){          this.value[9]=value;}  // �o�^����
    
    /**
     * �t�@�C���� �X�V���[�U�[ID�̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    public void setDispModifierId(boolean value){         this.value[10]=value;}  // �X�V���[�U�[ID
    
    /**
     * �t�@�C���̍X�V���[�U�[���O�C�����̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    public void setDispModifierLoginName(boolean value){  this.value[11]=value;}  // �X�V���[�U�[���O�C����
    
    /**
     * �t�@�C���̍X�V���[�U�[�\�����̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    public void setDispModifierDisplayName(boolean value){this.value[12]=value;}  // �X�V���[�U�[�\����
    
    /**
     * �t�@�C���̍X�V���Ԃ̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    public void setDispModifyTime(boolean value){         this.value[13]=value;}  // �X�V����
    
    /**
     * �t�@�C���̗����o�[�W����No�̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    public void setDispHistoryVersion(boolean value){     this.value[14]=value;}  // �����o�[�W����No

    /**
     * �t�@�C���̗����o�[�W�����Ǘ��L�E�����̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    public void setDispHistoryActive(boolean value){      this.value[15]=value;}  // �����o�[�W�����Ǘ��L�E����
        
    /**
     * �t�@�C���̗����t�@�C�����̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    public void setDispHistoryName(boolean value){        this.value[16]=value;}  // �����t�@�C����
    
    /**
     * �t�@�C���̗��𑀍�̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    public void setDispHistoryAction(boolean value){      this.value[17]=value;}  // ���𑀍�
    
    /**
     * �t�@�C���̗����X�V�R�����g�̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    public void setDispHistoryComment(boolean value){     this.value[18]=value;}  // �����X�V�R�����g
    
    /**
     * �t�@�C���̗����X�V���[�U�[ID�̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    public void setDispHistoryModifierId(boolean value){  this.value[19]=value;}  // �����X�V���[�U�[ID
    
    /**
     * �t�@�C���̗����X�V���[�U�[���O�C�����̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    public void setDispHistoryModifierLoginName(boolean value){  this.value[20]=value;}  // �����X�V���[�U�[���O�C����
    
    /**
     * �t�@�C���̗����X�V���[�U�[�\�����̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    public void setDispHistoryModifierDisplayName(boolean value){this.value[21]=value;}  // �����X�V���[�U�[�\����
    
    /**
     * �t�@�C���̗����X�V���Ԃ̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */
    public void setDispHistoryModifyTime(boolean value){         this.value[22]=value;}  // �����X�V����

    
    
    /**
     * �t�@�C���̃^�C�g���̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispTitle(){              return this.value[0];}  // �^�C�g��
    
    /**
     * �t�@�C���̐����̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispDescription(){        return this.value[1];}  // ����
    
    /**
     * �t�@�C���̃o�[�W��������l�̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispMaxVersion(){         return this.value[2];}  // �o�[�W��������l
    
    /**
     * �t�@�C���̃t�@�C�����̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispName(){               return this.value[3];}  // �t�@�C����
    
    /**
     * �t�@�C���̃t�@�C���T�C�Y�̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispSize(){               return this.value[4];}  // �t�@�C���T�C�Y
    
    /**
     * �t�@�C���̃}�C���^�C�v�̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispMimeType(){           return this.value[5];}  // �}�C���^�C�v
    
    /**
     * �t�@�C���̓o�^���[�U�[ID�̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispCreatorId(){          return this.value[6];}  // �o�^���[�U�[ID
    
    /**
     * �t�@�C���̓o�^���[�U�[���O�C�����̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispCreatorLoginName(){   return this.value[7];}  // �o�^���[�U�[���O�C����
    
    /**
     * �t�@�C���̓o�^���[�U�[�\�����̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispCreatorDisplayName(){ return this.value[8];}  // �o�^���[�U�[�\����
    
    /**
     * �t�@�C���̓o�^���Ԃ̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispCreateTime(){          return this.value[9];}  // �o�^����
    
    /**
     * �t�@�C���̍X�V���[�U�[ID�̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispModifierId(){         return this.value[10];}  // �X�V���[�U�[ID
    
    /**
     * �t�@�C���̍X�V���[�U�[���O�C�����̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispModifierLoginName(){  return this.value[11];}  // �X�V���[�U�[���O�C����
    
    /**
     * �t�@�C���̍X�V���[�U�[�\�����̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispModifierDisplayName(){return this.value[12];}  // �X�V���[�U�[�\����
    
    /**
     * �t�@�C���̍X�V���Ԃ̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispModifyTime(){         return this.value[13];}  // �X�V����
    
    /**
     * �t�@�C���̗����o�[�W����No�̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispHistoryVersion(){     return this.value[14];}  // �����o�[�W����No

    /**
     * �t�@�C���̗����o�[�W�����Ǘ��L�E�����̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispHistoryActive(){      return this.value[15];}  // �����o�[�W�����Ǘ��L�E����
        
    /**
     * �t�@�C���̗����t�@�C�����̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispHistoryName(){        return this.value[16];}  // �����t�@�C����
    
    /**
     * �t�@�C���̗��𑀍�̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispHistoryAction(){      return this.value[17];}  // ���𑀍�
    
    /**
     * �t�@�C���̗����X�V�R�����g�̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispHistoryComment(){     return this.value[18];}  // �����X�V�R�����g
    
    /**
     * �t�@�C���̗����X�V���[�U�[ID�̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispHistoryModifierId(){  return this.value[19];}  // �����X�V���[�U�[ID
    
    /**
     * �t�@�C���̗����X�V���[�U�[���O�C�����̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispHistoryModifierLoginName(){  return this.value[20];}  // �����X�V���[�U�[���O�C����
    
    /**
     * �t�@�C���̗����X�V���[�U�[�\�����̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispHistoryModifierDisplayName(){return this.value[21];}  // �����X�V���[�U�[�\����
    
    /**
     * �t�@�C���̗����X�V���Ԃ̕\���E��\���̐ݒ�l���擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
    public boolean getDispHistoryModifyTime(){         return this.value[22];}  // �����X�V����
    
    
    
    
    

}
