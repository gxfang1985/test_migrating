import jp.co.cybozu.garoon2.CoopLink;

public class TestWorkFlowDownloadSystemFile_1 {
	public static void main ( String args[]) throws Exception{
        String url = "http://haken-kreuz.corp.cybozu.co.jp/cgi-bin/cbgrn213/grn.cgi";                          // Garoon��URL
        String user = "Administrator";                         // ���O�C�����[�U�[�A�J�E���g
        String password = "cybozu";                     // ���O�C���p�X���[�h
        String afid = "1";                          // ���[�N�t���[�̓Y�t�t�@�C��ID
        String dirPath = "";                       // �f�B���N�g���p�X
        
        CoopLink workflowLink = null;                 // CoopLink����p

        // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
        workflowLink = new CoopLink( url, user, password );
        
        // �K���[���Q ���[�N�t���[��̓Y�t�t�@�C�����ŕۑ�����ꍇ
        workflowLink.downloadSystemWorkFlowAttachedFile( Long.parseLong(afid),     // ���[�N�t���[�̓Y�t�t�@�C��ID      
                                                         dirPath );               // �f�B���N�g���p�X
	}
}
