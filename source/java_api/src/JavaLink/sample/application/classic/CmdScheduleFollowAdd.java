import java.io.IOException;

import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.RemoteException;


public class CmdScheduleFollowAdd {

   /**
    * �K�C�_���X��\�����܂��B<BR>
    *
    */
    public static void usage() {
        System.err.println("Usage: java CmdScheduleFollowAdd [OPTIONS]");
        System.err.println();
        System.err.println("OPTIONS:");
        System.err.println("       -h                 Display this help,then exit.");
        System.err.println("       -o   URL           The url of the garoon administration system.");
        System.err.println("       -u   USER          The user account to login garoon.");
        System.err.println("       -p   PASSWORD      The password of the user.");
        System.err.println("       -id  EVENTID       The event id that you want to add follow.");
        System.err.println("       -r   REGISTRANT    I appoint the user account which I registered follow of schedule with.");
        System.err.println("                          It is not necessary for a case same as a login user to input it.");
        System.err.println("       -d   DATA          The text of event follow.");
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
     
        String url = null;                          // Garoon��URL
        String user = null;                         // ���O�C�����[�U�[�A�J�E���g
        String password = null;                     // ���O�C���p�X���[�h
        String registrant = null;                   // �o�^��     
        String eid = null;                          // �C�x���gID
        String data = null;                         // �t�H���[�̖{��
        String followId =null;                      // �K���[���Q�̃X�P�W���[���t�H���[ID(�߂�l)
        CoopLink scheduleLink = null;               // CoopLink����p
        

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
            else if ( args[i].equals("-id") ) {      // �K���[���Q�̃X�P�W���[��ID
                if ( i == (args.length - 1) ) {
                    System.err.println("missing event ID after -id.");
                    System.err.println();
                    usage();
                    return;
                }
                eid = args[++i];
            }
            else if ( args[i].equals("-r") ) {      // �o�^��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing registrant after -r.");
                    System.err.println();
                    usage();
                    return;
                }
                registrant = args[++i];
            } 
            else if ( args[i].equals("-d") ) {      // �t�H���[�̖{��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing text after -d.");
                    System.err.println();
                    usage();
                    return;
                }
                data = args[++i];
            } 
            else {
                System.err.println("warning: unknown option " + args[i]);
                usage(); 
                return; 
            }
        }

        // �K�{�I�v�V�����`�F�b�N
        if ( url == null ) {                 // URL
            System.err.println("[-o URL] is indispensable option.");
            usage();
            return;
        }
        if ( user == null ) {                // ���O�C����
            System.err.println("[-u USER] is indispensable option.");
            usage();
            return;
        }
        if ( password == null ) {            // �p�X���[�h
            System.err.println("[-p PASSWORD] is indispensable option.");
            usage();
            return;
        }
        if ( eid == null ) {                 // �C�x���gID
            System.err.println("[-id EVENTID] is indispensable option.");
            usage();
            return;
        }
        if ( data == null ) {                 // �t�H���[�̖{��
            System.err.println("[-d DATA] is indispensable option.");
            usage();
            return;
        }
        
        try {
            // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
            scheduleLink = new CoopLink( url,user,password );
            
            // Garoon�փX�P�W���[���t�H���[�o�^���𑗐M
            followId = scheduleLink.putScheduleFollowAdd(Long.parseLong(eid),       // �K���[���Q�̃C�x���gID
            	                                        data,                      // �t�H���[�̖{��
            	                                        registrant);               // �o�^��
        }
        catch ( RemoteException e ) {            //�K���[����̃G���[
            System.err.println(e.toString());
        } 
        catch ( IOException e ) {                // ���̑��ʐM��̃G���[
            System.err.println(e.toString());
        }
        catch ( NullPointerException e ) {
            System.err.println(e.toString());
        }
        catch (NumberFormatException e ) {       // ���̑��G���[
            System.err.println(e.toString());
        }
        finally
        {
            scheduleLink.logout();   // �K���[���̃��O�A�E�g
            
            if(followId!=null)
            System.out.println(followId); // �߂�l�\��
    
        }
    }
}
