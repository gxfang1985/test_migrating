import java.io.*;
import java.text.*;
import java.util.Calendar;
import jp.co.cybozu.garoon2.*;


public class CmdTimecardAdd {

    /**
     * �K�C�_���X��\�����܂��B<BR>
     *
     */
    public static void usage() {
        System.err.println("Usage: java CmdTimecardAdd [OPTIONS]");
        System.err.println();
        System.err.println("OPTIONS:");
        System.err.println("       -h                 Display this help,then exit.");
        System.err.println("       -o   URL           The url of the garoon administration system.");
        System.err.println("       -u   USER          The user account to login garoon administration system.");
        System.err.println("       -p   PASSWORD      The password of the user.");
        System.err.println("       -r   REGISTRANT    I appoint the user account which I registered an timecard with.");
        System.err.println("       -d   DATE          The date of timecard.");
        System.err.println("       -st  STARTTIME     Time of going to the office.(Format hh:mm or \"\" or \"*\")");
        System.err.println("                          The start time is initialized when you input ''. ");
        System.err.println("                          The start time is not changed when you input '*'. ");
        System.err.println("       -et  ENDTIME       Time of leaving the office.(Format hh:mm or \"\" or \"*\")");
        System.err.println("                          The end time is initialized when you input ''. ");  
        System.err.println("                          The end time is not changed when you input '*'. ");
        System.err.println("       -tt  TRIPTIME      when you  went out of an office.(Format hh:mm or \"\" or \"*\")");
        System.err.println("                          The triptime is initialized when you input ''. ");    
        System.err.println("                          The triptime is not changed when you input '*'. ");
        System.err.println("       -bt  BACKTIME      The time when you came back.(Format hh:mm or \"\" or \"*\")");
        System.err.println("                          The backtime is initialized when you input ''. "); 
        System.err.println("                          The backtime is not changed when you input '*'. ");
        System.err.println("       -ab  OLD TRIPTIME,NEW TRIPTIME,NEW BACKTIME");
        System.err.println("                          The time when you  went out of an office and the time when you came back.");
        System.err.println("       -m   MEMO          The memo of timecard.");
        System.err.println("       -c                 The specified timecard at the 'DATE' is initialized. ");
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
        String registrant = null;                    // �Ώۃ��[�U�[
        
        String iDate = null;                         // ���͓��t
        String sTime = null;                         // �o�Ў���
        String eTime =null;                          // �ގЎ���
        String tTime = null;                         // �O�o����  
        String bTime = null;                         // �A�Ў���
        String memo = null;                          // ���l
        boolean clearFlg = false;                  // �N���A�t���O
        
        int oneDimensionSize = 3;
        int twoDimensionSize = 6;                   // �O�o/���A�̍ő吔��6�񂪏�� by Garoon
        String[][] abcenscesTimes = new String[twoDimensionSize][oneDimensionSize]; //�s�ݏ��
        int abcenscesTimesCount =0;
 
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
                url =args[++i];
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
            else if ( args[i].equals("-r") ) {             //�Ώۃ��[�U�[
                if ( i == (args.length - 1) ) {
                    System.err.println("missing registrant user after -r.");
                    System.err.println();
                    usage();
                    return;
                }
                registrant = args[++i];
            }
            else if ( args[i].equals("-d") ) {             // ���͓��t
                if ( i == (args.length - 1) ) {
                    System.err.println("missing date after -d.");
                    System.err.println();
                    usage();
                    return;
                }
                iDate = args[++i];
            }
            else if ( args[i].equals("-st") ) {            // �o�Ў���
                if ( i == (args.length - 1) ) {
                    System.err.println("missing Time of going to the office after -st.");
                    System.err.println();
                    usage();
                    return;
                }
                sTime =  args[++i];
            }      
            else if ( args[i].equals("-et") ) {            // �A�Ў���
                if ( i == (args.length - 1) ) {
                    System.err.println("missing Time of leaving the office after -et.");
                    System.err.println();
                    usage();
                    return;
                }
                 eTime = args[++i];
            }
            else if(args[i].equals("-ab")){               // �s�ݎ���
                if ( i == (args.length - 1) ) {
                    System.err.println("missing Absent information time after -ab.");
                    System.err.println();
                    usage();
                    return;
                }
                String strTmp = args[++i];
                String[] arrayTmp = new String[oneDimensionSize];
                // �`�� (H:mm�`���A"*","" �����ꂩ�A�J���}��؂�K�{)�̃`�F�b�N
                if(!strTmp.matches("((\\*|([0-9]|[01][0-9]|2[0-3]):([0-9]|[0-5][0-9]))?,){2}(\\*|([0-9]|[01][0-9]|2[0-3]):([0-9]|[0-5][0-9]))?" ))
                {
                    System.err.println("The Input pattern of '-ab' is wrong.");
                    System.err.println();
                    usage();
                    return;        
                }
                // 6��ȏ�̓��͂͂�������
                if(abcenscesTimesCount > twoDimensionSize){
                    System.err.println("option �y-ab�zis too much.");
                    System.err.println();
                    return;
                }
                
                arrayTmp = strTmp.split(",",oneDimensionSize);          
                if(arrayTmp.length==oneDimensionSize)
                {                  
                    abcenscesTimes[abcenscesTimesCount] = arrayTmp;
                    abcenscesTimesCount++;
                }else {
                    System.err.println("the input pattern of of '-ab' is wrong.");
                    System.err.println();
                    usage();
                    return;        
                }
            }
            else if ( args[i].equals("-tt") ) {            // �O�o����
                if ( i == (args.length - 1) ) {
                    System.err.println("missing The going out time after -tt.");
                    System.err.println();
                    usage();
                    return;
                }
                tTime = args[++i];
            }
            else if ( args[i].equals("-bt") ) {            // �ގЎ���
                if ( i == (args.length - 1) ) {
                    System.err.println("missing Time of back the office after -bt.");
                    System.err.println();
                    usage();
                    return;
                }
                bTime = args[++i];
            }
            else if ( args[i].equals("-m") ) {             // ���l
                if ( i == (args.length - 1) ) {
                    System.err.println("missing memo after -m.");
                    System.err.println();
                    usage();
                    return;
                }
                memo = args[++i];
            }
            else if ( args[i].equals("-c") ) {             // �N���A
      
                clearFlg = true;
             
            }      
            else {
                System.err.println("warning: unknown option " + args[i]);
                System.err.println();
                usage();
                return;
            }
        }

        
        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
        CoopLink timecardGrnLink = null;

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
      
