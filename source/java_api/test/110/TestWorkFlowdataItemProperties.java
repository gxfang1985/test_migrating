import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.WorkFlowdataItemProperties;

public class TestWorkFlowdataItemProperties {
	public static void main ( String args[]) throws Exception{
        String url = null;                                      // Garoon��URL
        String user = null;                                     // ���[�U�[�A�J�E���g��
        String password = null;                                 // �p�X���[�h
        String pid = null;                                      // �\��ID
        String filePath = null;                                 // XML�t�@�C���p�X
        
        WorkFlowdataItemProperties items = new WorkFlowdataItemProperties();
        
        //�������C�ȉ��K�X�ύX�̂���///////////////////////////////////////////////////////////
        
        //�ꊇ�ݒ�
        //items.allDispSet(true);
    
        //  �f�t�H���g�l�Z�b�g
        //items.init();
        
        //�X�e�b�v�֘A�ꊇ�Z�b�g
        //items.stepDispSet(true);
        
        //get�n�̎������͈�U���ڂ�S����\���ɃZ�b�g
        //items.allDispSet(false);   
        
        //set�n
        //�e���ڐݒ�,�R�����g�A�E�g���O���ƍ��ڂ��o�͂��邩�ǂ�����true,false�Őݒ�ł��܂��D
        //items.setDispPetitionNumber(true);                        // �\������(�\���ԍ�)                       
        //items.setDispStatus(true);                                // �\������(���݃X�e�[�^�X)                                
        //items.setDispCreatorId(true);                             // �\������(�\����ID)                       
        //items.setDispCreatorLoginName(true);                      // �\������(�\���҃��O�C����)                
        //items.setDispCreatorDisplayName(true);                    // �\������(�\���ҕ\����)                          
        //items.setDispCreateTime(true);                            // �\������(�\������)                   
        //items.setDispAcceptanceHandlerId(true);                   // �\������(���F��ID)           
        //items.setDispAcceptanceHandlerLoginName(true);            // �\������(���F�҃��O�C����)           
        //items.setDispAcceptanceHandlerDisplayName(true);          // �\������(���F�ҕ\����)                      
        //items.setDispAcceptanceTime(true);                        // �\������(���F����)                        
        //items.setDispRejectHandlerId(true);                       // �\������(�p����ID)              
        //items.setDispRejectHandlerLoginName(true);                // �\������(�p���҃��O�C����)                
        //items.setDispRejectHandlerDisplayName(true);              // �\������(�p���ҕ\����)                             
        //items.setDispRejectTime(true);                            // �\������(�p������)                   
        //items.setDispFinishHandlerId(true);                       // �\������(������ID)              
        //items.setDispFinishHandlerLoginName(true);                // �\������(�����҃��O�C����)               
        //items.setDispFinishHandlerDisplayName(true);              // �\������(�����ҕ\����)                    
        //items.setDispFinishTime(true);                            // �\������(��������)                       
        //items.setDispCancelHandlerId(true);                       // �\������(�����ID)              
        //items.setDispCancelHandlerLoginName(true);                // �\������(����҃��O�C����)                
        //items.setDispCancelHandlerDisplayName(true);              // �\������(����ҕ\����)                           
        //items.setDispCancelTime(true);                            // �\������(�������)                             
        //items.setDispItemData(true);                              // �\������(���ڒl)                            
        //items.setDispStepStatus(true);                            // �\������(�o�H�X�e�[�^�X)                      
        //items.setDispStepHandleResult(true);                      // �\������(�o�H��������)                       
        //items.setDispStepHandleComment(true);                     // �\������(�o�H�����R�����g)                          
        //items.setDispStepHandlerId(true);                         // �\������(�o�H������ID)                  
        //items.setDispStepHandlerLoginName(true);                  // �\������(�o�H�����҃��O�C����)               
        //items.setDispStepHandlerDisplayName(true);                // �\������(�o�H�����ҕ\����)                    
        //items.setDispStepHandleTime(true);                        // �\������(�o�H��������)
        
        //get�n
        //�e�ݒ荀�ڎ擾,�R�����g�A�E�g���O����true��false���Ԃ��Ă��܂��D
        //System.out.println(items.getDispPetitionNumber());                       // �\������(�\���ԍ�)                       
        //System.out.println(items.getDispStatus());                               // �\������(���݃X�e�[�^�X)                            
        //System.out.println(items.getDispCreatorId());                            // �\������(�\����ID)                       
        //System.out.println(items.getDispCreatorLoginName());                     // �\������(�\���҃��O�C����)                
        //System.out.println(items.getDispCreatorDisplayName());                   // �\������(�\���ҕ\����)                          
        //System.out.println(items.getDispCreateTime());                           // �\������(�\������)                   
        //System.out.println(items.getDispAcceptanceHandlerId());                  // �\������(���F��ID)           
        //System.out.println(items.getDispAcceptanceHandlerLoginName());           // �\������(���F�҃��O�C����)           
        //System.out.println(items.getDispAcceptanceHandlerDisplayName());         // �\������(���F�ҕ\����)                      
        //System.out.println(items.getDispAcceptanceTime());                       // �\������(���F����)                        
        //System.out.println(items.getDispRejectHandlerId());                      // �\������(�p����ID)              
        //System.out.println(items.getDispRejectHandlerLoginName());               // �\������(�p���҃��O�C����)                
        //System.out.println(items.getDispRejectHandlerDisplayName());             // �\������(�p���ҕ\����)                             
        //System.out.println(items.getDispRejectTime());                           // �\������(�p������)                   
        //System.out.println(items.getDispFinishHandlerId());                      // �\������(������ID)              
        //System.out.println(items.getDispFinishHandlerLoginName());               // �\������(�����҃��O�C����)               
        //System.out.println(items.getDispFinishHandlerDisplayName());             // �\������(�����ҕ\����)                    
        //System.out.println(items.getDispFinishTime());                           // �\������(��������)                       
        //System.out.println(items.getDispCancelHandlerId());                      // �\������(�����ID)              
        //System.out.println(items.getDispCancelHandlerLoginName());               // �\������(����҃��O�C����)                
        //System.out.println(items.getDispCancelHandlerDisplayName());             // �\������(����ҕ\����)                           
        //System.out.println(items.getDispCancelTime());                           // �\������(�������)                             
        //System.out.println(items.getDispItemData());                             // �\������(���ڒl)                            
        //System.out.println(items.getDispStepStatus());                           // �\������(�o�H�X�e�[�^�X)                      
        //System.out.println(items.getDispStepHandleResult());                     // �\������(�o�H��������)                       
        //System.out.println(items.getDispStepHandleComment());                    // �\������(�o�H�����R�����g)                          
        //System.out.println(items.getDispStepHandlerId());                        // �\������(�o�H������ID)                  
        //System.out.println(items.getDispStepHandlerLoginName());                 // �\������(�o�H�����҃��O�C����)               
        //System.out.println(items.getDispStepHandlerDisplayName());               // �\������(�o�H�����ҕ\����)                    
        //System.out.println(items.getDispStepHandleTime());                       // �\������(�o�H��������)
        
        // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
        CoopLink workflowLink = new CoopLink( url, user, password );
        workflowLink.exportXMLSystemWorkFlowPetitionData(Long.parseLong(pid),items,filePath);
	}
}
