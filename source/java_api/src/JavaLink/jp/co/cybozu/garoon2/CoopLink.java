package jp.co.cybozu.garoon2;

import jp.co.cybozu.http.*;
import jp.co.cybozu.text.CSVReader;
import jp.co.cybozu.garoon2.util.GrnConnector;
import jp.co.cybozu.garoon2.util.Utils;

import java.io.*;
import java.net.HttpURLConnection;
import java.text.*;
import java.util.*;

/**
 * ガルーン２との各アプリケーション連携に共通する機能を実装します。<BR>
 * 
 * @author サイボウズ
 * @version 1.1.0
 * @see HttpClient
 * @see PostStream
 * @see RemoteException
 */
public class CoopLink extends HttpClient implements GrnConnector {

	/**
	 * アプリケーション連携のバージョン
	 */
	private static String CoopLinkVersion = "1.3.2 for Garoon 3.1.0";

	private static final String GASERROR_HEADER = "X-Cybozu-Error";

	private String grnURL;

	private static String loginUser;

	private static String loginPassword;

	private String csrfTicket;

	public static String getCoopLinkVersion() {
		return CoopLinkVersion;
	}

	/**
	 * 指定された<var>uri</var>及び、ログインに必要な <var>userName</var>,<var>password</var>を使用して
	 * ガルーン２への初期化とセッションを開始します。
	 * 
	 * @param uri
	 *            ガルーン２の実行に必要なURI (Uniform Resource Identifier) 文字列
	 * @param userName
	 *            ガルーン２へログインするためのログイン名
	 * @param password
	 *            ガルーン２へログインするために必要なパスワード文字列
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２上でエラーが発生した場合
	 */
	public CoopLink(String uri, String userName, String password)
			throws IOException, RemoteException {
		this(uri == null ? null : URI.create(uri), userName, password);

	}

	/**
	 * 指定された<var>uri</var>を使用して ガルーン２への初期化とセッションを開始します。
	 * 
	 * @param uri
	 *            ガルーン２の実行に必要なURI (Uniform Resource Identifier) 文字列
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２上でエラーが発生した場合
	 */
	public CoopLink(String uri) throws IOException, RemoteException {

		super(uri == null ? null : URI.create(uri.toString()));
		grnURL = getAddress(uri == null ? null : URI.create(uri.toString()));

	}

	private String getAddress(URI uri) {
		if (uri == null)
			return null;

		StringBuffer address = new StringBuffer().append(uri.getScheme())
				.append("://").append(uri.getHost());
		if (uri.getPort() != -1) {
			address.append(":").append(uri.getPort());
		}
		address.append(uri.getRawPath());

		return address.toString();
	}

	/**
	 * 指定された<var>coopURI</var>、ログイン用 <var>userName</var>,<var>password</var>を使用して
	 * ガルーン２への初期化とセッションを開始します。
	 * 
	 * @param uri
	 *            ガルーン２の実行に必要なURI (Uniform Resource Identifier) 文字列
	 * @param userName
	 *            ガルーン２へログインするためのログイン名
	 * @param password
	 *            ガルーン２へログインするために必要なパスワード文字列
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２上でエラーが発生した場合
	 */
	private CoopLink(URI uri, String userName, String password)
			throws IOException, RemoteException {
		super(uri == null ? null : uri);
		grnURL = getAddress(uri);
		// start the session
		login(userName, password);

	}

	/**
	 * ガルーン２連携用プログラムから出力された結果を処理します。 <br />
	 * リクエスト結果をHTMLの&lt;body&gt;部分より解析します。<br />
	 * リモートエンドに問題があった場合は、 {@link RemoteException}を投げます。
	 * 
	 * @param hc
	 *            {@link #getConnection}から返るHttpURLConnection.
	 * @param context
	 *            このメソッドが呼ばれた背景についての文言を指定します。 リモートエンドで何らかのエラーが起こった場合に、
	 *            {@link RemoteException}のエラーメッセージの一部になります。
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	private String processResult(java.net.HttpURLConnection hc, String context)
			throws IOException, RemoteException {
		super.processHeader(hc);
		checkErrorHeader(hc, context);

		// process output
		BufferedReader in = null;
		try {
			// in = new BufferedReader(
			// new InputStreamReader(hc.getInputStream(), "Shift_JIS"));
			in = new BufferedReader(new InputStreamReader(hc.getInputStream(),
					"UTF8"));
		} catch (UnsupportedEncodingException e) {
			// do nothing
		}

		int errno = 0;
		String event = null;

		while (true) {
			String line = in.readLine();
			// System.out.println(line);
			if (line == null)
				break;

			int setpos = line.indexOf("<Header Data><CR><LF>");
			if (setpos != -1) {
				int pointpos = line.indexOf(",", setpos);
				if (pointpos == -1) {
					errno = Integer.parseInt(line.substring(setpos + 21));
					break;
				} else {
					errno = Integer.parseInt(line.substring(setpos + 21,
							pointpos));
				}

				int endpos = line.indexOf("<Footer Data>", pointpos);
				if (endpos == -1) {
					event = line.substring(pointpos + 1);
				} else {
					event = line.substring(pointpos + 1, endpos);
				}
				break;
			} else {
				setpos = line.indexOf("<h2>");
				if (setpos == -1)
					continue;

				setpos = line.indexOf("(");
				if (setpos == -1)
					continue;

				int pointpos = line.indexOf(")", setpos);
				if (pointpos == -1) {
					event = line.substring(setpos + 1);
				} else {
					errno = 1;
					event = line.substring(setpos + 1, pointpos);
				}
				break;
			}
		}
		in.close();

		if (errno != 0) {
			throw new RemoteException(context + "(" + event + ")");
		}
		return event;
	}

	/**
	 * ガルーン２連携用プログラムから出力された結果を処理します。 <br />
	 * 
	 * @param hc
	 *            {@link #getConnection}から返るHttpURLConnection.
	 * @param context
	 *            このメソッドが呼ばれた背景についての文言を指定します。 リモートエンドで何らかのエラーが起こった場合に、
	 *            {@link RemoteException}のエラーメッセージの一部になります。
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	private BufferedReader processBufferResult(java.net.HttpURLConnection hc,
			String context) throws IOException, RemoteException {
		super.processHeader(hc);
		checkErrorHeader(hc, context);

		// process output
		BufferedReader in = null;
		try {
			in = new BufferedReader(new InputStreamReader(hc.getInputStream(),
					"UTF8"));
		} catch (UnsupportedEncodingException e) {
			// do nothing
		}

		return in;
	}

	// public APIs
	/**
	 * ガルーン２にログインし、セッションを開始します。 このメソッドは、インスタンス時({@link #CoopLink(String,String,String)})に自動で処理されます。
	 * 
	 * @param userName
	 *            ガルーン２へログインするためのログイン名
	 * @param password
	 *            ガルーン２へログインするために必要なパスワード文字列
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２上でエラーが発生した場合
	 */
	public void login(String userName, String password) throws IOException,
			RemoteException {
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopLogin").toString();

		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);

		PostStream ps = getURLEncodingStream(hc);
		if (userName != null)
			ps.addProperty("_account", userName); // アカウント
		else
			ps.addProperty("_account", ""); // アカウント

		if (password != null)
			ps.addProperty("_password", password); // パスワード
		else
			ps.addProperty("_password", ""); // パスワード

		ps.addProperty("version", CoopLinkVersion); // バージョン
		ps.close();

		// 2008/01/15 csrf 対応
		// processResult(hc, "login failed.");
		String csrf = processResult(hc, "login failed.");
		this.csrfTicket = csrf;

