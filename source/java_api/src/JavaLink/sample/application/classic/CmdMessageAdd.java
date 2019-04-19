import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Collection;
import jp.co.cybozu.garoon2.*;

public class CmdMessageAdd {

    /**
    * �K�C�_���X��\�����܂��B<BR>
    * 
    */
    public static void usage() {
        System.err.println("Usage: java CmdMessageAdd [OPTIONS]");
        System.err.println();
        System.err.println("OPTIONS:");
        System.err.println("       -h                 Display this help,then exit.");
        System.err.println("       -o   URL           The url of the garoon administration system.");
        System.err.println("       -u   USER          The user account to login garoon.");
        System.err.println("       -p   PASSWORD      The password of the user.");
        System.err.println("       -r   REGISTRANT    I appoint the user account which I registered an message with.");
        System.err.println("                          It is not necessary for a case same as a login user to input it.");
        System.err.println("       -t   TITLE         The title of message.");
        System.err.println("       -d   DATA          The text of message.");
        System.err.println("       -f   ATTACHEDFILES The attached files. ");
        System.err.println("                          Please apply the option at each [ATTACHEDFILES] when you specify the plural.");
        System.err.println("                          (ex.  -f \"/var/tmp/test1.txt\" -f \"/var/tmp/text2.txt\")");
        System.err.println("       -a   ACCOUNTS      The accounts of message address.");
        System.err.println("                          Please apply the option at each [ACCOUNTS] when you specify the plural.");
        System.err.println("                          (ex.  -a user1 -a user2)");
        System.err.println("       -op  OPERATORS     The accounts of message operators.");
        System.err.println("                          Please apply the option at each [OPERATORS] when you specify the plural.");
        System.err.println("                          (ex.  -op user1 -op user2)");
        System.err.println("       -c                 You specify this,when you want to check \"Who already read message?\".");
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
     
        String url = null;                           // Garoon��URL
        String user = null;                          // ���O�C�����[�U�[�A�J�E���g
        String password = null;                      // ���O�C���p�X���[�h
        String registrant = null;                    // ���o�l
        
        String title = null;                         // �W��
        String data = null;                          // �{��

        Collection accounts = new ArrayList();       // ����
        Collection operators = new ArrayList();      // ����(����ύX�̋��L��)
        Collection attachedFiles = new ArrayList();  // �Y�t�t�@�C��
     
        boolean confirm = false;                    // �{����
        
        String mid = null;                           // �Г����[��ID(�߂�l)

    
        for ( int i = 0; i < args.length; i++ ) {
            if ( args[i].equals("-h") ) {
                usage();
                return;
            }
            else if ( args[i].equals("-o") ) {   // Garoon��URL
                if ( i == (args.length - 1) ) {
                    System.err.println("missing URL after -o.");
                    System.err.println();
                    usage();
                    return;
                }
                url =args[++i];
            }
            else if ( args[i].equals("-u") ) {   // ���O�C�����[�U�[�A�J�E���g
                if ( i == (args.length - 1) ) {
                    System.err.println("missing user name after -u.");
                    System.err.println();
                    usage();
                    return;
                }
                user = args[++i];
            }
            else if ( args[i].equals("-p") ) {   // ���O�C���p�X���[�h
                if ( i == (args.length - 1) ) {
                    System.err.println("missing password after -p.");
                    System.err.println();
                    usage();
                    return;
                }
                password = args[++i];
            }
            else if ( args[i].equals("-r") ) {   // ���o�l
                if ( i == (args.length - 1) ) {
                    System.err.println("missing registrant after -r.");
                    System.err.println();
                    usage();
                    return;
                }
                registrant = args[++i];
            }
            else if ( args[i].equals("-t") ) {   // �W��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing title after -t.");
                    System.err.println();
                    usage();
                    return;
                }
                title = args[++i];
            }
            else if ( args[i].equals("-d") ) {   // �{��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing text after -d.");
                    System.err.println();
                    usage();
                    return;
                }
                data = args[++i];
            }
            else if ( args[i].equals("-a") ) {   // ����
                if ( i == (args.length - 1) ) {
                    System.err.println("missing receivers after -a.");
                    System.err.println();
                    usage();
                    return;
                }
                accounts.add(args[++i]);
            }
            else if ( args[i].equals("-op") ) {   // ����ύX��������������
                if ( i == (args.length - 1) ) {
                    System.err.println("missing receivers after -op.");
                    System.err.println();
                    usage();
                    return;
                }
                operators.add(args[++i]);
            }
            else if ( args[i].equals("-f") ) {   // �Y�t�t�@�C��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing attached file after -f.");
                    System.err.println();
                    usage();
                    return;
                }
                attachedFiles.add(args[++i]);
            }
            else if ( args[i].equals("-c") ) {   // �{����

                confirm = true;
            }
            else {
                System.err.println("warning: unknown option " + args[i]);
                System.err.println();
                usage(); 
                return; 
            }
        }

        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
        
        CoopLink messageLink = null;
        try 
        {
            String inp = null;
            
            if ( accounts.isEmpty() && operators.isEmpty() ) {          // ����
                System.err.println("Neither [-a ACCOUNTS] nor [-op OPERATORS] is entered.");
                usage();
                return;
            }
      
            if ( url == null ) {                 // Garoon��URL
                do {
                    System.err.print("URL: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        url =inp;
                    }
                } while(url.length() == 0);
            }

            if ( user == null ) {                // ���O�C�����[�U�[�A�J�E���g
                do {
                    System.err.print("User: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        user = inp;
                    }
                } while(user == null);
            }
                
            if ( password == null ) {            // ���O�C���p�X���[�h
                do {
                    System.err.print("Password: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                       password = inp;
                    }
                } while(password == null);
            }
      
            if ( title == null ) {               // �W��
                do {
                    System.err.print("Title: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        title = inp;
                    }
                } while(title == null);
            }
      
            
            //  Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
            messageLink = new CoopLink(url,user, password);

            // Garoon�ɎГ����[�����𑗐M
            mid =messageLink.putMessageAdd(title,           // �W�� 
                                           data,            // �{��
                                           confirm,         // �{����
                                           accounts,        // ����
                                           operators,       // ����ύX���̗L�鈶��
                                           attachedFiles,   // �Y�t�t�@�C��
                                           registrant);     // ���o�l      

        }
        catch ( RemoteException e ) {            //�K���[����̃G���[
            System.err.println(e.toString());
        } 
        catch ( IOException e ) {                // ���̑��ʐM��̃G���[
            System.err.println(e.toString());
        }
        catch ( IllegalArgumentException e ) {   // �����G���[ 
            System.err.println(e.toString());
        }
        catch ( NullPointerException e ) {
            System.err.println(e.toString());
        }        
        finally
        {
            messageLink.logout();   // �K���[���̃��O�A�E�g
            
            if(mid!=null)
            System.out.println(mid); // �߂�l�\��
        }      
    }
}
