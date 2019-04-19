import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import jp.co.cybozu.garoon2.*;

public class CmdFacilityScheduleExport
{
    /**
     * �K�C�_���X��\�����܂��B<BR>
     *
     */
    private static void usage ()
    {
        System.err.println("Usage: java CmdFacilityScheduleExport [OPTIONS]");
        System.err.println("");
        System.err.println("OPTIONS:");
        System.err.println("       -h                 Display this help,then exit.");
        System.err.println("       -o   URL           The url of the garoon administration system.");
        System.err.println("       -u   USER          The user account to login garoon administration system.");
        System.err.println("       -p   PASSWORD      The password of the user.");
        System.err.println("       -f   FILE          The file to write.");
        System.err.println("       -fc  FACILITYCODES The participant's facility code.");
        System.err.println("                          Please apply the option at each [FACILITYCODES] when you specify the plural.");
        System.err.println("                          (ex.  -fc \"roomA\" -fc \"roomB\")");
        System.err.println("       -sd  SETDATE       I am going to begin to write it, and it is a start day.");
        System.err.println("       -ed  ENDDATE       I am going to begin to write it, and it is the end day.");
        System.err.println("       -utf8              The character-code of the file is utf8.");
        System.err.println("                          When not specifying this.The character-code of the file is shift_jis.");
        System.err.println("       -he                There is the header.");
        System.err.println("       -ad                The additional opening sentence item.");
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
        String filepath = null;                             // �t�@�C���p�X
        String sDate = null;                                // �����o���\�����(�J�n��)
        String eDate = null;                                // �����o���\�����(�I����)
        boolean sjisEncode = true;                         // �G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
        boolean skip = false;                              // �擪�s�̗L��
        boolean add = false;                               // �ǉ��̏����o������
        Collection facility = new ArrayList();               // �{�݃R�[�h
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
            else if ( args[i].equals("-fc") ) {                // �{�݃R�[�h
                if ( i == (args.length - 1) ) {
                    System.err.println("missing facility after -fc.");
                    System.err.println();
                    usage();
                    return;
                }
                facility.add(args[++i]);
            }
            else if ( args[i].equals("-sd") ) {                // �����o���\�����(�J�n��)
                if ( i == (args.length - 1) ) {
                    System.err.println("missing start date after -sd.");
                    System.err.println();
                    usage();
                    return;
                }
                sDate = args[++i];
            }
            else if ( args[i].equals("-ed") ) {                // �����o���\�����(�I����)
                if ( i == (args.length - 1) ) {
                    System.err.println("missing end date after -ed.");
                    System.err.println();
                    usage();
                    return;
                }
                eDate = args[++i];
            }
            else if ( args[i].equals("-he") ) {                // �擪�s�̗L��
                skip = true;
            }
            else if ( args[i].equals("-ad") ) {                // �ǉ��̏����o������
                add = true;
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
            
            if ( facility.isEmpty() ) {                        // �{�݃R�[�h
                System.err.println("[-fc FACILLITY] is indispensable option.");
                usage();
                return;
            }
            
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

            if ( filepath == null ) {                        // �t�@�C��
                do {
                    System.err.print("File: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        filepath = inp;
                    }
                } while(filepath == null);
            }

            if ( sDate == null ) {                            // �����o���\�����(�J�n��)
                do {
                    System.err.print("Set date: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        sDate = inp;
                    }
                } while(sDate == null);
            }

            if ( eDate == null ) {                            // �����o���\�����(�I����)
                do {
                    System.err.print("End date: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        eDate = inp;
                    }
                } while(eDate == null);
            }
            
            

            Calendar sCal = null;          
            Calendar eCal = null;          
            SimpleDateFormat sdf = new SimpleDateFormat();
            sdf.setLenient( false );   
            
            sdf.applyPattern( "yyyy-MM-dd" );
            if (sDate != null){                                // �J�n��
                sCal = Calendar.getInstance();
                sCal.clear();
                sCal.setTime(sdf.parse(sDate));
            }
   
            if (eDate != null){                                // �I����
                eCal = Calendar.getInstance();
                eCal.clear();
                eCal.setTime(sdf.parse(eDate));
            }
            
            // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
            grnLink = new CoopLink( url, user, password );

            // Garoon�փf�[�^���M
            grnLink.exportFacilitySchedule( filepath,        // �t�@�C���p�X
                                            facility,        // �{�݃R�[�h
                                            sCal,            // �����o���\�����(�J�n��)
                                            eCal,            // �����o���\�����(�I����)
                                            skip,            // �擪�s�̗L��
                                            add,             // �ǉ��̏����o������
                                            sjisEncode );    // �G���R�[�h�w��(true:Shif_JIS,false:UTF-8)

            System.out.println("The download of the csv file was executed.(" + filepath + ")");
        }
        catch ( ParseException e){              // ���t�p�[�X�G���[
            System.err.println(e.toString()); 
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
