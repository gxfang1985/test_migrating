import jp.co.cybozu.garoon2.CoopLink;

public class TestCabinetModify {
    public static void main ( String args[]) throws Exception{
        
        String url = null;                                  //Garoon��URL
        String user = null;                                 //���[�U�[�A�J�E���g��
        String password = null;                             //�p�X���[�h
        String fid = null;                                  //�t�@�C��ID
        String registrant = null;                           //���ύX��
        String title = null;                                //�^�C�g��
        String version = null;                               //�o�[�W����
        String memo =null;                                 //����
        
        String fileId =null;                               //�t�@�C��ID(�߂�l)
        CoopLink cabinetLink =null;                        //CoopLink����p
        
        // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
        cabinetLink = new CoopLink( url, user, password );

        // Garoon�փf�[�^���M
        fileId = cabinetLink.putCabinetModify( Long.parseLong(fid),     // �t�@�C��ID
                                               title,                   // �^�C�g��
                                               Long.parseLong(version), // �o�[�W�����Ǘ�
                                               memo,                    // ����                                                    
                                               registrant );            // ���ύX��
        System.out.println(fileId);
    }
}
