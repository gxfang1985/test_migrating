import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.FolderInfoProperties;

public class TestFolderInfoProperties {
    public static void main ( String args[]) throws Exception{
        String url = null;                                  // Garoon��URL
        String user = null;                                 // ���[�U�[�A�J�E���g��
        String password = null;                             // �p�X���[�h
        String registrant = null;                           // ���s��
        String hid = null;                                 // �t�H���_ID
        String dirPath = null;                              // �f�B���N�g���p�X
    
    FolderInfoProperties items = null;                  // �o�͍���
    

    // FolderInfoProperties  ����
    items = new FolderInfoProperties();

    //�������C�ȉ��K�X�ύX�̂���///////////////////////////////////////////////////////////
    
    //�ꊇ�ݒ�
    //items.allDispSet(true);
    
    //�f�t�H���g�l�Z�b�g
    //items.init();
    
    // ��U���ڂ�S����\���ɃZ�b�g
    items.allDispSet(false);
 
    //set�n
    //�e���ڐݒ�,�R�����g�A�E�g���O���ƍ��ڂ��o�͂��邩�ǂ�����true,false�Őݒ�ł��܂��D
    items.setDispTitle(true);// �t�H���_��            
    items.setDispDescription(true);// �t�H���_����                 
    items.setDispCreatorId(true);// �o�^���[�U�[ID           
    items.setDispCreatorLoginName(true);// �o�^���[�U�[���O�C����          
    items.setDispCreatorDisplayName(true);// �o�^���[�U�[�\��ID                 
    items.setDispCreateTime(true); // �o�^����                 
    items.setDispModifierId(true);// �X�V���[�U�[ID          
    items.setDispModifierLoginName(true);// �X�V���[�U�[���O�C����         
    items.setDispModifierDisplayName(true);// �X�V���[�U�[�\����                  
    items.setDispModifyTime(true);// �X�V����
  
    //get�n
    //�e���ڐݒ�,�R�����g�A�E�g���O���ƍ��ڂ��o�͂��邩�ǂ�����,false�Őݒ�ł��܂��D
    //System.out.println(items.getDispTitle());// �t�H���_��            
    //System.out.println(items.getDispDescription());// �t�H���_����                 
    //System.out.println(items.getDispCreatorId());// �o�^���[�U�[ID           
    //System.out.println(items.getDispCreatorLoginName());// �o�^���[�U�[���O�C����          
    //System.out.println(items.getDispCreatorDisplayName());// �o�^���[�U�[�\��ID                 
    //System.out.println(items.getDispCreateTime()); // �o�^����                 
    //System.out.println(items.getDispModifierId());// �X�V���[�U�[ID          
    //System.out.println(items.getDispModifierLoginName());// �X�V���[�U�[���O�C����         
    //System.out.println(items.getDispModifierDisplayName());// �X�V���[�U�[�\����                  
    //System.out.println(items.getDispModifyTime());// �X�V����
    
    // set�n�ł̂ݎg�p
    // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
    CoopLink cabinetLink = new CoopLink( url, user, password );
    cabinetLink.exportXMLCabinetFolderInfo(Long.parseLong(hid),items,dirPath,registrant);
    
    }
}
