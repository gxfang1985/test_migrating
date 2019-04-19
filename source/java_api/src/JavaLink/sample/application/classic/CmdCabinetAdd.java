import java.io.*;
import jp.co.cybozu.garoon2.*;


public class CmdCabinetAdd
{
    /**
     * �K�C�_���X��\�����܂��B<BR>
     *
     */
    private static void usage ()
    {
        System.err.println("Usage: java CmdCabinetAdd [OPTIONS]");
        System.err.println("");
        System.err.println("OPTIONS:");
        System.err.println("       -h                 Display this help,then exit.");
        System.err.println("       -o   URL           The url of the garoon administration system.");
        System.err.println("       -u   USER          The user account to login garoon.");
        System.err.println("       -p   PASSWORD      The password of the user.");
        System.err.println("       -r   REGISTRANT    I appoint the user account which I registered an file with.");
        System.err.println("                          It is not necessary for a case same as a login user to input it.");
        System.err.println("       -fc  FOLDERCODE    The folder code of file management.");
        System.err.println("       -f   FILE          The file to upload.");
        System.err.println("       -t   TITLE         The title of file.");
        System.err.println("       -v   VERSION       The version of file.");
        System.err.println("       -m   MEMO          The memo of file.");
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
        String title = null;                                // �^�C�g��
        String folder = null;                               // �t�H���_�R�[�h
        String version = "0";                                // �o�[�W�����Ǘ�
        String memo = null;                                  // �t�@�C���̐���
        String registrant = null;                            // �o�^��
        File file = null;                                    // �t�@�C��
        String fileId = null;                                // �t�@�C��ID
        CoopLink cabinetLink = null;

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
            else if ( args[i].equals("-t") ) {                // �^�C�g��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing title after -t.");
                    System.err.println();
                    usage();
                    return;
                }
                title = args[++i];
            }
            else if ( args[i].equals("-fc") ) {                // �t�H���_�R�[�h
                if ( i == (args.length - 1) ) {
                    System.err.println("missing folder after -fo.");
                    System.err.println();
                    usage();
                    return;
                }
                folder = args[++i];
            }
            else if ( args[i].equals("-v") ) {                // �o�[�W�����Ǘ�
                if ( i == (args.length - 1) ) {
                    System.err.println("missing version after -v.");
                    System.err.println();
                    usage();
                    return;
                }
                
                version = args[++i];
            }
            else if ( args[i].equals("-m") ) {                // �t�@�C���̐���
                if ( i == (args.length - 1) ) {
                    System.err.println("missing explanation of a file after -m.");
                    System.err.println();
                    usage();
                    return;
                }
                memo = args[++i];
            }
            else if ( args[i].equals("-r") ) {                // �o�^��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing registrant of a file after -r.");
                    System.err.println();
                    usage();
                    return;
                }
                registrant = args[++i];
            }
            else if ( args[i].equals("-f") ) {                // �t�@�C��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing a file to add after -f.");
                    System.err.println("");
                    usage();
                    return;
                }
                file = new File(args[++i]);
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
                } while(url == null);
            }

            if ( user == null ) {                            // ���[�U�[�A�J�E���g��
                do {
                    System.err.print("User: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        user = inp;
                    }
                } while(user == null);
            }

            if ( password == null ) {                        // �p�X���[�h
                System.err.print("Password: ");
                password = in.readLine();
            }
            
            if ( folder == null ) {                          // �t�H���_�R�[�h
                do {
                    System.err.print("Folder: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        folder = inp;
                    }
                } while(folder == null);
            }
            
            if ( file == null ) {                            // �t�@�C���p�X
                do {
                    System.err.print("File: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        file = new File(inp);
                    }
                } while(file == null);
            }

            // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
            cabinetLink = new CoopLink( url, user, password );

            // Garoon�փf�[�^���M
            fileId = cabinetLink.putCabinetAdd( title,                     // �^�C�g��
                                                folder,                    // �t�H���_�R�[�h
                                                Long.parseLong(version),   // �o�[�W�����Ǘ�
                                                memo,                      // �t�@�C���̐���
                                                registrant,                // �o�^��
                                                file );                    // �t�@�C��
        }
        catch ( RemoteException e ) {           //�K���[����̃G���[
            System.err.println(e.toString());
        } 
        catch ( IOException e ) {               // ���̑��ʐM��̃G���[
            System.err.println(e.toString());
        }
        catch ( IllegalArgumentException e ) {  // �����G���[ 
            System.err.println(e.toString());
        } 
        catch ( NullPointerException e ) {
            System.err.println(e.toString());
        }
        finally {
            cabinetLink.logout();
            
            if ( fileId != null )                            // �t�@�C��ID
                System.out.println( fileId );                 // �߂�l(�t�@�C��ID)
        }
    }
}