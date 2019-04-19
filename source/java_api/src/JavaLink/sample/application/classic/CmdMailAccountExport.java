import java.io.IOException;
import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.RemoteException;

public class CmdMailAccountExport
{
    /**
     * �K�C�_���X��\�����܂��B<BR>
     *
     */
    private static void usage ()
    {
        System.err.println("Usage: java CmdMailAccountExport [OPTIONS]");
        System.err.println("");
        System.err.println("OPTIONS:");
        System.err.println("       -h                  Display this help,then exit.");
        System.err.println("       -o    URL           The url of the garoon administration system.");
        System.err.println("       -u    USER          The user account to login garoon.");
        System.err.println("       -p    PASSWORD      The password of the user.");
        System.err.println("       -f    FILE          The csv file to write.");
        System.err.println("       -utf8               The character-code of the file is utf8.");
        System.err.println("       -he                 There is the header.");
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
        String filePath = null;                             // CSV�t�@�C���p�X
        boolean sjisEncoding = true;                       // �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
        boolean skip = false;                              // �擪�s�̗L��(true:�L false:��)
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
            else if ( args[i].equals("-f") ) {                // CSV�t�@�C���p�X

                if ( i == (args.length - 1) ) {
                    System.err.println("missing csv file after -f.");
                    System.err.println();
                    usage();
                    return;
                }
                filePath = args[++i];
            }
            else if ( args[i].equals("-utf8") ) {              // �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)

                sjisEncoding = false;
            }
            else if ( args[i].equals("-he") ) {                // �擪�s�̗L��(true:�L false:��)

                skip = true;
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
        if ( filePath == null ) {            // CSV�t�@�C���p�X
            System.err.println("[-f FILE] is indispensable option.");
            usage();
            return;
        }
        
        try {
            // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
            grnLink = new CoopLink( url, user, password );

            // Garoon�փf�[�^���M
            grnLink.exportMailAccount( filePath,                // CSV�t�@�C���p�X
                                       skip,                    // �擪�s�̗L��(true:�L false:��)
                                       sjisEncoding);           // �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
            
            System.out.println("The export of the csv file was executed.(" + filePath + ")");
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
        finally {
            grnLink.logout();
        }
    }
}