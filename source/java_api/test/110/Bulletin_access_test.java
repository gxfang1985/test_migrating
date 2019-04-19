import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;

import jp.co.cybozu.garoon2.CoopLink;

public class Bulletin_access_test {
	public static void main(String[] args) {
        String url = "http://haken-kreuz.corp.cybozu.co.jp/cgi-bin/cbgrn213/grn.cgi";
        String user = "Administrator";
        String password = "cybozu";
        CoopLink cp ;
        String registrant = "cybozu";
        String bulletinId = null;
        String fid = null;
       
        try {
             cp = new CoopLink(url,user,password);
             //////////////////////////共通
             
             String categoryCode = "test";                 // カテゴリコード
             
             boolean canFollow = true;                  // フォロー許可
             Collection attachedFiles = new ArrayList(); // 添付ファイル
             
             //////////////////////////////登録
             String title = "登録-アクセス権";                        // タイトル
             String data = "登録掲示板データ";                         // 本文

             //////////////////////////////更新
             long modid = 10;
             String modtitle = "更新-アクセス権";                        // タイトル
             String moddata = "更新掲示板データ";                         // 本文

             //////////////////////////////削除
             Collection deluserAccount = new ArrayList();   // 参加者のユーザーアカウント
             deluserAccount.add("Administrator");

             //////////////////////////////フォロー登録
             long followaddid = 11;
             
            System.out.println("①登録start--------------------------------------");
            try {
                // Garoonに掲示情報を送信
                bulletinId=cp.putBulletinAdd(title,          // タイトル
                                                        categoryCode,  // カテゴリコード
                                                        null,          // 掲示期間開始日
                                                        null,          // 掲示期間終了日
                                                        data,          // 本文
                                                        null, // 添付ファイル
                                                        canFollow,     // フォロー書込許可
                                                        registrant);   // 差出人
                System.out.println(bulletinId);
            }catch (Exception e){
                //e.printStackTrace();
                System.out.println(e.toString());
            }
            System.out.println("①登録finish--------------------------------------");
   
            System.out.println("②更新start--------------------------------------");
            try {
                // Garoonに掲示情報を送信
                String modebulletinId=cp.putBulletinModify(modid,  // 掲示記事ID
                                                           modtitle,               // タイトル
                                                           null,                // 掲示期間開始日
                                                           null,                // 掲示期間終了日
                                                           moddata,                // 本文
                                                           null,       // 添付ファイル
                                                           canFollow,           // フォロー書込許可
                                                           registrant);         // 差出人
                System.out.println(modebulletinId);
            }catch (Exception e){
                //e.printStackTrace();
                System.out.println(e.toString());
            }
            System.out.println("②更新finish--------------------------------------");         
 
            System.out.println("③削除start--------------------------------------");
            try {
            	if(bulletinId == null){
                    // Garoonに掲示板削除情報を送信
                    String delarticle = cp.putBulletinDelete(Long.parseLong("24"),  // 掲示板記事ID
                                                             registrant);   // 更新者
                    System.out.println(delarticle);
            	}else{
                    // Garoonに掲示情報を送信
                    String deladdbulletinId=cp.putBulletinAdd(title,          // タイトル
                                                            categoryCode,  // カテゴリコード
                                                            null,          // 掲示期間開始日
                                                            null,          // 掲示期間終了日
                                                            data,          // 本文
                                                            null, // 添付ファイル
                                                            canFollow,     // フォロー書込許可
                                                            registrant);   // 差出人
                	
                    // Garoonに掲示板削除情報を送信
                    String delarticle = cp.putBulletinDelete(Long.parseLong(deladdbulletinId),  // 掲示板記事ID
                                                             registrant);   // 更新者
                    System.out.println(delarticle);
            	}

            }catch (Exception e){
                //e.printStackTrace();
                System.out.println(e.toString());
            }
            System.out.println("③削除finish--------------------------------------");  
           
            System.out.println("④フォロー登録start--------------------------------------");
            try {
                // Garoonにフォロー情報を送信
                fid = cp.putBulletinFollowAdd(followaddid,// 掲示板ID
                                                        data,               // 本文
                                                        null,      // 添付ファイル
                                                        registrant);        // 登録者
                System.out.println(fid);
            }catch (Exception e){
                //e.printStackTrace();
                System.out.println(e.toString());
            }
            System.out.println("④フォロー登録finish--------------------------------------");    
 
            System.out.println("⑤フォロー削除start--------------------------------------");
            try {
                if(fid == null){
                    // Garoonに掲示板フォロー削除情報を送信
                    String deladdarticlefollow = cp.putBulletinFollowDelete(Long.parseLong("17"),// 掲示板記事フォローID
                                                                         registrant);                    // 更新者
                    System.out.println(deladdarticlefollow);
                    
                }else{
                    // Garoonにフォロー情報を送信
                    String deladdfid = cp.putBulletinFollowAdd(followaddid,// 掲示板ID
                                                            data,               // 本文
                                                            null,      // 添付ファイル
                                                            registrant);        // 登録者
                    // Garoonに掲示板フォロー削除情報を送信
                    String deladdarticlefollow = cp.putBulletinFollowDelete(Long.parseLong(deladdfid),// 掲示板記事フォローID
                                                                         registrant);                    // 更新者
                    System.out.println(deladdarticlefollow);
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
