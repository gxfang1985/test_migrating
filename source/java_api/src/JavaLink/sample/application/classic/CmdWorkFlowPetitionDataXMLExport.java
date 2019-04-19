import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import java.text.SimpleDateFormat;
import jp.co.cybozu.text.ConfigParser;
import jp.co.cybozu.text.ParseException;
import java.util.Date;
import java.util.Enumeration;
import java.util.Properties;

import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.WorkFlowdataItemProperties;
import jp.co.cybozu.garoon2.WorkFlowdataSelectProperties;
import jp.co.cybozu.garoon2.RemoteException;

public class CmdWorkFlowPetitionDataXMLExport {
    
    public static WorkFlowdataSelectProperties selectProperties;   // �o�͏���
    public static WorkFlowdataItemProperties items;                // �o�͍���
    /**
     * �K�C�_���X��\�����܂��B<BR>
     *
     */
    private static void usage ()
    {
        System.err.println("Usage: java CmdWorkFlowPetitionDataXMLExport [OPTIONS]");
        System.err.println("");
        System.err.println("OPTIONS:");
        System.err.println("    -h                  Display this help,then exit.");
        System.err.println("    -o   URL            The url of the garoon administration system.");
        System.err.println("    -u   USER           The user account to login garoon.");
        System.err.println("    -p   PASSWORD       The password of the user.");
        System.err.println("    -ty  TYPE           The type of tartget.");
        System.err.println("                          0 : PetitionData ID");
        System.err.println("                          1 : PetitionForm ID");
        System.err.println("                          2 : PetitionForm Code");
        System.err.println("    -ta  TARGET         The target of petition data that you want to know.");
        System.err.println("    -c   CONFIGFILE     The file path of configuration file.");
        System.err.println("    -f   FILE           The xml file to write.");
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
        
        String url = null;                                      // Garoon��URL
        String user = null;                                     // ���[�U�[�A�J�E���g��
        String password = null;                                 // �p�X���[�h
        String config = null;                                   // �ݒ�t�@�C��
        String type = null;                                     // �\���Ώێw����@(0:pid,1:formid,2:formCode)
        String target = null;                                   // �\���Ώ�
        String filePath = null;                                 // XML�t�@�C���p�X
                
        CoopLink workflowLink = null;                           // CoopLink����p

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
            else if ( args[i].equals("-ty") ) {                // �\���Ώێw����@(0:pid,1:formid,2:formCode)
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
            }else if ( args[i].equals("-c") ) {                // �ݒ�t�@�C��
                if ( i == (args.length - 1) ) {
                    System.err.println("missing config file after -c.");
                    System.err.println();
                    usage();
                    return;
                }
                config = args[++i];
            }else if ( args[i].equals("-f") ) {                // XML�t�@�C���p�X
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
        if ( url == null ) {                   // URL
            System.err.println("[-o URL] is indispensable option.");
            usage();
            return;
        }
        if ( user == null ) {                  // ���O�C����
            System.err.println("[-u USER] is indispensable option.");
            usage();
            return;
        }
        if ( password == null ) {              // �p�X���[�h
            System.err.println("[-p PASSWORD] is indispensable option.");
            usage();
            return;
        }
        if ( filePath == null ) {              // XML�t�@�C���p�X
            System.err.println("[-f FILE] is indispensable option.");
            usage();
            return;
        }
        if ( type == null && target ==null ) { // �\���Ώێw����@ & �\���Ώ�              
            System.err.println("[-ty TYPE]  and [-ta TARGET] is indispensable option.");
            usage();
            return;
        }
        if ( type == null ) {                  // �\���Ώێw����@      
            System.err.println("[-ty TYPE]  is indispensable option.");
            usage();
            return;
        }
        if (!type.matches("[012]") ) {         // �\���Ώێw����@              
            System.err.println("[-ty TYPE]  is illegal value.");
            usage();
            return;
        }
        if (target ==null ) {                  // �\���Ώ�
            System.err.println("[-ta TARGET]  is indispensable option.");
            usage();
            return;
        }


        if (config !=null){
            try {
                getProperties(config,"MS932");
            }catch (Exception e){
                System.err.println(e.toString());
                System.err.println("It failed to load the config file.");
                usage();
                return;
            }

        }
        
        try{
            // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
            workflowLink = new CoopLink( url, user, password );

            // Garoon�փf�[�^���M
            if (type.equals("0")){         // �\��ID���w��
                if (items != null)
                    // �\�����ڂ̎w�肪����ꍇ (�R���t�B�O�t�@�C����Ǎ��񂾏ꍇ)
                    workflowLink.exportXMLSystemWorkFlowPetitionData(Long.parseLong(target),items,filePath);
                else
                    // �\�����ڂ̎w�肪�Ȃ��ꍇ
                    workflowLink.exportXMLSystemWorkFlowPetitionData(Long.parseLong(target),filePath);
                
            }else if (type.equals("1")){  //�t�H�[��ID���w��
                if(selectProperties==null)  selectProperties = new WorkFlowdataSelectProperties();
                
                if (items != null)
                    // �\�����ڂ̎w�肪����ꍇ (�R���t�B�O�t�@�C����Ǎ��񂾏ꍇ)
                    workflowLink.exportXMLSystemWorkFlowFormPetitionData(Long.parseLong(target),selectProperties,items,filePath);
                else
                    // �\�����ڂ̎w�肪�Ȃ��ꍇ                    
                    workflowLink.exportXMLSystemWorkFlowFormPetitionData(Long.parseLong(target),selectProperties,filePath);
                
                
            }else if (type.equals("2")){  // �t�H�[���R�[�h���w��
                if(selectProperties==null)  selectProperties = new WorkFlowdataSelectProperties();
                
                if (items != null)
                    // �\�����ڂ̎w�肪����ꍇ (�R���t�B�O�t�@�C����Ǎ��񂾏ꍇ)                    
                    workflowLink.exportXMLSystemWorkFlowFormPetitionData(target,selectProperties,items,filePath);
                else
                    // �\�����ڂ̎w�肪�Ȃ��ꍇ                    
                    workflowLink.exportXMLSystemWorkFlowFormPetitionData(target,selectProperties,filePath);
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
            workflowLink.logout();
           
        }
    }
        
        // �R���t�B�O�t�@�C����Ǎ��E��͂��s���A
        // �N���X�t�B�[���h
        //  (WorkFlowdataSelectProperties) selectProperties �y�� (WorkFlowdataItemProperties) items �ɒl���Z�b�g����
        public static void getProperties(String ConfigPath,String enc) throws Exception {
                       
            // �R���t�B�O�t�@�C���̓Ǎ�
            InputStream configIn = new FileInputStream(ConfigPath);
            Properties    config = new ConfigParser( configIn ,enc).getProperties();
        
            // WorkFlowdataSelectProperties�@���� (�o�͏����A�o�͕��я��̐ݒ�j/////
            selectProperties = new WorkFlowdataSelectProperties();
            // �X�e�[�^�X�̍i���ݏ������A�����l��ON�ɂȂ��Ă���̂ŁA��U�S��OFF�ɂ���
            selectProperties.setWhereStatusProgressing(false);
            selectProperties.setWhereStatusAcceptance(false);
            selectProperties.setWhereStatusReject(false);
            selectProperties.setWhereStatusFinish(false);
            selectProperties.setWhereStatusCancel(false);

            // WorkFlowdataItemProperties�@����(�o�͍��ڂ̐ݒ�j  /////////////////
            items = new WorkFlowdataItemProperties();
            // ��U���ڂ�S����\���ɃZ�b�g
            items.allDispSet(false);
            
            StringBuffer errMsg = null;
            String key;
            String value;
            boolean bvalue;
            Enumeration en = config.propertyNames();
            while ( en.hasMoreElements() ) {
                key = (String)en.nextElement();
                value = (String)config.getProperty(key);    
                bvalue = Boolean.valueOf(config.getProperty(key)).booleanValue(); 
                
                if(key.equals("where_petitionnumber") ){               
                    // �l������ꍇ�̂݃Z�b�g
                    if(!"".equals(value))
                    selectProperties.setWherePetitionNumber(value);           // �o�͏���(�\���ԍ�)
                    
                }else if(key.equals("where_title")){
                    // �l������ꍇ�̂݃Z�b�g
                    if(!"".equals(value))
                    selectProperties.setWhereTitle(value);                    // �o�͏���(�W��)
                    
                }else if (key.equals("where_creatordisplayname")){    
                    // �l������ꍇ�̂݃Z�b�g
                    if(!"".equals(value))
                    selectProperties.setWhereCreatorName(value);              // �o�͏���(�\���Җ�(�\����))
                    
                }else if (key.equals("where_statusprogressing")){                                
                    selectProperties.setWhereStatusProgressing(bvalue);       // �o�͏���(�X�e�[�^�X(�i�s��))
                    
                }else if (key.equals("where_statusacceptance")){                                
                    selectProperties.setWhereStatusAcceptance(bvalue);        // �o�͏���(�X�e�[�^�X(���F))
                    
                }else if (key.equals("where_statusreject")){                                    
                    selectProperties.setWhereStatusReject(bvalue);            // �o�͏���(�X�e�[�^�X(�p��))
                    
                }else if (key.equals("where_statusfinish")){                                      
                    selectProperties.setWhereStatusFinish(bvalue);            // �o�͏���(�X�e�[�^�X(����))  
                    
                }else if (key.equals("where_statuscancel")){                                    
                    selectProperties.setWhereStatusCancel(bvalue);            // �o�͏���(�X�e�[�^�X(���))
                    
                }else if (key.equals("where_datetype") && ("".equals(value) || value.matches("[0-4]"))){                    
                    if(!"".equals(value)){
                        String FromDate = config.getProperty("where_datefrom","");
                        String ToDate = config.getProperty("where_dateto","");
                        
                        SimpleDateFormat sdf = new SimpleDateFormat();
                        sdf.setLenient( false );
                        sdf.applyPattern( "yyyy-MM-dd" );
                        Date from =null;
                        Date to = null;
                        if (! FromDate.equals("")){
                            if(FromDate.matches("\\d{4}-\\d{1,2}-\\d{1,2}"))
                                from = sdf.parse( FromDate );
                            else    
                                throw new java.text.ParseException(FromDate,0);
                        }
                        
                        if (! ToDate.equals("")){
                            if(ToDate.matches("\\d{4}-\\d{1,2}-\\d{1,2}"))
                                to   = sdf.parse(ToDate); 
                            else    
                                throw new java.text.ParseException(ToDate,0);
                        }
                        
                       
                        // where_datefrom ��where_dateto �ǂ��炩�ɓ��t������Ώ������Z�b�g
                        if(from!=null || to !=null )
                        selectProperties.setWhereDate(Integer.valueOf(value),from,to);    // �o�͏���(����)
                    }
                        
                
                }else if (key.equals("sort") && ("".equals(value) || value.matches("[0-9]"))){        
                    if(!"".equals(value)){
                        // �l��2�Ŋ����Ă��܂肪0�Ȃ珸���A1�Ȃ�~��
                        int sortvalue =Integer.parseInt(value);                        
                        if(sortvalue%2 == 0)
                            selectProperties.setSortAsc(new Integer(sortvalue/2));        // ���я�
                        else
                            selectProperties.setSortDesc(new Integer(sortvalue/2));
                    }
                }else if (key.equals("petitionnumber")){                 
                    items.setDispPetitionNumber(bvalue);                        // �\������(�\���ԍ�)
                    
                }else if (key.equals("status")){                         
                    items.setDispStatus(bvalue);                                // �\������(���݃X�e�[�^�X)
                    
                }else if (key.equals("creatorid")){                         
                    items.setDispCreatorId(bvalue);                             // �\������(�\����ID)
                    
                }else if (key.equals("creatorloginname")){                 
                    items.setDispCreatorLoginName(bvalue);                      // �\������(�\���҃��O�C����)
                    
                }else if (key.equals("creatordisplayname")){             
                    items.setDispCreatorDisplayName(bvalue);                    // �\������(�\���ҕ\����)
                    
                }else if (key.equals("createtime")){                     
                    items.setDispCreateTime(bvalue);                            // �\������(�\������)
                    
                }else if (key.equals("acceptancehandlerid")){             
                    items.setDispAcceptanceHandlerId(bvalue);                   // �\������(���F��ID)
                    
                }else if (key.equals("acceptancehandlerloginname")){     
                    items.setDispAcceptanceHandlerLoginName(bvalue);            // �\������(���F�҃��O�C����)
                    
                }else if (key.equals("acceptancehandlerdisplayname")){     
                    items.setDispAcceptanceHandlerDisplayName(bvalue);          // �\������(���F�ҕ\����)
                    
                }else if (key.equals("acceptancetime") ){                 
                    items.setDispAcceptanceTime(bvalue);                        // �\������(���F����)
                    
                }else if (key.equals("rejecthandlerid")){                 
                    items.setDispRejectHandlerId(bvalue);                       // �\������(�p����ID)
                    
                }else if (key.equals("rejecthandlerloginname") ){         
                    items.setDispRejectHandlerLoginName(bvalue);                // �\������(�p���҃��O�C����)
                    
                }else if (key.equals("rejecthandlerdisplayname")){         
                    items.setDispRejectHandlerDisplayName(bvalue);              // �\������(�p���ҕ\����)
                    
                }else if (key.equals("rejecttime")){                     
                    items.setDispRejectTime(bvalue);                            // �\������(�p������)
                    
                }else if (key.equals("finishhandlerid")){                 
                    items.setDispFinishHandlerId(bvalue);                       // �\������(������ID)
                    
                }else if (key.equals("finishhandlerloginname")){         
                    items.setDispFinishHandlerLoginName(bvalue);                // �\������(�����҃��O�C����)
                    
                }else if (key.equals("finishhandlerdisplayname")){         
                    items.setDispFinishHandlerDisplayName(bvalue);              // �\������(�����ҕ\����)
                    
                }else if (key.equals("finishtime")){                     
                    items.setDispFinishTime(bvalue);                            // �\������(��������)
                    
                }else if (key.equals("cancelhandlerid")){                 
                    items.setDispCancelHandlerId(bvalue);                       // �\������(�����ID)
                    
                }else if (key.equals("cancelhandlerloginname")){         
                    items.setDispCancelHandlerLoginName(bvalue);                // �\������(����҃��O�C����)
                    
                }else if (key.equals("cancelhandlerdisplayname")){         
                    items.setDispCancelHandlerDisplayName(bvalue);              // �\������(����ҕ\����)
                    
                }else if (key.equals("canceltime")){                     
                    items.setDispCancelTime(bvalue);                            // �\������(�������)
                    
                }else if (key.equals("itemdata")){                         
                    items.setDispItemData(bvalue);                              // �\������(���ڒl)
                    
                }else if (key.equals("stepstatus")){                     
                    items.setDispStepStatus(bvalue);                            // �\������(�o�H�X�e�[�^�X)
                    
                }else if (key.equals("stephandleresult")){                 
                    items.setDispStepHandleResult(bvalue);                      // �\������(�o�H��������)
                    
                }else if (key.equals("stephandlecomment")){                 
                    items.setDispStepHandleComment(bvalue);                     // �\������(�o�H�����R�����g)
                    
                }else if (key.equals("stephandlerid")){                     
                    items.setDispStepHandlerId(bvalue);                         // �\������(�o�H������ID)
                    
                }else if (key.equals("stephandlerloginname")){             
                    items.setDispStepHandlerLoginName(bvalue);                  // �\������(�o�H�����҃��O�C����)
                    
                }else if (key.equals("stephandlerdisplayname")){         
                    items.setDispStepHandlerDisplayName(bvalue);                // �\������(�o�H�����ҕ\����)
                    
                }else if (key.equals("stephandletime")){                 
                    items.setDispStepHandleTime(bvalue);                        // �\������(�o�H��������)
                    
                }else{ 
                    
                    // ��L�y��
                    // where_datefrom,where_dateto �ȊO�œ��Ă͂܂���̂��Ȃ��ꍇ�̓G���[�Ƃ���
                    if(!key.equals("where_datefrom") && !key.equals("where_dateto")){
                        if (errMsg == null) errMsg = new StringBuffer("");
                        else                  errMsg.append(",");
                        
                        errMsg.append(key).append("=").append(value);
                        
                    }
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

        }

}
