import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import jp.co.cybozu.garoon2.*;

public class CmdScheduleAdd {

   /**
    * �K�C�_���X��\�����܂��B<BR>
    *
    */
    public static void usage() {
        System.err.println("Usage: java CmdScheduleAdd [OPTIONS]");
        System.err.println();
        System.err.println("OPTIONS:");
        System.err.println("       -h                 Display this help,then exit.");
        System.err.println("       -o   URL           The url of the garoon administration system.");
        System.err.println("       -u   USER          The user account to login garoon.");
        System.err.println("       -p   PASSWORD      The password of the user.");
        System.err.println("       -r   REGISTRANT    I appoint the user account which I registered an schedule with.");
        System.err.println("                          It is not necessary for a case same as a login user to input it.");
        System.err.println("       -k   KIND          The schedule classification.");
        System.err.println("                           0:Usually schedule.");
        System.err.println("                           1:Banner schedule.");
        System.err.println("       -sd  STARTDATE     The start date of schedule.(Format:yyyy-mm-dd)");
        System.err.println("       -ed  ENDDATE       The end date of schedule.(Format:yyyy-mm-dd)");
        System.err.println("       -st  STARTTIME     The start time of schedule.(Format hh:mm)");
        System.err.println("       -et  ENDTIME       The end time of schedule.(Format hh:mm)");
        System.err.println("       -tm  TITLEMENU     The titlemenu of schedule.");
        System.err.println("       -t   TITLE         The title of schedule.");
        System.err.println("       -a   ACCOUNTS      The participant's user account.");
        System.err.println("                          Please apply the option at each [ACCOUNTS] when you specify the plural.");
        System.err.println("                          (ex.  -a user1 -a user2)");
        System.err.println("       -fc  FACILITYCODES The participant's facility code.");
        System.err.println("                          Please apply the option at each [FACILITYCODES] when you specify the plural.");
        System.err.println("                          (ex.  -fc roomA -fc roomB)");
        System.err.println("       -pr                when you don't open this schedule to the public,specify this.");
        System.err.println("       -m   MEMO          The memo of schedule.");
    }
 
