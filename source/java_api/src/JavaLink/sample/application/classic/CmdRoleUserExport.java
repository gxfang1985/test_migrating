import java.io.*;
import jp.co.cybozu.garoon2.*;

public class CmdRoleUserExport
{
    /**
     * �K�C�_���X��\�����܂��B<BR>
     *
     */
    private static void usage ()
    {
        System.err.println("Usage: java CmdRoleUserExport [OPTIONS]");
        System.err.println("");
        System.err.println("OPTIONS:");
        System.err.println("       -h                 Display this help,then exit.");
        System.err.println("       -o   URL           The url of the garoon administration system.");
        System.err.println("       -u   USER          The user account to login garoon administration system.");
        System.err.println("       -p   PASSWORD      The password of the user.");
        System.err.println("       -f   FILE          The csv file to write.");
        System.err.println("       -utf8              The character-code of the file is utf8.");
        System.err.println("                          When not specifying this.The character-code of the file is shift_jis.");
        System.err.println("       -he                There is the header.");
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

        String url = null;                                    // Garoon��URL
        String user = null;                                   // ���[�U�[�A�J�E���g��
        String password = null;                               // �p�X���[�h
        String filepath = null;                               // �t�@�C���p�X
        boolean sjisEncode = true;                           // �G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
        boolean skip = false;                                // �擪�s�̗L��
        CoopLink grnLink = null;

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
            else if ( args[i].equals("-f") ) {                // �t�@�C���p�X
                if ( i == (args.length - 1) ) {
                    System.err.println("missing csv file after -f.");
                    System.err.println("");
                    usage();
                    return;
                }
                filepath = args[++i];
            }
            else if ( args[i].equals("-he") ) {                // �擪�s�̗L��
                skip = true;
            }
            else if ( args[i].equals("-utf8") ) {            // �G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
                
                sjisEncode = false;
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
            
            if ( filepath == null ) {                        // �t�@�C���p�X
                do {
                    System.err.print("File: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        filepath = inp;
                    }
                } while(filepath == null);
            }

            // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
            grnLink = new CoopLink( url,user,password );

            // Garoon�փf�[�^���M
            grnLink.exportRoleUser( filepath,                // �t�@�C���p�X
                                    skip,                    // �擪�s�̗L��
                                    sjisEncode );            // �G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
            
            System.out.println("The download of the csv file was executed.(" + filepath + ")");
        }
        catch ( RemoteException e ) {
            System.err.println(e.toString());
        } 
        catch ( IOException e ) {
            System.err.println(e.toString());
        } 
        catch ( NullPointerException e ) {
            System.err.println(e.toString());
        }
        catch ( IllegalArgumentException e ) {
            System.err.println(e.toString());
        }
        finally {
            grnLink.logout();
        }
    }
}