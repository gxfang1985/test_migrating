import java.io.File;

import jp.co.cybozu.garoon2.CoopLink;

public class TestCabinetDownload_1 {
    public static void main ( String args[]) throws Exception{
        
        String url = "http://haken-kreuz.corp.cybozu.co.jp/cgi-bin/cbgrn213/grn.cgi";                          // Garoon��URL
        String user = "Administrator";                         // ���O�C�����[�U�[�A�J�E���g
        String password = "cybozu";                     // ���O�C���p�X���[�h
        String fid = "90";                           // �t�@�C��ID
        String registrant = null;                    // ���s��
        String dirPath = "";                       // �f�B���N�g���p�X
        CoopLink cabinetLink = null;                        // CoopLink����p
        
        // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
        cabinetLink = new CoopLink( url, user, password );

        // Garoon�փf�[�^���M
            // �ŐV�o�[�W�����̃t�@�C�� �y�� �t�@�C���Ǘ���̃t�@�C�����ŕۑ�����ꍇ
            cabinetLink.putCabinetDownload( Long.parseLong(fid),     // �t�@�C��ID        
                                            dirPath,                 // �f�B���N�g���p�X
                                            registrant );            // ���s��
    }
}
