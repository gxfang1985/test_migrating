import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.FileInfoProperties;

public class TestFileInfoProperties {
    public static void main ( String args[]) throws Exception{
        String url = null;                     // Garoon��URL
        String user = null;                    // ���[�U�[�A�J�E���g��
        String password = null;                // �p�X���[�h
        String registrant = null;              // ���s��
        String fid = null;                    // �t�@�C��ID
        String dirPath = null;                 // �f�B���N�g���p�X
    
        FileInfoProperties items = null;       // �o�͍���
    
        
        // FileInfoProperties�@����
        items = new FileInfoProperties();
        
        //�������C�ȉ��K�X�ύX�̂���///////////////////////////////////////////////////////////
        
        //�ꊇ�ݒ�
        //items.allDispSet(true);
    
        //  �f�t�H���g�l�Z�b�g
        //items.init();
    
        //  �����֘A�ꊇ�Z�b�g
        //items.historyDispSet(false);
        
        // ��U���ڂ�S����\���ɃZ�b�g
        //items.allDispSet(false);    
        
        //set�n
        //�e���ڐݒ�,�R�����g�A�E�g���O���ƍ��ڂ��o�͂��邩�ǂ�����true,false�Őݒ�ł��܂��D
        //items.setDispTitle(true);// �^�C�g��
        //items.setDispDiscriptoin(true);// ����
        //items.setDispMaxVersion(true);// �o�[�W��������l
        //items.setDispName(true);// �t�@�C����
        //items.setDispSize(true);// �t�@�C���T�C�Y
        //items.setDispMimeType(true);// �t�@�C����MIMETYPE
        //items.setDispCreatorId(true);// �쐬��ID
        //items.setDispCreatorLoginName(true);// �쐬�҃��O�C����
        //items.setDispCreatorDisplayName(true);// �쐬�ҕ\����
        //items.setDispCreateTime(true);// �쐬����
        //items.setDispModifierId(true);// �X�V��ID
        //items.setDispModifierLoginName(true);// �X�V�҃��O�C����
        //items.setDispModifierDisplayName(true);// �X�V�ҕ\����
        //items.setDispModifyTime(true);// �X�V����
        //items.setDispHistoryVersion(true);// �o�[�W����NO
        //items.setDispHistoryActive(true);// �����Ǘ�����Ă��邩
        //items.setDispHistoryName(true);// �����̃t�@�C����
        //items.setDispHistoryAction(true);// ����
        //items.setDispHistoryComment(true);// �X�V�R�����g
        //items.setDispHistoryModifierId(true);// �X�V��ID
        //items.setDispHistoryModifierLoginName(true);// �X�V�҃��O�C����
        //items.setDispHistoryModifierDisplayName(true);// �X�V�ҕ\����
        //items.setDispHistoryModifyTime(true);// �X�V����
       
        //get�n
        //�e�ݒ荀�ڎ擾,�R�����g�A�E�g���O����true��false���Ԃ��Ă��܂��D
        //System.out.println(items.getDispTitle());// �^�C�g��
        //System.out.println(items.getDispDiscriptoin());// ����
        //System.out.println(items.getDispMaxVersion());// �o�[�W��������l
        //System.out.println(items.getDispName());// �t�@�C����
        //System.out.println(items.getDispSize());// �t�@�C���T�C�Y
        //System.out.println(items.getDispMimeType());// �t�@�C����MIMETYPE
        //System.out.println(items.getDispCreatorId());// �쐬��ID
        //System.out.println(items.getDispCreatorLoginName());// �쐬�҃��O�C����
        //System.out.println(items.getDispCreatorDisplayName());// �쐬�ҕ\����
        //System.out.println(items.getDispCreateTime());// �쐬����
        //System.out.println(items.getDispModifierId());// �X�V��ID
        //System.out.println(items.getDispModifierLoginName());// �X�V�҃��O�C����
        //System.out.println(items.getDispModifierDisplayName());// �X�V�ҕ\����
        //System.out.println(items.getDispModifyTime());// �X�V����
        //System.out.println(items.getDispHistoryVersion());// �o�[�W����NO
        //System.out.println(items.getDispHistoryActive());// �����Ǘ�����Ă��邩
        //System.out.println(items.getDispHistoryName());// �����̃t�@�C����
        //System.out.println(items.getDispHistoryAction());// ����
        //System.out.println(items.getDispHistoryComment());// �X�V�R�����g
        //System.out.println(items.getDispHistoryModifierId());// �X�V��ID
        //System.out.println(items.getDispHistoryModifierLoginName());// �X�V�҃��O�C����
        //System.out.println(items.getDispHistoryModifierDisplayName());// �X�V�ҕ\����
        //System.out.println(items.getDispHistoryModifyTime());// �X�V����
       
        //set�n�ł̂ݎg�p
        //Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
        //CoopLink cabinetLink = new CoopLink( url, user, password );
        //cabinetLink.exportXMLCabinetFileInfo(Long.parseLong(fid),items,dirPath,registrant);
    }
}
