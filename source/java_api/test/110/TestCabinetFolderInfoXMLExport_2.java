import jp.co.cybozu.garoon2.CoopLink;

public class TestCabinetFolderInfoXMLExport_2 {
    public static void main ( String args[]) throws Exception{
        String url = null;                                  // Garoon��URL
        String user = null;                                 // ���[�U�[�A�J�E���g��
        String password = null;                             // �p�X���[�h
        String registrant = null;                           // ���s��
        String hid = null;                               // �t�H���_ID
        String filePath = null;                              // �f�B���N�g���p�X
    
        // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
        CoopLink cabinetLink = new CoopLink( url, user, password );
        cabinetLink.exportXMLCabinetFolderInfo(Long.parseLong(hid),filePath,registrant);

    }
}
