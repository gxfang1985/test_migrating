import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.WorkFlowdataItemProperties;
import jp.co.cybozu.garoon2.WorkFlowdataSelectProperties;

public class TestWorkFlowPetitionDataXMLExport_4 {
	public static void main ( String args[]) throws Exception{
        String url = null;                                      // Garoon��URL
        String user = null;                                     // ���[�U�[�A�J�E���g��
        String password = null;                                 // �p�X���[�h
        String fid = null;                                      // �t�H�[��ID
        String filePath = null;                                 // XML�t�@�C���p�X
        WorkFlowdataSelectProperties selectProperties = new WorkFlowdataSelectProperties();
        // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
        CoopLink workflowLink = new CoopLink( url, user, password );
        workflowLink.exportXMLSystemWorkFlowFormPetitionData(Long.parseLong(fid),selectProperties,filePath);
	}
}
