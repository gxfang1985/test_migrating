import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import jp.co.cybozu.garoon2.*;


public class CmdBulletinDelete {

    /**
     * �K�C�_���X��\�����܂��B<BR>
     *
     */
    public static void usage() {
         System.err.println("Usage: java CmdBulletinDelete [OPTIONS]");
         System.err.println();
         System.err.println("OPTIONS:");
         System.err.println("       -h                 Display this help,then exit.");
         System.err.println("       -o   URL           The url of the garoon administration system.");
         System.err.println("       -u   USER          The user account to login garoon.");
         System.err.println("       -p   PASSWORD      The password of the user.");
         System.err.println("       -id  ARTICLEID     The article id that you want to delete.");
         System.err.println("       -r   REGISTRANT    I appoint the user account which I registered an bulletin board with.");
         System.err.println("                          It is not necessary for a case same as a login user to input it.");
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
     
        String url = null;                                  // Garoon��URL
        String user = null;                                 // ���O�C�����[�U�[�A�J�E���g
        String password = null;                             // ���O�C���p�X���[�h
        String articleID = null;                            // �L��ID
        String registrant = null;                           // �폜���s��
        long lngArticleID = 0;
        String article = null;                              // �L��ID(�߂�l)

        for ( int i = 0; i < args.length; i++ ) {
            if ( args[i].equals("-h") ) {
                usage();
                return;
            }
            else if ( args[i].equals("-o") ) {               // Garoon��URL
                if ( i == (args.length - 1) ) {
                    System.err.println("missing URL after -o.");
                    System.err.println();
                    usage();
                    return;
                }
                url=args[++i];
            }
            else if ( args[i].equals("-u") ) {              // ���O�C�����[�U�[�A�J�E���g
                if ( i == (args.length - 1) ) {
                    System.err.println("missing user name after -u.");
                    System.err.println();
                    usage();
                    return;
                }
                user = args[++i];
            }
            else if ( args[i].equals("-p") ) {               // ���O�C���p�X���[�h
                if ( i == (args.length - 1) ) {
                    System.err.println("missing password after -p.");
                    System.err.println();
                    usage();
                   return;
                }
                password = args[++i];
            }
            else if ( args[i].equals("-r") ) {              // �폜���s��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing registrant user after -r.");
                    System.err.println();
                    usage();
                    return;
                }
                registrant = args[++i];
            }
            else if ( args[i].equals("-id") ) {             // �L��ID
                if ( i == (args.length - 1) ) {
                    System.err.println("missing Article ID after -id.");
                    System.err.println();
                    usage();
                    return;
                }
                articleID = args[++i];
            }
            else {
                System.err.println("warning: unknown option " + args[i]);
                usage(); 
                return; 
            }
        }

        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
        CoopLink bulletinLink = null;
        try 
        {
          
            String inp = null;

            if ( url == null) {                             // Garoon��URL
                do {
                    System.err.print("URL: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        url= inp;
                    }
                } while(url.length() == 0);
            }

            if ( user == null ) {                           // ���O�C�����[�U�[�A�J�E���g
                do {
                    System.err.print("User: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        user = inp;
                    }
                } while(user == null);
            }
         
            if ( password == null ) {                       // ���O�C���p�X���[�h
                do {
                    System.err.print("Password: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        password = inp;
                    }
                } while(password == null);
            }
               
            if ( articleID == null ) {                      // �L��ID
                do {
                    System.err.print("ArticleID: ");
                    inp = in.readLine();
                    if (inp.length() > 0) {
                        articleID = inp;
                    }
                } while(articleID == null);
            }

            lngArticleID = Long.parseLong(articleID);

            // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
            bulletinLink = new CoopLink(url,user, password);

            // Garoon�Ɍf���폜���𑗐M
            article = bulletinLink.putBulletinDelete(lngArticleID,  // �f���L��ID
                                                     registrant);   // �X�V��

            
        }
        catch ( RemoteException e ) {             //�K���[����̃G���[
            System.err.println(e.toString());
        } 
        catch ( IOException e ) {                 // ���̑��ʐM��̃G���[
            System.err.println(e.toString());
        }
        catch ( IllegalArgumentException e ) {    // �����G���[ 
            System.err.println(e.toString());
        }
        catch ( NullPointerException e ) {
            System.err.println(e.toString());
        }        
        finally
        {
            bulletinLink.logout();                 // �K���[���̃��O�A�E�g
            
            if(article!=null)
            System.out.println(article);           // �߂�l�\��
    
        }
     
    }
}