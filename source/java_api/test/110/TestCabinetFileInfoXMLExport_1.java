import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.FileInfoProperties;

public class TestCabinetFileInfoXMLExport_1 {
    public static void main ( String args[]) throws Exception{
        
        String url = "http://haken-kreuz.corp.cybozu.co.jp/cgi-bin/cbgrn213/grn.cgi";                          // Garoon��URL
        String user = "Administrator";                         // ���O�C�����[�U�[�A�J�E���g
        String password = "cybozu";                     // ���O�C���p�X���[�h
        String registrant = null;              // ���s��
        String fid = "24";                    // �t�@�C��ID
        String filePath = "C:\\test.xml";                 // �f�B���N�g���p�X
    
        FileInfoProperties items = null;       // �o�͍���

    
        // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
        CoopLink cabinetLink = new CoopLink( url, user, password );
        cabinetLink.exportXMLCabinetFileInfo(Long.parseLong(fid),items,filePath,registrant);

    }
}