            if ( iDate == null ) {                         // ���͓��t
                do {
                    System.err.print("Date: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        iDate = inp;
                    }
                } while(iDate == null);
            }
               
            if(!(bTime==null && tTime==null)){             // �O�o�E�ގ� 
                tTime = tTime==null?"*":tTime;
                bTime = bTime==null?"*":bTime;
                abcenscesTimes[abcenscesTimesCount] = new String[]{"",tTime,bTime};                          
            }
      
     
            Calendar myCal = Calendar.getInstance();
            myCal.clear();
            SimpleDateFormat sdf = new SimpleDateFormat();
            sdf.setLenient( false );          
            sdf.applyPattern( "yyyy-MM-dd" );
            myCal.setTime(sdf.parse(iDate));

            // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
            timecardGrnLink = new CoopLink( url,user,password );

            // Garoon�Ƀ^�C���J�[�h���𑗐M
            timecardGrnLink.putTimecard(myCal,        // ���͓��t 
                                       sTime,         // �o�Ў���("H:mm","","*"�̂����ꂩ�̒l)
                                       eTime,         // �ގЎ���("H:mm","","*"�̂����ꂩ�̒l)
                                       abcenscesTimes,// �s�ݏ��({[�C���O�O�o����],[�C����O�o����],[�C���㕜�A����]}�̑������z��)
                                       memo,          // ����
                                       clearFlg,      // �N���A�t���O(true:�N���A����,false:�N���A���Ȃ�)
                                       registrant);   // �o�^�Ώۃ��[�U�[(���s���[�U�[) 
        }
        catch( ParseException e ){                 // ���t�ϊ��G���[
            System.err.println(e.toString());
        }
        catch ( RemoteException e ) {              //�K���[����̃G���[
            System.err.println(e.toString());
        } 
        catch ( IOException e ) {                  // ���̑��ʐM��̃G���[
            System.err.println(e.toString());
        }
        catch ( IllegalArgumentException e ) {     // �����G���[ 
            System.err.println(e.toString());
        }
        catch ( NullPointerException e ) {
            System.err.println(e.toString());
        }
        finally
        {
            timecardGrnLink.logout();               // �K���[���̃��O�A�E�g
        } 
     
    }
}