import jp.co.cybozu.garoon2.CoopLink;

public class TestCabinetDownload_2 {
    public static void main ( String args[]) throws Exception{
        
        String url = null;                          // Garoon��URL
        String user = null;                         // ���O�C�����[�U�[�A�J�E���g
        String password = null;                     // ���O�C���p�X���[�h
        String fid = null;                           // �t�@�C��ID
        String registrant = null;                    // ���s��
        String dirPath = null;                       // �f�B���N�g���p�X
        String fileName = null;                      // �t�@�C����
        String version = null;                       // �擾�o�[�W����
        CoopLink cabinetLink = null;                        // CoopLink����p
        
        // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
        cabinetLink = new CoopLink( url, user, password );

        // �o�[�W�������w�薔�̓t�@�C������ʖ��ŕۑ�����ꍇ
        cabinetLink.putCabinetDownload( Long.parseLong(fid),     // �t�@�C��ID    
                                        dirPath,                 // �f�B���N�g���p�X
                                        fileName,                // �t�@�C����
                                        version==null?null:Long.decode(version), // �o�[�W����
                                        registrant );            // ���s��    
    }
}
