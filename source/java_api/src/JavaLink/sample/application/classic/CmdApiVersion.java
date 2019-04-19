import java.io.*;
import jp.co.cybozu.garoon2.*;

public class CmdApiVersion
{
    /**
     * �K�C�_���X��\�����܂��B<BR>
     *
     */
    private static void usage ()
    {
        System.err.println("Usage: java CmdApiVersion [OPTIONS]");
        System.err.println("");
        System.err.println("OPTIONS:");
        System.err.println("       -h                  Display this help,then exit.");
        System.err.println("       -o       URL        The URL of the garoon administration system.");
    }

    /**
     * �A�gAPI(CSP�t�@�C��)�̃o�[�W�������擾<BR>
     * 
     * @param url garoon��URL
     * @param page �o�[�W�������擾����X�N���v�g�t�@�C����
     * @return �o�[�W����
     */
    private static String version (String url)
    throws IOException, RemoteException
    {
        String version = null;
        
           // garoon�ւ̐ڑ�
           CoopLink verLink = new CoopLink(url); 

           // garoon�փf�[�^���M
           version = verLink.versionInfo();
            
           verLink.logout();
    
        return version;
    }

    /**
     * �w�肵�������ɍ��ڂ�����Ȃ��ꍇ�ɑ���Ȃ����X�y�[�X�ł��߂�B<BR>
     * 
     * @param len ����
     * @param strVal ����
     * @return �ҏW��������
     */
    private static String addSpace (int len, String strVal)
    {
        String disppage = strVal;
        for (int index = 0 ; index < len ; index++) {
            disppage = disppage + " ";
        }
        
        return disppage;
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
            else {
                System.err.println("warning: unknown option " + args[i]);
                usage(); 
                return; 
            }
        }
            
        try {
            String title = null;
            String verJar = null;
            String verCsp = null;
            String disppage = null;
            String dispver = null;
            
            // API�̃o�[�W�����擾
            if ( (verCsp = version(url)) == null ) verCsp = "";
           
			// 2011/06/01 �s�GRNJAVAAPI-6�̉��C
            System.err.println( "+--------------------------------------+----------------------+");
            System.err.println( "|function                              |version               |");
            System.err.println( "+--------------------------------------+----------------------+");
            
            title = "garoon2.jar version";
            
            verJar = CoopLink.getCoopLinkVersion();
            disppage = addSpace((38 - title.length()), title);
            dispver = addSpace((9 - verJar.length()), verJar);
            System.err.println( "|" + disppage + "|" + dispver + "|" );

            title = "csp File version";
            disppage = addSpace((38 - title.length()), title);
            dispver = addSpace((9 - verCsp.length()), verCsp);
            System.err.println( "|" + disppage + "|" + dispver + "|" );
            System.err.println( "+--------------------------------------+----------------------+");// 2011/06/01 �s�GRNJAVAAPI-6�̉��C
        }
        catch ( FileNotFoundException e ) {
            System.err.println( e.toString() );
        }
        catch ( RemoteException e ) {
            System.err.println(e.toString());
        }
        catch ( IOException e ) {
            System.err.println( e.toString() );
        }
    }
}
