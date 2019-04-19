/* HttpClient.java */
package jp.co.cybozu.http;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;

/**
 * HTTP サーバーと通信する、最小限の機能を提供する HTTP クライアントを実装します。 <br>
 * このクラスは static な Cookie のレポジトリを保持しています。 <br>
 * そのため、このクラスのインスタンスあるいはサブクラスのインスタンスにまたがる Cookie のレポジトリを管理できます。 <br>
 * このクラスは継承して機能を拡張しなければ、役に立ちません。 <br>
 * 既存あるいは新規に作成したサブクラスで、継承したメソッドを使用して機能を拡張します。
 * 
 * @author サイボウズ
 * @version 1.0.0
 * @see Cookies
 */
public class HttpClient {
	private URI uri;

	private URI pageInfo;

	private URL url;

	private static final Cookies cookies = new Cookies();

	/**
	 * <var>uri </var>で指定された場所と通信する HTTP クライアントを作成します。 <br>
	 * URI のスキームは "http" もしくは "https" である必要があります。
	 * 
	 * @param uri HTTP サーバー上の URI。
	 * @throws IOException 通信エラーが発生した。
	 */
	protected HttpClient(URI uri) throws IOException {
		if (uri == null)
			throw new NullPointerException("uri is null.");
		if ((!uri.isAbsolute()) || uri.isOpaque())
			throw new IllegalArgumentException("Bad URI: "	+ uri.toASCIIString());

		String scheme = uri.getScheme();
		if ((scheme == null)
				|| ((!scheme.equalsIgnoreCase("http")) && (!scheme.equalsIgnoreCase("https")))) {
			throw new IllegalArgumentException("Bad Scheme: " + uri.toASCIIString());
		}

		this.uri = uri;
		url = uri.toURL();
		URLConnection.setDefaultAllowUserInteraction(false);
	}

	/**
	 * <var>pageInfo </var>で指定された場所に変更します。
	 * 
	 * @param pageInfo 変更するHTTP サーバー上の URI
	 * @throws IOException
	 */
	public void setPageInfo(URI pageInfo) throws IOException {
		this.pageInfo = pageInfo;
	}

	/**
	 * getConnection に渡すべきパラメータ。 POST リクエストを行う場合に指定する。
	 */
	public static final int POST = 1;

	/**
	 * getConnection に渡すべきパラメータ。 GET リクエストを行う場合に指定する。
	 */
	public static final int GET = 0;

	/**
	 * コンストラクタで指定した <var>URI </var> に向けて通信を行う、
	 * {@link java.net.HttpURLConnection}を取得します。 返されるコネクションには、既に適切な HTTP Cookie
	 * ヘッダがセットされています。 <br>
	 * もし <var>method </var> に {@link #POST}を指定した場合は、返却される HttpURLConnection
	 * をさらに {@link #getURLEncodingStream}もしくは {@link #getMultipartStream}
	 * に渡して、PostStream を取得します。
	 * 
	 * @param method
	 *            リクエストのメソッド。 {@link #POST}あるいは {@link #GET}を指定します。
	 * @return 通信先への HttpURLConnection。
	 * @throws IOException
	 *             通信エラーが発生した。
	 * @see #getURLEncodingStream
	 * @see #getMultipartStream
	 */
	protected HttpURLConnection getConnection(int method) throws IOException {
		String str = uri.toString();
		if (this.pageInfo != null) {
			str = this.pageInfo.toString();
		}
		else {
			str = this.uri.toString();
		}
		URI u = URI.create(str);
		url = u.toURL();

		URLConnection c = url.openConnection();
		// URL is assured to have HTTP scheme.
		HttpURLConnection hc = (HttpURLConnection) c;

		hc.setUseCaches(false);								// URLConnectionのuseCachesフィールドを、指定された値に設定します。
		hc.setDoInput(true);								// URLConnectionのdoInputフィールド値を指定した値に設定します。
		//hc.setFollowRedirects(false);
		hc.setInstanceFollowRedirects(false);

		// prepare cookies
		String cookie = cookies.getCookie(uri);
		hc.setRequestProperty("Cookie", cookie);

		if (method == POST) {
			hc.setDoOutput(true);							// URLConnectionのdoOutputフィールドの値を、指定された値に設定します。
			hc.setRequestMethod("POST");					// リクエストメソッドをPOSTに設定する
		} else if (method == GET) {
			hc.setRequestMethod("GET");						// リクエストメソッドをGETに設定する
			hc.connect();									// URL が参照するリソースへの通信リンクを確立します
		} else {
			throw new IllegalArgumentException("method is not valid: " + method);
		}
		return hc;
	}

