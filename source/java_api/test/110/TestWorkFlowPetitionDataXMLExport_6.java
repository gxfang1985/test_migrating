import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.WorkFlowdataItemProperties;
import jp.co.cybozu.garoon2.WorkFlowdataSelectProperties;

public class TestWorkFlowPetitionDataXMLExport_6 {
	public static void main ( String args[]) throws Exception{
        String url = null;                                      // Garoon��URL
        String user = null;                                     // ���[�U�[�A�J�E���g��
        String password = null;                                 // �p�X���[�h
        String formCode = null;                                 // �t�H�[���R�[�h
        String filePath = null;                                 // XML�t�@�C���p�X
        WorkFlowdataSelectProperties selectProperties = new WorkFlowdataSelectProperties();
        // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
        CoopLink workflowLink = new CoopLink( url, user, password );
        workflowLink.exportXMLSystemWorkFlowFormPetitionData(formCode,selectProperties,filePath);
	}
}
