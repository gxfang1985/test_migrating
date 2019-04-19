/* HttpClient.java */
package jp.co.cybozu.http;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;

/**
 * HTTP �T�[�o�[�ƒʐM����A�ŏ����̋@�\��񋟂��� HTTP �N���C�A���g���������܂��B <br>
 * ���̃N���X�� static �� Cookie �̃��|�W�g����ێ����Ă��܂��B <br>
 * ���̂��߁A���̃N���X�̃C���X�^���X���邢�̓T�u�N���X�̃C���X�^���X�ɂ܂����� Cookie �̃��|�W�g�����Ǘ��ł��܂��B <br>
 * ���̃N���X�͌p�����ċ@�\���g�����Ȃ���΁A���ɗ����܂���B <br>
 * �������邢�͐V�K�ɍ쐬�����T�u�N���X�ŁA�p���������\�b�h���g�p���ċ@�\���g�����܂��B
 * 
 * @author �T�C�{�E�Y
 * @version 1.0.0
 * @see Cookies
 */
public class HttpClient {
	private URI uri;

	private URI pageInfo;

	private URL url;

	private static final Cookies cookies = new Cookies();

	/**
	 * <var>uri </var>�Ŏw�肳�ꂽ�ꏊ�ƒʐM���� HTTP �N���C�A���g���쐬���܂��B <br>
	 * URI �̃X�L�[���� "http" �������� "https" �ł���K�v������܂��B
	 * 
	 * @param uri HTTP �T�[�o�[��� URI�B
	 * @throws IOException �ʐM�G���[�����������B
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
	 * <var>pageInfo </var>�Ŏw�肳�ꂽ�ꏊ�ɕύX���܂��B
	 * 
	 * @param pageInfo �ύX����HTTP �T�[�o�[��� URI
	 * @throws IOException
	 */
	public void setPageInfo(URI pageInfo) throws IOException {
		this.pageInfo = pageInfo;
	}

	/**
	 * getConnection �ɓn���ׂ��p�����[�^�B POST ���N�G�X�g���s���ꍇ�Ɏw�肷��B
	 */
	public static final int POST = 1;

	/**
	 * getConnection �ɓn���ׂ��p�����[�^�B GET ���N�G�X�g���s���ꍇ�Ɏw�肷��B
	 */
	public static final int GET = 0;

	/**
	 * �R���X�g���N�^�Ŏw�肵�� <var>URI </var> �Ɍ����ĒʐM���s���A
	 * {@link java.net.HttpURLConnection}���擾���܂��B �Ԃ����R�l�N�V�����ɂ́A���ɓK�؂� HTTP Cookie
	 * �w�b�_���Z�b�g����Ă��܂��B <br>
	 * ���� <var>method </var> �� {@link #POST}���w�肵���ꍇ�́A�ԋp����� HttpURLConnection
	 * ������� {@link #getURLEncodingStream}�������� {@link #getMultipartStream}
	 * �ɓn���āAPostStream ���擾���܂��B
	 * 
	 * @param method
	 *            ���N�G�X�g�̃��\�b�h�B {@link #POST}���邢�� {@link #GET}���w�肵�܂��B
	 * @return �ʐM��ւ� HttpURLConnection�B
	 * @throws IOException
	 *             �ʐM�G���[�����������B
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

		hc.setUseCaches(false);								// URLConnection��useCaches�t�B�[���h���A�w�肳�ꂽ�l�ɐݒ肵�܂��B
		hc.setDoInput(true);								// URLConnection��doInput�t�B�[���h�l���w�肵���l�ɐݒ肵�܂��B
		//hc.setFollowRedirects(false);
		hc.setInstanceFollowRedirects(false);

		// prepare cookies
		String cookie = cookies.getCookie(uri);
		hc.setRequestProperty("Cookie", cookie);

		if (method == POST) {
			hc.setDoOutput(true);							// URLConnection��doOutput�t�B�[���h�̒l���A�w�肳�ꂽ�l�ɐݒ肵�܂��B
			hc.setRequestMethod("POST");					// ���N�G�X�g���\�b�h��POST�ɐݒ肷��
		} else if (method == GET) {
			hc.setRequestMethod("GET");						// ���N�G�X�g���\�b�h��GET�ɐݒ肷��
			hc.connect();									// URL ���Q�Ƃ��郊�\�[�X�ւ̒ʐM�����N���m�����܂�
		} else {
			throw new IllegalArgumentException("method is not valid: " + method);
		}
		return hc;
	}

	/**
	 * URL�G���R�[�f�B���O���s�� {@link PostStream}���쐬���܂��B
	 * 
	 * @param hc
	 *            {@link #getConnection}�� POST ��n���Ď擾���� HttpURLConnection
	 * @return PostStream�I�u�W�F�N�g
	 * @throws IOException
	 *             �ʐM�G���[�����������B
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
	 * �}���`�p�[�g�� POST ���N�G�X�g���s�� {@link PostStream}���쐬���܂�
	 * 
	 * @param hc
	 *            {@link #getConnection}�� POST ��n���Ď擾�����B
	 * @return PostStream�I�u�W�F�N�g
	 * @throws IOException
	 *             �ʐM�G���[�����������B
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
	 * HTTP �T�[�o�[�Ƃ̒ʐM���ʂŁA�Ԃ��ꂽ�w�b�_���������܂��B <br>
	 * ���̃��\�b�h�ł� "Set-Cookie" �w�b�_���������ACookie �̃��|�W�g���ɒǉ����܂��B <br>
	 * ����Ȃ鏈�����K�v�ȏꍇ�́A���̃��\�b�h���T�u�N���X�ŃI�[�o�[���C�h���܂��B
	 * 
	 * @param hc
	 *            {@link #getConnection}�Ŏ擾���� HttpURLConnection
	 * @throws IOException
	 *             �ʐM�G���[����������
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
	 * HTTP �T�[�o�[�Ƃ̒ʐM���ʂŁA�Ԃ��ꂽ�w�b�_���������܂��B <br>
	 * ���̃��\�b�h�ł� "Set-Cookie" �w�b�_���������ACookie �̃��|�W�g���ɒǉ����܂��B <br>
	 * ����Ȃ鏈�����K�v�ȏꍇ�́A���̃��\�b�h���T�u�N���X�ŃI�[�o�[���C�h���܂��B
	 * 
	 * @param hc
	 *            {@link #getConnection}�Ŏ擾���� HttpURLConnection
	 * @return
	 * @throws IOException
	 *             �ʐM�G���[����������
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
	 * �Z�b�V���� Cookie ��j�����܂��B
	 */
	public static void logout() {
		cookies.clean();
	}
}
