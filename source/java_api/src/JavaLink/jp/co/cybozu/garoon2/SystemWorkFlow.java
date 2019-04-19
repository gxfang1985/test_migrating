package jp.co.cybozu.garoon2;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;

import jp.co.cybozu.garoon2.util.GrnConnector;
import jp.co.cybozu.garoon2.util.Utils;


/**
 * �R���X�g���N�^�̈���[grnCon] ���g�p���āA���[�N�t���[�̊e�푀��̋@�\���������܂��B<BR>
 *
 * @author �T�C�{�E�Y 
 * @version    1.1.0
 * 
 */
public class SystemWorkFlow {

    private GrnConnector grnCon;
    
    /**
     * �w��̐ڑ������g���āA�V����SystemWorkFlow ���쐬���܂��B<BR>
     * @param grnCon �ڑ����
     * 
     */
    public SystemWorkFlow(GrnConnector grnCon){
        this.grnCon = grnCon;
    }
    
    /**
     * ���� [attachedFileId]�̓Y�t�t�@�C�������[�N�t���[���_�E�����[�h���A<BR>
     * ���� ���� [directoryPath]�̃f�B���N�g�� �ɁA���� [fileName] �̃t�@�C�����ŕۑ����܂��B<BR>
     * 
     * @param attachedFileId ���[�N�t���[�̓Y�t�t�@�C��ID
     * @param directoryPath �t�@�C����ۑ�����f�B���N�g���p�X.null�w��\(�J�����g�f�B���N�g���ɕۑ����܂��B�j
     * @param fileName �t�@�C����ۑ�����t�@�C����.<BR>null�w��\(���[�N�t���[�ɓo�^����Ă���Y�t�t�@�C�����ŕۑ����܂��B)
     * 
     * @throws IOException �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
     * @throws RemoteException ���[�N�t���[�A�g�p�v���O������ŃG���[�����������ꍇ
     */
    public void downloadSystemFile(long attachedFileId,
                                     String directoryPath,
                                     String fileName)
    throws IOException, RemoteException
    {
        HashMap hm = new HashMap();
        InputStream responseIn = null;
        Utils units = new Utils();
        
        String pid = null;
        
        if (fileName == null) {
            hm.put("system", "2");                           // �����`�F�b�N�p(System)
            hm.put("manage", "workflow" );                   // �����`�F�b�N�pApplication��
            hm.put("ifid",Long.toString(attachedFileId));    // �Y�t�t�@�C��ID
            hm.put("title_flag","1");                        // ���[�N�t���[�̓Y�t�t�@�C���̃^�C�g���擾�t���O(�^�C�g���擾 1:����,1�ȊO:���Ȃ�)
            
            responseIn = this.grnCon.getResponseStream("/coop/grnWorkflow_download",hm,"failed to download of the workflow attached file.");
            
            BufferedReader in = units.processBufferResult(responseIn);
            String line = in.readLine();
            
            int pointpos = line.indexOf(",");
            if ( pointpos != -1 ) {
                pid = line.substring(0, pointpos);
                fileName = line.substring(pointpos + 1);
            } else {
                throw new RemoteException("failed to download of the workflow attached file.");
            }
            
            responseIn.close();
        }
        
        hm.clear();
        hm.put("system", "2");                               // �����`�F�b�N�p(System)
        hm.put("manage", "workflow" );                       // �����`�F�b�N�pApplication��
        hm.put("ifid",Long.toString(attachedFileId));        // �Y�t�t�@�C��ID
        hm.put( "pid", pid );                                // ���[�N�t���[�\��ID
        
        // ���N�G�X�g & ���X�|���XGET
        responseIn = this.grnCon.getResponseStream("/coop/grnWorkflow_download",hm,"failed to download of the workflow attached file.");
        
        // ���X�|���X�f�[�^���t�@�C���ɕۑ�
        units.writeBynaryFile(responseIn,directoryPath,fileName);
    }
    
