import jp.co.cybozu.garoon2.CoopLink;

public class TestCabinetFileInfoXMLExport_6 {
    public static void main ( String args[]) throws Exception{
        String url = "http://haken-kreuz.corp.cybozu.co.jp/cgi-bin/cbgrn213/grn.cgi";                          // Garoon��URL
        String user = "Administrator";                         // ���O�C�����[�U�[�A�J�E���g
        String password = "cybozu";                     // ���O�C���p�X���[�h
        String registrant = null;              // ���s��
        String folderCode = "test";                    // �t�H���_ID
        String filePath = "C:\\test.xml";                 // �f�B���N�g���p�X
    
        // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
        CoopLink cabinetLink = new CoopLink( url, user, password );
        cabinetLink.exportXMLCabinetFileInfoFolderChild(folderCode,filePath,registrant);

    }
}
