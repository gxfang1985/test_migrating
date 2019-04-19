import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;

import jp.co.cybozu.garoon2.CoopLink;

public class TestBulletinAdd {
	public static void main ( String args[]) throws Exception{
	    //String url = "http://haken-kreuz.corp.cybozu.co.jp/cgi-bin/cbgrn213/grn.cgi";                     // GaroonのURL
		String url = "http://localhost/scripts/cbgrn/grn.exe";                     // GaroonのURL
		
		String user = "Administrator";                    // ユーザーアカウント名
	    String password = "cybozu";                // パスワード
        String title = "test";                        // タイトル
        String categoryCode = "test";                 // カテゴリコード
        String registrant = null;                   // 差出人
        //String sdate = null;                        // 掲示期間開始日
        //String edate = null;                        // 掲示期間終了日
        Calendar sCal =null;       
        Calendar eCal = null; 
        String data = "test\rtest";                         // 本文
        boolean canFollow = true;                  // フォロー許可
        Collection attachedFiles = new ArrayList(); // 添付ファイル

        CoopLink bulletinLink =null;                        //CoopLink代入用
        
        // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)    
        bulletinLink = new CoopLink(url, user, password);
        
        // Garoonに掲示情報を送信    
        bulletinLink.putBulletinAdd(title,          // タイトル
                                            categoryCode,  // カテゴリコード
                                            sCal,          // 掲示期間開始日
                                            eCal,          // 掲示期間終了日
                                            data,          // 本文
                                            attachedFiles, // 添付ファイル
                                            canFollow,     // フォロー書込許可
                                            registrant);   // 差出人

	}
}