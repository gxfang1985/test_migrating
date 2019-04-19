import java.io.File;
import jp.co.cybozu.garoon2.CoopLink;

public class TestCabinetUpload {
    public static void main ( String args[]) throws Exception{
        
        String url = null;                                  // Garoon��URL
        String user = null;                                 // ���[�U�[�A�J�E���g��
        String password = null;                             // �p�X���[�h
        String fid = null;                                  // �t�@�C��ID
        String registrant =null;                            // �X�V��
        File file = new File("C:\\test.txt");                                   // �t�@�C��
        String comment = null;                              // �X�V�R�����g
        
        String fileId = null;                               // �t�@�C��ID(�߂�l)
        CoopLink cabinetLink = null;                        // CoopLink����p
        
        // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
        cabinetLink = new CoopLink( url, user, password );

        // Garoon�փf�[�^���M
        fileId = cabinetLink.putCabinetUpload( Long.parseLong(fid), // �t�@�C��ID
                                               comment,             // �X�V�R�����g                               
                                               file,                // �t�@�C��
                                               registrant );        // �X�V��
        System.out.println(fileId);
    }
}
