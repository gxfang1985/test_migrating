import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.RemoteException;

public class TestScheduleFollowAdd {
 

	public static void main ( String args[]) throws Exception{
   
	    String url = "http://haken-kreuz/cgi-bin/cbgrn213/grn.cgi";                          // Garoon��URL
	    String user = "Administrator";                         // ���O�C�����[�U�[�A�J�E���g
	    String password = "cybozu";                     // ���O�C���p�X���[�h
	    String user2 = "cybozu";                         // ���O�C�����[�U�[�A�J�E���g
	    String password2 = "cybozu";                     // ���O�C���p�X���[�h
	    final String registrant = null;                   // �o�^��
	    //final String registrant2 = "hieda";                   // �o�^��
	    final String registrant2 = null;                   // �o�^��
	    final String eid = "28";                          // �C�x���gID
	    final String eid2 = "29";                          // �C�x���gID
	    final String data = "admin";                         // �t�H���[�̖{��
	    final String data2 = "cybozu";                         // �t�H���[�̖{��
	    final String followId =null;                      // �K���[���Q�̃X�P�W���[���t�H���[ID(�߂�l)
	    final CoopLink scheduleLink = new CoopLink( url,user,password );               // CoopLink����p
	    final CoopLink scheduleLink2 = new CoopLink( url,user2,password2 );   

        // Garoon�ւ̐ڑ�&�F��(�K���[����URL,���O�C����,�p�X���[�h)
        //scheduleLink = new CoopLink( url,user,password );
        //scheduleLink2 = new CoopLink( url,user2,password2 );

        //admin�ł̓o�^
        Thread thread = new Thread() {
  	      public void run() {
  		      try {
  		    	for( int r=0 ; r<100 ; r++ ){
  	  		        // Garoon�փX�P�W���[���o�^���𑗐M
  	  		        scheduleLink.putScheduleFollowAdd(Long.parseLong(eid),       // �K���[���Q�̃C�x���gID
  	  		        	                                        data,                      // �t�H���[�̖{��
  	  		        	                                        registrant);               // �o�^��  		    		
  		    	}

  		      } catch (RemoteException e) {
  			      // TODO �����������ꂽ catch �u���b�N
  			      e.printStackTrace();
  		      } catch (Exception e) {
  			      // TODO �����������ꂽ catch �u���b�N
  			      e.printStackTrace();
  		      }
  	      }
        };
        //cybozu�ł̓o�^
        Thread thread2 = new Thread() {
  	      public void run() {
  		      try {
  		    	for( int r=0 ; r<100 ; r++ ){
  		          // Garoon�փX�P�W���[���o�^���𑗐M
  		          scheduleLink2.putScheduleFollowAdd(Long.parseLong(eid2),       // �K���[���Q�̃C�x���gID
  		          	                                        data2,                      // �t�H���[�̖{��
  		          	                                        registrant2);               // �o�^��		    		
  		    	}

  		      } catch (RemoteException e) {
  			      // TODO �����������ꂽ catch �u���b�N
  			      e.printStackTrace();
  		      } catch (Exception e) {
  			      // TODO �����������ꂽ catch �u���b�N
  			      e.printStackTrace();
  		      }
  	      }
        };       
        thread.start();
        thread2.start();
        
        


        System.out.println(followId); // �߂�l�\��
    }
}
