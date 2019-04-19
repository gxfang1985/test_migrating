import jp.co.cybozu.garoon2.CoopLink;

public class TestMailAccountExport {
    public static void main ( String args[]) throws Exception{
        
        String url = "http://haken-kreuz.corp.cybozu.co.jp/cgi-bin/cbgrn213/grn.cgi";                                  //GaroonのURL
        String user = "Administrator";                                 //ユーザーアカウント名
        String password = "cybozu";                             //パスワード
        String filePath = "test.csv";                             // CSVファイルパス
        boolean sjisEncode = true;                       // ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
        boolean skip = false;                              // 先頭行の有無(true:有 false:無)
        CoopLink grnLink = null;     
        
        // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
        grnLink = new CoopLink( url,user,password );

        // Garoonへデータ送信
        grnLink.exportMailAccount( filePath,                // CSVファイルパス
                                   skip,                    // 先頭行の有無(true:有 false:無)
                                   sjisEncode);           // ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
    }
}
