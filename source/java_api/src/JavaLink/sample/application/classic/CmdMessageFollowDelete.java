import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import jp.co.cybozu.garoon2.*;


public class CmdMessageFollowDelete {

    /**
     * �K�C�_���X��\�����܂��B<BR>
     * 
     */
    public static void usage() {
        System.err.println("Usage: java CmdMessageFollowDelete [OPTIONS]");
        System.err.println();
        System.err.println("OPTIONS:");
        System.err.println("       -h                 Display this help,then exit.");
        System.err.println("       -o   URL           The url of the garoon administration system.");
        System.err.println("       -u   USER          The user account to login garoon.");
        System.err.println("       -p   PASSWORD      The password of the user.");
        System.err.println("       -id  FOLLOWID      The follow id that you want to delete.");
        System.err.println("       -r   REGISTRANT    I appoint the user account which I registered an follow of message with.");
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

        String url = null;                                   // Garoon��URL
        String user = null;                                  // ���[�U�[�A�J�E���g��
        String password = null;                              // �p�X���[�h
        String fid = null;                                   // �t�H���[ID
        String followId = null;                              // �t�H���[ID
        String registrant = null;                            // �o�^��

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
            else if ( args[i].equals("-id") ) {                // �t�H���[ID
                if ( i == (args.length - 1) ) {
                    System.err.println("missing follow id after -id.");
                    System.err.println();
                    usage();
                    return;
                }
                fid = args[++i];
            }
            else if ( args[i].equals("-r") ) {                // �X�V��
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

            if ( fid == null ) {                            // �t�H���[ID
                do {
                    System.err.print("Follow ID: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        fid = inp;
                    }
                } while( fid == null );
            }
       
            // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
            messageLink = new CoopLink( url,user,password );
            
            // Garoon�ɎГ����[���t�H���[�폜���𑗐M            
            followId = messageLink.putMessageFollowDelete( Long.parseLong(fid), // �t�H���[ID
                                                           registrant );        // �o�^��
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
            
            if ( followId != null )                            // �t�H���[ID
                System.out.println( followId );                // �߂�l(�t�H���[ID)
        }
    }
}
