import java.io.IOException;

import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.RemoteException;

public class CmdCabinetDelete {
    
    
    /**
     * �K�C�_���X��\�����܂��B<BR>
     *
     */
    private static void usage ()
    {
        System.err.println("Usage: java CmdCabinetDelete [OPTIONS]");
        System.err.println("");
        System.err.println("OPTIONS:");
        System.err.println("       -h               Display this help,then exit.");
        System.err.println("       -o   URL         The url of the garoon administration system.");
        System.err.println("       -u   USER        The user account to login garoon.");
        System.err.println("       -p   PASSWORD    The password of the user.");
        System.err.println("       -id  FILEID      The file id that you want to delete.");
        System.err.println("       -r   REGISTRANT  I appoint the user account which I registered an file with.");
        System.err.println("                        It is not necessary for a case same as a login user to input it.");

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

        String url =null;                                  //Garoon��URL
        String user =null;                                 //���[�U�[�A�J�E���g��
        String password =null;                             //�p�X���[�h
        String fid =null;                                  //�t�@�C��ID
        String registrant =null;                           //�폜��
        
        String fileId =null;                               //�t�@�C��ID(�߂�l)
        CoopLink cabinetLink =null;                        //CoopLink����p


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
            else if ( args[i].equals("-id") ) {                // �t�@�C��ID
                if ( i == (args.length - 1) ) {
                    System.err.println("missing file id after -id.");
                    System.err.println();
                    usage();
                    return;
                }
                fid = args[++i];
            }
            else if ( args[i].equals("-r") ) {                // �폜��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing registrant of a file after -r.");
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
        if ( fid == null ) {                 // �t�@�C��ID
            System.err.println("[-id FILEID] is indispensable option.");
            usage();
            return;
        }

        try{
            // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
            cabinetLink = new CoopLink( url, user, password );

            // Garoon�փf�[�^���M
            fileId = cabinetLink.putCabinetDelete( Long.parseLong(fid),     // �t�@�C��ID
                                                   registrant );            // �폜��
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
            cabinetLink.logout();
            
            if ( fileId != null )                            // �t�@�C��ID
                System.out.println( fileId );                 // �߂�l(�t�@�C��ID)
        }
    }
}
