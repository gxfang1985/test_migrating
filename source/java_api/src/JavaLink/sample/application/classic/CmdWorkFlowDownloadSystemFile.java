import java.io.IOException;

import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.RemoteException;

public class CmdWorkFlowDownloadSystemFile {
    
    
    /**
     * �K�C�_���X��\�����܂��B<BR>
     *
     */
    private static void usage ()
    {
        System.err.println("Usage: java CmdWorkFlowDownloadSystemFile [OPTIONS]");
        System.err.println("");
        System.err.println("OPTIONS:");
        System.err.println("       -h                   Display this help,then exit.");
        System.err.println("       -o   URL             The url of the garoon administration system.");
        System.err.println("       -u   USER            The user account to login garoon.");
        System.err.println("       -p   PASSWORD        The password of the user.");
        System.err.println("       -id  ATTACHEDFILEID  The attached file id that you want to download.");
        System.err.println("       -d   DIRECTORYPATH   The saved directory of attached file.");
        System.err.println("       -f   FILENAME        The name of attached file.");
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

        String url = null;                           // Garoon��URL
        String user = null;                          // ���[�U�[�A�J�E���g��
        String password = null;                      // �p�X���[�h
        String afid = null;                          // ���[�N�t���[�̓Y�t�t�@�C��ID
        String dirPath = null;                       // �f�B���N�g���p�X
        String fileName = null;                      // �Y�t�t�@�C����
        
        CoopLink workflowLink = null;                 // CoopLink����p

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
            else if ( args[i].equals("-id") ) {                // ���[�N�t���[�̓Y�t�t�@�C��ID
                if ( i == (args.length - 1) ) {
                    System.err.println("missing attached file id after -id.");
                    System.err.println();
                    usage();
                    return;
                }
                afid = args[++i];
            }
            else if ( args[i].equals("-d") ) {                // �f�B���N�g���p�X
                if ( i == (args.length - 1) ) {
                    System.err.println("missing directory path after -d.");
                    System.err.println();
                    usage();
                    return;
                }
                dirPath = args[++i];
            } 
            else if ( args[i].equals("-f") ) {                // �Y�t�t�@�C����
                if ( i == (args.length - 1) ) {
                    System.err.println("missing attached file name after -f.");
                    System.err.println();
                    usage();
                    return;
                }
                fileName = args[++i];
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
        if (afid == null ) {                 // ���[�N�t���[�̓Y�t�t�@�C��ID�̎w��
            System.err.println("[-id ATTACHEDFILEID] is indispensable option.");
            usage();
            return;
        }

        try{
            // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
            workflowLink = new CoopLink( url, user, password );
            
            // Garoon�փf�[�^���M
            if(fileName == null){
                // �K���[���Q ���[�N�t���[��̓Y�t�t�@�C�����ŕۑ�����ꍇ
                workflowLink.downloadSystemWorkFlowAttachedFile( Long.parseLong(afid),     // ���[�N�t���[�̓Y�t�t�@�C��ID      
                                                                 dirPath );               // �f�B���N�g���p�X
            }else{                         
                // �t�@�C������ʖ��ŕۑ�����ꍇ
                workflowLink.downloadSystemWorkFlowAttachedFile( Long.parseLong(afid),     // ���[�N�t���[�̓Y�t�t�@�C��ID
                                                                 dirPath,                 // �f�B���N�g���p�X
                                                                 fileName );              // �Y�t�t�@�C����
            }
            
            // dirPath �� null �̏ꍇ�A�J�����g�f�B���N�g���ɏ����o��
            if ( dirPath == null )
            {
                dirPath = "./";
            }
            System.out.println("The download of the file was executed.(" + dirPath + ")");
        }
        catch ( RemoteException e ) {                        //�K���[����̃G���[
            System.err.println(e.toString());
        }
        catch ( IOException e ) {                            // ���̑��ʐM��̃G���[
            System.err.println(e.toString());
        }
        catch (NumberFormatException e ) {                   // ���̑��G���[
            System.err.println(e.toString());
        }
        
        finally {
            workflowLink.logout();

        }
    }
}
