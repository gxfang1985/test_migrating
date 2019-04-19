import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import jp.co.cybozu.garoon2.*;


public class CmdBulletinModify {
 
    /**
    * �K�C�_���X��\�����܂��B<BR>
    *
    */
    public static void usage() {
        System.err.println("Usage: java CmdBulletinModify [OPTIONS]");
        System.err.println();
        System.err.println("OPTIONS:");
        System.err.println("       -h                 Display this help,then exit.");
        System.err.println("       -o   URL           The url of the garoon administration system.");
        System.err.println("       -u   USER          The user account to login garoon.");
        System.err.println("       -p   PASSWORD      The password of the user.");
        System.err.println("       -id  ARTICLEID     The article id that you want to modify");
        System.err.println("       -r   REGISTRANT    I appoint the user account which I registered an bulletin board with.");
        System.err.println("                          It is not necessary for a case same as a login user to input it.");
        System.err.println("       -t   TITLE         The title of bulletin.");
        System.err.println("       -sd  STARTDATE     The start date of bulletin.(Format:yyyy-mm-dd)");
        System.err.println("                          Please specify neither start date nor end date when you do not specify the notice period.");     
        System.err.println("       -ed  ENDDATE       The bulletin end date. (Format:yyyy-mm-dd)");
        System.err.println("       -d   DATA          The text of bulletin.");
        System.err.println("       -f   ATTACHEDFILES The attached files.");
        System.err.println("                          Please apply the option at each [ATTACHEDFILES] when you specify the plural.");
        System.err.println("                          (ex.  -f /var/tmp/test1.txt -f /var/tmp/text2.txt)");
        System.err.println("       -uf                when you don't permit \"writing follow\",specify this ");
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
        
        String aid = null;                           // �f����ID
        String title = null;                         // �^�C�g��
        String registrant = null;                    // ���o�l
        String sdate = null;                         // �f�����ԊJ�n��
        String edate = null;                         // �f�����ԏI����
        String data = null;                          // �{��
        boolean canFollow = true;                   // �t�H���[����
        Collection attachedFiles = new ArrayList();  // �Y�t�t�@�C��                  
        String bulletinId = null;                    // �o�^�ł����f����ID(�߂�l)

        for ( int i = 0; i < args.length; i++ ) {
            if ( args[i].equals("-h") ) {
                usage();
                return;
            }
            else if ( args[i].equals("-o") ) {             // Garoon��URL
                if ( i == (args.length - 1) ) {
                    System.err.println("missing URL after -o.");
                    System.err.println();
                    usage();
                    return;
                }
                url = args[++i];
            }
            else if ( args[i].equals("-u") ) {             // ���O�C�����[�U�[�A�J�E���g
                if ( i == (args.length - 1) ) {
                    System.err.println("missing user name after -u.");
                    System.err.println();
                    usage();
                    return;
                }
                user = args[++i];
            }
            else if ( args[i].equals("-p") ) {             // ���O�C���p�X���[�h
                if ( i == (args.length - 1) ) {
                    System.err.println("missing password after -p.");
                    System.err.println();
                    usage();
                    return;
                }
                password = args[++i];
            }
            else if ( args[i].equals("-r") ) {             // ���o�l
                if ( i == (args.length - 1) ) {
                    System.err.println("missing registrant after -r.");
                    System.err.println();
                    usage();
                    return;
                }
                registrant = args[++i];
            }
            else if ( args[i].equals("-id") ) {             // �f����ID
                if ( i == (args.length - 1) ) {
                    System.err.println("missing Article ID after -id.");
                    System.err.println();
                    usage();
                    return;
                }
                aid =  args[++i];
            }
            else if ( args[i].equals("-t") ) {             // �^�C�g��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing title after -t.");
                    System.err.println();
                    usage();
                    return;
                }
                title = args[++i];
            }
            else if ( args[i].equals("-sd") ) {             // �f�����ԊJ�n��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing The bulletin start date after -sd.");
                    System.err.println();
                    usage();
                    return;
                }
                sdate =  args[++i];
            }
            else if ( args[i].equals("-ed") ) {             // �f�����ԏI����
                if ( i == (args.length - 1) ) {
                    System.err.println("missing The bulletin end date after -ed.");
                    System.err.println();
                    usage();
                    return;
                }
                edate = args[++i];
            }
            else if ( args[i].equals("-d") ) {             // ���l
                if ( i == (args.length - 1) ) {
                    System.err.println("missing text after -d.");
                    System.err.println();
                    usage();
                    return;
                }
                data = args[++i];                   
            }
            else if ( args[i].equals("-uf") ) {            // �t�H���[����

                canFollow = false;

            }
            else if ( args[i].equals("-f") ) {             // �Y�t�t�@�C��'s
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
                System.err.println();
                usage();
                return;
            }
        }

        BufferedReader in = new BufferedReader( new InputStreamReader(System.in));
        CoopLink bulletinLink = null;
        try 
        {
            String inp = null;
      
            if ( url == null ) {                           // Garoon��URL
                do {
                    System.err.print("URL: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        url =inp;
                    }
                } while(url.length() == 0);
            }

            if ( user == null ) {                          // ���O�C�����[�U�[�A�J�E���g
                do {
                    System.err.print("User: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        user = inp;
                    }
                } while(user == null);
            }

            if ( password == null ) {                      // ���O�C���p�X���[�h
                do {
                    System.err.print("Password: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        password = inp;
                    }
                } while(password == null);
            }
      
            if ( aid == null ) {                           // �J�e�S���R�[�h
                do {
                    System.err.print("Article ID: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        aid = inp;
                    }
                } while(aid == null);
            }
            
            if ( title == null ) {                           // �^�C�g��
                do {
                    System.err.print("Title: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        title = inp;
                    }
                } while(title == null);
            }   

            Calendar sCal =null;       
            Calendar eCal = null;          
     
            SimpleDateFormat sdf = new SimpleDateFormat();      
            sdf.setLenient( false );

            sdf.applyPattern( "yyyy-MM-dd" );
 
            if(sdate!=null){
                sCal = Calendar.getInstance();          
                sCal.clear();
                sCal.setTime(sdf.parse(sdate));
     
            }
            if(edate!=null){
                eCal = Calendar.getInstance();          
                eCal.clear();
                eCal.setTime(sdf.parse(edate));
            }   

            // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
            bulletinLink = new CoopLink(url,user,password);

            // Garoon�Ɍf�����𑗐M
            bulletinId=bulletinLink.putBulletinModify(Long.parseLong(aid),  // �f���L��ID
                                                       title,               // �^�C�g��
                                                       sCal,                // �f�����ԊJ�n��
                                                       eCal,                // �f�����ԏI����
                                                       data,                // �{��
                                                       attachedFiles,       // �Y�t�t�@�C��
                                                       canFollow,           // �t�H���[��������
                                                       registrant);         // ���o�l

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
        catch ( IllegalArgumentException e ) {  // �����G���[ 
            System.err.println(e.toString());
        }
        catch ( NullPointerException e ) {
            System.err.println(e.toString());
        }        
        finally
        {
            bulletinLink.logout();                                          // �K���[���̃��O�A�E�g
            
            if(bulletinId!=null)
            System.out.println(bulletinId);                                 // �߂�l�\��
    
        }
     
    }
}