		// 2007/05/09 仕様変更 ログイン情報をフィールドにセット
		setLoginInfo(userName, password);

	}

	// 2007/05/09 仕様変更 ログイン情報をフィールドにセット
	private void setLoginInfo(String userName, String password) {
		// 設定されていない or フィールド値と設定したい値がが異なる場合のみフィールド値にセット
		if (loginUser == null || loginPassword == null
				|| !loginUser.equals(userName)
				|| !loginPassword.equals(password)) {
			loginUser = userName;
			loginPassword = password;
		}

	}

	/**
	 * 掲示板の登録処理を行います。<BR/>
	 * 
	 * @param title
	 *            標題
	 * @param categoryCode
	 *            ガルーン２の掲示板カテゴリコード
	 * @param startDate
	 *            掲示開始日.null指定可能(掲示開始日を指定しません)
	 * @param endDate
	 *            掲示終了日.null指定可能(掲示終了日を指定しません)
	 * @param data
	 *            本文.null指定可能(本文を入力しません)
	 * @param attachedFiles
	 *            添付ファイルとなるファイルパスの集合. null指定可能(添付ファイルを登録しません)<BR/>
	 *            要素は、String型またはtoString()でファイルパスを取得できるObjectでなければいけません<BR>
	 *            要素内にnullがある場合は、NullPointerExceptionが発生します
	 * @param canFollow
	 *            フォロー書込許可フラグ (true:書込可,false:書込不許可)
	 * @param registrant
	 *            登録者のログイン名.null指定可能(登録者はログインユーザとなります)
	 * @return 登録されたガルーン２の掲示板ID
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	public String putBulletinAdd(String title, String categoryCode,
			Calendar startDate, Calendar endDate, String data,
			Collection attachedFiles, boolean canFollow, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		/**
		 * 掲示板登録用cspの呼び出し先格納変数
		 */

		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopBulletin_add").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "bulletin"); // Application
		if (title != null)
			ps.addProperty("title", title); // 標題
		else
			ps.addProperty("title", ""); // 標題

		if (categoryCode != null)
			ps.addProperty("c_code", categoryCode); // カテゴリコード
		else
			ps.addProperty("c_code", ""); // カテゴリコード

		ps.addProperty("editor", "0"); // 書式編集を指定しない
		ps.addProperty("send", ""); // 掲示するコマンド
		if (canFollow)
			ps.addProperty("can_follow", "1"); // フォロー書込許可

		if (startDate == null && endDate == null)
			ps.addProperty("enable_term", "0"); // 掲示期間有無
		else
			ps.addProperty("enable_term", "1"); // 掲示期間有無

		if (registrant != null)
			ps.addProperty("registrant", registrant); // 差出人
		else
			ps.addProperty("registrant", ""); // 差出人

		if (data != null)
			ps.addProperty("data", data); // 掲示板本文
		else
			ps.addProperty("data", ""); // 掲示板本文

		if (startDate != null) {
			ps.addProperty("sterm_year", startDate.get(Calendar.YEAR)); // 掲示期間開始年
			ps.addProperty("sterm_month", startDate.get(Calendar.MONTH) + 1); // 掲示期間開始月
			ps.addProperty("sterm_day", startDate.get(Calendar.DAY_OF_MONTH)); // 掲示期間開始日
		} else {
			ps.addProperty("sterm_year", ""); // 掲示期間開始年
			ps.addProperty("sterm_month", ""); // 掲示期間開始月
			ps.addProperty("sterm_day", ""); // 掲示期間開始日
		}

		if (endDate != null) {
			ps.addProperty("eterm_year", endDate.get(Calendar.YEAR)); // 掲示期間終了年
			ps.addProperty("eterm_month", endDate.get(Calendar.MONTH) + 1); // 掲示期間終了月
			ps.addProperty("eterm_day", endDate.get(Calendar.DAY_OF_MONTH)); // 掲示期間終了日
		} else {
			ps.addProperty("eterm_year", ""); // 掲示期間終了年
			ps.addProperty("eterm_month", ""); // 掲示期間終了月
			ps.addProperty("eterm_day", ""); // 掲示期間終了日
		}

		if (attachedFiles != null) { // 添付ファイル
			int i = 0;
			for (Iterator it = attachedFiles.iterator(); it.hasNext();) {
				ps.addFile(new File(it.next().toString()), new StringBuffer()
						.append("file").append(Integer.toString(i++))
						.toString(), "application/octet-stream");
			}
		}

		ps.close();
		return processResult(hc,
				"failed in the registration of the article on the bulletin board.");
	}

	/**
	 * 掲示板の削除処理を行います。<BR/>
	 * 
	 * @param articleId
	 *            ガルーン２の掲示板ID
	 * @param registrant
	 *            削除者のログイン名.null指定可能(削除者はログインユーザとなります)
	 * @return 削除されたガルーン２上の掲示板ID
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	public String putBulletinDelete(long articleId, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		/**
		 * 掲示板削除用cspの呼び出し先格納変数
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopBulletin_delete").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getURLEncodingStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);
		ps.addProperty("app", "bulletin"); // Application
		ps.addProperty("aid", String.valueOf(articleId)); // 掲示ID

		if (registrant != null)
			ps.addProperty("registrant", registrant); // 更新者
		else
			ps.addProperty("registrant", ""); // 更新者

		ps.close();
		return processResult(hc,
				"failed in the deletion of the article on the bulletin board."); // 戻り値(記事ID)
	}

	/**
	 * 掲示板フォローの登録処理を行います。<BR/>
	 * 
	 * @param articleId
	 *            ガルーン２の掲示板ID
	 * @param data
	 *            本文.nullを指定可能(本文を入力しません)
	 * @param attachedFiles
	 *            添付ファイルとなるファイルパスの集合. null指定可能(添付ファイルを登録しません)<BR/>
	 *            要素は、String型またはtoString()でファイルパスを取得できるObjectでなければいけません<BR>
	 *            要素内にnullがある場合は、NullPointerExceptionが発生します
	 * @param registrant
	 *            登録者のログイン名.null指定可能(登録者はログインユーザとなります)
	 * @return 登録されたガルーン２の掲示板フォローID
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	public String putBulletinFollowAdd(long articleId, String data,
			Collection attachedFiles, String registrant) throws IOException,
			RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		/**
		 * 掲示板フォロー登録用cspの呼び出し先格納変数
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopBulletin_follow_add").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "bulletin"); // Application
		ps.addProperty("aid", String.valueOf(articleId)); // 掲示板ID
		ps.addProperty("editor", "0"); // 書式編集を指定しない
		ps.addProperty("send", ""); // 掲示するコマンド

		if (registrant != null)
			ps.addProperty("registrant", registrant); // 登録者
		else
			ps.addProperty("registrant", ""); // 登録者

		if (data != null)
			ps.addProperty("data", data); // 掲示板本文
		else
			ps.addProperty("data", ""); // 掲示板本文

		if (attachedFiles != null) { // 添付ファイル
			int i = 0;
			for (Iterator it = attachedFiles.iterator(); it.hasNext();) {
				ps.addFile(new File(it.next().toString()), new StringBuffer()
						.append("file").append(Integer.toString(i++))
						.toString(), "application/octet-stream");
			}
		}

		ps.close();
		return processResult(hc,
				"failed in the registration of the article Follow.");
	}

	/**
	 * 掲示板フォローの削除処理を行います。<BR/>
	 * 
	 * @param followId
	 *            ガルーン２の掲示板フォローID
	 * @param registrant
	 *            削除者のログイン名.null指定可能(削除者はログインユーザとなります)
	 * @return 削除されたガルーン２の掲示板フォローID
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	public String putBulletinFollowDelete(long followId, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		/**
		 * 掲示板フォロー削除用cspの呼び出し先格納変数
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopBulletin_follow_delete").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getURLEncodingStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "bulletin"); // Application
		ps.addProperty("follow_id", String.valueOf(followId)); // 記事フォローID

		if (registrant != null)
			ps.addProperty("registrant", registrant); // 更新者(削除実行者)
		else
			ps.addProperty("registrant", ""); // 更新者(削除実行者)

		ps.close();
		return processResult(hc,
				"failed in the deletion of the article Follow."); // 戻り値(記事フォローID)
	}

	/**
	 * 掲示板の更新処理を行います。<BR/> 全ての項目は、引数で指定された項目値に置換えられます。<BR/>
	 * 
	 * @param articleId
	 *            ガルーン２の掲示板ID
	 * @param title
	 *            標題
	 * @param startDate
	 *            掲示開始日.null指定可能(掲示開始日を指定しません)
	 * @param endDate
	 *            掲示終了日.null指定可能(掲示開始日を指定しません)
	 * @param data
	 *            本文 .null指定可能(本文を入力しません)
	 * @param attachedFiles
	 *            添付ファイルとなるファイルパスの集合. null指定可能(添付ファイルを登録しません)<BR/>
	 *            要素は、String型またはtoString()でファイルパスを取得できるObjectでなければいけません<BR>
	 *            要素内にnullがある場合は、NullPointerExceptionが発生します
	 * @param canFollow
	 *            フォロー書込み許可フラグ (false:書込不許可,true:書込可)
	 * @param registrant
	 *            更新者のログイン名.null指定可能(更新者はログインユーザとなります)
	 * @return 更新されたガルーン２の掲示板ID
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */

	public String putBulletinModify(long articleId, String title,
			Calendar startDate, Calendar endDate, String data,
			Collection attachedFiles, boolean canFollow, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		/**
		 * 掲示板更新用cspの呼び出し先格納変数
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopBulletin_modify").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "bulletin"); // Application

		ps.addProperty("aid", String.valueOf(articleId)); // 掲示板ID

		if (title != null)
			ps.addProperty("title", title); // 標題
		else
			ps.addProperty("title", ""); // 標題

		ps.addProperty("editor", "0"); // 書式編集を指定しない

		ps.addProperty("send", ""); // 掲示するコマンド

		if (canFollow)
			ps.addProperty("can_follow", "1"); // フォロー書込許可

		if (startDate == null && endDate == null)
			ps.addProperty("enable_term", "0"); // 掲示期間有無
		else
			ps.addProperty("enable_term", "1"); // 掲示期間有無

		if (registrant != null)
			ps.addProperty("registrant", registrant); // 差出人
		else
			ps.addProperty("registrant", ""); // 差出人

		if (data != null)
			ps.addProperty("data", data); // 掲示板本文
		else
			ps.addProperty("data", ""); // 掲示板本文

		if (startDate != null) {
			ps.addProperty("sterm_year", startDate.get(Calendar.YEAR)); // 掲示期間開始年
			ps.addProperty("sterm_month", startDate.get(Calendar.MONTH) + 1); // 掲示期間開始月
			ps.addProperty("sterm_day", startDate.get(Calendar.DAY_OF_MONTH)); // 掲示期間開始日
		} else {
			ps.addProperty("sterm_year", ""); // 掲示期間開始年
			ps.addProperty("sterm_month", ""); // 掲示期間開始月
			ps.addProperty("sterm_day", ""); // 掲示期間開始日
		}

		if (endDate != null) {
			ps.addProperty("eterm_year", endDate.get(Calendar.YEAR)); // 掲示期間終了年
			ps.addProperty("eterm_month", endDate.get(Calendar.MONTH) + 1); // 掲示期間終了月
			ps.addProperty("eterm_day", endDate.get(Calendar.DAY_OF_MONTH)); // 掲示期間終了日
		} else {
			ps.addProperty("eterm_year", ""); // 掲示期間終了年
			ps.addProperty("eterm_month", ""); // 掲示期間終了月
			ps.addProperty("eterm_day", ""); // 掲示期間終了日
		}

		if (attachedFiles != null) { // 添付ファイル
			int i = 0;
			for (Iterator it = attachedFiles.iterator(); it.hasNext();) {
				ps.addFile(new File(it.next().toString()), new StringBuffer()
						.append("file").append(Integer.toString(i++))
						.toString(), "application/octet-stream");
			}

		}

		ps.close();
		return processResult(hc,
				"failed in the modification of the article on the bulletin board.");
	}

	/**
	 * ファイル管理の登録処理を行います。<BR>
	 * 
	 * @param title
	 *            タイトル.null指定可能(タイトルを入力しません)
	 * @param foldercode
	 *            ガルーン２のフォルダコード
	 * @param version
	 *            バージョン管理 <BR>
	 *            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 *            [値 = -1]
	 *            の場合，無制限で管理します。(システム管理-バージョン管理の上限値が設定されている場合，バージョン管理の上限値を設定)<BR>
	 *            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 *            [値 = 0] の場合，バージョン管理をしません。<BR>
	 *            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 *            [0 ＜ 値 ≦ 10] の場合，各値を設定します。([値 ＞
	 *            システム管理-バージョン管理の上限値]の場合，バージョン管理の上限値を設定)<BR>
	 *            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 * @param memo
	 *            ファイルの説明.null指定可能(説明を入力しません)
	 * @param registrant
	 *            登録者のログイン名.null指定可能(登録者はログインユーザとなります)
	 * @param file
	 *            追加するファイル
	 * @return 登録されたガルーン２のファイルID
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 * @throws NullPointerException
	 *             必須項目のパラメータがNULLの場合
	 * @throws IllegalArgumentException
	 *             不正な引数、または不適切な引数をメソッドに渡した場合
	 */
	// javadoc 2007/03/22 ファイル管理、タイトルがNULL指定可能になっていない 不具合管理(173)
	// (タイトルを入力しません) を追記
	// javadoc 2007/03/28 versionの詳細記述が存在しない (不具合管理203)
	// version部分の記述修正
	// 2007/03/22 putCabinet_addの引数名を修正 不具合管理(186)
	// folder ⇒ foldercode
	public String putCabinetAdd(String title, String foldercode, long version,
			String memo, String registrant, File file) throws IOException,
			RemoteException, NullPointerException, IllegalArgumentException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		/**
		 * ファイル管理ファイル追加用cspの呼び出し先格納変数
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopCabinet_add").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "cabinet");
		if (title != null) // タイトル
			ps.addProperty("title", title);
		else
			ps.addProperty("title", "");
		// 2007/03/22 putCabinet_addの引数名を修正 不具合管理(186)
		// folder ⇒ foldercode
		if (foldercode != null) // フォルダコード
			ps.addProperty("folder", foldercode);
		else
			ps.addProperty("folder", "");
		ps.addProperty("max_version", String.valueOf(version)); // バージョン管理
		if (memo != null) // ファイルの説明
			ps.addProperty("memo", memo);
		else
			ps.addProperty("memo", "");
		if (registrant != null) // 登録者
			ps.addProperty("registrant", registrant);
		else
			ps.addProperty("registrant", "");
		ps.addFile(file, "file", "application/octet-stream"); // 追加するファイル

		ps.close();
		return processResult(hc, "failed to register a cabinet.");
	}

	/**
	 * ファイル管理のファイル更新処理を行います。<BR>
	 * 
	 * @param fileId
	 *            ガルーン２のファイルID
	 * @param comment
	 *            更新コメント.null指定可能(更新コメントを入力しません）
	 * @param newFile
	 *            アップロードするファイル
	 * @param registrant
	 *            更新者のログイン名.null指定可能(更新者はログインユーザとなります)
	 * 
	 * @return ファイル更新されたガルーン２のファイルID
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	public String putCabinetUpload(long fileId, String comment, File newFile,
			String registrant) throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		/**
		 * ファイル管理ファイルUpload用cspの呼び出し先格納変数
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopCabinet_upload").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "cabinet");

		ps.addProperty("fid", Long.toString(fileId)); // ファイルID

		if (comment != null) // コメント
			ps.addProperty("comment", comment);

		if (registrant != null) // 更新者
			ps.addProperty("registrant", registrant);

		if (newFile != null) // ファイル
			ps.addFile(newFile, "newfile", "application/octet-stream");

		ps.close();
		return processResult(hc, " failed to upload of file.");
	}

	/**
	 * ファイル管理のファイル情報変更処理を行います。<BR>
	 * 
	 * @param fileId
	 *            ガルーン２のファイルID
	 * @param title
	 *            タイトル.null指定可能(タイトルを入力しません）
	 * @param version
	 *            バージョン管理 <BR>
	 *            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 *            [値 = -1]
	 *            の場合，無制限で管理します。(システム管理-バージョン管理の上限値が設定されている場合，バージョン管理の上限値を設定)<BR>
	 *            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 *            [値 = 0] の場合，バージョン管理をしません。<BR>
	 *            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 *            [0 ＜ 値 ≦ 10] の場合，各値を設定します。([値 ＞
	 *            システム管理-バージョン管理の上限値]の場合，バージョン管理の上限値を設定)<BR>
	 *            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 * @param memo
	 *            ファイルの説明.null指定可能(説明を入力しません)
	 * @param registrant
	 *            情報変更のログイン名.null指定可能(情報変更者はログインユーザとなります)
	 * 
	 * @return 情報変更されたガルーン２のファイルID
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	public String putCabinetModify(long fileId, String title, long version,
			String memo, String registrant) throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		/**
		 * ファイル管理ファイル情報変更用cspの呼び出し先格納変数
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopCabinet_modify").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = super.getURLEncodingStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "cabinet");

		ps.addProperty("fid", Long.toString(fileId)); // ファイルID
		ps.addProperty("ver", Long.toString(version)); // バージョン

		if (title != null) // タイトル
			ps.addProperty("title", title);

		if (memo != null) // メモ
			ps.addProperty("memo", memo);

		if (registrant != null) // 情報変更者
			ps.addProperty("registrant", registrant);

		ps.close();
		return processResult(hc, " failed to modify of file information.");
	}

	/**
	 * ファイル管理の削除処理を行います。<BR>
	 * 
	 * @param fileId
	 *            ガルーン２のファイルID
	 * @param registrant
	 *            削除者のログイン名.null指定可能(削除者はログインユーザとなります)
	 * 
	 * @return 削除されたガルーン２上のファイルID
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	public String putCabinetDelete(long fileId, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		/**
		 * ファイル管理ファイル削除用cspの呼び出し先格納変数
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopCabinet_delete").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = super.getURLEncodingStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "cabinet");

		ps.addProperty("fid", Long.toString(fileId)); // ファイルID

		if (registrant != null) // 削除者
			ps.addProperty("registrant", registrant);

		ps.close();
		return processResult(hc, " failed to delete of file.");
	}

	/**
	 * 引数 [fileId]のうち、バージョンNoが引数 [version] のファイルをガルーン２ ファイル管理よりダウンロードし、<BR>
	 * 引数 [directoryPath]のディレクトリ に、引数 [fileName] のファイル名で保存します。
	 * 
	 * @param fileId
	 *            ガルーン２のファイルID
	 * @param directoryPath
	 *            ファイルを保存するディレクトリパス.null指定可能(カレントディレクトリに保存します。）
	 * @param fileName
	 *            ファイルを保存するファイル名.null指定可能(ガルーン２に登録されているファイル名で保存します。
	 * @param ver
	 *            取得するバージョンNo.null指定可能(最新バージョンのファイルを取得します）
	 * @param registrant
	 *            ダウンロードを行うユーザーのログイン名.null指定可能(ダウンロードを行うユーザーはログインユーザとなります)
	 * 
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	public void putCabinetDownload(long fileId, String directoryPath,
			String fileName, Long ver, String registrant) throws IOException,
			RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		/**
		 * ファイル管理ファイルDL用cspの呼び出し先格納変数
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopCabinet_download").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = super.getURLEncodingStream(hc);

		if (fileName == null) {
			// 2008/01/15 csrf 対応
			if (this.csrfTicket != null)
				ps.addProperty("csrf_ticket", this.csrfTicket);
			ps.addProperty("app", "cabinet");
			ps.addProperty("fid", Long.toString(fileId)); // ファイルID
			ps.addProperty("title_flag", 1); // ファイル管理のファイルのタイトル取得フラグ(タイトル取得
												// 1:する,1以外:しない)

			if (ver != null) // バージョン
				ps.addProperty("ver", ver.toString());

			if (registrant != null) // ダウンロードを行うユーザー
				ps.addProperty("registrant", registrant);

			ps.close();

			BufferedReader in = processBufferResult(hc,
					"failed to download of file.");
			fileName = in.readLine();
		}

		hc = getConnection(HttpClient.POST);
		ps = super.getURLEncodingStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "cabinet");
		ps.addProperty("fid", Long.toString(fileId)); // ファイルID

		if (ver != null) // バージョン
			ps.addProperty("ver", ver.toString());

		if (registrant != null) // ダウンロードを行うユーザー
			ps.addProperty("registrant", registrant);

		ps.close();

		saveResponseDataToFile(hc, directoryPath, fileName,
				"failed to download of file.");
	}

	/**
	 * 引数 [fileId]の最新バージョンのファイルをガルーン２ ファイル管理よりダウンロードし、<BR>
	 * 引数 [directoryPath]のディレクトリに保存します。<BR>
	 * ファイル名は、ファイル管理上に保存されているファイルの名前になります。<BR>
	 * 
	 * @param fileId
	 *            ガルーン２のファイルID
	 * @param directoryPath
	 *            ファイルを保存するディレクトリパス.null指定可能(カレントディレクトリに保存します。）
	 * @param registrant
	 *            ダウンロードを行うユーザーのログイン名.null指定可能(ダウンロードを行うユーザーはログインユーザとなります)
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	public void putCabinetDownload(long fileId, String directoryPath,
			String registrant) throws IOException, RemoteException {
		this.putCabinetDownload(fileId, directoryPath, null, null, registrant);
	}

	
	
    /**
     * 社内メールの登録処理を行います。<BR/>
     *
     * @param title 標題
     * @param data 本文.null指定可能(本文を入力しません)
     * @param confirm 閲覧状況フラグ(true:確認ボタンをつける,false:確認ボタンをつけない)
     * @param accounts 宛先のうち、宛先の変更、削除が許可されていないユーザーのログイン名の集合<BR/>
     *              要素は、String型またはtoString()でログイン名を取得できるObjectでなければいけません<BR>
     *              要素内にnullがある場合は、NullPointerExceptionが発生します<BR/>
     * @param operators 宛先のうち、宛先の変更、削除が許可されたなログイン名の集合<BR/>
     *                  要素は、String型またはtoString()でログイン名を取得できるObjectでなければいけません<BR/>
     *                  要素内にnullが有る場合は、NullPointerExceptionが発生します
     * @param attachedFiles 添付ファイルとなるファイルパスの集合.
     *                     null指定可能(添付ファイルを指定しない)<BR/>
     *                     要素は、String型またはtoString()でファイルパスを取得できるObjectでなければいけません<BR>
     *                     要素内にnullがある場合は、NullPointerExceptionが発生する
     * @param registrant 登録者のログイン名.null指定可能(登録者はログインユーザとなります)
     * @return 登録されたガルーン２の社内メールID
     * @throws IOException 接続が確立できない等通信上のエラーが発生した場合
     * @throws RemoteException ガルーン２連携用プログラム上でエラーが発生した場合
     */
    public String putMessageAdd (String title,
                                  String data,
                                  boolean confirm,
                                  Collection accounts,
                                  Collection operators,
                                  Collection attachedFiles,
                                  String registrant)
    throws IOException, RemoteException
    {
        // 2007/05/09 仕様変更
        this.login(loginUser,loginPassword);
        
        /**
         * 社内メール登録用cspの呼び出し先格納変数
         */
        String Page = new StringBuffer().append(grnURL).append("/coop/coopMessage_add").toString();
        super.setPageInfo(URI.create(Page));
        
        
        java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
        PostStream ps = getMultipartStream(hc);
        //2008/01/15 csrf 対応
        if(this.csrfTicket!=null)ps.addProperty("csrf_ticket",this.csrfTicket);
        
        ps.addProperty("app","message");                                // Application
        if (title!=null)
                ps.addProperty("title", title);                                // 標題
        else
            ps.addProperty("title", "");                                // 標題
        
        if (data!=null)
                ps.addProperty("data", data);                                // 本文
        else
            ps.addProperty("data", "");                                    // 本文
        
        if (confirm==true)
            ps.addProperty("confirm", "1");                                // 閲覧状況
           
        if ( registrant != null )
            ps.addProperty("registrant", registrant);                    // 差出人
        else
            ps.addProperty("registrant", "");                            // 差出人
        
        if ( accounts != null ){
               for (Iterator it = accounts.iterator(); it.hasNext(); ) {    
                ps.addProperty("receivers[]", it.next().toString());    // 宛先変更許可の無い宛先
            }
        }
        //2010/08/01 宛先変更の許可に対応 Yoshida Shin
        if ( operators != null ){
        	for ( Iterator it = operators.iterator(); it.hasNext(); ){
        		ps.addProperty("operators[]", it.next().toString());   // 宛先変更許可の有る宛先
        	}
        }
        
        if ( attachedFiles != null ){                                    // 添付ファイル
            int i = 0;
               for (Iterator it = attachedFiles.iterator(); it.hasNext(); ) {    
                ps.addFile( new File(it.next().toString()),
                            new StringBuffer().append("file").append(Integer.toString(i++)).toString(),
                            "application/octet-stream");    
            }
        }      
        
        ps.close();
        return processResult(hc, "failed in the registration of the message.");
    }

    /**
     * 社内メールの登録処理を行います。<BR/>
     * API 1.3.1 互換のためのメソッドです。<BR/>
     *
     * @param title 標題
     * @param data 本文.null指定可能(本文を入力しません)
     * @param confirm 閲覧状況フラグ(true:確認ボタンをつける,false:確認ボタンをつけない)
     * @param accounts 宛先のログイン名の集合<BR/>
     *              要素は、String型またはtoString()でログイン名を取得できるObjectでなければいけません<BR>
     *              要素内にnullがある場合は、NullPointerExceptionが発生します<BR/>
     *              この宛先のユーザーは、宛先変更許可を持ちません。
     * @param attachedFiles 添付ファイルとなるファイルパスの集合.
     *                     null指定可能(添付ファイルを指定しない)<BR/>
     *                     要素は、String型またはtoString()でファイルパスを取得できるObjectでなければいけません<BR>
     *                     要素内にnullがある場合は、NullPointerExceptionが発生する
     * @param registrant 登録者のログイン名.null指定可能(登録者はログインユーザとなります)
     * @return 登録されたガルーン２の社内メールID
     * @throws IOException 接続が確立できない等通信上のエラーが発生した場合
     * @throws RemoteException ガルーン２連携用プログラム上でエラーが発生した場合
     */
    public String putMessageAdd (String title,
            String data,
            boolean confirm,
            Collection accounts,
            Collection attachedFiles,
            String registrant)
    throws IOException, RemoteException
    {
    	Collection operators = null;    	
    	return this.putMessageAdd(title, data, confirm, accounts, operators, attachedFiles, registrant);
    	
    }

	
	
	

	/**
	 * 社内メールの削除処理を行います。<BR/>
	 * 
	 * @param mid
	 *            ガルーン２の社内メールID
	 * @param registrant
	 *            削除者のログイン名.null指定可能(削除者はログインユーザとなります)
	 * @return 削除されたガルーン２の社内メールID
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	public String putMessageDelete(long mid, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		/**
		 * 社内メール削除用cspの呼び出し先格納変数
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopMessage_delete").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "message");
		ps.addProperty("mid", String.valueOf(mid)); // メッセージID
		if (registrant != null)
			ps.addProperty("registrant", registrant); // 登録者
		else
			ps.addProperty("registrant", "");
		ps.close();

		return processResult(hc, "failed in the deletion of the message.");
	}

	/**
	 * 社内メールフォローの登録処理を行います。<BR/>
	 * 
	 * @param messageId
	 *            ガルーン２の社内メールID
	 * @param data
	 *            本文.null指定可能(本文を入力しません)
	 * @param attachedFiles
	 *            添付ファイルとなるファイルパスの集合. null指定可能(添付ファイルを指定しません)<BR/>
	 *            要素は、String型またはtoString()でファイルパスを取得できるObjectでなければいけません<BR>
	 *            要素内にnullがある場合は、NullPointerExceptionが発生します
	 * @param registrant
	 *            登録者のログイン名.null指定可能(登録者はログインユーザとなります)
	 * @return 登録されたガルーン２の社内メールフォローID
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	public String putMessageFollowAdd(long messageId, String data,
			Collection attachedFiles, String registrant) throws IOException,
			RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		/**
		 * 社内メールフォロー登録用cspの呼び出し先格納変数
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopMessage_follow_add").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "message"); // Application
		ps.addProperty("mid", String.valueOf(messageId)); // メールID
		ps.addProperty("data", data == null ? "" : data); // フォロー本文
		ps.addProperty("editor", "0"); // 書式編集を指定しない(テキスト指定)
		ps.addProperty("cmd", "follow"); // 処理コマンド
		if (registrant != null)
			ps.addProperty("registrant", registrant); // 差出人
		else
			ps.addProperty("registrant", ""); // 差出人

		if (attachedFiles != null) { // 添付ファイル
			int i = 0;
			for (Iterator it = attachedFiles.iterator(); it.hasNext();) {
				ps.addFile(new File(it.next().toString()), new StringBuffer()
						.append("file").append(Integer.toString(i++))
						.toString(), "application/octet-stream");
			}
		}
		ps.close();
		return processResult(hc,
				"failed in the registration of the message Follow.");
	}

	/**
	 * 社内メールフォローの削除処理を行います。<BR/>
	 * 
	 * @param fid
	 *            ガルーン２の社内メールフォローID
	 * @param registrant
	 *            削除者のログイン名.null指定可能(削除者はログインユーザとなります)
	 * @return 削除されたガルーン２の社内メールフォローID
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	public String putMessageFollowDelete(long fid, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		/**
		 * 社内メールフォロー削除用cspの呼び出し先格納変数
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopMessage_follow_delete").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "message");
		ps.addProperty("fid", String.valueOf(fid)); // フォローID
		if (registrant != null) // 登録者
			ps.addProperty("registrant", registrant);
		else
			ps.addProperty("registrant", "");
		ps.close();

		return processResult(hc,
				"failed in the deletion of the message Follow.");
	}

	/**
	 * 社内メールの更新処理を行います。<BR/>
	 * 
	 * @param mid
	 *            ガルーン２の社内メールID
	 * @param title
	 *            標題
	 * @param data
	 *            本文.null指定可能(本文を入力しません)
	 * @param attached_files
	 *            添付ファイルとなるファイルパスの集合. null指定可能(添付ファイルを追加しません)<BR/>
	 *            要素は、String型またはtoString()でファイルパスを取得できるObjectでなければいけません<BR>
	 *            要素内にnullがある場合は、NullPointerExceptionが発生します
	 * @param registrant
	 *            更新者のログイン名.null指定可能(更新者はログインユーザとなります)
	 * @return 更新されたガルーン２の社内メールID
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	public String putMessageModify(long mid, String title, String data,
			Collection attached_files, String registrant) throws IOException,
			RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		/**
		 * 社内メール更新用cspの呼び出し先格納変数
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopMessage_modify").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "message");
		ps.addProperty("mid", String.valueOf(mid)); // メッセージID
		if (title != null) // 標題
			ps.addProperty("title", title);
		else
			ps.addProperty("title", "");
		if (data != null) // 本文
			ps.addProperty("data", data);
		else
			ps.addProperty("data", "");
		if (attached_files != null) { // 添付ファイル
			Object obj = null;
			int i = 0;
			for (Iterator it = attached_files.iterator(); it.hasNext();) {
				obj = it.next();
				if (obj == null)
					continue;
				if ("java.lang.String".equals(obj.getClass().getName())) {
					ps.addFile(new File(obj.toString()), new StringBuffer()
							.append("file").append(Integer.toString(i++))
							.toString(), "application/octet-stream");
				} else if ("java.io.File".equals(obj.getClass().getName())) {
					ps.addFile((File) obj, new StringBuffer().append("file")
							.append(Integer.toString(i++)).toString(),
							"application/octet-stream");
				}
			}
		}
		if (registrant != null)
			ps.addProperty("registrant", registrant); // 差出人
		else
			ps.addProperty("registrant", "");
		ps.close();

		return processResult(hc, "failed in the modification of the message.");
	}

	/**
	 * スケジュールの登録処理を行います。<BR/>
	 * 
	 * @param eventKind
	 *            予定区分(1:バナー予定,1以外:通常予定 )
	 * @param titleMenu
	 *            メニュー.null指定可能(メニューを入力しません)
	 * @param title
	 *            タイトル.null指定可能(タイトルを入力しません)
	 * @param eventPrivate
	 *            公開方法(1:非公開 ,1以外:公開 )
	 * @param detail
	 *            メモ.null指定可能(メモを入力しません)
	 * @param startDate
	 *            開始日<BR/>
	 *            次のフィールドのみ参照(Calendar.YEAR,Calendar.MONTH,Calendar.DAY_OF_MONTH)
	 * @param endDate
	 *            終了日 <BR/>
	 *            次のフィールドのみ参照(Calendar.YEAR,Calendar.MONTH,Calendar.DAY_OF_MONTH)
	 * @param startTime
	 *            開始時刻.null指定可能(開始時刻を指定しません)<BR/>
	 *            次のフィールドのみ参照(Calendar.HOUR_OF_DAY,Calendar.MINUTE)
	 * @param endTime
	 *            終了時刻.null指定可能(終了時刻を指定しません)<BR/>
	 *            次のフィールドのみ参照(Calendar.HOUR_OF_DAY,Calendar.MINUTE)
	 * @param userAccounts
	 *            スケジュール参加者となるログイン名の集合<BR/>
	 *            要素は、String型またはtoString()でログイン名を取得できるObjectでなければいけません<BR/>
	 *            要素内にnullがある場合は、NullPointerExceptionが発生します
	 * @param facilitiesCodes
	 *            予約するガルーン２の施設コードの集合 null指定可能(施設を予約しません)<BR/>
	 *            要素は、String型またはtoString()で施設コードを取得できるObjectでなければいけません<BR>
	 *            要素内にnullがある場合は、NullPointerExceptionが発生します
	 * @param registrant
	 *            登録者のログイン名.null指定可能(登録者はログインユーザとなります)
	 * @return 登録されたガルーン２のスケジュールID
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	public String putScheduleAdd(int eventKind, String titleMenu, String title,
			String eventPrivate, String detail, Calendar startDate,
			Calendar endDate, Calendar startTime, Calendar endTime,
			Collection userAccounts, Collection facilitiesCodes,
			String registrant) throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		/**
		 * スケジュール登録用cspの呼び出し先格納変数
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopSchedule_add").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);

		PostStream ps = getURLEncodingStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "schedule"); // Application

		if (eventKind == 1)
			ps.addProperty("BN", "1"); // 予定区分(バナー予定)

		if (titleMenu != null)
			ps.addProperty("menu", titleMenu); // 予定メニュー
		else
			ps.addProperty("menu", ""); // 予定メニュー

		if (title != null)
			ps.addProperty("title", title); // 予定タイトル
		else
			ps.addProperty("title", ""); // 予定タイトル

		if (eventKind != 1)
			ps.addProperty("private", "1".equals(eventPrivate) ? eventPrivate
					: "0");// 公開/非公開

		if (detail != null)
			ps.addProperty("memo", detail); // 予定メモ
		else
			ps.addProperty("memo", ""); // 予定メモ

		if (registrant != null)
			ps.addProperty("registrant", registrant); // 登録者(実行ユーザー)
		else
			ps.addProperty("registrant", ""); // 登録者(実行ユーザー)

		if (userAccounts != null) {
			for (Iterator it = userAccounts.iterator(); it.hasNext();) {
				ps.addProperty("user_account[]", it.next().toString()); // 参加者のユーザーアカウント
			}
		}

		if (facilitiesCodes != null && eventKind != 1) {
			for (Iterator it = facilitiesCodes.iterator(); it.hasNext();) {
				ps.addProperty("sITEM_CODE[]", it.next().toString()); // 施設コード
			}
		}
		if (startDate != null) {
			ps.addProperty("bdate", new StringBuffer().append(
					startDate.get(Calendar.YEAR)).append("-").append(
					startDate.get(Calendar.MONTH) + 1).append("-").append(
					startDate.get(Calendar.DAY_OF_MONTH)).toString());

			ps.addProperty("start_year", startDate.get(Calendar.YEAR)); // 開始日(年)
			ps.addProperty("start_month", startDate.get(Calendar.MONTH) + 1); // 開始日(月)
			ps.addProperty("start_day", startDate.get(Calendar.DAY_OF_MONTH)); // 開始日(日)
		} else {
			ps.addProperty("bdate", "");
			ps.addProperty("start_year", ""); // 開始日(年)
			ps.addProperty("start_month", ""); // 開始日(月)
			ps.addProperty("start_day", ""); // 開始日(日)
		}
		if (startTime != null && eventKind != 1) {
			ps.addProperty("start_hour", startTime.get(Calendar.HOUR_OF_DAY));// 開始時刻(時)
			ps.addProperty("start_minute", startTime.get(Calendar.MINUTE)); // 開始時刻(分)
		} else if (eventKind != 1) {
			ps.addProperty("start_hour", ""); // 終了時刻(時)
			ps.addProperty("start_minute", ""); // 終了時刻(分)
		}
		if (endDate != null) {
			ps.addProperty("end_year", endDate.get(Calendar.YEAR)); // 終了日(年)
			ps.addProperty("end_month", endDate.get(Calendar.MONTH) + 1); // 終了日(月)
			ps.addProperty("end_day", endDate.get(Calendar.DAY_OF_MONTH)); // 終了日(日)
		} else {
			ps.addProperty("end_year", ""); // 終了日(年)
			ps.addProperty("end_month", ""); // 終了日(月)
			ps.addProperty("end_day", ""); // 終了日(日)
		}
		if (endTime != null && eventKind != 1) {
			ps.addProperty("end_hour", endTime.get(Calendar.HOUR_OF_DAY)); // 終了時刻(時)
			ps.addProperty("end_minute", endTime.get(Calendar.MINUTE)); // 終了時刻(分)
		} else if (eventKind != 1) {
			ps.addProperty("end_hour", ""); // 終了時刻(時)
			ps.addProperty("end_minute", ""); // 終了時刻(分)
		}

		ps.close();
		return processResult(hc, "failed in the registration of the schedule.");// 戻り値(イベントID)
	}

	/**
	 * スケジュールの削除処理を行います。<BR/> 指定されたスケジュールIDにおける全参加者,全範囲の予定を削除します
	 * 
	 * @param eventId
	 *            ガルーン２のスケジュールID
	 * @param registrant
	 *            削除者のログイン名.null指定可能(削除者はログインユーザとなります)
	 * @return 削除されたガルーン２のスケジュールID
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	public String putScheduleDelete(long eventId, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		/**
		 * スケジュール削除用cspの呼び出し先格納変数
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopSchedule_delete").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getURLEncodingStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "schedule"); // Application
		ps.addProperty("event", String.valueOf(eventId)); // イベントID
		ps.addProperty("member", "0"); // 削除の対象となる参加者
		ps.addProperty("apply", "1"); // 削除する範囲

		if (registrant != null)
			ps.addProperty("registrant", registrant); // 更新者(削除実行者)
		else
			ps.addProperty("registrant", ""); // 更新者(削除実行者)

		ps.close();
		return processResult(hc, "failed in the deletion of the schedule."); // 戻り値(イベントID)
	}

	/**
	 * スケジュールの更新処理を行います。<BR/> 全ての項目は、引数で指定された項目値に置換えられます。<BR/>
	 * 
	 * @param eventId
	 *            ガルーン２のスケジュールID
	 * @param titleMenu
	 *            メニュー.null指定可能(メニューを入力しません)
	 * @param title
	 *            タイトル.null指定可能(タイトルを入力しません)
	 * @param eventPrivate
	 *            公開方法(1:非公開 ,1以外:公開 )
	 * @param detail
	 *            メモ.null指定可能(メモを入力しません)
	 * @param startDate
	 *            開始日<BR/>
	 *            次のフィールドのみ参照(Calendar.YEAR,Calendar.MONTH,Calendar.DAY_OF_MONTH)
	 * @param endDate
	 *            終了日 <BR/>
	 *            次のフィールドのみ参照(Calendar.YEAR,Calendar.MONTH,Calendar.DAY_OF_MONTH)
	 * @param startTime
	 *            開始時刻.null指定可能(開始時刻を指定しません)<BR/>
	 *            次のフィールドのみ参照(Calendar.HOUR_OF_DAY,Calendar.MINUTE)
	 * @param endTime
	 *            終了時刻.null指定可能(終了時刻を指定しません)<BR/>
	 *            次のフィールドのみ参照(Calendar.HOUR_OF_DAY,Calendar.MINUTE)
	 * @param userAccounts
	 *            スケジュール参加者となるログイン名の集合<BR/>
	 *            要素は、String型またはtoString()でログイン名を取得できるObjectでなければいけません<BR/>
	 *            要素内にnullがある場合は、NullPointerExceptionが発生します
	 * @param facilitiesCodes
	 *            予約するガルーン２の施設コードの集合 null指定可能(施設を予約しません)<BR/>
	 *            要素は、String型またはtoString()で施設コードを取得できるObjectでなければいけません<BR>
	 *            要素内にnullがある場合は、NullPointerExceptionが発生します
	 * @param registrant
	 *            登録者のログイン名.null指定可能(登録者はログインユーザとなります)
	 * @return 更新されたガルーン２のスケジュールID
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	public String putScheduleModify(long eventId, String titleMenu,
			String title, String eventPrivate, String detail,
			Calendar startDate, Calendar endDate, Calendar startTime,
			Calendar endTime, Collection userAccounts,
			Collection facilitiesCodes, String registrant) throws IOException,
			RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		/**
		 * スケジュール更新用cspの呼び出し先格納変数
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopSchedule_modify").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getURLEncodingStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "schedule"); // Application

		ps.addProperty("event", String.valueOf(eventId)); // イベントID
		ps.addProperty("apply", "all"); // 更新する範囲(今のところ固定値)

		if (titleMenu != null)
			ps.addProperty("menu", titleMenu); // 予定メニュー
		else
			ps.addProperty("menu", ""); // 予定メニュー

		if (title != null)
			ps.addProperty("title", title); // 予定タイトル
		else
			ps.addProperty("title", ""); // 予定タイトル

		if (eventPrivate != null)
			ps.addProperty("private", "1".equals(eventPrivate) ? eventPrivate
					: "0");// 公開/非公開

		if (detail != null)
			ps.addProperty("memo", detail); // 予定メモ
		else
			ps.addProperty("memo", ""); // 予定メモ

		if (registrant != null)
			ps.addProperty("registrant", registrant); // 更新者
		else
			ps.addProperty("registrant", ""); // 更新者

		if (userAccounts != null) {
			for (Iterator it = userAccounts.iterator(); it.hasNext();) {
				ps.addProperty("user_account[]", it.next().toString()); // 参加者のユーザーアカウント
			}
		}

		if (facilitiesCodes != null) { // 施設コード
			for (Iterator it = facilitiesCodes.iterator(); it.hasNext();) {
				ps.addProperty("sITEM_CODE[]", it.next().toString());
			}
		}
		if (startDate != null) {
			ps.addProperty("start_year", startDate.get(Calendar.YEAR)); // 開始日(年)
			ps.addProperty("start_month", startDate.get(Calendar.MONTH) + 1); // 開始日(月)
			ps.addProperty("start_day", startDate.get(Calendar.DAY_OF_MONTH)); // 開始日(日)
		} else {
			ps.addProperty("bdate", "");
			ps.addProperty("start_year", ""); // 開始日(年)
			ps.addProperty("start_month", ""); // 開始日(月)
			ps.addProperty("start_day", ""); // 開始日(日)
		}
		if (startTime != null) {
			ps.addProperty("start_hour", startTime.get(Calendar.HOUR_OF_DAY));// 開始時刻(時)
			ps.addProperty("start_minute", startTime.get(Calendar.MINUTE)); // 開始時刻(分)
		} else {
			ps.addProperty("start_hour", ""); // 終了時刻(時)
			ps.addProperty("start_minute", ""); // 終了時刻(分)
		}
		if (endDate != null) {
			ps.addProperty("end_year", endDate.get(Calendar.YEAR)); // 終了日(年)
			ps.addProperty("end_month", endDate.get(Calendar.MONTH) + 1); // 終了日(月)
			ps.addProperty("end_day", endDate.get(Calendar.DAY_OF_MONTH)); // 終了日(日)
		} else {
			ps.addProperty("end_year", ""); // 終了日(年)
			ps.addProperty("end_month", ""); // 終了日(月)
			ps.addProperty("end_day", ""); // 終了日(日)
		}

		if (endTime != null) {
			ps.addProperty("end_hour", endTime.get(Calendar.HOUR_OF_DAY)); // 終了時刻(時)
			ps.addProperty("end_minute", endTime.get(Calendar.MINUTE)); // 終了時刻(分)
		} else {
			ps.addProperty("end_hour", ""); // 終了時刻(時)
			ps.addProperty("end_minute", ""); // 終了時刻(分)
		}
		ps.close();
		return processResult(hc, "failed in the modification of the schedule.");// 戻り値(イベントID)
	}

	/**
	 * 施設予定への書き出しを行います。<BR>
	 * 
	 * @param filepath
	 *            出力先のファイルパス
	 * @param facility
	 *            ガルーン２の施設コードの集合<BR>
	 *            要素は、String型またはtoString()で施設コードを取得できるObjectでなければいけません<BR/>
	 *            要素内にnullがある場合は、NullPointerExceptionが発生します
	 * @param setDate
	 *            書き出す予定期間(開始日)
	 * @param endDate
	 *            書き出す予定期間(終了日)
	 * @param skipFirst
	 *            先頭行の有無(true:有 false:無)
	 * @param creator
	 *            追加の項目書出しフラグ(true:追加項目を書出す,false:追加項目を書出さない)
	 * @param sjisEncoding
	 *            ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 * @throws NullPointerException
	 *             必須項目のパラメータがNULLの場合にエラーが発生
	 */
	public void exportFacilitySchedule(String filepath, Collection facility,
			Calendar setDate, Calendar endDate, boolean skipFirst,
			boolean creator, boolean sjisEncoding) throws IOException,
			RemoteException, NullPointerException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		if (filepath == null)
			filepath = ""; // CSVファイルパス

		Iterator it = facility.iterator();
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/grnFacilitySchedule_export").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);

		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("system", "2"); // 権限チェック用(System)
		ps.addProperty("manage", "schedule"); // 権限チェック用Application名

		if (setDate != null) { // 書き出す予定期間(開始日)
			ps.addProperty("start_year", setDate.get(Calendar.YEAR)); // 開始日(年)
			ps.addProperty("start_month", setDate.get(Calendar.MONTH) + 1); // 開始日(月)
			ps.addProperty("start_day", setDate.get(Calendar.DAY_OF_MONTH));// 開始日(日)
		} else {
			ps.addProperty("start_year", ""); // 開始日(年)
			ps.addProperty("start_month", ""); // 開始日(月)
			ps.addProperty("start_day", ""); // 開始日(日)
		}

		if (endDate != null) { // 書き出す予定期間(終了日)
			ps.addProperty("end_year", endDate.get(Calendar.YEAR)); // 終了日(年)
			ps.addProperty("end_month", endDate.get(Calendar.MONTH) + 1); // 終了日(月)
			ps.addProperty("end_day", endDate.get(Calendar.DAY_OF_MONTH)); // 終了日(日)
		} else {
			ps.addProperty("end_year", ""); // 終了日(年)
			ps.addProperty("end_month", ""); // 終了日(月)
			ps.addProperty("end_day", ""); // 終了日(日)
		}

		if (creator)
			ps.addProperty("creator", 1); // 追加の書き出し項目
		else
			ps.addProperty("creator", 0); // 追加の書き出し項目

		it = facility.iterator(); // 施設コード
		while (it.hasNext()) {
			ps.addProperty("target[]", "facility:" + it.next().toString());
		}

		if (skipFirst) // 先頭行の有無
			ps.addProperty("item_name", 1); // 先頭行の有
		else
			ps.addProperty("item_name", 0); // 先頭行の無

		if (sjisEncoding == true)
			ps.addProperty("charset", "SJIS-win");
		else
			ps.addProperty("charset", "UTF8");
		ps.close();

		fileWrite(hc, filepath, sjisEncoding); // 施設予定CSVファイルの作成
	}

	/**
	 * ユーザー管理用CSVファイルへの書き出しを行います。(組織情報)<BR>
	 * 
	 * @param filepath
	 *            CSVファイルパス
	 * @param skipFirst
	 *            先頭行の有無(true:有 false:無)
	 * @param sjisEncoding
	 *            ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 * @throws NullPointerException
	 *             必須項目のパラメータがNULLの場合にエラーが発生
	 */
	public void exportOrganization(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnOrganization_export";
		exportInfo(Page, filepath, skipFirst, sjisEncoding);
	}

	/**
	 * ユーザー管理用CSVファイルへの書き出しを行います。(組織の所属ユーザー)<BR>
	 * 
	 * @param filepath
	 *            CSVファイルパス
	 * @param skipFirst
	 *            先頭行の有無(true:有 false:無)
	 * @param sjisEncoding
	 *            ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 * @throws NullPointerException
	 *             必須項目のパラメータがNULLの場合にエラーが発生
	 */
	public void exportOrganizationUser(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnOrganizationUser_export";
		exportInfo(Page, filepath, skipFirst, sjisEncoding);
	}

	/**
	 * ユーザー管理用CSVファイルへの書き出しを行います。(ロール情報)<BR>
	 * 
	 * @param filepath
	 *            CSVファイルパス
	 * @param skipFirst
	 *            先頭行の有無(true:有 false:無)
	 * @param sjisEncoding
	 *            ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 * @throws NullPointerException
	 *             必須項目のパラメータがNULLの場合にエラーが発生
	 */
	public void exportRole(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnRole_export";
		exportInfo(Page, filepath, skipFirst, sjisEncoding);
	}

	/**
	 * ユーザー管理用CSVファイルへの書き出しを行います。(ロールの所持ユーザー)<BR>
	 * 
	 * @param filepath
	 *            CSVファイルパス
	 * @param skipFirst
	 *            先頭行の有無(true:有 false:無)
	 * @param sjisEncoding
	 *            ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 * @throws NullPointerException
	 *             必須項目のパラメータがNULLの場合にエラーが発生
	 */
	public void exportRoleUser(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnRoleUser_export";
		exportInfo(Page, filepath, skipFirst, sjisEncoding);
	}

	/**
	 * ユーザー管理用CSVファイルへの書き出しを行います。(ユーザー情報)<BR>
	 * 
	 * @param filepath
	 *            CSVファイルパス
	 * @param skipFirst
	 *            先頭行の有無(true:有 false:無)
	 * @param sjisEncoding
	 *            ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 * @throws NullPointerException
	 *             必須項目のパラメータがNULLの場合にエラーが発生
	 */
	public void exportUser(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnUser_export";
		exportInfo(Page, filepath, skipFirst, sjisEncoding);
	}

	/**
	 * ユーザー管理用CSVファイルへの書き出しを行います。(ユーザーの所属組織)<BR>
	 * 
	 * @param filepath
	 *            CSVファイルパス
	 * @param skipFirst
	 *            先頭行の有無(true:有 false:無)
	 * @param sjisEncoding
	 *            ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 * @throws NullPointerException
	 *             必須項目のパラメータがNULLの場合にエラーが発生
	 */
	public void exportUserOrganization(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnUserOrganization_export";
		exportInfo(Page, filepath, skipFirst, sjisEncoding);
	}

	/**
	 * ユーザー管理用CSVファイルへの書き出しを行います。(ユーザーの所持ロール)<BR>
	 * 
	 * @param filepath
	 *            CSVファイルパス
	 * @param skipFirst
	 *            先頭行の有無(true:有 false:無)
	 * @param sjisEncoding
	 *            ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 * @throws NullPointerException
	 *             必須項目のパラメータがNULLの場合にエラーが発生
	 */
	public void exportUserRole(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnUserRole_export";
		exportInfo(Page, filepath, skipFirst, sjisEncoding);
	}

	/**
	 * ユーザー管理用CSVファイルの読み込みを行います。(組織情報)<BR>
	 * 
	 * @param filepath
	 *            CSVファイルパス
	 * @param skipFirst
	 *            先頭行の有無(true:有 false:無)
	 * @param sjisEncoding
	 *            ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 * @throws NullPointerException
	 *             必須項目のパラメータがNULLの場合にエラーが発生
	 */
	public void importOrganization(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnOrganization_import";
		importInfo(Page, filepath, skipFirst, sjisEncoding);

	}

	/**
	 * ユーザー管理用CSVファイルの読み込みを行います。(組織の所属ユーザー)<BR>
	 * 
	 * @param filepath
	 *            CSVファイルパス
	 * @param skipFirst
	 *            先頭行の有無(true:有 false:無)
	 * @param sjisEncoding
	 *            ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 * @throws NullPointerException
	 *             必須項目のパラメータがNULLの場合にエラーが発生
	 */
	public void importOrganizationUser(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnOrganizationUser_import";
		importInfo(Page, filepath, skipFirst, sjisEncoding);
	}

	/**
	 * ユーザー管理用CSVファイルの読み込みを行います。(ロール情報)<BR>
	 * 
	 * @param filepath
	 *            CSVファイルパス
	 * @param skipFirst
	 *            先頭行の有無(true:有 false:無)
	 * @param sjisEncoding
	 *            ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 * @throws NullPointerException
	 *             必須項目のパラメータがNULLの場合にエラーが発生
	 */
	public void importRole(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnRole_import";
		importInfo(Page, filepath, skipFirst, sjisEncoding);

	}

	/**
	 * ユーザー管理用CSVファイルの読み込みを行います。(ロールの所持ユーザー)<BR>
	 * 
	 * @param filepath
	 *            CSVファイルパス
	 * @param skipFirst
	 *            先頭行の有無(true:有 false:無)
	 * @param sjisEncoding
	 *            ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 * @throws NullPointerException
	 *             必須項目のパラメータがNULLの場合にエラーが発生
	 */
	public void importRoleUser(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnRoleUser_import";
		importInfo(Page, filepath, skipFirst, sjisEncoding);

	}

	/**
	 * ユーザー管理用CSVファイルの読み込みを行います。(ユーザー情報)<BR>
	 * 
	 * @param filepath
	 *            CSVファイルパス
	 * @param skipFirst
	 *            先頭行の有無(true:有 false:無)
	 * @param sjisEncoding
	 *            ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 * @throws NullPointerException
	 *             必須項目のパラメータがNULLの場合にエラーが発生
	 */
	public void importUser(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnUser_import";
		importInfo(Page, filepath, skipFirst, sjisEncoding);

	}

	/**
	 * ユーザー管理用CSVファイルの読み込みを行います。(ユーザーの所属組織)<BR>
	 * 
	 * @param filepath
	 *            CSVファイルパス
	 * @param skipFirst
	 *            先頭行の有無(true:有 false:無)
	 * @param sjisEncoding
	 *            ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 * @throws NullPointerException
	 *             必須項目のパラメータがNULLの場合にエラーが発生
	 */
	public void importUserOrganization(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnUserOrganization_import";
		importInfo(Page, filepath, skipFirst, sjisEncoding);

	}

	/**
	 * ユーザー管理用CSVファイルの読み込みを行います。(ロールの所持ユーザー)<BR>
	 * 
	 * @param filepath
	 *            CSVファイルパス
	 * @param skipFirst
	 *            先頭行の有無(true:有 false:無)
	 * @param sjisEncoding
	 *            ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 * @throws NullPointerException
	 *             必須項目のパラメータがNULLの場合にエラーが発生
	 */
	public void importUserRole(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnUserRole_import";
		importInfo(Page, filepath, skipFirst, sjisEncoding);

	}

	/**
	 * タイムカードの登録処理を行います。<BR/> 指定された日付について、項目単位での登録が可能です。
	 * 
	 * @param setDate
	 *            タイムカードの日付
	 * @param startTime
	 *            出社時刻("","*",H:mm形式)のいずれかの値<BR>
	 *            値初期化場合: ""<BR/> 既存値変更しない場合: "*" または null<BR/>
	 *            時間を新たに設定する場合：H:mm形式
	 * @param endTime
	 *            退社時刻("","*",H:mm形式)のいずれかの値<BR>
	 *            値初期化場合: ""<BR/> 既存値変更しない場合: "*" または null<BR/>
	 *            時間を新たに設定する場合：H:mm形式
	 * @param abcencesTimes
	 *            {[修正前外出時刻],[修正後外出時刻],[修正後復帰時刻]} の２次元配列<BR>
	 *            要素の時刻については、("","*",null,H:mm形式)のいずれかの値<BR/> 値初期化の場合: ""<BR/>
	 *            既存値変更しない場合: "*" または null<BR/>
	 *            [修正前外出時刻]に既存設定時刻を指定することによりそれぞれの不在時刻を修正することが可能です。<BR/>
	 *            [修正前外出時刻]に""を指定した場合は、新規に不在時刻を登録します。<BR/>
	 *            1次元目の配列の要素数が3以外の場合は、IllegalArgumentException が発生します。
	 * @param memo
	 *            備考.null指定可能(備考を変更しません)
	 * @param clearFlg
	 *            タイムカードのクリアフラグ(true:クリアする,false:クリアしない)<BR/>
	 *            既に設定してある日付(setDate)のタイムカード情報をクリアします。<BR/> このフラグは、他の項目より優先されます<BR/>
	 * @param registrant
	 *            登録対象者のログイン名.null指定可能(登録対象者はログインユーザとなります)
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 * @throws ParseException
	 *             startTime,endTime,abcencesTimesのいずれかがCalendar型に変換できない場合
	 */
	public void putTimecard(Calendar setDate, String startTime, String endTime,
			String[][] abcencesTimes, String memo, boolean clearFlg,
			String registrant) throws IOException, RemoteException,
			ParseException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		String Page = new StringBuffer().append(grnURL).append(
				"/coop/grnTimecard_add").toString();
		super.setPageInfo(URI.create(Page));
		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getURLEncodingStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "timecard"); // Application

		ps.addProperty("system", "2"); // 権限チェック用(System)
		ps.addProperty("manage", "timecard"); // 権限チェック用Application名

		if (memo != null)
			ps.addProperty("remarks", memo); // 備考ファイル

		if (registrant != null)
			ps.addProperty("registrant", registrant); // 対象ユーザー

		if (clearFlg == true) // クリアフラグ
			ps.addProperty("clear", "");

		if (setDate != null) // 日付
			ps.addProperty("date", new StringBuffer().append(
					setDate.get(Calendar.YEAR)).append("-").append(
					setDate.get(Calendar.MONTH) + 1).append("-").append(
					setDate.get(Calendar.DAY_OF_MONTH)).toString());

		Calendar myCal = Calendar.getInstance();
		;
		SimpleDateFormat sdf = new SimpleDateFormat();
		sdf.applyPattern("H:mm");
		sdf.setLenient(false);

		if (startTime == null) // 出社時刻
			startTime = "*";

		if (startTime.equals("") || startTime.equals("*")) {
			ps.addProperty("start_hour", startTime);
			ps.addProperty("start_minute", startTime);
		} else {
			myCal.setTime(sdf.parse(startTime));
			ps.addProperty("start_hour", myCal.get(Calendar.HOUR_OF_DAY));
			ps.addProperty("start_minute", myCal.get(Calendar.MINUTE));
		}

		if (endTime == null) // 出社時刻
			endTime = "*";

		if (endTime.equals("") || endTime.equals("*")) {
			ps.addProperty("finish_hour", endTime);
			ps.addProperty("finish_minute", endTime);
		} else {
			myCal.setTime(sdf.parse(endTime));
			ps.addProperty("finish_hour", myCal.get(Calendar.HOUR_OF_DAY));
			ps.addProperty("finish_minute", myCal.get(Calendar.MINUTE));
		}

		StringBuffer paramPrefix = new StringBuffer("");
		if (abcencesTimes != null) {
			for (int i = 0; i < abcencesTimes.length; i++) {
				if (abcencesTimes[i] == null)
					continue;

				if (abcencesTimes[i].length != 3)
					throw new IllegalArgumentException("Bad abcencesTimes");

				for (int j = 0; j < abcencesTimes[i].length; j++) {
					switch (j) {
					case 0:
						paramPrefix = new StringBuffer("before_trip_mod_");
						break;
					case 1:
						paramPrefix = new StringBuffer("after_trip_mod_");
						break;
					case 2:
						paramPrefix = new StringBuffer("after_back_mod_");
						break;
					}
					if (j == 0 && abcencesTimes[i][j] == null
							&& abcencesTimes[i][j + 1] == null
							&& abcencesTimes[i][j + 2] == null) {
						j = j + 2;
						continue;
					}
					if (abcencesTimes[i][j] == null)
						abcencesTimes[i][j] = j == 0 ? "" : "*";

					if (abcencesTimes[i][j].equals("")
							|| abcencesTimes[i][j].equals("*")) {
						ps.addProperty(new StringBuffer().append(paramPrefix)
								.append("hour[]").toString(),
								abcencesTimes[i][j]);
						ps.addProperty(new StringBuffer().append(paramPrefix)
								.append("minute[]").toString(),
								abcencesTimes[i][j]);
					} else {
						myCal.setTime(sdf.parse(abcencesTimes[i][j]));
						ps.addProperty(new StringBuffer().append(paramPrefix)
								.append("hour[]").toString(), myCal
								.get(Calendar.HOUR_OF_DAY));
						ps.addProperty(new StringBuffer().append(paramPrefix)
								.append("minute[]").toString(), myCal
								.get(Calendar.MINUTE));
					}
				}
			}
		}

		ps.close();
		processResult(hc, "failed in the registration of the timecard.");
	}

	/**
	 * メールアカウントのCSVファイルへの書き出しを行います。<BR>
	 * 
	 * @param filePath
	 *            CSVファイルパス
	 * @param skipFirst
	 *            先頭行の有無(true:有 false:無)
	 * @param sjisEncoding
	 *            ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	// 2007/04/16
	// [Javaメソッド]メールアカウントCSV書き出し時、CSVファイルパス部分に「null」等を設定した際のエラーメッセージが不正と思われる。
	// 不具合管理(212)
	public void exportMailAccount(String filePath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		String Page = new StringBuffer().append(grnURL).append(
				"/coop/grnMailAccount_export").toString();
		super.setPageInfo(URI.create(Page));
		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);

		PostStream ps = super.getURLEncodingStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("system", "2"); // 権限チェック用(System)
		ps.addProperty("manage", "mail"); // 権限チェック用Application名
		if (skipFirst) // 先頭行の有無
			ps.addProperty("item_name", 1); // 先頭行の有
		else
			ps.addProperty("item_name", 0); // 先頭行の無

		if (sjisEncoding == true) // エンコード
			ps.addProperty("charset", "SJIS-win");
		else
			ps.addProperty("charset", "UTF-8");
		ps.close();

		fileWrite(hc, filePath, sjisEncoding);
	}

	/**
	 * メールアカウントのCSVファイルの読み込みを行います。<BR>
	 * 
	 * @param filePath
	 *            CSVファイルパス
	 * @param skipFirst
	 *            先頭行の有無(true:有 false:無)
	 * @param sjisEncoding
	 *            ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	public void importMailAccount(String filePath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		String Page = new StringBuffer().append(grnURL).append(
				"/coop/grnMailAccount_import").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);

		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("system", "2"); // 権限チェック用(System)
		ps.addProperty("manage", "mail"); // 権限チェック用Application名
		if (filePath != null)
			ps.addFile(new File(filePath), new StringBuffer().append("file")
					.toString(), "application/octet-stream");
		if (skipFirst) // 先頭行の有無
			ps.addProperty("skip", 1); // 先頭行の有
		else
			ps.addProperty("skip", 0); // 先頭行の無

		if (sjisEncoding == true) // エンコード
			ps.addProperty("charset", "SJIS-win");
		else
			ps.addProperty("charset", "UTF-8");
		ps.close();

		processResult(hc, "failed to import csv file.");
	}

	/**
	 * スケジュールフォローの追加処理を行います。<BR/>
	 * 
	 * @param eventId
	 *            ガルーン２のスケジュールID
	 * @param data
	 *            フォローの本文
	 * @param registrant
	 *            登録者のログイン名.null指定可能(登録者はログインユーザとなります)
	 * @return 登録されたガルーン２のスケジュールフォローID
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	public String putScheduleFollowAdd(long eventId, String data,
			String registrant) throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		/**
		 * スケジュールフォロー追加用cspの呼び出し先格納変数
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopSchedule_follow_add").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);

		PostStream ps = super.getURLEncodingStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "schedule"); // Application
		ps.addProperty("event", String.valueOf(eventId)); // ガルーン２のスケジュールID

		if (data != null)
			ps.addProperty("data", data); // フォローの本文

		if (registrant != null) // 登録者のログイン名
			ps.addProperty("registrant", registrant);

		ps.close();
		return processResult(hc, "failed to registrant of schedule follow.");// 戻り値(スケジュールフォローID)
	}

	/**
	 * スケジュールフォローの削除処理を行います。<BR/>
	 * 
	 * @param followId
	 *            ガルーン２のスケジュールフォローID
	 * @param registrant
	 *            削除者のログイン名.null指定可能(削除者はログインユーザとなります)
	 * @return 削除されたガルーン２のスケジュールフォローID
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	public String putScheduleFollowDelete(long followId, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		/**
		 * スケジュール削除用cspの呼び出し先格納変数
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopSchedule_follow_delete").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = super.getURLEncodingStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "schedule"); // Application
		ps.addProperty("follow_id", String.valueOf(followId)); // スケジュールフォローID

		if (registrant != null)
			ps.addProperty("registrant", registrant); // 削除者のログイン名

		ps.close();
		return processResult(hc, "failed to delete of schedule follow.");// 戻り値(スケジュールフォローID)
	}

	/**
	 * HTTP サーバーとの通信結果で、返されたヘッダを処理します。<br>
	 * このメソッドでは "Set-Cookie" ヘッダを処理し、Cookie のレポジトリに追加します。<br>
	 * さらなる処理が必要な場合は、このメソッドをサブクラスでオーバーライドします。
	 * 
	 * @param hc
	 *            {@link #getConnection} で取得した HttpURLConnection
	 * @param context
	 *            このメソッドが呼ばれた背景についての文言を指定します。 リモートエンドで何らかのエラーが起こった場合に、
	 *            {@link RemoteException}のエラーメッセージの一部になります。
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	private void checkErrorHeader(HttpURLConnection hc, String context)
			throws IOException, RemoteException {

		String errno = hc.getHeaderField(GASERROR_HEADER);
		if (errno != null) {
			throw new RemoteException(context + "(" + errno + ")");
		}
	}

	/**
	 * ユーザー管理用CSVファイルの作成を行います。<BR>
	 * 
	 * @param hc
	 *            HttpClient.getConnection(int) から取得した HttpURLConnection。
	 * @param filepath
	 *            CSVファイルパス
	 * @param sjisEncoding
	 *            ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	private void fileWrite(java.net.HttpURLConnection hc, String filepath,
			boolean sjisEncoding) throws IOException, RemoteException {

		// 不具合管理 275 csv書出で、Client-Linuxで書出されるCSVの改行コードがLFになる 2008/01/15
		// バイトストリームで書出す。
		saveResponseDataToFile(hc, filepath, "failed to download a CSV file.");
		// String en = null;
		//        
		// super.processHeader( hc );
		// checkErrorHeader(hc,"failed to download a CSV file.");
		//
		// if (sjisEncoding==true)
		//            
		// en = "MS932";
		// else
		// en = "UTF-8";
		//
		// // process output
		// BufferedReader in = null;
		// try {
		// in = new BufferedReader(
		// new InputStreamReader( hc.getInputStream(), en ) );
		// }
		// catch ( UnsupportedEncodingException e ) {
		// // do nothing
		// }
		//        
		// BufferedWriter writer = null;
		// try {
		// writer = new BufferedWriter(new OutputStreamWriter(
		// new FileOutputStream( filepath ),
		// en));
		// while ( true )
		// {
		// String line = in.readLine();
		// if ( line == null ) break;
		//                
		// writer.write( line, 0, line.length() );
		// writer.newLine();
		// }
		// in.close();
		// }
		// finally {
		// try {
		// if ( writer != null ) {
		// writer.flush();
		// writer.close();
		// }
		// }
		// catch ( Exception e ) {
		// }
		// }

	}

	/**
	 * ガルーン２連携用プログラムのバージョン取得を行います。
	 * 
	 * @return アプリケーション連携のバージョン
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	public String versionInfo() throws IOException, RemoteException {
		/**
		 * ガルーン２連携用プログラムバージョンチェックの呼び出し先格納変数
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopLogin").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);

		PostStream ps = getURLEncodingStream(hc);
		ps.addProperty("version", "0"); // バージョン
		ps.close();
		processResult(hc, "The acquisition of an API version.");

		return hc.getHeaderField("X-Cybozu-API-VERSION");
	}

	/**
	 * ユーザー管理用CSVファイルの読み込みを行います。<BR>
	 * 
	 * @param page
	 *            ページ指定
	 * @param filepath
	 *            CSVファイルパス
	 * @param skipFirst
	 *            先頭行の有無(true:有 false:無)
	 * @param sjisEncoding
	 *            ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 * @throws NullPointerException
	 *             必須項目のパラメータがNULLの場合にエラーが発生
	 */
	private void importInfo(String page, String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		if (filepath == null)
			filepath = ""; // CSVファイルパス

		String Page = new StringBuffer().append(grnURL).append(page).toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);

		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("system", "1"); // 権限チェック用(System)
		ps.addProperty("manage", "user"); // 権限チェック用Application名
		ps.addFile(new File(filepath), new StringBuffer().append("file")
				.toString(), "application/octet-stream");
		if (skipFirst) // 先頭行の有無
			ps.addProperty("skip", 1); // 先頭行の有
		else
			ps.addProperty("skip", 0); // 先頭行の無

		if (sjisEncoding == true) // エンコード
			ps.addProperty("charset", "SJIS-win");
		else
			ps.addProperty("charset", "UTF8");
            
			ps.addProperty("old", 1); // 不具合GRNJAVAAPI-5の改修

		ps.close();

		processResult(hc, "failed to upload a CSV file.");
	}

	/**
	 * ユーザー管理用CSVファイルの書き出しを行います。<BR>
	 * 
	 * @param page
	 *            ページ指定
	 * @param filepath
	 *            CSVファイルパス
	 * @param skipFirst
	 *            先頭行の有無(true:有 false:無)
	 * @param sjisEncoding
	 *            ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 * @throws NullPointerException
	 *             必須項目のパラメータがNULLの場合にエラーが発生
	 */
	private void exportInfo(String page, String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		if (filepath == null)
			filepath = ""; // CSVファイルパス

		String Page = new StringBuffer().append(grnURL).append(page).toString();
		super.setPageInfo(URI.create(Page));
		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);

		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("system", "1"); // 権限チェック用(System)
		ps.addProperty("manage", "user"); // 権限チェック用Application名
		if (skipFirst) // 先頭行の有無
			ps.addProperty("title", 1); // 先頭行の有
		else
			ps.addProperty("title", 0); // 先頭行の無

		if (sjisEncoding == true) // エンコード
			ps.addProperty("charset", "SJIS-win");
		else
			ps.addProperty("charset", "UTF8");

            ps.addProperty("old", 1); // 不具合GRNJAVAAPI-5の改修

		ps.close();

		fileWrite(hc, filepath, sjisEncoding); // ユーザー管理用CSVファイルの作成
	}

	/**
	 * ガルーン２ ファイル管理上のファイルID(引数 [fileId]) について、<BR/> 引数
	 * [items]で出力指定された項目を持つXMLファイルを、引数 [filePath] に出力します。<BR/>
	 * 
	 * @param fileId
	 *            ガルーン２のファイルID
	 * @param items
	 *            出力項目
	 * @param filePath
	 *            XMLファイルパス
	 * @param registrant
	 *            情報取得を行うユーザーのログイン名. null指定可能(情報取得を行うユーザーはログインユーザとなります)
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	// javadoc 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	// directoryPath + "fileinformation.xml" → filePath
	// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	public void exportXMLCabinetFileInfo(long fileId, FileInfoProperties items,
			String filePath, String registrant) throws IOException,
			RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		// 不具合改修 FolderInfoProperties,FileInfoProperties使いまわした場合に、挙動が不正 (266)
		HashMap hm = new HashMap();
		if (items != null)
			hm.putAll(items.getParameters());

		hm.put("app", "cabinet");
		hm.put("fid", Long.toString(fileId));

		if (registrant != null)
			hm.put("registrant", registrant);

		// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
		saveResponseDataToFile(getResponseStream(
				"/coop/coopCabinet_fileinfo_exportXML", hm), filePath,
				"failed to export xmlfile of file information.");
	}

	/**
	 * ガルーン２ ファイル管理上のファイルID(引数 [fileId]) について、<BR/>
	 * 履歴情報以外のファイル情報項目を持つXMLファイルを、引数 [filePath] に出力します。<BR/>
	 * 
	 * @param fileId
	 *            ガルーン２のファイルID
	 * @param filePath
	 *            XMLファイルパス
	 * @param registrant
	 *            情報取得を行うユーザーのログイン名. null指定可能(情報取得を行うユーザーはログインユーザとなります)
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	// javadoc 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	// directoryPath + "fileinformation.xml" → filePath
	// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	public void exportXMLCabinetFileInfo(long fileId, String filePath,
			String registrant) throws IOException, RemoteException {
		// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
		exportXMLCabinetFileInfo(fileId, new FileInfoProperties(), filePath,
				registrant);
	}

	/**
	 * ガルーン２ ファイル管理上のフォルダID(引数 [folderId]) のフォルダ内にあるファイルリストについて<BR/> 引数
	 * [items]で出力指定された項目を持つXMLファイルを、引数 [filePath] に出力します。<BR/>
	 * 
	 * @param folderId
	 *            ガルーン２のフォルダID
	 * @param items
	 *            出力項目
	 * @param filePath
	 *            XMLファイルパス
	 * @param registrant
	 *            情報取得を行うユーザーのログイン名. null指定可能(情報取得を行うユーザーはログインユーザとなります)
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	// javadoc 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	// directoryPath + "fileinformation.xml" → filePath
	// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	public void exportXMLCabinetFileInfoFolderChild(long folderId,
			FileInfoProperties items, String filePath, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		// 不具合改修 FolderInfoProperties,FileInfoProperties使いまわした場合に、挙動が不正 (266)
		HashMap hm = new HashMap();
		if (items != null)
			hm.putAll(items.getParameters());

		hm.put("app", "cabinet");
		hm.put("hid", Long.toString(folderId));

		if (registrant != null)
			hm.put("registrant", registrant);

		// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
		saveResponseDataToFile(getResponseStream(
				"/coop/coopCabinet_fileinfo_exportXML", hm), filePath,
				"failed to export xmlfile of file information.");
	}

	/**
	 * ガルーン２ ファイル管理上のフォルダコード(引数 [folderCode]) のフォルダ内にあるファイルリストについて<BR/> 引数
	 * [items]で出力指定された項目を持つXMLファイルを、引数 [filePath] に出力します。<BR/>
	 * 
	 * @param folderCode
	 *            ガルーン２のフォルダコード
	 * @param items
	 *            出力項目
	 * @param filePath
	 *            XMLファイルパス
	 * @param registrant
	 *            情報取得を行うユーザーのログイン名. null指定可能(情報取得を行うユーザーはログインユーザとなります)
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	// javadoc 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	// directoryPath + "fileinformation.xml" → filePath
	// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	public void exportXMLCabinetFileInfoFolderChild(String folderCode,
			FileInfoProperties items, String filePath, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		// 不具合改修 FolderInfoProperties,FileInfoProperties使いまわした場合に、挙動が不正 (266)
		HashMap hm = new HashMap();
		if (items != null)
			hm.putAll(items.getParameters());

		hm.put("app", "cabinet");

		if (folderCode != null)
			hm.put("foldercode", folderCode);

		if (registrant != null)
			hm.put("registrant", registrant);

		// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
		saveResponseDataToFile(getResponseStream(
				"/coop/coopCabinet_fileinfo_exportXML", hm), filePath,
				"failed to export xmlfile of file information.");
	}

	/**
	 * ガルーン２ ファイル管理上のフォルダID(引数 [folderId]) のフォルダ内にあるファイルリストについて<BR/>
	 * 履歴情報以外のファイル情報項目を持つXMLファイルを、引数 [filePath] に出力します。<BR/>
	 * 
	 * @param folderId
	 *            ガルーン２のフォルダID
	 * @param filePath
	 *            XMLファイルパス
	 * @param registrant
	 *            情報取得を行うユーザーのログイン名. null指定可能(情報取得を行うユーザーはログインユーザとなります)
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	// javadoc 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	// directoryPath + "fileinformation.xml" → filePath
	// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	public void exportXMLCabinetFileInfoFolderChild(long folderId,
			String filePath, String registrant) throws IOException,
			RemoteException {
		// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
		this.exportXMLCabinetFileInfoFolderChild(folderId,
				new FileInfoProperties(), filePath, registrant);
	}

	/**
	 * ガルーン２ ファイル管理上のフォルダコード(引数 [folderCode]) のフォルダ内にあるファイルリストについて<BR/>
	 * 履歴情報以外のファイル情報項目を持つXMLファイルを、引数 [filePath] に出力します。<BR/>
	 * 
	 * @param folderCode
	 *            ガルーン２のフォルダコード
	 * @param filePath
	 *            XMLファイルパス
	 * @param registrant
	 *            情報取得を行うユーザーのログイン名. null指定可能(情報取得を行うユーザーはログインユーザとなります)
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	// javadoc 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	// directoryPath + "fileinformation.xml" → filePath
	// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	public void exportXMLCabinetFileInfoFolderChild(String folderCode,
			String filePath, String registrant) throws IOException,
			RemoteException {
		// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
		this.exportXMLCabinetFileInfoFolderChild(folderCode,
				new FileInfoProperties(), filePath, registrant);
	}

	/**
	 * ガルーン２ ファイル管理上のフォルダID(引数 [folderId]) におけるフォルダ情報(直下以降のフォルダの情報は含みません）について、<BR/>
	 * 引数 [items]で出力指定された項目を持つXMLファイルを、引数 [filePath] に出力します。<BR/>
	 * 
	 * @param folderId
	 *            ガルーン２のフォルダID
	 * @param items
	 *            出力項目
	 * @param filePath
	 *            XMLファイルパス
	 * @param registrant
	 *            情報取得を行うユーザーのログイン名. null指定可能(情報取得を行うユーザーはログインユーザとなります)
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	// javadoc 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	// directoryPath + "folderinformation.xml" → filePath
	// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	public void exportXMLCabinetFolderInfo(long folderId,
			FolderInfoProperties items, String filePath, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		// 不具合改修 FolderInfoProperties,FileInfoProperties使いまわした場合に、挙動が不正 (266)
		HashMap hm = new HashMap();
		if (items != null)
			hm.putAll(items.getParameters());

		hm.put("app", "cabinet");
		hm.put("type", "0");
		hm.put("hid", Long.toString(folderId));

		if (registrant != null)
			hm.put("registrant", registrant);

		// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
		saveResponseDataToFile(getResponseStream(
				"/coop/coopCabinet_folderinfo_exportXML", hm), filePath,
				"failed to export xmlfile of folder infomation.");
	}

	/**
	 * ガルーン２ ファイル管理上のフォルダID(引数 [folderId]) におけるフォルダ情報(直下以降のフォルダの情報は含みません）について、<BR/>
	 * フォルダ名とフォルダメモの項目を持つXMLファイルを 、引数 [filePath] に出力します。<BR/>
	 * 
	 * @param folderId
	 *            ガルーン２のフォルダID
	 * @param filePath
	 *            XMLファイルパス
	 * @param registrant
	 *            情報取得を行うユーザーのログイン名. null指定可能(情報取得を行うユーザーはログインユーザとなります)
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	// javadoc 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	// directoryPath + "folderinformation.xml" → filePath
	// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	public void exportXMLCabinetFolderInfo(long folderId, String filePath,
			String registrant) throws IOException, RemoteException {
		FolderInfoProperties fp = new FolderInfoProperties();

		// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
		exportXMLCabinetFolderInfo(folderId, fp, filePath, registrant);
	}

	/**
	 * ガルーン２ ファイル管理上のフォルダID(引数 [folderId]) におけるフォルダ情報(直下の子フォルダの情報を含む）について、<BR/>
	 * 引数 [items]で出力指定された項目を持つXMLファイルを、引数 [filePath] に出力します。<BR/>
	 * 
	 * @param folderId
	 *            ガルーン２のフォルダID
	 * @param items
	 *            出力項目
	 * @param filePath
	 *            XMLファイルパス
	 * @param registrant
	 *            情報取得を行うユーザーのログイン名. null指定可能(情報取得を行うユーザーはログインユーザとなります)
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	// javadoc 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	// directoryPath + "folderinformation.xml" → filePath
	// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	public void exportXMLCabinetFolderInfo_Child(long folderId,
			FolderInfoProperties items, String filePath, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		// 不具合改修 FolderInfoProperties,FileInfoProperties使いまわした場合に、挙動が不正 (266)
		HashMap hm = new HashMap();
		if (items != null)
			hm.putAll(items.getParameters());

		hm.put("app", "cabinet");
		hm.put("type", "1");
		hm.put("hid", Long.toString(folderId));

		if (registrant != null)
			hm.put("registrant", registrant);

		// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
		saveResponseDataToFile(getResponseStream(
				"/coop/coopCabinet_folderinfo_exportXML", hm), filePath,
				"failed to export xmlfile of folder infomation.");
	}

	/**
	 * ガルーン２ ファイル管理上のフォルダID(引数 [folderId]) におけるフォルダ情報(直下の子フォルダの情報を含む）について、<BR/>
	 * フォルダ名とフォルダメモの項目を持つXMLファイルを 、引数 [filePath] に出力します。<BR/>
	 * 
	 * @param folderId
	 *            ガルーン２のフォルダID
	 * @param filePath
	 *            XMLファイルパス
	 * @param registrant
	 *            情報取得を行うユーザーのログイン名. null指定可能(情報取得を行うユーザーはログインユーザとなります)
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	// javadoc 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	// directoryPath + "folderinformation.xml" → filePath
	// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	public void exportXMLCabinetFolderInfo_Child(long folderId,
			String filePath, String registrant) throws IOException,
			RemoteException {
		FolderInfoProperties fp = new FolderInfoProperties();

		// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
		exportXMLCabinetFolderInfo_Child(folderId, fp, filePath, registrant);
	}

	/**
	 * ガルーン２ ファイル管理上のフォルダID(引数 [folderId]) におけるフォルダ情報(Tree構造）について、<BR/> 引数
	 * [items]で出力指定された項目を持つXMLファイルを、引数 [filePath] に出力します。<BR/>
	 * 
	 * @param folderId
	 *            ガルーン２のフォルダID
	 * @param items
	 *            出力項目
	 * @param filePath
	 *            XMLファイルパス
	 * @param registrant
	 *            情報取得を行うユーザーのログイン名. null指定可能(情報取得を行うユーザーはログインユーザとなります)
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	// javadoc 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	// directoryPath + "folderinformation.xml" → filePath
	// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	public void exportXMLCabinetFolderInfo_Tree(long folderId,
			FolderInfoProperties items, String filePath, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		// 不具合改修 FolderInfoProperties,FileInfoProperties使いまわした場合に、挙動が不正 (266)
		HashMap hm = new HashMap();
		if (items != null)
			hm.putAll(items.getParameters());

		hm.put("app", "cabinet");
		hm.put("type", "2");
		hm.put("hid", Long.toString(folderId));

		if (registrant != null)
			hm.put("registrant", registrant);

		// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
		saveResponseDataToFile(getResponseStream(
				"/coop/coopCabinet_folderinfo_exportXML", hm), filePath,
				"failed to export xmlfile of folder infomation.");
	}

	/**
	 * ガルーン２ ファイル管理上のフォルダID(引数 [folderId]) におけるフォルダ情報(Tree構造）について、<BR/>
	 * フォルダ名とフォルダメモの項目を持つXMLファイルを 、引数 [filePath] に出力します。<BR/>
	 * 
	 * @param folderId
	 *            ガルーン２のフォルダID
	 * @param filePath
	 *            XMLファイルパス
	 * @param registrant
	 *            情報取得を行うユーザーのログイン名. null指定可能(情報取得を行うユーザーはログインユーザとなります)
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	// javadoc 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	// directoryPath + "folderinformation.xml" → filePath
	// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	public void exportXMLCabinetFolderInfo_Tree(long folderId, String filePath,
			String registrant) throws IOException, RemoteException {
		FolderInfoProperties fp = new FolderInfoProperties();

		// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
		exportXMLCabinetFolderInfo_Tree(folderId, fp, filePath, registrant);
	}

	/**
	 * ガルーン２ ファイル管理上のフォルダコード(引数 [folderCode])
	 * におけるフォルダ情報(直下以降のフォルダの情報は含みません）について、<BR/> 引数
	 * [items]で出力指定された項目を持つXMLファイルを、引数 [filePath] に出力します。<BR/>
	 * 
	 * @param folderCode
	 *            ガルーン２のフォルダコード
	 * @param items
	 *            出力項目
	 * @param filePath
	 *            XMLファイルパス
	 * @param registrant
	 *            情報取得を行うユーザーのログイン名. null指定可能(情報取得を行うユーザーはログインユーザとなります)
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	// javadoc 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	// directoryPath + "folderinformation.xml" → filePath
	// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	public void exportXMLCabinetFolderInfo(String folderCode,
			FolderInfoProperties items, String filePath, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		// 不具合改修 FolderInfoProperties,FileInfoProperties使いまわした場合に、挙動が不正 (266)
		HashMap hm = new HashMap();
		if (items != null)
			hm.putAll(items.getParameters());

		hm.put("app", "cabinet");
		hm.put("type", "0");
		hm.put("foldercode", folderCode);

		if (registrant != null)
			hm.put("registrant", registrant);

		// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
		saveResponseDataToFile(getResponseStream(
				"/coop/coopCabinet_folderinfo_exportXML", hm), filePath,
				"failed to export xmlfile of folder infomation.");
	}

	/**
	 * ガルーン２ ファイル管理上のフォルダコード(引数 [folderCode])
	 * におけるフォルダ情報(直下以降のフォルダの情報は含みません）について、<BR/> フォルダ名とフォルダメモの項目を持つXMLファイルを 、引数
	 * [filePath] に出力します。<BR/>
	 * 
	 * @param folderCode
	 *            ガルーン２のフォルダコード
	 * @param filePath
	 *            XMLファイルパス
	 * @param registrant
	 *            情報取得を行うユーザーのログイン名. null指定可能(情報取得を行うユーザーはログインユーザとなります)
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	// javadoc 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	// directoryPath + "folderinformation.xml" → filePath
	// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	public void exportXMLCabinetFolderInfo(String folderCode, String filePath,
			String registrant) throws IOException, RemoteException {
		FolderInfoProperties fp = new FolderInfoProperties();

		// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
		exportXMLCabinetFolderInfo(folderCode, fp, filePath, registrant);
	}

	/**
	 * ガルーン２ ファイル管理上のフォルダコード(引数 [folderCode]) におけるフォルダ情報(直下の子フォルダの情報を含む）について、<BR/>
	 * 引数 [items]で出力指定された項目を持つXMLファイルを、引数 [filePath] に出力します。<BR/>
	 * 
	 * @param folderCode
	 *            ガルーン２のフォルダコード
	 * @param items
	 *            出力項目
	 * @param filePath
	 *            XMLファイルパス
	 * @param registrant
	 *            情報取得を行うユーザーのログイン名. null指定可能(情報取得を行うユーザーはログインユーザとなります)
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	// javadoc 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	// directoryPath + "folderinformation.xml" → filePath
	// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	public void exportXMLCabinetFolderInfo_Child(String folderCode,
			FolderInfoProperties items, String filePath, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		// 不具合改修 FolderInfoProperties,FileInfoProperties使いまわした場合に、挙動が不正 (266)
		HashMap hm = new HashMap();
		if (items != null)
			hm.putAll(items.getParameters());

		hm.put("app", "cabinet");
		hm.put("type", "1");
		hm.put("foldercode", folderCode);

		if (registrant != null)
			hm.put("registrant", registrant);

		// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
		saveResponseDataToFile(getResponseStream(
				"/coop/coopCabinet_folderinfo_exportXML", hm), filePath,
				"failed to export xmlfile of folder infomation.");
	}

	/**
	 * ガルーン２ ファイル管理上のフォルダコード(引数 [folderCode]) におけるフォルダ情報(直下の子フォルダの情報を含む）について、<BR/>
	 * フォルダ名とフォルダメモの項目を持つXMLファイルを 、引数 [filePath] に出力します。<BR/>
	 * 
	 * @param folderCode
	 *            ガルーン２のフォルダコード
	 * @param filePath
	 *            XMLファイルパス
	 * @param registrant
	 *            情報取得を行うユーザーのログイン名. null指定可能(情報取得を行うユーザーはログインユーザとなります)
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	// javadoc 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	// directoryPath + "folderinformation.xml" → filePath
	// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	public void exportXMLCabinetFolderInfo_Child(String folderCode,
			String filePath, String registrant) throws IOException,
			RemoteException {
		FolderInfoProperties fp = new FolderInfoProperties();

		// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
		exportXMLCabinetFolderInfo_Child(folderCode, fp, filePath, registrant);
	}

	/**
	 * ガルーン２ ファイル管理上のフォルダコード(引数 [folderCode]) におけるフォルダ情報(Tree構造）について、<BR/> 引数
	 * [items]で出力指定された項目を持つXMLファイルを、引数 [filePath] に出力します。<BR/>
	 * 
	 * @param folderCode
	 *            ガルーン２のフォルダコード
	 * @param items
	 *            出力項目
	 * @param filePath
	 *            XMLファイルパス
	 * @param registrant
	 *            情報取得を行うユーザーのログイン名. null指定可能(情報取得を行うユーザーはログインユーザとなります)
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	// javadoc 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	// directoryPath + "folderinformation.xml" → filePath
	// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	public void exportXMLCabinetFolderInfo_Tree(String folderCode,
			FolderInfoProperties items, String filePath, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		// 不具合改修 FolderInfoProperties,FileInfoProperties使いまわした場合に、挙動が不正 (266)
		HashMap hm = new HashMap();
		if (items != null)
			hm.putAll(items.getParameters());

		hm.put("app", "cabinet");
		hm.put("type", "2");
		hm.put("foldercode", folderCode);

		if (registrant != null)
			hm.put("registrant", registrant);

		// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
		saveResponseDataToFile(getResponseStream(
				"/coop/coopCabinet_folderinfo_exportXML", hm), filePath,
				"failed to export xmlfile of folder infomation.");
	}

	/**
	 * ガルーン２ ファイル管理上のフォルダコード(引数 [folderCode]) におけるフォルダ情報(Tree構造）について、<BR/>
	 * フォルダ名とフォルダメモの項目を持つXMLファイルを 、引数 [filePath] に出力します。<BR/>
	 * 
	 * @param folderCode
	 *            ガルーン２のフォルダコード
	 * @param filePath
	 *            XMLファイルパス
	 * @param registrant
	 *            情報取得を行うユーザーのログイン名. null指定可能(情報取得を行うユーザーはログインユーザとなります)
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	// javadoc 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	// directoryPath + "folderinformation.xml" → filePath
	// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
	public void exportXMLCabinetFolderInfo_Tree(String folderCode,
			String filePath, String registrant) throws IOException,
			RemoteException {
		FolderInfoProperties fp = new FolderInfoProperties();

		// 2007/04/20 XML書出し時のdirpathはfilepathにして、保存名を選択可能になるべき(233)
		exportXMLCabinetFolderInfo_Tree(folderCode, fp, filePath, registrant);
	}

	/**
	 * 引数 [attachedFileId]の添付ファイルをガルーン２ ワークフローよりダウンロードし、<BR>
	 * 引数 引数 [directoryPath]のディレクトリ に、引数 [fileName] のファイル名で保存します。<BR>
	 * 
	 * @param attachedFileId
	 *            ガルーン２ ワークフローの添付ファイルID
	 * @param directoryPath
	 *            ファイルを保存するディレクトリパス.null指定可能(カレントディレクトリに保存します。）
	 * @param fileName
	 *            ファイルを保存するファイル名.null指定可能(ガルーン２ ワークフローに登録されている添付ファイル名で保存します。)
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	public void downloadSystemWorkFlowAttachedFile(long attachedFileId,
			String directoryPath, String fileName) throws IOException,
			RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		SystemWorkFlow workFlow = new SystemWorkFlow(this);
		workFlow.downloadSystemFile(attachedFileId, directoryPath, fileName);
	}

	/**
	 * 引数 [attachedFileId]の添付ファイルをガルーン２ ワークフローよりダウンロードし、<BR>
	 * 引数 引数 [directoryPath]のディレクトリ に、引数 [fileName] のファイル名で保存します。<BR>
	 * 
	 * @param attachedFileId
	 *            ガルーン２ ワークフローの添付ファイルID
	 * @param directoryPath
	 *            ファイルを保存するディレクトリパス.null指定可能(カレントディレクトリに保存します。）
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 */
	public void downloadSystemWorkFlowAttachedFile(long attachedFileId,
			String directoryPath) throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		SystemWorkFlow workFlow = new SystemWorkFlow(this);
		workFlow.downloadSystemFile(attachedFileId, directoryPath);
	}

	/**
	 * ガルーン２ ワークフロー上の申請データID(引数 [petitionId]) について、 引数
	 * [items]で出力指定された項目を持つXMLファイルを 引数 [filePath] に出力します。
	 * 
	 * @param petitionId
	 *            ワークフローの申請ID
	 * @param items
	 *            出力項目
	 * @param filePath
	 *            XMLファイルパス
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２上でエラーが発生した場合
	 */
	public void exportXMLSystemWorkFlowPetitionData(long petitionId,
			WorkFlowdataItemProperties items, String filePath)
			throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		new SystemWorkFlow(this).exportXMLPetitionData(petitionId, items,
				filePath);
	}

	/**
	 * ガルーン２ ワークフロー上の申請データID(引数 [petitionId]) について、 経路情報以外の項目を持つXMLファイルを 引数
	 * [filePath] に出力します。
	 * 
	 * @param petitionId
	 *            ワークフローの申請ID
	 * @param filePath
	 *            XMLファイルパス
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２上でエラーが発生した場合
	 */
	public void exportXMLSystemWorkFlowPetitionData(long petitionId,
			String filePath) throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		new SystemWorkFlow(this).exportXMLPetitionData(petitionId, filePath);
	}

	/**
	 * ガルーン２ ワークフロー上の申請フォームID(引数 [formId]) 内において、
	 * 引数[selectProperties]で指定される抽出条件に合致する申請データの一覧について、 引数
	 * [items]で出力指定された項目を持つXMLファイルを 引数 [filePath] に出力します。
	 * 
	 * @param formId
	 *            ワークフローの申請フォームID
	 * @param selectProperties
	 *            抽出条件
	 * @param items
	 *            出力項目
	 * @param filePath
	 *            XMLファイルパス
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２上でエラーが発生した場合
	 */
	public void exportXMLSystemWorkFlowFormPetitionData(long formId,
			WorkFlowdataSelectProperties selectProperties,
			WorkFlowdataItemProperties items, String filePath)
			throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		new SystemWorkFlow(this).exportXMLFormPetitionData(formId,
				selectProperties, items, filePath);

	}

	/**
	 * ガルーン２ ワークフロー上の申請フォームID(引数 [formId]) 内において、
	 * 引数[selectProperties]で指定される抽出条件に合致する申請データの一覧について、 経路情報以外の項目を持つXMLファイルを 引数
	 * [filePath] に出力します。
	 * 
	 * @param formId
	 *            ワークフローの申請フォームID
	 * @param selectProperties
	 *            抽出条件
	 * @param filePath
	 *            XMLファイルパス
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２上でエラーが発生した場合
	 */
	public void exportXMLSystemWorkFlowFormPetitionData(long formId,
			WorkFlowdataSelectProperties selectProperties, String filePath)
			throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		new SystemWorkFlow(this).exportXMLFormPetitionData(formId,
				selectProperties, filePath);

	}

	/**
	 * ガルーン２ ワークフロー上の申請フォームコード(引数 [formCode]) 内において、
	 * 引数[selectProperties]で指定される抽出条件に合致する申請データの一覧について、 引数
	 * [items]で出力指定された項目を持つXMLファイルを 引数 [filePath] に出力します。
	 * 
	 * @param formCode
	 *            ワークフローの申請フォームコード
	 * @param selectProperties
	 *            抽出条件
	 * @param items
	 *            出力項目
	 * @param filePath
	 *            XMLファイルパス
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２上でエラーが発生した場合
	 */
	public void exportXMLSystemWorkFlowFormPetitionData(String formCode,
			WorkFlowdataSelectProperties selectProperties,
			WorkFlowdataItemProperties items, String filePath)
			throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		new SystemWorkFlow(this).exportXMLFormPetitionData(formCode,
				selectProperties, items, filePath);

	}

	/**
	 * ガルーン２ ワークフロー上の申請フォームコード(引数 [formCode]) 内において、
	 * 引数[selectProperties]で指定される抽出条件に合致する申請データの一覧について、 経路情報以外の項目を持つXMLファイルを引数
	 * [filePath] に出力します。
	 * 
	 * @param formCode
	 *            ワークフローの申請フォームコード
	 * @param selectProperties
	 *            抽出条件
	 * @param filePath
	 *            XMLファイルパス
	 * 
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２上でエラーが発生した場合
	 */
	public void exportXMLSystemWorkFlowFormPetitionData(String formCode,
			WorkFlowdataSelectProperties selectProperties, String filePath)
			throws IOException, RemoteException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		new SystemWorkFlow(this).exportXMLFormPetitionData(formCode,
				selectProperties, filePath);

	}

	/**
	 * 引数[hc] より取得したレスポンスデータをファイルに出力します。
	 * 
	 * @param filepath
	 *            ファイルパス
	 * @param RemoteExceptionMessage
	 *            RemoteException 発生時のメッセージ
	 * @throws IOException
	 * @throws RemoteException
	 */
	private void saveResponseDataToFile(java.net.HttpURLConnection hc,
			String filePath, String RemoteExceptionMessage) throws IOException,
			RemoteException {
		// クッキーの更新
		super.processHeader(hc);

		// エラーチェック
		checkErrorHeader(hc, RemoteExceptionMessage);

		new Utils().writeBynaryFile(hc.getInputStream(), filePath);
	}

	/**
	 * 引数[hc] より取得したレスポンスデータをファイルに出力します。
	 * 
	 * @param hc
	 * @param directoryPath
	 *            ディレクトリパス(nullの場合は、カレントディレクトリに書出します)
	 * @param fileName
	 *            ファイル名
	 * @param RemoteExceptionMessage
	 *            RemoteException 発生時のメッセージ
	 * @throws IOException
	 * @throws RemoteException
	 */
	private void saveResponseDataToFile(java.net.HttpURLConnection hc,
			String directoryPath, String fileName, String RemoteExceptionMessage)
			throws IOException, RemoteException {
		// クッキーの更新
		super.processHeader(hc);

		// エラーチェック
		checkErrorHeader(hc, RemoteExceptionMessage);

		new Utils().writeBynaryFile(hc.getInputStream(), directoryPath,
				fileName);
	}

	/**
	 * grnURL + 引数[page] へリクエストを飛ばし(マルチパートでPOSTします)、HttpURLConnectionを返します
	 * 
	 * 
	 * @param page
	 *            grnURL以降のリクエストページ先 ( ex. /coop/coopCabinetAdd)
	 * @param hm
	 *            リクエストパラメータ群
	 * 
	 * @return InputStream
	 * 
	 * @throws IOException
	 * @throws RemoteException
	 */
	private java.net.HttpURLConnection getResponseStream(String page, HashMap hm)
			throws IOException {
		String Page = new StringBuffer().append(grnURL).append(page).toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = super.getMultipartStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);
		new Utils().postParamaters(ps, hm);
		ps.close();

		return hc;

	}

	/*
	 * (非 Javadoc)
	 * 
	 * @see jp.co.cybozu.garoon2.util.GrnConnector#getResponseStream()
	 */
	public InputStream getResponseStream(String page, HashMap parameters,
			String remoteExceptionMessage) throws IOException, RemoteException {
		java.net.HttpURLConnection hc = getResponseStream(page, parameters);

		// クッキーの更新
		super.processHeader(hc);

		// エラーチェック
		checkErrorHeader(hc, remoteExceptionMessage);

		return hc.getInputStream();
	}

	/**
	 * ユーザーIDとログイン名のリストを取得します。
	 * 
	 * @return ユーザーID(Long)がキー,ログイン名(String)が値のTreeMap
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２上でエラーが発生した場合
	 */
	public TreeMap getUserIdList() throws IOException, RemoteException {

		this.login(loginUser, loginPassword);

		String page = "/coop/grnUser_get_id_list";
		String errMsg = "failed to get id list.";

		HashMap request = new HashMap();
		request.put("system", "1");
		request.put("manage", "user");

		InputStream in = getResponseStream(page, request, errMsg);

		return getIdMap(in, errMsg);
	}

	/**
	 * 組織IDと組織コードのリストを取得します。
	 * 
	 * @return 組織ID(Long)がキー,組織コード(String)が値のTreeMap
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２上でエラーが発生した場合
	 */
	public TreeMap getGroupIdList() throws IOException, RemoteException {

		this.login(loginUser, loginPassword);

		String page = "/coop/grnGroup_get_id_list";
		String errMsg = "failed to get id list.";

		HashMap request = new HashMap();
		request.put("system", "1");
		request.put("manage", "user");

		InputStream in = getResponseStream(page, request, errMsg);

		return getIdMap(in, errMsg);
	}

	/**
	 * ストリームを解析してTreeMapを返します。
	 * 
	 * @param in
	 *            解析対象のストリーム(1行が[ID],[対応する値]のCSV形式のストリーム)
	 * @return 解析結果のTreeMap(keyがID,valueがコード又はそれに準ずる値)
	 * @throws RemoteException
	 *             解析不能時
	 */
	private TreeMap getIdMap(InputStream in, String parserErrorMsg)
			throws RemoteException {

		CSVReader parser = null;
		try {
			parser = new CSVReader(new InputStreamReader(in, "UTF-8"));
		} catch (UnsupportedEncodingException e1) {
			// Do nothing
		}

		TreeMap tm = new TreeMap();
		String[] col;
		Long key;
		String val;
		try {
			while ((col = parser.readLine()) != null) {
				key = new Long(col[0]);
				val = col[1];
				tm.put(key, val);
			}
			return tm;
		} catch (Exception e) {
			// 解析不能時
			throw new RemoteException(parserErrorMsg);
		} finally {
			try {
				if (in != null)
					in.close();
			} catch (Exception e) {
			}
		}

	}

	/**
	 * アプリケーション用CSVファイルの書き出しを行います。<BR>
	 * 
	 * @param page
	 *            ページ指定
	 * @param filepath
	 *            CSVファイルパス
	 * @param skipFirst
	 *            先頭行の有無(true:有 false:無)
	 * @param sjisEncoding
	 *            ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
	 * @param appName
	 *            アプリケーションモジュール名
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 * @throws NullPointerException
	 *             必須項目のパラメータがNULLの場合にエラーが発生
	 */
	private void exportInfoApp(String page, String filepath, boolean skipFirst,
			boolean sjisEncoding, String appName) throws IOException,
			RemoteException, NullPointerException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		if (filepath == null)
			filepath = ""; // CSVファイルパス

		String Page = new StringBuffer().append(grnURL).append(page).toString();
		super.setPageInfo(URI.create(Page));
		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);

		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("system", "2"); // 権限チェック用(System)
		ps.addProperty("manage", appName); // 権限チェック用Application名
		if (skipFirst) // 先頭行の有無
			ps.addProperty("item_name", 1); // 先頭行の有
		else
			ps.addProperty("item_name", 0); // 先頭行の無

		if (sjisEncoding == true) // エンコード
			ps.addProperty("charset", "SJIS-win");
		else
			ps.addProperty("charset", "UTF8");
		ps.close();

		fileWrite(hc, filepath, sjisEncoding); // ユーザー管理用CSVファイルの作成
	}

	/**
	 * アプリケーション用CSVファイルの読み込みを行います。<BR>
	 * 
	 * @param page
	 *            ページ指定
	 * @param filepath
	 *            CSVファイルパス
	 * @param skipFirst
	 *            先頭行の有無(true:有 false:無)
	 * @param sjisEncoding
	 *            ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
	 * @param appName
	 *            アプリケーションモジュール名
	 * @throws IOException
	 *             接続が確立できない等通信上のエラーが発生した場合
	 * @throws RemoteException
	 *             ガルーン２連携用プログラム上でエラーが発生した場合
	 * @throws NullPointerException
	 *             必須項目のパラメータがNULLの場合にエラーが発生
	 */
	private void importInfoApp(String page, String filepath, boolean skipFirst,
			boolean sjisEncoding, String appName) throws IOException,
			RemoteException, NullPointerException {
		// 2007/05/09 仕様変更
		this.login(loginUser, loginPassword);

		if (filepath == null)
			filepath = ""; // CSVファイルパス

		String Page = new StringBuffer().append(grnURL).append(page).toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);

		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf 対応
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("system", "2"); // 権限チェック用(System)
		ps.addProperty("manage", appName); // 権限チェック用Application名
		ps.addFile(new File(filepath), new StringBuffer().append("file")
				.toString(), "application/octet-stream");
		if (skipFirst) // 先頭行の有無
			ps.addProperty("skip", 1); // 先頭行の有
		else
			ps.addProperty("skip", 0); // 先頭行の無

		if (sjisEncoding == true) // エンコード
			ps.addProperty("charset", "SJIS-win");
		else
			ps.addProperty("charset", "UTF8");
		ps.close();

		processResult(hc, "failed to upload a CSV file.");
	}
	
	/**
     * スケジュール：アクセス権CSVファイルへの書き出しを行います。<BR>
     * 
     * @param filepath CSVファイルパス
     * @param skipFirst 先頭行の有無(true:有 false:無)
     * @param sjisEncoding ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
     * @throws IOException 接続が確立できない等通信上のエラーが発生した場合
     * @throws RemoteException ガルーン２連携用プログラム上でエラーが発生した場合
     * @throws NullPointerException 必須項目のパラメータがNULLの場合にエラーが発生
     */
    public void exportScheduleAccess( String filepath, boolean skipFirst, boolean sjisEncoding )
    throws IOException, RemoteException, NullPointerException
    {
        String Page = "/coop/scheduleAccess_export";
        exportInfoApp( Page,  filepath,  skipFirst,  sjisEncoding , "schedule");
    }

    /**
     * スケジュール：アクセス権CSVファイルの読み込みを行います。<BR>
     * 
     * @param filepath CSVファイルパス
     * @param skipFirst 先頭行の有無(true:有 false:無)
     * @param sjisEncoding ファイルのエンコード指定(true:Shif_JIS,false:UTF-8)
     * @throws IOException 接続が確立できない等通信上のエラーが発生した場合
     * @throws RemoteException ガルーン２連携用プログラム上でエラーが発生した場合
     * @throws NullPointerException 必須項目のパラメータがNULLの場合にエラーが発生
     */
    public void importScheduleAccess( String filepath, boolean skipFirst, boolean sjisEncoding )
    throws IOException, RemoteException, NullPointerException
    {
        String Page = "/coop/scheduleAccess_import";
        importInfoApp(  Page,  filepath,  skipFirst,  sjisEncoding , "schedule");

    }

}
