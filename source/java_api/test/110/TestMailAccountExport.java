import jp.co.cybozu.garoon2.CoopLink;

public class TestMailAccountExport {
    public static void main ( String args[]) throws Exception{
        
        String url = "http://haken-kreuz.corp.cybozu.co.jp/cgi-bin/cbgrn213/grn.cgi";                                  //Garoon��URL
        String user = "Administrator";                                 //���[�U�[�A�J�E���g��
        String password = "cybozu";                             //�p�X���[�h
        String filePath = "test.csv";                             // CSV�t�@�C���p�X
        boolean sjisEncode = true;                       // �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
        boolean skip = false;                              // �擪�s�̗L��(true:�L false:��)
        CoopLink grnLink = null;     
        
        // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
        grnLink = new CoopLink( url,user,password );

        // Garoon�փf�[�^���M
        grnLink.exportMailAccount( filePath,                // CSV�t�@�C���p�X
                                   skip,                    // �擪�s�̗L��(true:�L false:��)
                                   sjisEncode);           // �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
    }
}
