import jp.co.cybozu.garoon2.CoopLink;

public class TestCabinetDelete {
    
    public static void main ( String args[]) throws Exception{
        
        String url = null;                          // Garoon��URL
        String user = null;                         // ���O�C�����[�U�[�A�J�E���g
        String password = null;                     // ���O�C���p�X���[�h
        String fid = null;                                  //�t�@�C��ID
        String registrant = null;                           //�폜��
        
        CoopLink cabinetLink = new CoopLink( url, user, password );
        String fileId = cabinetLink.putCabinetDelete( Long.parseLong(fid),registrant);
        System.out.println(fileId);
    }
}
