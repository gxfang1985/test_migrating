import java.text.SimpleDateFormat;
import java.util.Date;

import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.WorkFlowdataItemProperties;
import jp.co.cybozu.garoon2.WorkFlowdataSelectProperties;

public class TestWorkFlowdataSelectProperties {
	public static void main ( String args[]) throws Exception{
        String url = null;                     // Garoon��URL
        String user = null;                    // ���[�U�[�A�J�E���g��
        String password = null;                // �p�X���[�h
        String fid = null;                                      // �t�H�[��ID
        String filePath = null;                                 // XML�t�@�C���p�X
        //�������C�ȉ��ύX�̕K�v����܂���I�̂���////////////////
        Date from =null;
        Date to = null;
        SimpleDateFormat sdf = new SimpleDateFormat();
        sdf.setLenient( false );
        sdf.applyPattern( "yyyy-MM-dd" );
        //////////////////////////////////////////////////////////
        
        WorkFlowdataItemProperties items = new WorkFlowdataItemProperties();
        
        WorkFlowdataSelectProperties selectProperties = new WorkFlowdataSelectProperties();
        //�������C�ȉ��K�X�ύX�̂���///////////////////////////////////////////////////////////
        
        //set�n
        //selectProperties.setWherePetitionNumber("������");           // �o�͏���(�\���ԍ�)
        //selectProperties.setWhereTitle("������");                    // �o�͏���(�W��)
        //selectProperties.setWhereCreatorName("������");              // �o�͏���(�\���Җ�(�\����))
        
        //�X�e�[�^�X
        //selectProperties.setWhereStatusProgressing(false);        // �o�͏���(�X�e�[�^�X(�i�s��))
        //selectProperties.setWhereStatusAcceptance(false);         // �o�͏���(�X�e�[�^�X(���F))
        //selectProperties.setWhereStatusReject(false);             // �o�͏���(�X�e�[�^�X(�p��))
        //selectProperties.setWhereStatusFinish(false);             // �o�͏���(�X�e�[�^�X(����))  
        //selectProperties.setWhereStatusCancel(false);             // �o�͏���(�X�e�[�^�X(���))
        
        //����      
        //from = sdf.parse( "2007-02-25" );
        //to = sdf.parse( "2007-04-26" );
        //selectProperties.setWhereDate(Integer.valueOf("0"),from,to);    // �o�͏���(����)
        
        //�\�[�g
        //�������͈ȉ���value�̒l��ς��Ă��������B�܂��ȉ�2�s+1�s�i���~�j�̃R�����g�A�E�g���O���Ă�������
        //selectProperties.setSortAsc(new Integer("0"));        // ���я�����
        //selectProperties.setSortDesc(new Integer("0"));         // ���я��~�� 
 
        //get�n
        //System.out.println(selectProperties.getWherePetitionNumber());           // �o�͏���(�\���ԍ�)
        //System.out.println(selectProperties.getWhereTitle());                    // �o�͏���(�W��)
        //System.out.println(selectProperties.getWhereCreatorName());              // �o�͏���(�\���Җ�(�\����))
        
        //�X�e�[�^�X
        //System.out.println(selectProperties.getWhereStatusProgressing());        // �o�͏���(�X�e�[�^�X(�i�s��))
        //System.out.println(selectProperties.getWhereStatusAcceptance());         // �o�͏���(�X�e�[�^�X(���F))
        //System.out.println(selectProperties.getWhereStatusReject());             // �o�͏���(�X�e�[�^�X(�p��))
        //System.out.println(selectProperties.getWhereStatusFinish());             // �o�͏���(�X�e�[�^�X(����))  
        //System.out.println(selectProperties.getWhereStatusCancel());             // �o�͏���(�X�e�[�^�X(���))
        
        //����      
        //System.out.println(selectProperties.getWhereDateType());    // �o�͏���(�^�C�v)
        //System.out.println(selectProperties.getWhereDateFrom());    // �o�͏���(from)
        //System.out.println(selectProperties.getWhereDateTo());    // �o�͏���(to)
        
        //�\�[�g
        //System.out.println(selectProperties.getSortField());     //���я��ɐݒ肳��Ă���t�B�[���h��Ԃ��܂�
        //System.out.println(selectProperties.isSortAsc());        //���я��������ł��邩��Ԃ��܂�
        //int sortvalue =Integer.parseInt(value);  
        //System.out.println(selectProperties.setSortAsc(new Integer(sortvalue));        // ���я�����
        //System.out.println(selectProperties.setSortDesc(new Integer(sortvalue));         // ���я��~�� 
        
        //set�n�ł̂ݎg�p
        // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
        CoopLink workflowLink = new CoopLink( url, user, password );
        workflowLink.exportXMLSystemWorkFlowFormPetitionData(Long.parseLong(fid),selectProperties,items,filePath);

	
	
	
	}
}