	/**
	 * URLエンコーディングを行う {@link PostStream}を作成します。
	 * 
	 * @param hc
	 *            {@link #getConnection}に POST を渡して取得した HttpURLConnection
	 * @return PostStreamオブジェクト
	 * @throws IOException
	 *             通信エラーが発生した。
	 * @see PostStream
	 */
	protected PostStream getURLEncodingStream(HttpURLConnection hc)
			throws IOException {
		hc.setRequestProperty("Content-Type",
				"application/x-www-form-urlencoded");
		hc.connect();
		return new PostStream(hc.getOutputStream());
	}

	/**
	 * マルチパートの POST リクエストを行う {@link PostStream}を作成します
	 * 
	 * @param hc
	 *            {@link #getConnection}に POST を渡して取得した。
	 * @return PostStreamオブジェクト
	 * @throws IOException
	 *             通信エラーが発生した。
	 * @see PostStream
	 */
	protected PostStream getMultipartStream(HttpURLConnection hc)
			throws IOException {
		String boundary = "---------------------------7d51af2b10340";
		hc.setRequestProperty("Content-Type", "multipart/form-data; boundary="
				+ boundary);
		hc.connect();
		return new PostStream(hc.getOutputStream(), boundary);
	}

	/**
	 * HTTP サーバーとの通信結果で、返されたヘッダを処理します。 <br>
	 * このメソッドでは "Set-Cookie" ヘッダを処理し、Cookie のレポジトリに追加します。 <br>
	 * さらなる処理が必要な場合は、このメソッドをサブクラスでオーバーライドします。
	 * 
	 * @param hc
	 *            {@link #getConnection}で取得した HttpURLConnection
	 * @throws IOException
	 *             通信エラーが発生した
	 */
	protected void processHeader(HttpURLConnection hc) throws IOException {
		// <var>i</var> must starts from 0 since the HTTP response
		// header (that has no name!) is at the index 0.
		for (int i = 1; true; i++) {
			String key = hc.getHeaderFieldKey(i);
			if (key == null)
				break;
			if (!(key.equals("Set-Cookie")))
				continue;

			if (key.equals("Set-Cookie")) {
				String value = hc.getHeaderField(i);
				cookies.setCookie(value, uri);
			}
		}
	}

	/**
	 * HTTP サーバーとの通信結果で、返されたヘッダを処理します。 <br>
	 * このメソッドでは "Set-Cookie" ヘッダを処理し、Cookie のレポジトリに追加します。 <br>
	 * さらなる処理が必要な場合は、このメソッドをサブクラスでオーバーライドします。
	 * 
	 * @param hc
	 *            {@link #getConnection}で取得した HttpURLConnection
	 * @return
	 * @throws IOException
	 *             通信エラーが発生した
	 */
	protected String processHeader2(HttpURLConnection hc) throws IOException {
		// <var>i</var> must starts from 0 since the HTTP response
		// header (that has no name!) is at the index 0.
		String s = null;
		for (int i = 1; true; i++) {
			String key = hc.getHeaderFieldKey(i);
			if (key == null)
				break;
			if (!(key.equals("Location")))
				continue;

			if (key.equals("Location")) {
				s = hc.getHeaderField(i);
			}
		}
		return s;
	}

	/**
	 * セッション Cookie を破棄します。
	 */
	public static void logout() {
		cookies.clean();
	}
}
