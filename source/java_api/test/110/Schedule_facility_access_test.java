import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;

import jp.co.cybozu.garoon2.CoopLink;

public class Schedule_facility_access_test {
	public static void main(String[] args) {
        String url = "http://haken-kreuz.corp.cybozu.co.jp/cgi-bin/cbgrn213/grn.cgi";
        String user = "Administrator";
        String password = "cybozu";
        CoopLink cp ;
        String registrant = "cybozu";
        String followId = null;

       
        try {
             cp = new CoopLink(url,user,password);
             //////////////////////////共通
             SimpleDateFormat sdf = new SimpleDateFormat();
             sdf.setLenient( false );  
             sdf.applyPattern( "yyyy-MM-dd" );
             SimpleDateFormat sdf2 = new SimpleDateFormat();
             sdf2.setLenient( false );  
             sdf2.applyPattern( "H:mm" );
             Calendar stCal = null;         
             Calendar etCal = null; 
             Collection userAccount = new ArrayList();   // 参加者のユーザーアカウント
             userAccount.add("Administrator");
             Collection facilityCode = new ArrayList();  // 施設コード
             facilityCode.add("001");
             
             //////////////////////////////登録
             String addevent = null;
             String eventKind = "0";                     // 予定区分
             String titleMenu = null;                    // 予定メニュー
             String title = "登録";                        // 予定タイトル
             String eventPrivate = "0";                  // 公開/非公開
             String detail = null;                       // 予定メモ  

             Calendar sCal = Calendar.getInstance();
             sCal.clear();
             sCal.setTime(sdf.parse("2007-05-10"));
             Calendar eCal = Calendar.getInstance();
             eCal.clear();
             eCal.setTime(sdf.parse("2007-05-10"));
             stCal = Calendar.getInstance();
             stCal.clear();
             stCal.setTime(sdf2.parse("11:00"));
             etCal = Calendar.getInstance();
             etCal.clear();
             etCal.setTime(sdf2.parse("12:00"));

             //////////////////////////////更新
             long modid = 30;
             String modtitleMenu = null;                    // 予定メニュー
             String modtitle = "更新";                        // 予定タイトル
             String modeventPrivate = "0";                  // 公開/非公開
             String moddetail = null;                       // 予定メモ  
             Calendar modsCal = Calendar.getInstance();
             modsCal.clear();
             modsCal.setTime(sdf.parse("2007-05-18"));
             Calendar modeCal = Calendar.getInstance();
             modeCal.clear();
             modeCal.setTime(sdf.parse("2007-05-18"));
             
             Calendar modstCal = Calendar.getInstance();
             modstCal.clear();
             modstCal.setTime(sdf2.parse("11:00"));
             Calendar modetCal = Calendar.getInstance();
             modetCal.clear();
             modetCal.setTime(sdf2.parse("12:00"));

             //////////////////////////////削除
             String deladdevent = null;
             Collection deluserAccount = new ArrayList();   // 参加者のユーザーアカウント
             deluserAccount.add("Administrator");

             //////////////////////////////フォロー登録
             long faddid = 31;
             String data = "フォロー";
             
            System.out.println("①登録start--------------------------------------");
            try {
                // Garoonへスケジュール登録情報を送信
                addevent = cp.putScheduleAdd(Integer.parseInt(eventKind),// 予定区分
                                                    titleMenu,                  // 予定タイトルメニュー
                                                    title,                      // 予定タイトル
                                                    eventPrivate,               // 公開/非公開
                                                    detail,                     // 予定メモ
                                                    sCal,                       // 開始日
                                                    eCal,                       // 終了日
                                                    stCal,                      // 開始時刻
                                                    etCal,                      // 終了時刻
                                                    userAccount,                // 参加者のユーザーアカウント
                                                    facilityCode,               // 施設コード
                                                    registrant);                // 登録者
                if(addevent == null){
                	
                }else{
                    // Garoonにスケジュール削除情報を送信(通常予定/バナー予定のみ対応)
                    cp.putScheduleDelete(Long.parseLong(addevent),  // イベントID
                                                           null);              // 更新者                	
                }

                System.out.println(addevent);
            }catch (Exception e){
                //e.printStackTrace();
                System.out.println(e.toString());
            }
            System.out.println("①登録finish--------------------------------------");
   
            System.out.println("②更新start--------------------------------------");
            try {
                // スケジュール更新情報を送信
                String modevent = cp.putScheduleModify(modid, // イベントID
                                                       modtitleMenu,               // 予定メニュー
                                                       modtitle,                   // 予定タイトル
                                                       modeventPrivate,            // 公開/非公開
                                                       moddetail,                  // 予定メモ
                                                       modsCal,                    // 開始日
                                                       modeCal,                    // 終了日
                                                       modstCal,                   // 開始時刻
                                                       modetCal,                   // 終了時刻
                                                       userAccount,            // 参加者のユーザーアカウント
                                                       facilityCode,           // 施設コード
                                                       registrant);             // 更新者
                System.out.println(modevent);
            }catch (Exception e){
                //e.printStackTrace();
                System.out.println(e.toString());
            }
            System.out.println("②更新finish--------------------------------------");         
 
            System.out.println("③削除start--------------------------------------");
            try {
                // Garoonへスケジュール登録情報を送信
                deladdevent = cp.putScheduleAdd(Integer.parseInt(eventKind),// 予定区分
                                                    titleMenu,                  // 予定タイトルメニュー
                                                    title,                      // 予定タイトル
                                                    eventPrivate,               // 公開/非公開
                                                    detail,                     // 予定メモ
                                                    sCal,                       // 開始日
                                                    eCal,                       // 終了日
                                                    stCal,                      // 開始時刻
                                                    etCal,                      // 終了時刻
                                                    deluserAccount,                // 参加者のユーザーアカウント
                                                    facilityCode,               // 施設コード
                                                    null);                // 登録者

                // Garoonにスケジュール削除情報を送信(通常予定/バナー予定のみ対応)
                String delevent = cp.putScheduleDelete(Long.parseLong(deladdevent ),  // イベントID
                                                       registrant);              // 更新者
                System.out.println(delevent);
            }catch (Exception e){
                //e.printStackTrace();
                System.out.println(e.toString());
                // Garoonにスケジュール削除情報を送信(通常予定/バナー予定のみ対応)
                String delevent = cp.putScheduleDelete(Long.parseLong(deladdevent ),  // イベントID
                                                       null);              // 更新者
            }
            
            System.out.println("③削除finish--------------------------------------");  
           
            System.out.println("④フォロー登録start--------------------------------------");
            try {
                // Garoonへスケジュールフォロー登録情報を送信
                followId = cp.putScheduleFollowAdd(faddid,       // ガルーン２のイベントID
                	                                        data,                      // フォローの本文
                	                                        registrant);               // 登録者
                System.out.println(followId);
            }catch (Exception e){
                //e.printStackTrace();
                System.out.println(e.toString());
            }
            System.out.println("④フォロー登録finish--------------------------------------");    
 
            System.out.println("⑤フォロー削除start--------------------------------------");
            try {
                // Garoonへスケジュールフォロー登録情報を送信
/*            	String deladdfollowId = null;
                deladdfollowId = cp.putScheduleFollowAdd(faddid,       // ガルーン２のイベントID
                	                                        data,                      // フォローの本文
                	                                        registrant);               // 登録者
*/                if(followId == null){
                    // Garoonにスケジュールフォロー削除情報を送信
                    String delfollowId = cp.putScheduleFollowDelete(Long.parseLong("1106"),  // ガルーン２のスケジュールフォローID
                                                                   registrant);          // 削除者
                    System.out.println(delfollowId);
                    
                }else{
                    // Garoonへスケジュールフォロー登録情報を送信
                    String deladdfollowId = cp.putScheduleFollowAdd(faddid,       // ガルーン２のイベントID
                    	                                        data,                      // フォローの本文
                    	                                        registrant);               // 登録者
                    // Garoonにスケジュールフォロー削除情報を送信
                    String delfollowId = cp.putScheduleFollowDelete(Long.parseLong(deladdfollowId),  // ガルーン２のスケジュールフォローID
                                                                   registrant);          // 削除者
                    System.out.println(delfollowId);
                }

                
            }catch (Exception e){
                //e.printStackTrace();
                System.out.println(e.toString());
            }
            System.out.println("⑤フォロー削除finish--------------------------------------");   
            
        }catch (Exception e){
            e.printStackTrace();
        }
    } 
}