   /**
    * ���C������<BR>
    * @param args
    */
    public static void main(String[] args) 
    {
        if ( args.length == 0 ) {
            System.err.println("too few arguments.");
            System.err.println();
            usage();
            return;
        }
     
        String event = null;                        // �C�x���gID(�߂�l)
        String url = null;                          // Garoon��
        String user = null;                         // ���O�C�����[�U�[�A�J�E���g
        String password = null;                     // ���O�C���p�X���[�h
        String registrant = null;                   // �o�^��     
        String eventKind = "0";                     // �\��敪
        String titleMenu = null;                    // �\�胁�j���[
        String title = null;                        // �\��^�C�g��
        String eventPrivate = "0";                  // ���J/����J
        String detail = null;                       // �\�胁��  
    
        String sDate = null;                        // �\��J�n��
        String eDate = null;                        // �\��I����
        String sTime = null;                        // �\��J�n����
        String eTime = null;                        // �\��I������

        Collection userAccount = new ArrayList();   // �Q���҂̃��[�U�[�A�J�E���g
        Collection facilityCode = new ArrayList();  // �{�݃R�[�h

        for ( int i = 0; i < args.length; i++ ) {
            if ( args[i].equals("-h") ) {
                usage();
                return;
            }
            else if ( args[i].equals("-o") ) {      // URL
                if ( i == (args.length - 1) ) {
                    System.err.println("missing URL after -o.");
                    System.err.println();
                    usage();
                    return;
                }
                url =args[++i];
            }
            else if ( args[i].equals("-u") ) {      // ���O�C�����[�U�[�A�J�E���g
                if ( i == (args.length - 1) ) {
                    System.err.println("missing user name after -u.");
                    System.err.println();
                    usage();
                    return;
                }
                user = args[++i];
            }
            else if ( args[i].equals("-p") ) {      // ���O�C���p�X���[�h
                if ( i == (args.length - 1) ) {
                    System.err.println("missing password after -p.");
                    System.err.println();
                    usage();
                    return;
                }
                password = args[++i];
            }
            else if ( args[i].equals("-r") ) {      // �o�^��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing registrant user after -r.");
                    System.err.println();
                    usage();
                    return;
                }
                registrant = args[++i];
            } 
            else if ( args[i].equals("-k") ) {      // �\��敪
                if ( i == (args.length - 1) ) {
                    System.err.println("missing kind after -k.");
                    System.err.println();
                    usage();
                    return;
                }
                eventKind = args[++i];
            }

            else if ( args[i].equals("-tm") ) {     // �\��^�C�g�����j���[
                if ( i == (args.length - 1) ) {
                    System.err.println("missing title menu after -tm.");
                    System.err.println();
                    usage();
                    return;
                }
                titleMenu = args[++i];
            }
            else if ( args[i].equals("-t") ) {      // �\��^�C�g��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing event title after -t.");
                    System.err.println();
                    usage();
                    return;
                }
                title = args[++i];
            }
            else if ( args[i].equals("-pr") ) {     // ���J/����J

                eventPrivate = "1";       
            }
            else if ( args[i].equals("-m") ) {      // �\�胁��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing memo after -m.");
                    System.err.println();
                    usage();
                    return;
                }
                detail = args[++i];
            }
            else if ( args[i].equals("-a") ) {      // �Q���҂̃��[�U�[�A�J�E���g
                if ( i == (args.length - 1) ) {
                    System.err.println("missing account after -a.");
                    System.err.println();
                    usage();
                    return;
                }
                userAccount.add(args[++i]);
            }
            else if ( args[i].equals("-sd") ) {     // �\��J�n��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing start date after -sd.");
                    System.err.println();
                    usage();
                    return;
                }
                sDate = args[++i];
            }
            else if ( args[i].equals("-st") ) {     // �\��J�n����
                if ( i == (args.length - 1) ) {
                    System.err.println("missing start time after -st.");
                    System.err.println();
                    usage();
                    return;
                }
                sTime = args[++i];
            }
            else if ( args[i].equals("-ed") ) {     // �\��I����
                if ( i == (args.length - 1) ) {
                    System.err.println("missing end date after -ed.");
                    System.err.println();
                    usage();
                    return;
                }
                eDate = args[++i];
            }
            else if ( args[i].equals("-et") ) {     // �\��I������
                if ( i == (args.length - 1) ) {
                    System.err.println("missing end time after -et.");
                    System.err.println();
                    usage();
                    return;
                }
                eTime = args[++i];
            }
            else if ( args[i].equals("-fc") ) {     // �{�݃R�[�h
                if ( i == (args.length - 1) ) {
                    System.err.println("missing facility code after -fc.");
                    System.err.println();
                    usage();
                    return;
                }
                facilityCode.add(args[++i]);
            }    
            else {
                System.err.println("warning: unknown option " + args[i]);
                usage(); 
                return; 
            }
        }

        BufferedReader in = new BufferedReader( new InputStreamReader(System.in));
        CoopLink scheduleLink = null;
  
        try {
            String inp = null;
            if ( userAccount.isEmpty() ) {       // �Q���҂̃��[�U�[�A�J�E���g
                System.err.println("[-a ACCOUNTS] is indispensable option.");
                usage();
                return;
            }

            if ( url == null ) {        // Garoon��URL
                do {
                    System.err.print("URL: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        url = inp;
                    }
                } while(url.length() == 0);
            }

            if ( user == null ) {        // ���O�C�����[�U�[�A�J�E���g
                do {
                    System.err.print("User: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        user = inp;
                    }
                } while(user == null);
            }

            if ( password == null ) {    // ���O�C���p�X���[�h
                do {
                    System.err.print("Password: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        password = inp;
                    }
                } while(password == null);
            }

            if ( eventKind == null ) {   // �\��敪
                do {
                    System.err.print("Event kind: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        eventKind = inp;
                    }
                } while(eventKind == null);
            }
            
            if ( !"0".equals(eventKind) &&  !"1".equals(eventKind) ) {       // �\��敪(0 or 1)
                do {
                    System.err.print("-k "+eventKind+ " is wrong value.");
                    System.err.println("Please input it again.( 0 or 1)");
                    System.err.print("Event kind : ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        eventKind = inp;
                    }
                } while(!"0".equals(eventKind) &&  !"1".equals(eventKind));
            }
            
            
            if ( sDate == null ) {               // �\��J�n��
                do {
                    System.err.print("Set date: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        sDate = inp;
                    }
                } while(sDate == null);
            }

            if ( eDate == null ) {               // �\��I����
                do {
                    System.err.print("End date: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        eDate = inp;
                    }
                } while(eDate == null);
            }
      
           
      
            // ���M�O�̉����� 
            Calendar sCal = null;          
            Calendar eCal = null;          
            Calendar stCal = null;         
            Calendar etCal = null;  
            SimpleDateFormat sdf = new SimpleDateFormat();
            sdf.setLenient( false );   
      
            sdf.applyPattern( "yyyy-MM-dd" );
            if (sDate != null){         // �J�n��
                sCal = Calendar.getInstance();
                sCal.clear();
                sCal.setTime(sdf.parse(sDate));
            }
   
            if (eDate != null){         // �I����
                eCal = Calendar.getInstance();
                eCal.clear();
                eCal.setTime(sdf.parse(eDate));
            }
    
            sdf.applyPattern( "H:mm" );
            if(sTime !=null){         // �J�n����
                stCal = Calendar.getInstance();
                stCal.clear();
                stCal.setTime(sdf.parse(sTime));
            }
   
            if(eTime !=null){         // �I������
                etCal = Calendar.getInstance();
                etCal.clear();
                etCal.setTime(sdf.parse(eTime));
            }

            // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
            scheduleLink = new CoopLink( url,user,password );

          
            // Garoon�փX�P�W���[���o�^���𑗐M
            event = scheduleLink.putScheduleAdd(Integer.parseInt(eventKind),// �\��敪
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

        }catch ( ParseException e){
            System.err.println(e.toString());        
        }
        catch ( RemoteException e ) {            //�K���[����̃G���[
            System.err.println(e.toString());
        } 
        catch ( IOException e ) {                // ���̑��ʐM��̃G���[
            System.err.println(e.toString());
        }
        catch ( IllegalArgumentException e ) {    // �����G���[ 
            System.err.println(e.toString());
        }
        catch ( NullPointerException e ) {
            System.err.println(e.toString());
        }
        finally
        {
            scheduleLink.logout();   // �K���[���̃��O�A�E�g
            
            if(event!=null)
            System.out.println(event); // �߂�l�\��
    
        }
    }
    
  
    
}
