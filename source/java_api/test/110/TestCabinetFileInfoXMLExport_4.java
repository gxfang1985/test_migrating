import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.FileInfoProperties;

public class TestCabinetFileInfoXMLExport_4 {
    public static void main ( String args[]) throws Exception{
        String url = null;                     // Garoon��URL
        String user = null;                    // ���[�U�[�A�J�E���g��
        String password = null;                // �p�X���[�h
        String registrant = null;              // ���s��
        String folderCode = null;                    // �t�H���_�R�[�h
        String filePath = null;                 // �f�B���N�g���p�X
    
        FileInfoProperties items = null;       // �o�͍���
 
    
        // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
        CoopLink cabinetLink = new CoopLink( url, user, password );
        cabinetLink.exportXMLCabinetFileInfoFolderChild(folderCode,items,filePath,registrant);

    }
}