    /**
     * ���� [attachedFileId]�̓Y�t�t�@�C�������[�N�t���[���_�E�����[�h���A<BR>
     * ���� [directoryPath]�̃f�B���N�g���ɕۑ����܂��B<BR>
     * �t�@�C�����́A���[�N�t���[�œY�t����Ă���t�@�C���̖��O�ɂȂ�܂��B<BR>
     * 
     * @param attachedFileId ���[�N�t���[�̓Y�t�t�@�C��ID
     * @param directoryPath �t�@�C����ۑ�����f�B���N�g���p�X.null�w��\(�J�����g�f�B���N�g���ɕۑ����܂��B�j
     *  
     * @throws IOException �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
     * @throws RemoteException ���[�N�t���[�A�g�p�v���O������ŃG���[�����������ꍇ
     */
    public void downloadSystemFile(long attachedFileId,
                                     String directoryPath)
    throws IOException, RemoteException
    {
        this.downloadSystemFile(attachedFileId,directoryPath,null);
    }
    
    /**
     * ���[�N�t���[�\���f�[�^�o�͗p���ʃ��\�b�h
     * @param hm �\��ID,�\���t�H�[��ID,�\���t�H�[���R�[�h�̂��Âꂩ�̃p�����[�^(Key,Value)���Z�b�g���ꂽHashMap
     * @param selectProperties ���o����
     * @param items �o�͍���
     * @param filePath XML�t�@�C���p�X
     * 
     */
    private void exportXMLPetitionData(HashMap hm,
                                       WorkFlowdataSelectProperties selectProperties,
                                       WorkFlowdataItemProperties items,
                                       String filePath)
    throws IOException,RemoteException
    {
        if (hm ==null) hm = new HashMap();
        if (selectProperties != null)     hm.putAll(selectProperties.getParameters());
        if (items != null)                hm.putAll(items.getParameters());
        
        hm.put("system","2");
        hm.put("manage","workflow");
        
        // ���N�G�X�g & ���X�|���XGET
        InputStream in = grnCon.getResponseStream("/coop/grnWorkflow_petitiondata_exportXML",
                                                  hm,
                                                  "failed to export xmlfile of petitiondata");
        // �t�@�C���̏o��
        new Utils().writeBynaryFile(in,filePath);
    }

    
    /**
     * ���[�N�t���[��̐\���f�[�^ID(���� [petitionId]) �ɂ��āA���� [items]�ŏo�͎w�肳�ꂽ���ڂ�����
     * XML�t�@�C�������� [filePath]  �ɏo�͂��܂��B
     * 
     * @param petitionId ���[�N�t���[�̐\��ID
     * @param items �o�͍���.
     * @param filePath XML�t�@�C���p�X
     * 
     * @throws IOException �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
     * @throws RemoteException �K���[���Q��ŃG���[�����������ꍇ
     */
    public void exportXMLPetitionData(long petitionId,
                                        WorkFlowdataItemProperties items,
                                        String filePath)
    throws IOException,RemoteException
    {
        HashMap hm = new HashMap();
        hm.put("pid",Long.toString(petitionId));
        exportXMLPetitionData(hm,null,items,filePath);
    }
    
    /**
     * ���[�N�t���[��̐\���f�[�^ID(���� [petitionId]) �ɂ��āA�o�H���ȊO�̍��ڂ�����
     * XML�t�@�C�������� [filePath] �ɏo�͂��܂��B
     * 
     * @param petitionId ���[�N�t���[�̐\��ID
     * @param filePath XML�t�@�C���p�X
     * 
     * @throws IOException �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
     * @throws RemoteException �K���[���Q��ŃG���[�����������ꍇ
     */
    public void exportXMLPetitionData(long petitionId,
                                      String filePath)
    throws IOException,RemoteException
    {
        exportXMLPetitionData(petitionId,new WorkFlowdataItemProperties(),filePath);
    }
    
    
    /**
     * ���[�N�t���[��̐\���t�H�[��ID(���� [formId]) ���ɂ����āA
     * ����[selectProperties]�Ŏw�肳��钊�o�����ɍ��v����
     * �\���f�[�^�̈ꗗ�ɂ��āA���� [items]�ŏo�͎w�肳�ꂽ���ڂ�����
     * XML�t�@�C�������� [filePath] �ɏo�͂��܂��B
     * 
     * @param formId ���[�N�t���[�̐\���t�H�[��ID
     * @param selectProperties ���o����
     * @param items �o�͍���
     * @param filePath XML�t�@�C���p�X
     * 
     * @throws IOException �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
     * @throws RemoteException �K���[���Q��ŃG���[�����������ꍇ
     */
    public void exportXMLFormPetitionData(long formId,
                                          WorkFlowdataSelectProperties selectProperties,
                                          WorkFlowdataItemProperties items,
                                          String filePath)
    throws IOException,RemoteException
    {
        HashMap hm = new HashMap();
        hm.put("fid",Long.toString(formId));
        exportXMLPetitionData(hm,selectProperties,items,filePath);
    }
    
