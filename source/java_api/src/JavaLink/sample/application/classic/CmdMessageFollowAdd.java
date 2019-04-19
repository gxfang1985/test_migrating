import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Collection;
import jp.co.cybozu.garoon2.*;

public class CmdMessageFollowAdd {
 
   /**
    * �K�C�_���X��\�����܂��B<BR>
    *
    */
    public static void usage() {
        System.err.println("Usage: java CmdMessageFollowAdd [OPTIONS]");
        System.err.println();
        System.err.println("OPTIONS:");
        System.err.println("       -h                 Display this help,then exit.");
        System.err.println("       -o   URL           The url of the garoon administration system.");
        System.err.println("       -u   USER          The user account to login garoon.");
        System.err.println("       -p   PASSWORD      The password of the user.");
        System.err.println("       -id  MESSAGEID     The message id that you want to add the follow.");
        System.err.println("       -r   REGISTRANT    I appoint the user account which I registered an follow of message with.");
        System.err.println("                          It is not necessary for a case same as a login user to input it.");
        System.err.println("       -d   DATA          The text of message follow.");
        System.err.println("       -f   ATTACHEDFILES The attached files.");
        System.err.println("                          Please apply the option at each [ATTACHEDFILES] when you specify the plural.");
        System.err.println("                          (ex.  -f \"/var/tmp/test1.txt\" -f \"/var/tmp/text2.txt\")");
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
        String mid = null;                          // ���b�Z�[�WID
        String registrant = null;                   // ���o�l
        String data = null;                         // �{��
        Collection attachedFiles = new ArrayList(); // �Y�t�t�@�C��
        String mfid = null;                         // �t�H���[ID (�߂�l)
   
        for ( int i = 0; i < args.length; i++ ) {
            if ( args[i].equals("-h") ) {
                usage();
                return;
            }
            else if ( args[i].equals("-o") ) {    // Garoon��URL
                if ( i == (args.length - 1) ) {
                    System.err.println("missing URL after -o.");
                    System.err.println();
                    usage();
                    return;
                }
                url = args[++i];
            }
            else if ( args[i].equals("-u") ) {    // ���O�C�����[�U�[�A�J�E���g
                if ( i == (args.length - 1) ) {
                    System.err.println("missing user name after -u.");
                    System.err.println();
                    usage();
                    return;
                }
                user = args[++i];
            }
            else if ( args[i].equals("-p") ) {    // ���O�C���p�X���[�h
                if ( i == (args.length - 1) ) {
                    System.err.println("missing password after -p.");
                    System.err.println();
                    usage();
                    return;
                }
                password = args[++i];
            }
            else if ( args[i].equals("-r") ) {    // ���o�l
                if ( i == (args.length - 1) ) {
                    System.err.println("missing registrant after -r.");
                    System.err.println();
                    usage();
                    return;
                }
                registrant = args[++i];
            }
            else if ( args[i].equals("-id") ) {   // �Г����[��ID
                if ( i == (args.length - 1) ) {
                    System.err.println("missing message id after -id.");
                    System.err.println();
                    usage();
                    return;
                }
                mid = args[++i];
            }
            else if ( args[i].equals("-d") ) {    // �{��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing text after -d.");
                    System.err.println();
                    usage();
                    return;
                }
                data = args[++i];
            }      
            else if ( args[i].equals("-f") ) {    // �Y�t�t�@�C��
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
                usage();
                return;
            }
        }

        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
        CoopLink messageLink = null;
        try 
        {

            String inp = null;
      
            if ( url == null ) {                  // Garoon��URL
                do {
                    System.err.print("URL: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        url=inp;
                    }
                } while(url.length() == 0);
            }

            if ( user == null ) {                 // ���O�C�����[�U�[�A�J�E���g
                do {
                    System.err.print("User: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        user = inp;
                    }
                } while(user == null);
            }

            if ( password == null ) {             // ���O�C���p�X���[�h
                do {
                    System.err.print("Password: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        password = inp;
                    }
                } while(password == null);
            }
      
            if ( mid == null ) {                  // ���b�Z�[�WID
                do {
                    System.err.print("MESSAGE ID: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        mid = inp;
                    }
                } while(mid == null);
            }

            // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
            messageLink = new CoopLink(url,user,password);


            // Garoon�Ƀt�H���[���𑗐M
            mfid = messageLink.putMessageFollowAdd(Long.parseLong(mid),// �Г����[��ID
                                                    data,              // �{��
                                                    attachedFiles,     // �Y�t�t�@�C��
                                                    registrant);       // ���o�l    

      
        }
        catch ( RemoteException e ) {                                 //�K���[����̃G���[
            System.err.println(e.toString());
        } 
        catch ( IOException e ) {                                     // ���̑��ʐM��̃G���[
            System.err.println(e.toString());
        }
        catch ( IllegalArgumentException e ) {                        // �����G���[ 
            System.err.println(e.toString());
        }
        catch ( NullPointerException e ) {
            System.err.println(e.toString());
        }        
        finally
        {
            messageLink.logout();   // �K���[���̃��O�A�E�g
            
            if(mfid!=null)
            System.out.println(mfid); // �߂�l�\��
    
        } 
    }
}