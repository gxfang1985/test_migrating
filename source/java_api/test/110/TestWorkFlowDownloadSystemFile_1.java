import jp.co.cybozu.garoon2.CoopLink;

public class TestWorkFlowDownloadSystemFile_1 {
	public static void main ( String args[]) throws Exception{
        String url = "http://haken-kreuz.corp.cybozu.co.jp/cgi-bin/cbgrn213/grn.cgi";                          // GaroonのURL
        String user = "Administrator";                         // ログインユーザーアカウント
        String password = "cybozu";                     // ログインパスワード
        String afid = "1";                          // ワークフローの添付ファイルID
        String dirPath = "";                       // ディレクトリパス
        
        CoopLink workflowLink = null;                 // CoopLink代入用

        // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
        workflowLink = new CoopLink( url, user, password );
        
        // ガルーン２ ワークフロー上の添付ファイル名で保存する場合
        workflowLink.downloadSystemWorkFlowAttachedFile( Long.parseLong(afid),     // ワークフローの添付ファイルID      
                                                         dirPath );               // ディレクトリパス
	}
}
