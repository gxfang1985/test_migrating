import jp.co.cybozu.garoon2.CoopLink;

public class TestScheduleFollowDelete {
    public static void main ( String args[]) throws Exception{
        
        String url = null;                                // Garoon��URL
        String user = null;                               // ���O�C�����[�U�[�A�J�E���g
        String password = null;                           // ���O�C���p�X���[�h
        String registrant = null;                         // �폜��
        String fid = null;                                // �K���[���Q�̃X�P�W���[���t�H���[ID
        String followId = null;                           // �K���[���Q�̃X�P�W���[���t�H���[ID�i�߂�l�j
        CoopLink scheduleLink = null;                     // CoopLink����p
        
        // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
        scheduleLink = new CoopLink( url,user,password );
        
        // Garoon�ɃX�P�W���[���폜���𑗐M(�ʏ�\��/�o�i�[�\��̂ݑΉ�)
        followId = scheduleLink.putScheduleFollowDelete(Long.parseLong(fid),  // �K���[���Q�̃X�P�W���[���t�H���[ID
                                                       registrant);          // �폜��
        System.out.println(followId); // �߂�l�\��
    }
}
