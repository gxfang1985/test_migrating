import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.WorkFlowdataItemProperties;

public class TestWorkFlowPetitionDataXMLExport_2 {
	public static void main ( String args[]) throws Exception{
        String url = null;                                      // Garoon��URL
        String user = null;                                     // ���[�U�[�A�J�E���g��
        String password = null;                                 // �p�X���[�h
        String pid = null;                                      // �\��ID
        String filePath = null;                                 // XML�t�@�C���p�X
        
        // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
        CoopLink workflowLink = new CoopLink( url, user, password );
        workflowLink.exportXMLSystemWorkFlowPetitionData(Long.parseLong(pid),filePath);
	}
}