    /**
     *  ���[�N�t���[��̐\���t�H�[��ID(���� [formId]) ���ɂ����āA
     *  ����[selectProperties]�Ŏw�肳��钊�o�����ɍ��v����
     *  �\���f�[�^�̈ꗗ�ɂ��āA�o�H���ȊO�̍��ڂ�����
     *  XML�t�@�C�������� [filePath]  �ɏo�͂��܂��B
     * 
     * @param formId ���[�N�t���[�̐\���t�H�[��ID
     * @param selectProperties ���o����
     * @param filePath XML�t�@�C���p�X
     * 
     * @throws IOException �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
     * @throws RemoteException �K���[���Q��ŃG���[�����������ꍇ
     */
    public void exportXMLFormPetitionData(long formId,
                                          WorkFlowdataSelectProperties selectProperties,
                                          String filePath)
    throws IOException,RemoteException
    {
        exportXMLFormPetitionData(formId,
                                  selectProperties,
                                  new WorkFlowdataItemProperties(),
                                  filePath);
    }
    
    /**
     *  ���[�N�t���[��̐\���t�H�[���R�[�h(���� [formCode]) ���ɂ����āA
     *  ����[selectProperties]�Ŏw�肳��钊�o�����ɍ��v����
     *  �\���f�[�^�̈ꗗ�ɂ��āA���� [items]�ŏo�͎w�肳�ꂽ���ڂ�����
     *  XML�t�@�C�������� [filePath]  �ɏo�͂��܂��B
     * 
     * @param formCode ���[�N�t���[�̐\���t�H�[���R�[�h
     * @param selectProperties ���o����
     * @param items �o�͍���
     * @param filePath XML�t�@�C���p�X
     * 
     * @throws IOException �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
     * @throws RemoteException �K���[���Q��ŃG���[�����������ꍇ
     */
    public void exportXMLFormPetitionData(String formCode,
                                          WorkFlowdataSelectProperties selectProperties,
                                          WorkFlowdataItemProperties items,
                                          String filePath)
    throws IOException,RemoteException
    {
        HashMap hm = new HashMap();
        hm.put("formcode",formCode);
        exportXMLPetitionData(hm,selectProperties,items,filePath);
    }

    /**
     * ���[�N�t���[��̐\���t�H�[���R�[�h(���� [formCode]) ���ɂ����āA
     * ����[selectProperties]�Ŏw�肳��钊�o�����ɍ��v����
     * �\���f�[�^�̈ꗗ�ɂ��āA�o�H���ȊO�̍��ڂ�����
     * XML�t�@�C�������� [filePath]  �ɏo�͂��܂��B
     * 
     * @param formCode  ���[�N�t���[�̐\���t�H�[���R�[�h
     * @param selectProperties ���o����
     * @param filePath XML�t�@�C���p�X
     * 
     * @throws IOException �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
     * @throws RemoteException �K���[���Q��ŃG���[�����������ꍇ
     */    
    public void exportXMLFormPetitionData(String formCode,
                                          WorkFlowdataSelectProperties selectProperties,
                                          String filePath)
    throws IOException,RemoteException
    {
        exportXMLFormPetitionData(formCode,
                                  selectProperties,
                                  new WorkFlowdataItemProperties(),
                                  filePath);
    }



}
