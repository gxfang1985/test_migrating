import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.RemoteException;

public class CmdMessageDelete {

    /**
     * �K�C�_���X��\�����܂��B<BR>
     * 
     */
    public static void usage() {
        System.err.println("Usage: java CmdMessageDelete [OPTIONS]");
        System.err.println();
        System.err.println("OPTIONS:");
        System.err.println("       -h                 Display this help,then exit.");
        System.err.println("       -o   URL           The url of the garoon administration system.");
        System.err.println("       -u   USER          The user account to login garoon.");
        System.err.println("       -p   PASSWORD      The password of the user.");
        System.err.println("       -id  MESSAGEID     The message id that you want to delete.");
        System.err.println("       -r   REGISTRANT    I appoint the user account which I registered an message with.");
        System.err.println("                          It is not necessary for a case same as a login user to input it.");
    }
    
    /**
     * ���C������<BR>
     * 
     * @param args
     */
    public static void main( String[] args )
    {
        if ( args.length == 0 )    {
            System.err.println("too few arguments.");
            System.err.println();
            usage();
            return;
        }

        String url = null;                                  // Garoon��URL
        String user = null;                                 // ���[�U�[�A�J�E���g��
        String password = null;                             // �p�X���[�h
        String mid = null;                                  // ���b�Z�[�WID
        String messageId = null;                            // ���b�Z�[�WID
        String registrant= null;                            // �o�^��
        CoopLink messageLink = null;
        
        for ( int i = 0; i < args.length; i++ )    {
            if ( args[i].equals("-h") ) {                    // Print this message and exit.
                usage();
                return;
            }
            else if ( args[i].equals("-o") ) {                // Garoon��URL
                if ( i == (args.length - 1) ) {
                    System.err.println("missing URL after -o.");
                    System.err.println();
                    usage();
                    return;
                }
                url = args[++i];
            }
            else if ( args[i].equals("-u") ) {                // ���[�U�[�A�J�E���g��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing user name after -u.");
                    System.err.println();
                    usage();
                    return;
                }
                user = args[++i];
            }
            else if ( args[i].equals("-p") ) {                // ���[�U�[�p�X���[�h
                if ( i == (args.length - 1) ) {
                    System.err.println("missing password after -p.");
                    System.err.println();
                    usage();
                    return;
                }
                password = args[++i];
            }
            else if ( args[i].equals("-id") ) {                // ���b�Z�[�WID
                if ( i == (args.length - 1) ) {
                    System.err.println("missing message id after -id.");
                    System.err.println();
                    usage();
                    return;
                }
                mid = args[++i];
            }
            else if ( args[i].equals("-r") ) {                // �o�^��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing registrant after -r.");
                    System.err.println();
                    usage();
                    return;
                }
                registrant = args[++i];
            }
            else {
                System.err.println("warning: unknown option " + args[i]);
                usage(); 
                return; 
            }
        }

        BufferedReader in = new BufferedReader(
                new InputStreamReader(System.in));

        try {
            String inp = null;
            
            if ( url == null ) {                            // Garoon��URL
                do {
                    System.err.print("URL: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        url = inp;
                    }
                } while( url == null );
            }

            if ( user == null ) {                            // ���[�U�[�A�J�E���g��
                do {
                    System.err.print("User: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        user = inp;
                    }
                } while( user == null );
            }

            if ( password == null ) {                        // �p�X���[�h
                System.err.print("Password: ");
                password = in.readLine();
            }

            if ( mid == null ) {                            // ���b�Z�[�WID
                do {
                    System.err.print("Message ID: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        mid = inp;
                    }
                } while( mid == null );
            }
       
            // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
            messageLink = new CoopLink( url,user, password );
            
            // Garoon�ɎГ����[���폜���𑗐M
            messageId = messageLink.putMessageDelete( Long.parseLong(mid),    // ���b�Z�[�WID
                                                      registrant );           // �o�^��
        }
        catch ( RemoteException e ) {           //�K���[����̃G���[
            System.err.println(e.toString());
        } 
        catch ( IOException e ) {               // ���̑��ʐM��̃G���[
            System.err.println(e.toString());
        } 
        catch ( NullPointerException e ) {
            System.err.println(e.toString());
        }
        catch ( NumberFormatException e ) {    
            System.err.println(e.toString());
        }
        catch ( IllegalArgumentException e ) {  // �����G���[
            System.err.println(e.toString());
        }
        finally {
            messageLink.logout();
            
            if ( messageId != null )                        // ���b�Z�[�WID
                System.out.println( messageId );            // �߂�l(���b�Z�[�WID)
        }
    }
}
