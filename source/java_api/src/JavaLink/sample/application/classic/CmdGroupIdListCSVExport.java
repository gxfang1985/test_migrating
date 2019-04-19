import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.Iterator;
import java.util.Map;
import java.util.TreeMap;

import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.RemoteException;
import jp.co.cybozu.text.CSVWriter;

public class CmdGroupIdListCSVExport {
    
    /**
     * �K�C�_���X��\�����܂��B<BR>    
     *
     */
    private static void usage ()
    {
        System.err.println("Usage: java CmdGroupIdListCSVExport [OPTIONS]");
        System.err.println();
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
    public static void main(String[] args) {      
        
        if ( args.length == 0 )    {
            System.err.println("too few arguments.");
            System.err.println();
            usage();
            return;
        }

        String url = null;                                    // Garoon��URL
        String user = null;                                   // ���[�U�[�A�J�E���g��
        String password = null;                               // �p�X���[�h
        String filePath = null;                               // �t�@�C���p�X
        String encode = "MS932";                              // �G���R�[�h
        String[] title = null;                                // �擪�s
        
        CoopLink grnLink = null;
        CSVWriter groupCSV = null;
        
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
                filePath = args[++i];
            }
            else if ( args[i].equals("-he") ) {                // �擪�s
                title =  new String[]{"�g�DID","�g�D�R�[�h"};
            }
            else if ( args[i].equals("-utf8") ) {              // �G���R�[�h
                encode = "UTF-8";
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

            // Garoon�փf�[�^���M/�擾
            TreeMap maps = grnLink.getGroupIdList();
            
            // TreeMap��CSV�ŏ����o��
            // Writer�̏���
            groupCSV = new CSVWriter(new OutputStreamWriter(new FileOutputStream(filePath), encode));
            
            // �^�C�g���s�̏��o
            if(title !=null){
                groupCSV.println(title);
            }
            
            // �f�[�^�s�̏��o
            Iterator it = maps.entrySet().iterator();
            Map.Entry entry;
            String[] line = new String[2];
            while (it.hasNext()) {
                entry = (Map.Entry) it.next();
                line[0] = ((Long) entry.getKey()).toString();  // �g�DID
                line[1] = (String) entry.getValue();           // �g�D�R�[�h
                
                groupCSV.println(line);
            }
            groupCSV.close();
            
            System.out.println("The download of the csv file was executed.(" + filePath + ")");
            
        }
        catch ( RemoteException e ) {           //�K���[����̃G���[
            System.err.println(e.toString());
        } 
        catch ( IOException e ) {               // ���̑��ʐM��̃G���[
            System.err.println(e.toString());
        }
        finally {
            grnLink.logout();
            
        }
    }
}
