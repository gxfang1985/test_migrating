import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Collection;
import jp.co.cybozu.garoon2.*;

public class CmdBulletinFollowAdd {
 
    /**
     * �K�C�_���X��\�����܂��B<BR>
     *
     */
    public static void usage() {
        System.err.println("Usage: java CmdBulletinFollowAdd [OPTIONS]");
        System.err.println();
        System.err.println("OPTIONS:");
        System.err.println("       -h                 Display this help,then exit.");
        System.err.println("       -o   URL           The url of the garoon administration system.");
        System.err.println("       -u   USER          The user account to login garoon.");
        System.err.println("       -p   PASSWORD      The password of the user.");
        System.err.println("       -id  ARTICLEID     The article id that you want to add the follow.");
        System.err.println("       -r   REGISTRANT    I appoint the user account which I registered an follow of bulletin board with.");
        System.err.println("                          It is not necessary for a case same as a login user to input it.");
        System.err.println("       -d   DATA          The text of bulletin follow.");
        System.err.println("       -f   ATTACHEDFILES The attached files.");
        System.err.println("                          Please apply the option at each [ATTACHEDFILES] when you specify the plural.");
        System.err.println("                          (ex.  -f /var/tmp/test1.txt -f /var/tmp/text2.txt)");
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
        
        String fid = null;                            // �o�^�ł����f���t�H���[��ID
        String url = null;                            // Garoon��URL
        String user = null;                           // ���O�C�����[�U�[�A�J�E���g
        String password = null;                       // ���O�C���p�X���[�h
        String aid = null;                            // �L��ID
        String registrant = null;                     // �t�H���[�o�^��(���s���[�U�[)
        String data = null;                           // �{��
        Collection attachedFiles = new ArrayList();   // �Y�t�t�@�C��
       
        for ( int i = 0; i < args.length; i++ ) {
            if ( args[i].equals("-h") ) {
                usage();
                return;
            }
            else if ( args[i].equals("-o") ) {        // Garoon��URL
                if ( i == (args.length - 1) ) {
                    System.err.println("missing URL after -o.");
                    System.err.println();
                    usage();
                    return;
                }
                url =args[++i];
            }
            else if ( args[i].equals("-u") ) {        // ���O�C�����[�U�[�A�J�E���g
                if ( i == (args.length - 1) ) {
                    System.err.println("missing user name after -u.");
                    System.err.println();
                    usage();
                    return;
                }
                user = args[++i];
            }
            else if ( args[i].equals("-p") ) {        // ���O�C���p�X���[�h
                if ( i == (args.length - 1) ) {
                    System.err.println("missing password after -p.");
                    System.err.println();
                    usage();
                    return;
                }
                password = args[++i];
            }
            else if ( args[i].equals("-r") ) {        // �o�^��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing registrant user after -r.");
                    System.err.println();
                    usage();
                    return;
                }
                registrant = args[++i];
            }
            else if ( args[i].equals("-id") ) {       // �L��ID
                if ( i == (args.length - 1) ) {
                    System.err.println("missing article id after -id.");
                    System.err.println();
                    usage();
                    return;
                }
                aid = args[++i];
            }      
            else if ( args[i].equals("-d") ) {        // �{��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing text after -d.");
                    System.err.println();
                    usage();
                    return;
                }
                data = args[++i];
            }      
            else if ( args[i].equals("-f") ) {        // �Y�t�t�@�C��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing The attached file after -f.");
                    System.err.println();
                    usage();
                    return;
                }
                attachedFiles.add(args[++i]);
            }
            else {
                System.err.println("warning: unknown option " + args[i]);
                System.err.println();
                usage();
                return;
            }
        }

        BufferedReader in = new BufferedReader( new InputStreamReader(System.in));
        CoopLink bulletinLink = null;
        try 
        {

            String inp = null;
      
            if ( url == null ) {       // Garoon��URL
                do {
                    System.err.print("URL: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                         url =inp;
                    }
                } while(url.length() == 0);
            }

            if ( user == null ) {       // ���O�C�����[�U�[�A�J�E���g
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
      
            if ( aid == null ) {       // �L��ID
                do {
                    System.err.print("Article ID: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        aid = inp;
                    }
                } while(aid == null);
            }

            // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
            bulletinLink = new CoopLink(url,user,password); 

            // Garoon�Ƀt�H���[���𑗐M
            fid = bulletinLink.putBulletinFollowAdd(Long.parseLong(aid),// �f����ID
                                                    data,               // �{��
                                                    attachedFiles,      // �Y�t�t�@�C��
                                                    registrant);        // �o�^��


        }
        catch ( RemoteException e ) {                         //�K���[����̃G���[
            System.err.println(e.toString());
        } 
        catch ( IOException e ) {                             // ���̑��ʐM��̃G���[
            System.err.println(e.toString());
        }
        catch ( IllegalArgumentException e ) {                // �����G���[ 
            System.err.println(e.toString());
        }
        catch ( NullPointerException e ) {
            System.err.println(e.toString());
        }
        finally
        {
            bulletinLink.logout();                            // �K���[���̃��O�A�E�g
            
            if(fid!=null)
            System.out.println(fid);                          // �߂�l�\��
    
        }
     
    }
}