import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.Properties;

import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.RemoteException;
import jp.co.cybozu.garoon2.FolderInfoProperties;
import jp.co.cybozu.text.ConfigParser;
import jp.co.cybozu.text.ParseException;

public class CmdCabinetFolderInfoXMLExport {
    
    
    /**
     * �K�C�_���X��\�����܂��B<BR>
     *
     */
    private static void usage ()
    {
        System.err.println("Usage: java CmdCabinetFolderInfoXMLExport [OPTIONS]");
        System.err.println("");
        System.err.println("OPTIONS:");
        System.err.println("       -h                  Display this help,then exit.");
        System.err.println("       -o   URL            The url of the garoon administration system.");
        System.err.println("       -u   USER           The user account to login garoon.");
        System.err.println("       -p   PASSWORD       The password of the user.");
        System.err.println("       -r   REGISTRANT     I appoint the user account which I got a folder information with.");
        System.err.println("                           It is not necessary for a case same as a login user to input it.");
        System.err.println("       -ty  TYPE           The type of target.");
        System.err.println("                             0 : Current folder information that uses folder id");
        System.err.println("                             1 : Current folder information that uses folder code");
        System.err.println("                             2 : Child folder information that uses folder id");
        System.err.println("                             3 : Child folder information that uses folder code");
        System.err.println("                             4 : Tree folder information that uses folder id");
        System.err.println("                             5 : Tree folder information that uses folder code");
        System.err.println("       -ta  TARGET         The target of folder Information that you want to know.");
        System.err.println("       -c   CONFIGFILE     The file path of configuration file.");
        System.err.println("       -f   FILE           The xml file to write.");

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
        String registrant = null;                           // ���s��
        String type = null;                                 // �\���Ώێw����@
        String target = null;                               // �\���Ώ�
        String config = null;                               // �ݒ�t�@�C��
        String filePath = null;                             // �t�@�C���p�X
        
        
        FolderInfoProperties items = null;                  // �o�͍���
        CoopLink cabinetLink =null;                         // CoopLink����p


        for ( int i = 0; i < args.length; i++ )    {
            if ( args[i].equals("-h") ) {                     // Print this message and exit.
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
            else if ( args[i].equals("-r") ) {                // ���s��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing registrant after -r.");
                    System.err.println();
                    usage();
                    return;
                }
                registrant = args[++i];
            }            
            else if ( args[i].equals("-ty") ) {                // �\���Ώێw����@
                if ( i == (args.length - 1) ) {
                    System.err.println("missing type after -ty.");
                    System.err.println();
                    usage();
                    return;
                }
                type = args[++i];
            }
            else if ( args[i].equals("-ta") ) {                // �\���Ώ�
                if ( i == (args.length - 1) ) {
                    System.err.println("missing target after -ta.");
                    System.err.println();
                    usage();
                    return;
                }
                target = args[++i];
            }
            else if ( args[i].equals("-c") ) {                // �ݒ�t�@�C��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing config file after -c.");
                    System.err.println();
                    usage();
                    return;
                }
                config = args[++i];
            }
            else if ( args[i].equals("-f") ) {                // �t�@�C���p�X
                if ( i == (args.length - 1) ) {
                    System.err.println("missing xml file after -f.");
                    System.err.println();
                    usage();
                    return;
                }
                filePath = args[++i];
            }
            else {
                System.err.println("warning: unknown option " + args[i]);
                usage(); 
                return; 
            }
        }
        
        // �K�{�I�v�V�����`�F�b�N
        if ( url == null ) {                          // URL
            System.err.println("[-o URL] is indispensable option.");
            usage();
            return;
        }
        if ( user == null ) {                         // ���O�C����
            System.err.println("[-u USER] is indispensable option.");
            usage();
            return;
        }
        if ( password == null ) {                     // �p�X���[�h
            System.err.println("[-p PASSWORD] is indispensable option.");
            usage();
            return;
        }
        if ( filePath == null ) {                    // XML�t�@�C���p�X
            System.err.println("[-f FILE] is indispensable option.");
            usage();
            return;
        }
        if ( type == null && target == null ) { 
            System.err.println("[-ty TYPE] and [-ta TARGET] is indispensable option.");
            usage();
            return;
        }
        if ( type == null ) {
            System.err.println("[-ty TYPE] is indispensable option.");
            usage();
            return;
        }
        if ( target == null ) {
            System.err.println("[-ta TARGET] is indispensable option.");
            usage();
            return;
        }
        if ( !type.matches("[0-5]") ) {
            System.err.println("[-ty TYPE] is illegal value.");
            usage();
            return;
        }
        
        if (config !=null){
            try {
                items = getProperties(config,"MS932");
            }catch (Exception e){
                System.err.println(e.toString());
                System.err.println("It failed to load the config file.");
                usage();
                return;
            }
        }
        
