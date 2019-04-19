import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;

import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.FileInfoProperties;
import jp.co.cybozu.garoon2.FolderInfoProperties;


public class Schedule_access_test {
	public static void main(String[] args) {
        String url = "http://haken-kreuz.corp.cybozu.co.jp/cgi-bin/cbgrn213/grn.cgi";
        String user = "Administrator";
        String password = "cybozu";
        CoopLink cp ;
        String registrant = "cybozu";
        String followId = null;

       
        try {
             cp = new CoopLink(url,user,password);
             //////////////////////////����
             SimpleDateFormat sdf = new SimpleDateFormat();
             sdf.setLenient( false );  
             sdf.applyPattern( "yyyy-MM-dd" );
             Calendar stCal = null;         
             Calendar etCal = null; 
             Collection userAccount = new ArrayList();   // �Q���҂̃��[�U�[�A�J�E���g
             userAccount.add("Administrator");
             Collection facilityCode = new ArrayList();  // �{�݃R�[�h
             
             //////////////////////////////�o�^
             String eventKind = "0";                     // �\��敪
             String titleMenu = null;                    // �\�胁�j���[
             String title = "�o�^";                        // �\��^�C�g��
             String eventPrivate = "0";                  // ���J/����J
             String detail = null;                       // �\�胁��  

             Calendar sCal = Calendar.getInstance();
             sCal.clear();
             sCal.setTime(sdf.parse("2007-05-10"));
             Calendar eCal = Calendar.getInstance();
             eCal.clear();
             eCal.setTime(sdf.parse("2007-05-10"));

             //////////////////////////////�X�V
             long modid = 30;
             String modtitleMenu = null;                    // �\�胁�j���[
             String modtitle = "�X�V";                        // �\��^�C�g��
             String modeventPrivate = "0";                  // ���J/����J
             String moddetail = null;                       // �\�胁��  
             Calendar modsCal = Calendar.getInstance();
             modsCal.clear();
             modsCal.setTime(sdf.parse("2007-05-18"));
             Calendar modeCal = Calendar.getInstance();
             modeCal.clear();
             modeCal.setTime(sdf.parse("2007-05-18"));

             //////////////////////////////�폜
             Collection deluserAccount = new ArrayList();   // �Q���҂̃��[�U�[�A�J�E���g
             deluserAccount.add("Administrator");

             //////////////////////////////�t�H���[�o�^
             long faddid = 31;
             String data = "�t�H���[";
             
            System.out.println("�@�o�^start--------------------------------------");
            try {
                // Garoon�փX�P�W���[���o�^���𑗐M
                String addevent = cp.putScheduleAdd(Integer.parseInt(eventKind),// �\��敪
                                                    titleMenu,                  // �\��^�C�g�����j���[
                                                    title,                      // �\��^�C�g��
                                                    eventPrivate,               // ���J/����J
                                                    detail,                     // �\�胁��
                                                    sCal,                       // �J�n��
                                                    eCal,                       // �I����
                                                    stCal,                      // �J�n����
                                                    etCal,                      // �I������
                                                    userAccount,                // �Q���҂̃��[�U�[�A�J�E���g
                                                    facilityCode,               // �{�݃R�[�h
                                                    registrant);                // �o�^��
                System.out.println(addevent);
            }catch (Exception e){
                //e.printStackTrace();
                System.out.println(e.toString());
            }
            System.out.println("�@�o�^finish--------------------------------------");
   
            System.out.println("�A�X�Vstart--------------------------------------");
            try {
                // �X�P�W���[���X�V���𑗐M
                String modevent = cp.putScheduleModify(modid, // �C�x���gID
                                                       modtitleMenu,               // �\�胁�j���[
                                                       modtitle,                   // �\��^�C�g��
                                                       modeventPrivate,            // ���J/����J
                                                       moddetail,                  // �\�胁��
                                                       modsCal,                    // �J�n��
                                                       modeCal,                    // �I����
                                                       stCal,                   // �J�n����
                                                       etCal,                   // �I������
                                                       userAccount,            // �Q���҂̃��[�U�[�A�J�E���g
                                                       facilityCode,           // �{�݃R�[�h
                                                       registrant);             // �X�V��
                System.out.println(modevent);
            }catch (Exception e){
                //e.printStackTrace();
                System.out.println(e.toString());
            }
            System.out.println("�A�X�Vfinish--------------------------------------");         
 
            System.out.println("�B�폜start--------------------------------------");
            try {
                // Garoon�փX�P�W���[���o�^���𑗐M
                String deladdevent = cp.putScheduleAdd(Integer.parseInt(eventKind),// �\��敪
                                                    titleMenu,                  // �\��^�C�g�����j���[
                                                    title,                      // �\��^�C�g��
                                                    eventPrivate,               // ���J/����J
                                                    detail,                     // �\�胁��
                                                    sCal,                       // �J�n��
                                                    eCal,                       // �I����
                                                    stCal,                      // �J�n����
                                                    etCal,                      // �I������
                                                    deluserAccount,                // �Q���҂̃��[�U�[�A�J�E���g
                                                    facilityCode,               // �{�݃R�[�h
                                                    null);                // �o�^��
            	
                // Garoon�ɃX�P�W���[���폜���𑗐M(�ʏ�\��/�o�i�[�\��̂ݑΉ�)
                String delevent = cp.putScheduleDelete(Long.parseLong(deladdevent ),  // �C�x���gID
                                                       registrant);              // �X�V��
                System.out.println(delevent);
            }catch (Exception e){
                //e.printStackTrace();
                System.out.println(e.toString());
            }
            System.out.println("�B�폜finish--------------------------------------");  
           
            System.out.println("�C�t�H���[�o�^start--------------------------------------");
            try {
                // Garoon�փX�P�W���[���t�H���[�o�^���𑗐M
                followId = cp.putScheduleFollowAdd(faddid,       // �K���[���Q�̃C�x���gID
                	                                        data,                      // �t�H���[�̖{��
                	                                        registrant);               // �o�^��
                System.out.println(followId);
            }catch (Exception e){
                //e.printStackTrace();
                System.out.println(e.toString());
            }
            System.out.println("�C�t�H���[�o�^finish--------------------------------------");    
 
            System.out.println("�D�t�H���[�폜start--------------------------------------");
            try {
                // Garoon�փX�P�W���[���t�H���[�o�^���𑗐M
/*            	String deladdfollowId = null;
                deladdfollowId = cp.putScheduleFollowAdd(faddid,       // �K���[���Q�̃C�x���gID
                	                                        data,                      // �t�H���[�̖{��
                	                                        registrant);               // �o�^��
*/                if(followId == null){
                    // Garoon�ɃX�P�W���[���t�H���[�폜���𑗐M
                    String delfollowId = cp.putScheduleFollowDelete(Long.parseLong("1016"),  // �K���[���Q�̃X�P�W���[���t�H���[ID
                                                                   registrant);          // �폜��
                    System.out.println(delfollowId);
                    
                }else{
                    // Garoon�փX�P�W���[���t�H���[�o�^���𑗐M
                    String deladdfollowId = cp.putScheduleFollowAdd(faddid,       // �K���[���Q�̃C�x���gID
                    	                                        data,                      // �t�H���[�̖{��
                    	                                        registrant);               // �o�^��
                    // Garoon�ɃX�P�W���[���t�H���[�폜���𑗐M
                    String delfollowId = cp.putScheduleFollowDelete(Long.parseLong(deladdfollowId),  // �K���[���Q�̃X�P�W���[���t�H���[ID
                                                                   registrant);          // �폜��
                    System.out.println(delfollowId);
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
