import jp.co.cybozu.garoon2.CoopLink;

public class TestWorkFlowDownloadSystemFile_2 {
	public static void main ( String args[]) throws Exception{
        String url = "http://haken-kreuz.corp.cybozu.co.jp/cgi-bin/cbgrn213/grn.cgi";                          // GaroonのURL
        String user = "Administrator";                         // ログインユーザーアカウント
        String password = "password";                     // ログインパスワード
        String afid = "1";                          // ワークフローの添付ファイルID
        String dirPath = null;                       // ディレクトリパス
        String fileName = "";                      // 添付ファイル名
        
        CoopLink workflowLink = null;                 // CoopLink代入用

        // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
        workflowLink = new CoopLink( url, user, password );
        
        // ファイル名を別名で保存する場合
        workflowLink.downloadSystemWorkFlowAttachedFile( Long.parseLong(afid),     // ワークフローの添付ファイルID
                                                         dirPath,                 // ディレクトリパス
                                                         fileName );              // 添付ファイル名
	}
}
