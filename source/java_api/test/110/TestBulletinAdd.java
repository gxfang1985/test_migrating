import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;

import jp.co.cybozu.garoon2.CoopLink;

public class TestBulletinAdd {
	public static void main ( String args[]) throws Exception{
	    //String url = "http://haken-kreuz.corp.cybozu.co.jp/cgi-bin/cbgrn213/grn.cgi";                     // Garoon��URL
		String url = "http://localhost/scripts/cbgrn/grn.exe";                     // Garoon��URL
		
		String user = "Administrator";                    // ���[�U�[�A�J�E���g��
	    String password = "cybozu";                // �p�X���[�h
        String title = "test";                        // �^�C�g��
        String categoryCode = "test";                 // �J�e�S���R�[�h
        String registrant = null;                   // ���o�l
        //String sdate = null;                        // �f�����ԊJ�n��
        //String edate = null;                        // �f�����ԏI����
        Calendar sCal =null;       
        Calendar eCal = null; 
        String data = "test\rtest";                         // �{��
        boolean canFollow = true;                  // �t�H���[����
        Collection attachedFiles = new ArrayList(); // �Y�t�t�@�C��

        CoopLink bulletinLink =null;                        //CoopLink����p
        
        // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)    
        bulletinLink = new CoopLink(url, user, password);
        
        // Garoon�Ɍf�����𑗐M    
        bulletinLink.putBulletinAdd(title,          // �^�C�g��
                                            categoryCode,  // �J�e�S���R�[�h
                                            sCal,          // �f�����ԊJ�n��
                                            eCal,          // �f�����ԏI����
                                            data,          // �{��
                                            attachedFiles, // �Y�t�t�@�C��
                                            canFollow,     // �t�H���[��������
                                            registrant);   // ���o�l

	}
}