        try{
            // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
            cabinetLink = new CoopLink( url, user, password );
            
            // Garoon�փf�[�^���M
            if (type.equals("0")){            // �t�H���_ID�w�莞
                if (items != null)
                    cabinetLink.exportXMLCabinetFolderInfo(Long.parseLong(target),items,filePath,registrant);
                else
                    cabinetLink.exportXMLCabinetFolderInfo(Long.parseLong(target),filePath,registrant);
            } else if (type.equals("1")){    // �t�H���_�R�[�h�w�莞
                if (items != null)
                    cabinetLink.exportXMLCabinetFolderInfo(target,items,filePath,registrant);
                else
                    cabinetLink.exportXMLCabinetFolderInfo(target,filePath,registrant);
            } else if (type.equals("2")){    // �t�H���_ID�w�莞
                if (items != null)
                    cabinetLink.exportXMLCabinetFolderInfo_Child(Long.parseLong(target),items,filePath,registrant);
                else
                    cabinetLink.exportXMLCabinetFolderInfo_Child(Long.parseLong(target),filePath,registrant);
            } else if (type.equals("3")){    // �t�H���_�R�[�h�w�莞
                if (items != null)
                    cabinetLink.exportXMLCabinetFolderInfo_Child(target,items,filePath,registrant);
                else
                    cabinetLink.exportXMLCabinetFolderInfo_Child(target,filePath,registrant);
            } else if (type.equals("4")){    // �t�H���_ID�w�莞
                if (items != null)
                    cabinetLink.exportXMLCabinetFolderInfo_Tree(Long.parseLong(target),items,filePath,registrant);
                else
                    cabinetLink.exportXMLCabinetFolderInfo_Tree(Long.parseLong(target),filePath,registrant);
            } else if (type.equals("5")){    // �t�H���_�R�[�h�w�莞
                if (items != null)
                    cabinetLink.exportXMLCabinetFolderInfo_Tree(target,items,filePath,registrant);
                else
                    cabinetLink.exportXMLCabinetFolderInfo_Tree(target,filePath,registrant);
            }
            
            System.out.println("The export of the xml file was executed.(" + filePath + ")");
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
        }
    }
    
    public static FolderInfoProperties getProperties(String ConfigPath,String enc) throws Exception {
        FolderInfoProperties  fp = null;
        
        // �R���t�B�O�t�@�C���̓Ǎ�
        InputStream configIn = new FileInputStream(ConfigPath);
        Properties    config = new ConfigParser( configIn ,enc).getProperties();
        
        // FolderInfoProperties  ����
        fp = new FolderInfoProperties();
        // ��U���ڂ�S����\���ɃZ�b�g
        fp.allDispSet(false);
        
        StringBuffer errMsg = null;
        String key;
        boolean value;
        Enumeration en = config.propertyNames();
        while ( en.hasMoreElements() ) {
            key = (String)en.nextElement();
            value = Boolean.valueOf(config.getProperty(key)).booleanValue();
            
            if(key.equals("title")) {                                // �t�H���_��
                fp.setDispTitle(value);
            } else if(key.equals("description")) {                   // �t�H���_����
                fp.setDispDescription(value);
            } else if(key.equals("creatorid")) {                     // �o�^���[�U�[ID
                fp.setDispCreatorId(value);
            } else if(key.equals("creatorloginname")) {              // �o�^���[�U�[���O�C����
                fp.setDispCreatorLoginName(value);
            } else if(key.equals("creatordisplayname")) {            // �o�^���[�U�[�\��ID
                fp.setDispCreatorDisplayName(value);
            } else if(key.equals("createtime")) {                    // �o�^����
                fp.setDispCreateTime(value);
            } else if(key.equals("modifierid")) {                    // �X�V���[�U�[ID
                fp.setDispModifierId(value);
            } else if(key.equals("modifierloginname")) {             // �X�V���[�U�[���O�C����
                fp.setDispModifierLoginName(value);
            } else if(key.equals("modifierdisplayname")) {           // �X�V���[�U�[�\����
                fp.setDispModifierDisplayName(value);
            } else if(key.equals("modifytime")) {                    // �X�V����
                fp.setDispModifyTime(value);
            } else {
                if (errMsg == null) errMsg = new StringBuffer("");
                else                  errMsg.append(",");
                
                errMsg.append(key).append("=").append(value);
            }
        }
        
        if (errMsg != null){
            StringBuffer sb = new StringBuffer();
            sb.append("illegal value is included in the configuration file.");
            sb.append("(");
            sb.append(errMsg);
            sb.append(")");
            
            throw new ParseException(sb.toString());
        }
        
        return fp;
    }
}
