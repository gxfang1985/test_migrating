package jp.co.cybozu.garoon2;

import java.util.ArrayList;

import jp.co.cybozu.garoon2.util.AbstractParameters;

/**
 * �t�@�C���Ǘ��̃t�H���_���擾���ɏo�͂���XML�̍��ڌQ��ݒ肷��N���X�ł��B<BR>
 *
 * @author �T�C�{�E�Y
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
     * �t�H���_�̏o�͍��ڌQ�ɂ��āA�����l���Z�b�g���܂��B<BR>
     * �����l�́A�t�H���_���E�t�H���_�����͕\���A����ȊO�́A��\���ł��B
     * 
     */
    // �f�t�H���g�l�Z�b�g
	public void init() {
        allDispSet(false);
        setDispTitle(true);
        setDispDescription(true);
	}
	
    /**
     * �t�H���_�̏o�͍��ڌQ�̕\���E��\���̐ݒ�l���ꊇ�ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
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
     * �t�H���_���̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */    
	public void setDispTitle(boolean value) {                this.value[0]=value;}  // �t�H���_��
	
    /**
     * �t�H���_�����̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */    
	public void setDispDescription(boolean value) {          this.value[1]=value;}  // �t�H���_����
	
    /**
     * �o�^���[�U�[ID�̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */    
	public void setDispCreatorId(boolean value) {            this.value[2]=value;}  // �o�^���[�U�[ID
	
    /**
     * �o�^���[�U�[���O�C�����̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */    
	public void setDispCreatorLoginName(boolean value) {     this.value[3]=value;}  // �o�^���[�U�[���O�C����
	
    /**
     * �o�^���[�U�[�\��ID�̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */    
	public void setDispCreatorDisplayName(boolean value) {   this.value[4]=value;}  // �o�^���[�U�[�\��ID
	
    /**
     * �o�^�����̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */    
	public void setDispCreateTime(boolean value) {            this.value[5]=value;}  // �o�^����
	
    /**
     * �X�V���[�U�[ID�̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */    
	public void setDispModifierId(boolean value) {           this.value[6]=value;}  // �X�V���[�U�[ID
	
    /**
     * �X�V���[�U�[���O�C�����̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */    
	public void setDispModifierLoginName(boolean value) {    this.value[7]=value;}  // �X�V���[�U�[���O�C����
	
    /**
     * �X�V���[�U�[�\�����̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */    
	public void setDispModifierDisplayName(boolean value) {  this.value[8]=value;}  // �X�V���[�U�[�\����
	
    /**
     * �X�V���Ԃ̕\���E��\����ݒ肵�܂��B
     * @param value true�̏ꍇ�A�\�����܂��B
     */    
	public void setDispModifyTime(boolean value) {           this.value[9]=value;}  // �X�V����
	
	
    /**
     * �t�H���_���̕\���E��\�����擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */    
	public boolean getDispTitle() {                return this.value[0];}  // �t�H���_��
	
    /**
     * �t�H���_�����̕\���E��\�����擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */   
	public boolean getDispDescription() {          return this.value[1];}  // �t�H���_����
	
    /**
     * �o�^���[�U�[ID�̕\���E��\�����擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */    
	public boolean getDispCreatorId() {            return this.value[2];}  // �o�^���[�U�[ID
	
    /**
     * �o�^���[�U�[���O�C�����̕\���E��\�����擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */    
	public boolean getDispCreatorLoginName() {     return this.value[3];}  // �o�^���[�U�[���O�C����
	
    /**
     * �o�^���[�U�[�\��ID�̕\���E��\�����擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */    
	public boolean getDispCreatorDisplayName() {   return this.value[4];}  // �o�^���[�U�[�\��ID
	
    /**
     * �o�^�����̕\���E��\�����擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */
	public boolean getDispCreateTime() {            return this.value[5];}  // �o�^����
	
    /**
     * �X�V���[�U�[ID�̕\���E��\�����擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */    
	public boolean getDispModifierId() {           return this.value[6];}  // �X�V���[�U�[ID
	
    /**
     * �X�V���[�U�[���O�C�����̕\���E��\�����擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */    
	public boolean getDispModifierLoginName() {    return this.value[7];}  // �X�V���[�U�[���O�C����
	
    /**
     * �X�V���[�U�[�\�����̕\���E��\�����擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */    
	public boolean getDispModifierDisplayName() {  return this.value[8];}  // �X�V���[�U�[�\����
	
    /**
     * �X�V���Ԃ̕\���E��\�����擾���܂��B
     * @return true�̏ꍇ�A�\�����܂��B
     */   
	public boolean getDispModifyTime() {           return this.value[9];}  // �X�V����
}