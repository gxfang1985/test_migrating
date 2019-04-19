import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;

import jp.co.cybozu.garoon2.CoopLink;

public class Bulletin_access_test {
	public static void main(String[] args) {
        String url = "http://haken-kreuz.corp.cybozu.co.jp/cgi-bin/cbgrn213/grn.cgi";
        String user = "Administrator";
        String password = "cybozu";
        CoopLink cp ;
        String registrant = "cybozu";
        String bulletinId = null;
        String fid = null;
       
        try {
             cp = new CoopLink(url,user,password);
             //////////////////////////����
             
             String categoryCode = "test";                 // �J�e�S���R�[�h
             
             boolean canFollow = true;                  // �t�H���[����
             Collection attachedFiles = new ArrayList(); // �Y�t�t�@�C��
             
             //////////////////////////////�o�^
             String title = "�o�^-�A�N�Z�X��";                        // �^�C�g��
             String data = "�o�^�f���f�[�^";                         // �{��

             //////////////////////////////�X�V
             long modid = 10;
             String modtitle = "�X�V-�A�N�Z�X��";                        // �^�C�g��
             String moddata = "�X�V�f���f�[�^";                         // �{��

             //////////////////////////////�폜
             Collection deluserAccount = new ArrayList();   // �Q���҂̃��[�U�[�A�J�E���g
             deluserAccount.add("Administrator");

             //////////////////////////////�t�H���[�o�^
             long followaddid = 11;
             
            System.out.println("�@�o�^start--------------------------------------");
            try {
                // Garoon�Ɍf�����𑗐M
                bulletinId=cp.putBulletinAdd(title,          // �^�C�g��
                                                        categoryCode,  // �J�e�S���R�[�h
                                                        null,          // �f�����ԊJ�n��
                                                        null,          // �f�����ԏI����
                                                        data,          // �{��
                                                        null, // �Y�t�t�@�C��
                                                        canFollow,     // �t�H���[��������
                                                        registrant);   // ���o�l
                System.out.println(bulletinId);
            }catch (Exception e){
                //e.printStackTrace();
                System.out.println(e.toString());
            }
            System.out.println("�@�o�^finish--------------------------------------");
   
            System.out.println("�A�X�Vstart--------------------------------------");
            try {
                // Garoon�Ɍf�����𑗐M
                String modebulletinId=cp.putBulletinModify(modid,  // �f���L��ID
                                                           modtitle,               // �^�C�g��
                                                           null,                // �f�����ԊJ�n��
                                                           null,                // �f�����ԏI����
                                                           moddata,                // �{��
                                                           null,       // �Y�t�t�@�C��
                                                           canFollow,           // �t�H���[��������
                                                           registrant);         // ���o�l
                System.out.println(modebulletinId);
            }catch (Exception e){
                //e.printStackTrace();
                System.out.println(e.toString());
            }
            System.out.println("�A�X�Vfinish--------------------------------------");         
 
            System.out.println("�B�폜start--------------------------------------");
            try {
            	if(bulletinId == null){
                    // Garoon�Ɍf���폜���𑗐M
                    String delarticle = cp.putBulletinDelete(Long.parseLong("24"),  // �f���L��ID
                                                             registrant);   // �X�V��
                    System.out.println(delarticle);
            	}else{
                    // Garoon�Ɍf�����𑗐M
                    String deladdbulletinId=cp.putBulletinAdd(title,          // �^�C�g��
                                                            categoryCode,  // �J�e�S���R�[�h
                                                            null,          // �f�����ԊJ�n��
                                                            null,          // �f�����ԏI����
                                                            data,          // �{��
                                                            null, // �Y�t�t�@�C��
                                                            canFollow,     // �t�H���[��������
                                                            registrant);   // ���o�l
                	
                    // Garoon�Ɍf���폜���𑗐M
                    String delarticle = cp.putBulletinDelete(Long.parseLong(deladdbulletinId),  // �f���L��ID
                                                             registrant);   // �X�V��
                    System.out.println(delarticle);
            	}

            }catch (Exception e){
                //e.printStackTrace();
                System.out.println(e.toString());
            }
            System.out.println("�B�폜finish--------------------------------------");  
           
            System.out.println("�C�t�H���[�o�^start--------------------------------------");
            try {
                // Garoon�Ƀt�H���[���𑗐M
                fid = cp.putBulletinFollowAdd(followaddid,// �f����ID
                                                        data,               // �{��
                                                        null,      // �Y�t�t�@�C��
                                                        registrant);        // �o�^��
                System.out.println(fid);
            }catch (Exception e){
                //e.printStackTrace();
                System.out.println(e.toString());
            }
            System.out.println("�C�t�H���[�o�^finish--------------------------------------");    
 
            System.out.println("�D�t�H���[�폜start--------------------------------------");
            try {
                if(fid == null){
                    // Garoon�Ɍf���t�H���[�폜���𑗐M
                    String deladdarticlefollow = cp.putBulletinFollowDelete(Long.parseLong("17"),// �f���L���t�H���[ID
                                                                         registrant);                    // �X�V��
                    System.out.println(deladdarticlefollow);
                    
                }else{
                    // Garoon�Ƀt�H���[���𑗐M
                    String deladdfid = cp.putBulletinFollowAdd(followaddid,// �f����ID
                                                            data,               // �{��
                                                            null,      // �Y�t�t�@�C��
                                                            registrant);        // �o�^��
                    // Garoon�Ɍf���t�H���[�폜���𑗐M
                    String deladdarticlefollow = cp.putBulletinFollowDelete(Long.parseLong(deladdfid),// �f���L���t�H���[ID
                                                                         registrant);                    // �X�V��
                    System.out.println(deladdarticlefollow);
                }

                
            }catch (Exception e){
                //e.printStackTrace();
                System.out.println(e.toString());
            }
            System.out.println("�D�t�H���[�폜finish--------------------------------------");   
            
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
