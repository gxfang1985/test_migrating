import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.FolderInfoProperties;

public class TestCabinetFolderInfoXMLExport_5 {
    public static void main ( String args[]) throws Exception{
        String url = null;                                  // Garoon��URL
        String user = null;                                 // ���[�U�[�A�J�E���g��
        String password = null;                             // �p�X���[�h
        String registrant = null;                           // ���s��
        String hid = null;                               // �t�H���_ID
        String filePath = null;                              // �f�B���N�g���p�X
    
        FolderInfoProperties items = null;       // �o�͍���

        // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
        CoopLink cabinetLink = new CoopLink( url, user, password );
        cabinetLink.exportXMLCabinetFolderInfo_Child(Long.parseLong(hid),items,filePath,registrant);

    }
}
