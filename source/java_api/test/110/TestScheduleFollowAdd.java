import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.RemoteException;

public class TestScheduleFollowAdd {
 

	public static void main ( String args[]) throws Exception{
   
	    String url = "http://haken-kreuz/cgi-bin/cbgrn213/grn.cgi";                          // GaroonのURL
	    String user = "Administrator";                         // ログインユーザーアカウント
	    String password = "cybozu";                     // ログインパスワード
	    String user2 = "cybozu";                         // ログインユーザーアカウント
	    String password2 = "cybozu";                     // ログインパスワード
	    final String registrant = null;                   // 登録者
	    //final String registrant2 = "hieda";                   // 登録者
	    final String registrant2 = null;                   // 登録者
	    final String eid = "28";                          // イベントID
	    final String eid2 = "29";                          // イベントID
	    final String data = "admin";                         // フォローの本文
	    final String data2 = "cybozu";                         // フォローの本文
	    final String followId =null;                      // ガルーン２のスケジュールフォローID(戻り値)
	    final CoopLink scheduleLink = new CoopLink( url,user,password );               // CoopLink代入用
	    final CoopLink scheduleLink2 = new CoopLink( url,user2,password2 );   

        // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
        //scheduleLink = new CoopLink( url,user,password );
        //scheduleLink2 = new CoopLink( url,user2,password2 );

        //adminでの登録
        Thread thread = new Thread() {
  	      public void run() {
  		      try {
  		    	for( int r=0 ; r<100 ; r++ ){
  	  		        // Garoonへスケジュール登録情報を送信
  	  		        scheduleLink.putScheduleFollowAdd(Long.parseLong(eid),       // ガルーン２のイベントID
  	  		        	                                        data,                      // フォローの本文
  	  		        	                                        registrant);               // 登録者  		    		
  		    	}

  		      } catch (RemoteException e) {
  			      // TODO 自動生成された catch ブロック
  			      e.printStackTrace();
  		      } catch (Exception e) {
  			      // TODO 自動生成された catch ブロック
  			      e.printStackTrace();
  		      }
  	      }
        };
        //cybozuでの登録
        Thread thread2 = new Thread() {
  	      public void run() {
  		      try {
  		    	for( int r=0 ; r<100 ; r++ ){
  		          // Garoonへスケジュール登録情報を送信
  		          scheduleLink2.putScheduleFollowAdd(Long.parseLong(eid2),       // ガルーン２のイベントID
  		          	                                        data2,                      // フォローの本文
  		          	                                        registrant2);               // 登録者		    		
  		    	}

  		      } catch (RemoteException e) {
  			      // TODO 自動生成された catch ブロック
  			      e.printStackTrace();
  		      } catch (Exception e) {
  			      // TODO 自動生成された catch ブロック
  			      e.printStackTrace();
  		      }
  	      }
        };       
        thread.start();
        thread2.start();
        
        


        System.out.println(followId); // 戻り値表示
    }
}
