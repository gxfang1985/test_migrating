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
 * �K���[���Q�Ƃ̊e�A�v���P�[�V�����A�g�ɋ��ʂ���@�\���������܂��B<BR>
 * 
 * @author �T�C�{�E�Y
 * @version 1.1.0
 * @see HttpClient
 * @see PostStream
 * @see RemoteException
 */
public class CoopLink extends HttpClient implements GrnConnector {

	/**
	 * �A�v���P�[�V�����A�g�̃o�[�W����
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
	 * �w�肳�ꂽ<var>uri</var>�y�сA���O�C���ɕK�v�� <var>userName</var>,<var>password</var>���g�p����
	 * �K���[���Q�ւ̏������ƃZ�b�V�������J�n���܂��B
	 * 
	 * @param uri
	 *            �K���[���Q�̎��s�ɕK�v��URI (Uniform Resource Identifier) ������
	 * @param userName
	 *            �K���[���Q�փ��O�C�����邽�߂̃��O�C����
	 * @param password
	 *            �K���[���Q�փ��O�C�����邽�߂ɕK�v�ȃp�X���[�h������
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q��ŃG���[�����������ꍇ
	 */
	public CoopLink(String uri, String userName, String password)
			throws IOException, RemoteException {
		this(uri == null ? null : URI.create(uri), userName, password);

	}

	/**
	 * �w�肳�ꂽ<var>uri</var>���g�p���� �K���[���Q�ւ̏������ƃZ�b�V�������J�n���܂��B
	 * 
	 * @param uri
	 *            �K���[���Q�̎��s�ɕK�v��URI (Uniform Resource Identifier) ������
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q��ŃG���[�����������ꍇ
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
	 * �w�肳�ꂽ<var>coopURI</var>�A���O�C���p <var>userName</var>,<var>password</var>���g�p����
	 * �K���[���Q�ւ̏������ƃZ�b�V�������J�n���܂��B
	 * 
	 * @param uri
	 *            �K���[���Q�̎��s�ɕK�v��URI (Uniform Resource Identifier) ������
	 * @param userName
	 *            �K���[���Q�փ��O�C�����邽�߂̃��O�C����
	 * @param password
	 *            �K���[���Q�փ��O�C�����邽�߂ɕK�v�ȃp�X���[�h������
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q��ŃG���[�����������ꍇ
	 */
	private CoopLink(URI uri, String userName, String password)
			throws IOException, RemoteException {
		super(uri == null ? null : uri);
		grnURL = getAddress(uri);
		// start the session
		login(userName, password);

	}

	/**
	 * �K���[���Q�A�g�p�v���O��������o�͂��ꂽ���ʂ��������܂��B <br />
	 * ���N�G�X�g���ʂ�HTML��&lt;body&gt;��������͂��܂��B<br />
	 * �����[�g�G���h�ɖ�肪�������ꍇ�́A {@link RemoteException}�𓊂��܂��B
	 * 
	 * @param hc
	 *            {@link #getConnection}����Ԃ�HttpURLConnection.
	 * @param context
	 *            ���̃��\�b�h���Ă΂ꂽ�w�i�ɂ��Ă̕������w�肵�܂��B �����[�g�G���h�ŉ��炩�̃G���[���N�������ꍇ�ɁA
	 *            {@link RemoteException}�̃G���[���b�Z�[�W�̈ꕔ�ɂȂ�܂��B
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
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
	 * �K���[���Q�A�g�p�v���O��������o�͂��ꂽ���ʂ��������܂��B <br />
	 * 
	 * @param hc
	 *            {@link #getConnection}����Ԃ�HttpURLConnection.
	 * @param context
	 *            ���̃��\�b�h���Ă΂ꂽ�w�i�ɂ��Ă̕������w�肵�܂��B �����[�g�G���h�ŉ��炩�̃G���[���N�������ꍇ�ɁA
	 *            {@link RemoteException}�̃G���[���b�Z�[�W�̈ꕔ�ɂȂ�܂��B
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
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
	 * �K���[���Q�Ƀ��O�C�����A�Z�b�V�������J�n���܂��B ���̃��\�b�h�́A�C���X�^���X��({@link #CoopLink(String,String,String)})�Ɏ����ŏ�������܂��B
	 * 
	 * @param userName
	 *            �K���[���Q�փ��O�C�����邽�߂̃��O�C����
	 * @param password
	 *            �K���[���Q�փ��O�C�����邽�߂ɕK�v�ȃp�X���[�h������
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q��ŃG���[�����������ꍇ
	 */
	public void login(String userName, String password) throws IOException,
			RemoteException {
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopLogin").toString();

		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);

		PostStream ps = getURLEncodingStream(hc);
		if (userName != null)
			ps.addProperty("_account", userName); // �A�J�E���g
		else
			ps.addProperty("_account", ""); // �A�J�E���g

		if (password != null)
			ps.addProperty("_password", password); // �p�X���[�h
		else
			ps.addProperty("_password", ""); // �p�X���[�h

		ps.addProperty("version", CoopLinkVersion); // �o�[�W����
		ps.close();

		// 2008/01/15 csrf �Ή�
		// processResult(hc, "login failed.");
		String csrf = processResult(hc, "login failed.");
		this.csrfTicket = csrf;

		// 2007/05/09 �d�l�ύX ���O�C�������t�B�[���h�ɃZ�b�g
		setLoginInfo(userName, password);

	}

	// 2007/05/09 �d�l�ύX ���O�C�������t�B�[���h�ɃZ�b�g
	private void setLoginInfo(String userName, String password) {
		// �ݒ肳��Ă��Ȃ� or �t�B�[���h�l�Ɛݒ肵�����l�����قȂ�ꍇ�̂݃t�B�[���h�l�ɃZ�b�g
		if (loginUser == null || loginPassword == null
				|| !loginUser.equals(userName)
				|| !loginPassword.equals(password)) {
			loginUser = userName;
			loginPassword = password;
		}

	}

	/**
	 * �f���̓o�^�������s���܂��B<BR/>
	 * 
	 * @param title
	 *            �W��
	 * @param categoryCode
	 *            �K���[���Q�̌f���J�e�S���R�[�h
	 * @param startDate
	 *            �f���J�n��.null�w��\(�f���J�n�����w�肵�܂���)
	 * @param endDate
	 *            �f���I����.null�w��\(�f���I�������w�肵�܂���)
	 * @param data
	 *            �{��.null�w��\(�{������͂��܂���)
	 * @param attachedFiles
	 *            �Y�t�t�@�C���ƂȂ�t�@�C���p�X�̏W��. null�w��\(�Y�t�t�@�C����o�^���܂���)<BR/>
	 *            �v�f�́AString�^�܂���toString()�Ńt�@�C���p�X���擾�ł���Object�łȂ���΂����܂���<BR>
	 *            �v�f����null������ꍇ�́ANullPointerException���������܂�
	 * @param canFollow
	 *            �t�H���[�������t���O (true:������,false:�����s����)
	 * @param registrant
	 *            �o�^�҂̃��O�C����.null�w��\(�o�^�҂̓��O�C�����[�U�ƂȂ�܂�)
	 * @return �o�^���ꂽ�K���[���Q�̌f����ID
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	public String putBulletinAdd(String title, String categoryCode,
			Calendar startDate, Calendar endDate, String data,
			Collection attachedFiles, boolean canFollow, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		/**
		 * �f���o�^�pcsp�̌Ăяo����i�[�ϐ�
		 */

		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopBulletin_add").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "bulletin"); // Application
		if (title != null)
			ps.addProperty("title", title); // �W��
		else
			ps.addProperty("title", ""); // �W��

		if (categoryCode != null)
			ps.addProperty("c_code", categoryCode); // �J�e�S���R�[�h
		else
			ps.addProperty("c_code", ""); // �J�e�S���R�[�h

		ps.addProperty("editor", "0"); // �����ҏW���w�肵�Ȃ�
		ps.addProperty("send", ""); // �f������R�}���h
		if (canFollow)
			ps.addProperty("can_follow", "1"); // �t�H���[��������

		if (startDate == null && endDate == null)
			ps.addProperty("enable_term", "0"); // �f�����ԗL��
		else
			ps.addProperty("enable_term", "1"); // �f�����ԗL��

		if (registrant != null)
			ps.addProperty("registrant", registrant); // ���o�l
		else
			ps.addProperty("registrant", ""); // ���o�l

		if (data != null)
			ps.addProperty("data", data); // �f���{��
		else
			ps.addProperty("data", ""); // �f���{��

		if (startDate != null) {
			ps.addProperty("sterm_year", startDate.get(Calendar.YEAR)); // �f�����ԊJ�n�N
			ps.addProperty("sterm_month", startDate.get(Calendar.MONTH) + 1); // �f�����ԊJ�n��
			ps.addProperty("sterm_day", startDate.get(Calendar.DAY_OF_MONTH)); // �f�����ԊJ�n��
		} else {
			ps.addProperty("sterm_year", ""); // �f�����ԊJ�n�N
			ps.addProperty("sterm_month", ""); // �f�����ԊJ�n��
			ps.addProperty("sterm_day", ""); // �f�����ԊJ�n��
		}

		if (endDate != null) {
			ps.addProperty("eterm_year", endDate.get(Calendar.YEAR)); // �f�����ԏI���N
			ps.addProperty("eterm_month", endDate.get(Calendar.MONTH) + 1); // �f�����ԏI����
			ps.addProperty("eterm_day", endDate.get(Calendar.DAY_OF_MONTH)); // �f�����ԏI����
		} else {
			ps.addProperty("eterm_year", ""); // �f�����ԏI���N
			ps.addProperty("eterm_month", ""); // �f�����ԏI����
			ps.addProperty("eterm_day", ""); // �f�����ԏI����
		}

		if (attachedFiles != null) { // �Y�t�t�@�C��
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
	 * �f���̍폜�������s���܂��B<BR/>
	 * 
	 * @param articleId
	 *            �K���[���Q�̌f����ID
	 * @param registrant
	 *            �폜�҂̃��O�C����.null�w��\(�폜�҂̓��O�C�����[�U�ƂȂ�܂�)
	 * @return �폜���ꂽ�K���[���Q��̌f����ID
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	public String putBulletinDelete(long articleId, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		/**
		 * �f���폜�pcsp�̌Ăяo����i�[�ϐ�
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopBulletin_delete").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getURLEncodingStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);
		ps.addProperty("app", "bulletin"); // Application
		ps.addProperty("aid", String.valueOf(articleId)); // �f��ID

		if (registrant != null)
			ps.addProperty("registrant", registrant); // �X�V��
		else
			ps.addProperty("registrant", ""); // �X�V��

		ps.close();
		return processResult(hc,
				"failed in the deletion of the article on the bulletin board."); // �߂�l(�L��ID)
	}

	/**
	 * �f���t�H���[�̓o�^�������s���܂��B<BR/>
	 * 
	 * @param articleId
	 *            �K���[���Q�̌f����ID
	 * @param data
	 *            �{��.null���w��\(�{������͂��܂���)
	 * @param attachedFiles
	 *            �Y�t�t�@�C���ƂȂ�t�@�C���p�X�̏W��. null�w��\(�Y�t�t�@�C����o�^���܂���)<BR/>
	 *            �v�f�́AString�^�܂���toString()�Ńt�@�C���p�X���擾�ł���Object�łȂ���΂����܂���<BR>
	 *            �v�f����null������ꍇ�́ANullPointerException���������܂�
	 * @param registrant
	 *            �o�^�҂̃��O�C����.null�w��\(�o�^�҂̓��O�C�����[�U�ƂȂ�܂�)
	 * @return �o�^���ꂽ�K���[���Q�̌f���t�H���[ID
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	public String putBulletinFollowAdd(long articleId, String data,
			Collection attachedFiles, String registrant) throws IOException,
			RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		/**
		 * �f���t�H���[�o�^�pcsp�̌Ăяo����i�[�ϐ�
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopBulletin_follow_add").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "bulletin"); // Application
		ps.addProperty("aid", String.valueOf(articleId)); // �f����ID
		ps.addProperty("editor", "0"); // �����ҏW���w�肵�Ȃ�
		ps.addProperty("send", ""); // �f������R�}���h

		if (registrant != null)
			ps.addProperty("registrant", registrant); // �o�^��
		else
			ps.addProperty("registrant", ""); // �o�^��

		if (data != null)
			ps.addProperty("data", data); // �f���{��
		else
			ps.addProperty("data", ""); // �f���{��

		if (attachedFiles != null) { // �Y�t�t�@�C��
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
	 * �f���t�H���[�̍폜�������s���܂��B<BR/>
	 * 
	 * @param followId
	 *            �K���[���Q�̌f���t�H���[ID
	 * @param registrant
	 *            �폜�҂̃��O�C����.null�w��\(�폜�҂̓��O�C�����[�U�ƂȂ�܂�)
	 * @return �폜���ꂽ�K���[���Q�̌f���t�H���[ID
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	public String putBulletinFollowDelete(long followId, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		/**
		 * �f���t�H���[�폜�pcsp�̌Ăяo����i�[�ϐ�
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopBulletin_follow_delete").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getURLEncodingStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "bulletin"); // Application
		ps.addProperty("follow_id", String.valueOf(followId)); // �L���t�H���[ID

		if (registrant != null)
			ps.addProperty("registrant", registrant); // �X�V��(�폜���s��)
		else
			ps.addProperty("registrant", ""); // �X�V��(�폜���s��)

		ps.close();
		return processResult(hc,
				"failed in the deletion of the article Follow."); // �߂�l(�L���t�H���[ID)
	}

	/**
	 * �f���̍X�V�������s���܂��B<BR/> �S�Ă̍��ڂ́A�����Ŏw�肳�ꂽ���ڒl�ɒu�������܂��B<BR/>
	 * 
	 * @param articleId
	 *            �K���[���Q�̌f����ID
	 * @param title
	 *            �W��
	 * @param startDate
	 *            �f���J�n��.null�w��\(�f���J�n�����w�肵�܂���)
	 * @param endDate
	 *            �f���I����.null�w��\(�f���J�n�����w�肵�܂���)
	 * @param data
	 *            �{�� .null�w��\(�{������͂��܂���)
	 * @param attachedFiles
	 *            �Y�t�t�@�C���ƂȂ�t�@�C���p�X�̏W��. null�w��\(�Y�t�t�@�C����o�^���܂���)<BR/>
	 *            �v�f�́AString�^�܂���toString()�Ńt�@�C���p�X���擾�ł���Object�łȂ���΂����܂���<BR>
	 *            �v�f����null������ꍇ�́ANullPointerException���������܂�
	 * @param canFollow
	 *            �t�H���[�����݋��t���O (false:�����s����,true:������)
	 * @param registrant
	 *            �X�V�҂̃��O�C����.null�w��\(�X�V�҂̓��O�C�����[�U�ƂȂ�܂�)
	 * @return �X�V���ꂽ�K���[���Q�̌f����ID
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */

	public String putBulletinModify(long articleId, String title,
			Calendar startDate, Calendar endDate, String data,
			Collection attachedFiles, boolean canFollow, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		/**
		 * �f���X�V�pcsp�̌Ăяo����i�[�ϐ�
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopBulletin_modify").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "bulletin"); // Application

		ps.addProperty("aid", String.valueOf(articleId)); // �f����ID

		if (title != null)
			ps.addProperty("title", title); // �W��
		else
			ps.addProperty("title", ""); // �W��

		ps.addProperty("editor", "0"); // �����ҏW���w�肵�Ȃ�

		ps.addProperty("send", ""); // �f������R�}���h

		if (canFollow)
			ps.addProperty("can_follow", "1"); // �t�H���[��������

		if (startDate == null && endDate == null)
			ps.addProperty("enable_term", "0"); // �f�����ԗL��
		else
			ps.addProperty("enable_term", "1"); // �f�����ԗL��

		if (registrant != null)
			ps.addProperty("registrant", registrant); // ���o�l
		else
			ps.addProperty("registrant", ""); // ���o�l

		if (data != null)
			ps.addProperty("data", data); // �f���{��
		else
			ps.addProperty("data", ""); // �f���{��

		if (startDate != null) {
			ps.addProperty("sterm_year", startDate.get(Calendar.YEAR)); // �f�����ԊJ�n�N
			ps.addProperty("sterm_month", startDate.get(Calendar.MONTH) + 1); // �f�����ԊJ�n��
			ps.addProperty("sterm_day", startDate.get(Calendar.DAY_OF_MONTH)); // �f�����ԊJ�n��
		} else {
			ps.addProperty("sterm_year", ""); // �f�����ԊJ�n�N
			ps.addProperty("sterm_month", ""); // �f�����ԊJ�n��
			ps.addProperty("sterm_day", ""); // �f�����ԊJ�n��
		}

		if (endDate != null) {
			ps.addProperty("eterm_year", endDate.get(Calendar.YEAR)); // �f�����ԏI���N
			ps.addProperty("eterm_month", endDate.get(Calendar.MONTH) + 1); // �f�����ԏI����
			ps.addProperty("eterm_day", endDate.get(Calendar.DAY_OF_MONTH)); // �f�����ԏI����
		} else {
			ps.addProperty("eterm_year", ""); // �f�����ԏI���N
			ps.addProperty("eterm_month", ""); // �f�����ԏI����
			ps.addProperty("eterm_day", ""); // �f�����ԏI����
		}

		if (attachedFiles != null) { // �Y�t�t�@�C��
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
	 * �t�@�C���Ǘ��̓o�^�������s���܂��B<BR>
	 * 
	 * @param title
	 *            �^�C�g��.null�w��\(�^�C�g������͂��܂���)
	 * @param foldercode
	 *            �K���[���Q�̃t�H���_�R�[�h
	 * @param version
	 *            �o�[�W�����Ǘ� <BR>
	 *            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 *            [�l = -1]
	 *            �̏ꍇ�C�������ŊǗ����܂��B(�V�X�e���Ǘ�-�o�[�W�����Ǘ��̏���l���ݒ肳��Ă���ꍇ�C�o�[�W�����Ǘ��̏���l��ݒ�)<BR>
	 *            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 *            [�l = 0] �̏ꍇ�C�o�[�W�����Ǘ������܂���B<BR>
	 *            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 *            [0 �� �l �� 10] �̏ꍇ�C�e�l��ݒ肵�܂��B([�l ��
	 *            �V�X�e���Ǘ�-�o�[�W�����Ǘ��̏���l]�̏ꍇ�C�o�[�W�����Ǘ��̏���l��ݒ�)<BR>
	 *            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 * @param memo
	 *            �t�@�C���̐���.null�w��\(��������͂��܂���)
	 * @param registrant
	 *            �o�^�҂̃��O�C����.null�w��\(�o�^�҂̓��O�C�����[�U�ƂȂ�܂�)
	 * @param file
	 *            �ǉ�����t�@�C��
	 * @return �o�^���ꂽ�K���[���Q�̃t�@�C��ID
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 * @throws NullPointerException
	 *             �K�{���ڂ̃p�����[�^��NULL�̏ꍇ
	 * @throws IllegalArgumentException
	 *             �s���Ȉ����A�܂��͕s�K�؂Ȉ��������\�b�h�ɓn�����ꍇ
	 */
	// javadoc 2007/03/22 �t�@�C���Ǘ��A�^�C�g����NULL�w��\�ɂȂ��Ă��Ȃ� �s��Ǘ�(173)
	// (�^�C�g������͂��܂���) ��ǋL
	// javadoc 2007/03/28 version�̏ڍ׋L�q�����݂��Ȃ� (�s��Ǘ�203)
	// version�����̋L�q�C��
	// 2007/03/22 putCabinet_add�̈��������C�� �s��Ǘ�(186)
	// folder �� foldercode
	public String putCabinetAdd(String title, String foldercode, long version,
			String memo, String registrant, File file) throws IOException,
			RemoteException, NullPointerException, IllegalArgumentException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		/**
		 * �t�@�C���Ǘ��t�@�C���ǉ��pcsp�̌Ăяo����i�[�ϐ�
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopCabinet_add").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "cabinet");
		if (title != null) // �^�C�g��
			ps.addProperty("title", title);
		else
			ps.addProperty("title", "");
		// 2007/03/22 putCabinet_add�̈��������C�� �s��Ǘ�(186)
		// folder �� foldercode
		if (foldercode != null) // �t�H���_�R�[�h
			ps.addProperty("folder", foldercode);
		else
			ps.addProperty("folder", "");
		ps.addProperty("max_version", String.valueOf(version)); // �o�[�W�����Ǘ�
		if (memo != null) // �t�@�C���̐���
			ps.addProperty("memo", memo);
		else
			ps.addProperty("memo", "");
		if (registrant != null) // �o�^��
			ps.addProperty("registrant", registrant);
		else
			ps.addProperty("registrant", "");
		ps.addFile(file, "file", "application/octet-stream"); // �ǉ�����t�@�C��

		ps.close();
		return processResult(hc, "failed to register a cabinet.");
	}

	/**
	 * �t�@�C���Ǘ��̃t�@�C���X�V�������s���܂��B<BR>
	 * 
	 * @param fileId
	 *            �K���[���Q�̃t�@�C��ID
	 * @param comment
	 *            �X�V�R�����g.null�w��\(�X�V�R�����g����͂��܂���j
	 * @param newFile
	 *            �A�b�v���[�h����t�@�C��
	 * @param registrant
	 *            �X�V�҂̃��O�C����.null�w��\(�X�V�҂̓��O�C�����[�U�ƂȂ�܂�)
	 * 
	 * @return �t�@�C���X�V���ꂽ�K���[���Q�̃t�@�C��ID
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	public String putCabinetUpload(long fileId, String comment, File newFile,
			String registrant) throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		/**
		 * �t�@�C���Ǘ��t�@�C��Upload�pcsp�̌Ăяo����i�[�ϐ�
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopCabinet_upload").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "cabinet");

		ps.addProperty("fid", Long.toString(fileId)); // �t�@�C��ID

		if (comment != null) // �R�����g
			ps.addProperty("comment", comment);

		if (registrant != null) // �X�V��
			ps.addProperty("registrant", registrant);

		if (newFile != null) // �t�@�C��
			ps.addFile(newFile, "newfile", "application/octet-stream");

		ps.close();
		return processResult(hc, " failed to upload of file.");
	}

	/**
	 * �t�@�C���Ǘ��̃t�@�C�����ύX�������s���܂��B<BR>
	 * 
	 * @param fileId
	 *            �K���[���Q�̃t�@�C��ID
	 * @param title
	 *            �^�C�g��.null�w��\(�^�C�g������͂��܂���j
	 * @param version
	 *            �o�[�W�����Ǘ� <BR>
	 *            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 *            [�l = -1]
	 *            �̏ꍇ�C�������ŊǗ����܂��B(�V�X�e���Ǘ�-�o�[�W�����Ǘ��̏���l���ݒ肳��Ă���ꍇ�C�o�[�W�����Ǘ��̏���l��ݒ�)<BR>
	 *            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 *            [�l = 0] �̏ꍇ�C�o�[�W�����Ǘ������܂���B<BR>
	 *            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 *            [0 �� �l �� 10] �̏ꍇ�C�e�l��ݒ肵�܂��B([�l ��
	 *            �V�X�e���Ǘ�-�o�[�W�����Ǘ��̏���l]�̏ꍇ�C�o�[�W�����Ǘ��̏���l��ݒ�)<BR>
	 *            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 * @param memo
	 *            �t�@�C���̐���.null�w��\(��������͂��܂���)
	 * @param registrant
	 *            ���ύX�̃��O�C����.null�w��\(���ύX�҂̓��O�C�����[�U�ƂȂ�܂�)
	 * 
	 * @return ���ύX���ꂽ�K���[���Q�̃t�@�C��ID
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	public String putCabinetModify(long fileId, String title, long version,
			String memo, String registrant) throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		/**
		 * �t�@�C���Ǘ��t�@�C�����ύX�pcsp�̌Ăяo����i�[�ϐ�
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopCabinet_modify").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = super.getURLEncodingStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "cabinet");

		ps.addProperty("fid", Long.toString(fileId)); // �t�@�C��ID
		ps.addProperty("ver", Long.toString(version)); // �o�[�W����

		if (title != null) // �^�C�g��
			ps.addProperty("title", title);

		if (memo != null) // ����
			ps.addProperty("memo", memo);

		if (registrant != null) // ���ύX��
			ps.addProperty("registrant", registrant);

		ps.close();
		return processResult(hc, " failed to modify of file information.");
	}

	/**
	 * �t�@�C���Ǘ��̍폜�������s���܂��B<BR>
	 * 
	 * @param fileId
	 *            �K���[���Q�̃t�@�C��ID
	 * @param registrant
	 *            �폜�҂̃��O�C����.null�w��\(�폜�҂̓��O�C�����[�U�ƂȂ�܂�)
	 * 
	 * @return �폜���ꂽ�K���[���Q��̃t�@�C��ID
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	public String putCabinetDelete(long fileId, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		/**
		 * �t�@�C���Ǘ��t�@�C���폜�pcsp�̌Ăяo����i�[�ϐ�
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopCabinet_delete").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = super.getURLEncodingStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "cabinet");

		ps.addProperty("fid", Long.toString(fileId)); // �t�@�C��ID

		if (registrant != null) // �폜��
			ps.addProperty("registrant", registrant);

		ps.close();
		return processResult(hc, " failed to delete of file.");
	}

	/**
	 * ���� [fileId]�̂����A�o�[�W����No������ [version] �̃t�@�C�����K���[���Q �t�@�C���Ǘ����_�E�����[�h���A<BR>
	 * ���� [directoryPath]�̃f�B���N�g�� �ɁA���� [fileName] �̃t�@�C�����ŕۑ����܂��B
	 * 
	 * @param fileId
	 *            �K���[���Q�̃t�@�C��ID
	 * @param directoryPath
	 *            �t�@�C����ۑ�����f�B���N�g���p�X.null�w��\(�J�����g�f�B���N�g���ɕۑ����܂��B�j
	 * @param fileName
	 *            �t�@�C����ۑ�����t�@�C����.null�w��\(�K���[���Q�ɓo�^����Ă���t�@�C�����ŕۑ����܂��B
	 * @param ver
	 *            �擾����o�[�W����No.null�w��\(�ŐV�o�[�W�����̃t�@�C�����擾���܂��j
	 * @param registrant
	 *            �_�E�����[�h���s�����[�U�[�̃��O�C����.null�w��\(�_�E�����[�h���s�����[�U�[�̓��O�C�����[�U�ƂȂ�܂�)
	 * 
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	public void putCabinetDownload(long fileId, String directoryPath,
			String fileName, Long ver, String registrant) throws IOException,
			RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		/**
		 * �t�@�C���Ǘ��t�@�C��DL�pcsp�̌Ăяo����i�[�ϐ�
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopCabinet_download").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = super.getURLEncodingStream(hc);

		if (fileName == null) {
			// 2008/01/15 csrf �Ή�
			if (this.csrfTicket != null)
				ps.addProperty("csrf_ticket", this.csrfTicket);
			ps.addProperty("app", "cabinet");
			ps.addProperty("fid", Long.toString(fileId)); // �t�@�C��ID
			ps.addProperty("title_flag", 1); // �t�@�C���Ǘ��̃t�@�C���̃^�C�g���擾�t���O(�^�C�g���擾
												// 1:����,1�ȊO:���Ȃ�)

			if (ver != null) // �o�[�W����
				ps.addProperty("ver", ver.toString());

			if (registrant != null) // �_�E�����[�h���s�����[�U�[
				ps.addProperty("registrant", registrant);

			ps.close();

			BufferedReader in = processBufferResult(hc,
					"failed to download of file.");
			fileName = in.readLine();
		}

		hc = getConnection(HttpClient.POST);
		ps = super.getURLEncodingStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "cabinet");
		ps.addProperty("fid", Long.toString(fileId)); // �t�@�C��ID

		if (ver != null) // �o�[�W����
			ps.addProperty("ver", ver.toString());

		if (registrant != null) // �_�E�����[�h���s�����[�U�[
			ps.addProperty("registrant", registrant);

		ps.close();

		saveResponseDataToFile(hc, directoryPath, fileName,
				"failed to download of file.");
	}

	/**
	 * ���� [fileId]�̍ŐV�o�[�W�����̃t�@�C�����K���[���Q �t�@�C���Ǘ����_�E�����[�h���A<BR>
	 * ���� [directoryPath]�̃f�B���N�g���ɕۑ����܂��B<BR>
	 * �t�@�C�����́A�t�@�C���Ǘ���ɕۑ�����Ă���t�@�C���̖��O�ɂȂ�܂��B<BR>
	 * 
	 * @param fileId
	 *            �K���[���Q�̃t�@�C��ID
	 * @param directoryPath
	 *            �t�@�C����ۑ�����f�B���N�g���p�X.null�w��\(�J�����g�f�B���N�g���ɕۑ����܂��B�j
	 * @param registrant
	 *            �_�E�����[�h���s�����[�U�[�̃��O�C����.null�w��\(�_�E�����[�h���s�����[�U�[�̓��O�C�����[�U�ƂȂ�܂�)
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	public void putCabinetDownload(long fileId, String directoryPath,
			String registrant) throws IOException, RemoteException {
		this.putCabinetDownload(fileId, directoryPath, null, null, registrant);
	}

	
	
    /**
     * �Г����[���̓o�^�������s���܂��B<BR/>
     *
     * @param title �W��
     * @param data �{��.null�w��\(�{������͂��܂���)
     * @param confirm �{���󋵃t���O(true:�m�F�{�^��������,false:�m�F�{�^�������Ȃ�)
     * @param accounts ����̂����A����̕ύX�A�폜��������Ă��Ȃ����[�U�[�̃��O�C�����̏W��<BR/>
     *              �v�f�́AString�^�܂���toString()�Ń��O�C�������擾�ł���Object�łȂ���΂����܂���<BR>
     *              �v�f����null������ꍇ�́ANullPointerException���������܂�<BR/>
     * @param operators ����̂����A����̕ύX�A�폜�������ꂽ�ȃ��O�C�����̏W��<BR/>
     *                  �v�f�́AString�^�܂���toString()�Ń��O�C�������擾�ł���Object�łȂ���΂����܂���<BR/>
     *                  �v�f����null���L��ꍇ�́ANullPointerException���������܂�
     * @param attachedFiles �Y�t�t�@�C���ƂȂ�t�@�C���p�X�̏W��.
     *                     null�w��\(�Y�t�t�@�C�����w�肵�Ȃ�)<BR/>
     *                     �v�f�́AString�^�܂���toString()�Ńt�@�C���p�X���擾�ł���Object�łȂ���΂����܂���<BR>
     *                     �v�f����null������ꍇ�́ANullPointerException����������
     * @param registrant �o�^�҂̃��O�C����.null�w��\(�o�^�҂̓��O�C�����[�U�ƂȂ�܂�)
     * @return �o�^���ꂽ�K���[���Q�̎Г����[��ID
     * @throws IOException �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
     * @throws RemoteException �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
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
        // 2007/05/09 �d�l�ύX
        this.login(loginUser,loginPassword);
        
        /**
         * �Г����[���o�^�pcsp�̌Ăяo����i�[�ϐ�
         */
        String Page = new StringBuffer().append(grnURL).append("/coop/coopMessage_add").toString();
        super.setPageInfo(URI.create(Page));
        
        
        java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
        PostStream ps = getMultipartStream(hc);
        //2008/01/15 csrf �Ή�
        if(this.csrfTicket!=null)ps.addProperty("csrf_ticket",this.csrfTicket);
        
        ps.addProperty("app","message");                                // Application
        if (title!=null)
                ps.addProperty("title", title);                                // �W��
        else
            ps.addProperty("title", "");                                // �W��
        
        if (data!=null)
                ps.addProperty("data", data);                                // �{��
        else
            ps.addProperty("data", "");                                    // �{��
        
        if (confirm==true)
            ps.addProperty("confirm", "1");                                // �{����
           
        if ( registrant != null )
            ps.addProperty("registrant", registrant);                    // ���o�l
        else
            ps.addProperty("registrant", "");                            // ���o�l
        
        if ( accounts != null ){
               for (Iterator it = accounts.iterator(); it.hasNext(); ) {    
                ps.addProperty("receivers[]", it.next().toString());    // ����ύX���̖�������
            }
        }
        //2010/08/01 ����ύX�̋��ɑΉ� Yoshida Shin
        if ( operators != null ){
        	for ( Iterator it = operators.iterator(); it.hasNext(); ){
        		ps.addProperty("operators[]", it.next().toString());   // ����ύX���̗L�鈶��
        	}
        }
        
        if ( attachedFiles != null ){                                    // �Y�t�t�@�C��
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
     * �Г����[���̓o�^�������s���܂��B<BR/>
     * API 1.3.1 �݊��̂��߂̃��\�b�h�ł��B<BR/>
     *
     * @param title �W��
     * @param data �{��.null�w��\(�{������͂��܂���)
     * @param confirm �{���󋵃t���O(true:�m�F�{�^��������,false:�m�F�{�^�������Ȃ�)
     * @param accounts ����̃��O�C�����̏W��<BR/>
     *              �v�f�́AString�^�܂���toString()�Ń��O�C�������擾�ł���Object�łȂ���΂����܂���<BR>
     *              �v�f����null������ꍇ�́ANullPointerException���������܂�<BR/>
     *              ���̈���̃��[�U�[�́A����ύX���������܂���B
     * @param attachedFiles �Y�t�t�@�C���ƂȂ�t�@�C���p�X�̏W��.
     *                     null�w��\(�Y�t�t�@�C�����w�肵�Ȃ�)<BR/>
     *                     �v�f�́AString�^�܂���toString()�Ńt�@�C���p�X���擾�ł���Object�łȂ���΂����܂���<BR>
     *                     �v�f����null������ꍇ�́ANullPointerException����������
     * @param registrant �o�^�҂̃��O�C����.null�w��\(�o�^�҂̓��O�C�����[�U�ƂȂ�܂�)
     * @return �o�^���ꂽ�K���[���Q�̎Г����[��ID
     * @throws IOException �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
     * @throws RemoteException �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
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
	 * �Г����[���̍폜�������s���܂��B<BR/>
	 * 
	 * @param mid
	 *            �K���[���Q�̎Г����[��ID
	 * @param registrant
	 *            �폜�҂̃��O�C����.null�w��\(�폜�҂̓��O�C�����[�U�ƂȂ�܂�)
	 * @return �폜���ꂽ�K���[���Q�̎Г����[��ID
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	public String putMessageDelete(long mid, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		/**
		 * �Г����[���폜�pcsp�̌Ăяo����i�[�ϐ�
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopMessage_delete").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "message");
		ps.addProperty("mid", String.valueOf(mid)); // ���b�Z�[�WID
		if (registrant != null)
			ps.addProperty("registrant", registrant); // �o�^��
		else
			ps.addProperty("registrant", "");
		ps.close();

		return processResult(hc, "failed in the deletion of the message.");
	}

	/**
	 * �Г����[���t�H���[�̓o�^�������s���܂��B<BR/>
	 * 
	 * @param messageId
	 *            �K���[���Q�̎Г����[��ID
	 * @param data
	 *            �{��.null�w��\(�{������͂��܂���)
	 * @param attachedFiles
	 *            �Y�t�t�@�C���ƂȂ�t�@�C���p�X�̏W��. null�w��\(�Y�t�t�@�C�����w�肵�܂���)<BR/>
	 *            �v�f�́AString�^�܂���toString()�Ńt�@�C���p�X���擾�ł���Object�łȂ���΂����܂���<BR>
	 *            �v�f����null������ꍇ�́ANullPointerException���������܂�
	 * @param registrant
	 *            �o�^�҂̃��O�C����.null�w��\(�o�^�҂̓��O�C�����[�U�ƂȂ�܂�)
	 * @return �o�^���ꂽ�K���[���Q�̎Г����[���t�H���[ID
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	public String putMessageFollowAdd(long messageId, String data,
			Collection attachedFiles, String registrant) throws IOException,
			RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		/**
		 * �Г����[���t�H���[�o�^�pcsp�̌Ăяo����i�[�ϐ�
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopMessage_follow_add").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "message"); // Application
		ps.addProperty("mid", String.valueOf(messageId)); // ���[��ID
		ps.addProperty("data", data == null ? "" : data); // �t�H���[�{��
		ps.addProperty("editor", "0"); // �����ҏW���w�肵�Ȃ�(�e�L�X�g�w��)
		ps.addProperty("cmd", "follow"); // �����R�}���h
		if (registrant != null)
			ps.addProperty("registrant", registrant); // ���o�l
		else
			ps.addProperty("registrant", ""); // ���o�l

		if (attachedFiles != null) { // �Y�t�t�@�C��
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
	 * �Г����[���t�H���[�̍폜�������s���܂��B<BR/>
	 * 
	 * @param fid
	 *            �K���[���Q�̎Г����[���t�H���[ID
	 * @param registrant
	 *            �폜�҂̃��O�C����.null�w��\(�폜�҂̓��O�C�����[�U�ƂȂ�܂�)
	 * @return �폜���ꂽ�K���[���Q�̎Г����[���t�H���[ID
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	public String putMessageFollowDelete(long fid, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		/**
		 * �Г����[���t�H���[�폜�pcsp�̌Ăяo����i�[�ϐ�
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopMessage_follow_delete").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "message");
		ps.addProperty("fid", String.valueOf(fid)); // �t�H���[ID
		if (registrant != null) // �o�^��
			ps.addProperty("registrant", registrant);
		else
			ps.addProperty("registrant", "");
		ps.close();

		return processResult(hc,
				"failed in the deletion of the message Follow.");
	}

	/**
	 * �Г����[���̍X�V�������s���܂��B<BR/>
	 * 
	 * @param mid
	 *            �K���[���Q�̎Г����[��ID
	 * @param title
	 *            �W��
	 * @param data
	 *            �{��.null�w��\(�{������͂��܂���)
	 * @param attached_files
	 *            �Y�t�t�@�C���ƂȂ�t�@�C���p�X�̏W��. null�w��\(�Y�t�t�@�C����ǉ����܂���)<BR/>
	 *            �v�f�́AString�^�܂���toString()�Ńt�@�C���p�X���擾�ł���Object�łȂ���΂����܂���<BR>
	 *            �v�f����null������ꍇ�́ANullPointerException���������܂�
	 * @param registrant
	 *            �X�V�҂̃��O�C����.null�w��\(�X�V�҂̓��O�C�����[�U�ƂȂ�܂�)
	 * @return �X�V���ꂽ�K���[���Q�̎Г����[��ID
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	public String putMessageModify(long mid, String title, String data,
			Collection attached_files, String registrant) throws IOException,
			RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		/**
		 * �Г����[���X�V�pcsp�̌Ăяo����i�[�ϐ�
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopMessage_modify").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "message");
		ps.addProperty("mid", String.valueOf(mid)); // ���b�Z�[�WID
		if (title != null) // �W��
			ps.addProperty("title", title);
		else
			ps.addProperty("title", "");
		if (data != null) // �{��
			ps.addProperty("data", data);
		else
			ps.addProperty("data", "");
		if (attached_files != null) { // �Y�t�t�@�C��
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
			ps.addProperty("registrant", registrant); // ���o�l
		else
			ps.addProperty("registrant", "");
		ps.close();

		return processResult(hc, "failed in the modification of the message.");
	}

	/**
	 * �X�P�W���[���̓o�^�������s���܂��B<BR/>
	 * 
	 * @param eventKind
	 *            �\��敪(1:�o�i�[�\��,1�ȊO:�ʏ�\�� )
	 * @param titleMenu
	 *            ���j���[.null�w��\(���j���[����͂��܂���)
	 * @param title
	 *            �^�C�g��.null�w��\(�^�C�g������͂��܂���)
	 * @param eventPrivate
	 *            ���J���@(1:����J ,1�ȊO:���J )
	 * @param detail
	 *            ����.null�w��\(��������͂��܂���)
	 * @param startDate
	 *            �J�n��<BR/>
	 *            ���̃t�B�[���h�̂ݎQ��(Calendar.YEAR,Calendar.MONTH,Calendar.DAY_OF_MONTH)
	 * @param endDate
	 *            �I���� <BR/>
	 *            ���̃t�B�[���h�̂ݎQ��(Calendar.YEAR,Calendar.MONTH,Calendar.DAY_OF_MONTH)
	 * @param startTime
	 *            �J�n����.null�w��\(�J�n�������w�肵�܂���)<BR/>
	 *            ���̃t�B�[���h�̂ݎQ��(Calendar.HOUR_OF_DAY,Calendar.MINUTE)
	 * @param endTime
	 *            �I������.null�w��\(�I���������w�肵�܂���)<BR/>
	 *            ���̃t�B�[���h�̂ݎQ��(Calendar.HOUR_OF_DAY,Calendar.MINUTE)
	 * @param userAccounts
	 *            �X�P�W���[���Q���҂ƂȂ郍�O�C�����̏W��<BR/>
	 *            �v�f�́AString�^�܂���toString()�Ń��O�C�������擾�ł���Object�łȂ���΂����܂���<BR/>
	 *            �v�f����null������ꍇ�́ANullPointerException���������܂�
	 * @param facilitiesCodes
	 *            �\�񂷂�K���[���Q�̎{�݃R�[�h�̏W�� null�w��\(�{�݂�\�񂵂܂���)<BR/>
	 *            �v�f�́AString�^�܂���toString()�Ŏ{�݃R�[�h���擾�ł���Object�łȂ���΂����܂���<BR>
	 *            �v�f����null������ꍇ�́ANullPointerException���������܂�
	 * @param registrant
	 *            �o�^�҂̃��O�C����.null�w��\(�o�^�҂̓��O�C�����[�U�ƂȂ�܂�)
	 * @return �o�^���ꂽ�K���[���Q�̃X�P�W���[��ID
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	public String putScheduleAdd(int eventKind, String titleMenu, String title,
			String eventPrivate, String detail, Calendar startDate,
			Calendar endDate, Calendar startTime, Calendar endTime,
			Collection userAccounts, Collection facilitiesCodes,
			String registrant) throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		/**
		 * �X�P�W���[���o�^�pcsp�̌Ăяo����i�[�ϐ�
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopSchedule_add").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);

		PostStream ps = getURLEncodingStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "schedule"); // Application

		if (eventKind == 1)
			ps.addProperty("BN", "1"); // �\��敪(�o�i�[�\��)

		if (titleMenu != null)
			ps.addProperty("menu", titleMenu); // �\�胁�j���[
		else
			ps.addProperty("menu", ""); // �\�胁�j���[

		if (title != null)
			ps.addProperty("title", title); // �\��^�C�g��
		else
			ps.addProperty("title", ""); // �\��^�C�g��

		if (eventKind != 1)
			ps.addProperty("private", "1".equals(eventPrivate) ? eventPrivate
					: "0");// ���J/����J

		if (detail != null)
			ps.addProperty("memo", detail); // �\�胁��
		else
			ps.addProperty("memo", ""); // �\�胁��

		if (registrant != null)
			ps.addProperty("registrant", registrant); // �o�^��(���s���[�U�[)
		else
			ps.addProperty("registrant", ""); // �o�^��(���s���[�U�[)

		if (userAccounts != null) {
			for (Iterator it = userAccounts.iterator(); it.hasNext();) {
				ps.addProperty("user_account[]", it.next().toString()); // �Q���҂̃��[�U�[�A�J�E���g
			}
		}

		if (facilitiesCodes != null && eventKind != 1) {
			for (Iterator it = facilitiesCodes.iterator(); it.hasNext();) {
				ps.addProperty("sITEM_CODE[]", it.next().toString()); // �{�݃R�[�h
			}
		}
		if (startDate != null) {
			ps.addProperty("bdate", new StringBuffer().append(
					startDate.get(Calendar.YEAR)).append("-").append(
					startDate.get(Calendar.MONTH) + 1).append("-").append(
					startDate.get(Calendar.DAY_OF_MONTH)).toString());

			ps.addProperty("start_year", startDate.get(Calendar.YEAR)); // �J�n��(�N)
			ps.addProperty("start_month", startDate.get(Calendar.MONTH) + 1); // �J�n��(��)
			ps.addProperty("start_day", startDate.get(Calendar.DAY_OF_MONTH)); // �J�n��(��)
		} else {
			ps.addProperty("bdate", "");
			ps.addProperty("start_year", ""); // �J�n��(�N)
			ps.addProperty("start_month", ""); // �J�n��(��)
			ps.addProperty("start_day", ""); // �J�n��(��)
		}
		if (startTime != null && eventKind != 1) {
			ps.addProperty("start_hour", startTime.get(Calendar.HOUR_OF_DAY));// �J�n����(��)
			ps.addProperty("start_minute", startTime.get(Calendar.MINUTE)); // �J�n����(��)
		} else if (eventKind != 1) {
			ps.addProperty("start_hour", ""); // �I������(��)
			ps.addProperty("start_minute", ""); // �I������(��)
		}
		if (endDate != null) {
			ps.addProperty("end_year", endDate.get(Calendar.YEAR)); // �I����(�N)
			ps.addProperty("end_month", endDate.get(Calendar.MONTH) + 1); // �I����(��)
			ps.addProperty("end_day", endDate.get(Calendar.DAY_OF_MONTH)); // �I����(��)
		} else {
			ps.addProperty("end_year", ""); // �I����(�N)
			ps.addProperty("end_month", ""); // �I����(��)
			ps.addProperty("end_day", ""); // �I����(��)
		}
		if (endTime != null && eventKind != 1) {
			ps.addProperty("end_hour", endTime.get(Calendar.HOUR_OF_DAY)); // �I������(��)
			ps.addProperty("end_minute", endTime.get(Calendar.MINUTE)); // �I������(��)
		} else if (eventKind != 1) {
			ps.addProperty("end_hour", ""); // �I������(��)
			ps.addProperty("end_minute", ""); // �I������(��)
		}

		ps.close();
		return processResult(hc, "failed in the registration of the schedule.");// �߂�l(�C�x���gID)
	}

	/**
	 * �X�P�W���[���̍폜�������s���܂��B<BR/> �w�肳�ꂽ�X�P�W���[��ID�ɂ�����S�Q����,�S�͈̗͂\����폜���܂�
	 * 
	 * @param eventId
	 *            �K���[���Q�̃X�P�W���[��ID
	 * @param registrant
	 *            �폜�҂̃��O�C����.null�w��\(�폜�҂̓��O�C�����[�U�ƂȂ�܂�)
	 * @return �폜���ꂽ�K���[���Q�̃X�P�W���[��ID
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	public String putScheduleDelete(long eventId, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		/**
		 * �X�P�W���[���폜�pcsp�̌Ăяo����i�[�ϐ�
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopSchedule_delete").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getURLEncodingStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "schedule"); // Application
		ps.addProperty("event", String.valueOf(eventId)); // �C�x���gID
		ps.addProperty("member", "0"); // �폜�̑ΏۂƂȂ�Q����
		ps.addProperty("apply", "1"); // �폜����͈�

		if (registrant != null)
			ps.addProperty("registrant", registrant); // �X�V��(�폜���s��)
		else
			ps.addProperty("registrant", ""); // �X�V��(�폜���s��)

		ps.close();
		return processResult(hc, "failed in the deletion of the schedule."); // �߂�l(�C�x���gID)
	}

	/**
	 * �X�P�W���[���̍X�V�������s���܂��B<BR/> �S�Ă̍��ڂ́A�����Ŏw�肳�ꂽ���ڒl�ɒu�������܂��B<BR/>
	 * 
	 * @param eventId
	 *            �K���[���Q�̃X�P�W���[��ID
	 * @param titleMenu
	 *            ���j���[.null�w��\(���j���[����͂��܂���)
	 * @param title
	 *            �^�C�g��.null�w��\(�^�C�g������͂��܂���)
	 * @param eventPrivate
	 *            ���J���@(1:����J ,1�ȊO:���J )
	 * @param detail
	 *            ����.null�w��\(��������͂��܂���)
	 * @param startDate
	 *            �J�n��<BR/>
	 *            ���̃t�B�[���h�̂ݎQ��(Calendar.YEAR,Calendar.MONTH,Calendar.DAY_OF_MONTH)
	 * @param endDate
	 *            �I���� <BR/>
	 *            ���̃t�B�[���h�̂ݎQ��(Calendar.YEAR,Calendar.MONTH,Calendar.DAY_OF_MONTH)
	 * @param startTime
	 *            �J�n����.null�w��\(�J�n�������w�肵�܂���)<BR/>
	 *            ���̃t�B�[���h�̂ݎQ��(Calendar.HOUR_OF_DAY,Calendar.MINUTE)
	 * @param endTime
	 *            �I������.null�w��\(�I���������w�肵�܂���)<BR/>
	 *            ���̃t�B�[���h�̂ݎQ��(Calendar.HOUR_OF_DAY,Calendar.MINUTE)
	 * @param userAccounts
	 *            �X�P�W���[���Q���҂ƂȂ郍�O�C�����̏W��<BR/>
	 *            �v�f�́AString�^�܂���toString()�Ń��O�C�������擾�ł���Object�łȂ���΂����܂���<BR/>
	 *            �v�f����null������ꍇ�́ANullPointerException���������܂�
	 * @param facilitiesCodes
	 *            �\�񂷂�K���[���Q�̎{�݃R�[�h�̏W�� null�w��\(�{�݂�\�񂵂܂���)<BR/>
	 *            �v�f�́AString�^�܂���toString()�Ŏ{�݃R�[�h���擾�ł���Object�łȂ���΂����܂���<BR>
	 *            �v�f����null������ꍇ�́ANullPointerException���������܂�
	 * @param registrant
	 *            �o�^�҂̃��O�C����.null�w��\(�o�^�҂̓��O�C�����[�U�ƂȂ�܂�)
	 * @return �X�V���ꂽ�K���[���Q�̃X�P�W���[��ID
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	public String putScheduleModify(long eventId, String titleMenu,
			String title, String eventPrivate, String detail,
			Calendar startDate, Calendar endDate, Calendar startTime,
			Calendar endTime, Collection userAccounts,
			Collection facilitiesCodes, String registrant) throws IOException,
			RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		/**
		 * �X�P�W���[���X�V�pcsp�̌Ăяo����i�[�ϐ�
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopSchedule_modify").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getURLEncodingStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "schedule"); // Application

		ps.addProperty("event", String.valueOf(eventId)); // �C�x���gID
		ps.addProperty("apply", "all"); // �X�V����͈�(���̂Ƃ���Œ�l)

		if (titleMenu != null)
			ps.addProperty("menu", titleMenu); // �\�胁�j���[
		else
			ps.addProperty("menu", ""); // �\�胁�j���[

		if (title != null)
			ps.addProperty("title", title); // �\��^�C�g��
		else
			ps.addProperty("title", ""); // �\��^�C�g��

		if (eventPrivate != null)
			ps.addProperty("private", "1".equals(eventPrivate) ? eventPrivate
					: "0");// ���J/����J

		if (detail != null)
			ps.addProperty("memo", detail); // �\�胁��
		else
			ps.addProperty("memo", ""); // �\�胁��

		if (registrant != null)
			ps.addProperty("registrant", registrant); // �X�V��
		else
			ps.addProperty("registrant", ""); // �X�V��

		if (userAccounts != null) {
			for (Iterator it = userAccounts.iterator(); it.hasNext();) {
				ps.addProperty("user_account[]", it.next().toString()); // �Q���҂̃��[�U�[�A�J�E���g
			}
		}

		if (facilitiesCodes != null) { // �{�݃R�[�h
			for (Iterator it = facilitiesCodes.iterator(); it.hasNext();) {
				ps.addProperty("sITEM_CODE[]", it.next().toString());
			}
		}
		if (startDate != null) {
			ps.addProperty("start_year", startDate.get(Calendar.YEAR)); // �J�n��(�N)
			ps.addProperty("start_month", startDate.get(Calendar.MONTH) + 1); // �J�n��(��)
			ps.addProperty("start_day", startDate.get(Calendar.DAY_OF_MONTH)); // �J�n��(��)
		} else {
			ps.addProperty("bdate", "");
			ps.addProperty("start_year", ""); // �J�n��(�N)
			ps.addProperty("start_month", ""); // �J�n��(��)
			ps.addProperty("start_day", ""); // �J�n��(��)
		}
		if (startTime != null) {
			ps.addProperty("start_hour", startTime.get(Calendar.HOUR_OF_DAY));// �J�n����(��)
			ps.addProperty("start_minute", startTime.get(Calendar.MINUTE)); // �J�n����(��)
		} else {
			ps.addProperty("start_hour", ""); // �I������(��)
			ps.addProperty("start_minute", ""); // �I������(��)
		}
		if (endDate != null) {
			ps.addProperty("end_year", endDate.get(Calendar.YEAR)); // �I����(�N)
			ps.addProperty("end_month", endDate.get(Calendar.MONTH) + 1); // �I����(��)
			ps.addProperty("end_day", endDate.get(Calendar.DAY_OF_MONTH)); // �I����(��)
		} else {
			ps.addProperty("end_year", ""); // �I����(�N)
			ps.addProperty("end_month", ""); // �I����(��)
			ps.addProperty("end_day", ""); // �I����(��)
		}

		if (endTime != null) {
			ps.addProperty("end_hour", endTime.get(Calendar.HOUR_OF_DAY)); // �I������(��)
			ps.addProperty("end_minute", endTime.get(Calendar.MINUTE)); // �I������(��)
		} else {
			ps.addProperty("end_hour", ""); // �I������(��)
			ps.addProperty("end_minute", ""); // �I������(��)
		}
		ps.close();
		return processResult(hc, "failed in the modification of the schedule.");// �߂�l(�C�x���gID)
	}

	/**
	 * �{�ݗ\��ւ̏����o�����s���܂��B<BR>
	 * 
	 * @param filepath
	 *            �o�͐�̃t�@�C���p�X
	 * @param facility
	 *            �K���[���Q�̎{�݃R�[�h�̏W��<BR>
	 *            �v�f�́AString�^�܂���toString()�Ŏ{�݃R�[�h���擾�ł���Object�łȂ���΂����܂���<BR/>
	 *            �v�f����null������ꍇ�́ANullPointerException���������܂�
	 * @param setDate
	 *            �����o���\�����(�J�n��)
	 * @param endDate
	 *            �����o���\�����(�I����)
	 * @param skipFirst
	 *            �擪�s�̗L��(true:�L false:��)
	 * @param creator
	 *            �ǉ��̍��ڏ��o���t���O(true:�ǉ����ڂ����o��,false:�ǉ����ڂ����o���Ȃ�)
	 * @param sjisEncoding
	 *            �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 * @throws NullPointerException
	 *             �K�{���ڂ̃p�����[�^��NULL�̏ꍇ�ɃG���[������
	 */
	public void exportFacilitySchedule(String filepath, Collection facility,
			Calendar setDate, Calendar endDate, boolean skipFirst,
			boolean creator, boolean sjisEncoding) throws IOException,
			RemoteException, NullPointerException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		if (filepath == null)
			filepath = ""; // CSV�t�@�C���p�X

		Iterator it = facility.iterator();
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/grnFacilitySchedule_export").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);

		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("system", "2"); // �����`�F�b�N�p(System)
		ps.addProperty("manage", "schedule"); // �����`�F�b�N�pApplication��

		if (setDate != null) { // �����o���\�����(�J�n��)
			ps.addProperty("start_year", setDate.get(Calendar.YEAR)); // �J�n��(�N)
			ps.addProperty("start_month", setDate.get(Calendar.MONTH) + 1); // �J�n��(��)
			ps.addProperty("start_day", setDate.get(Calendar.DAY_OF_MONTH));// �J�n��(��)
		} else {
			ps.addProperty("start_year", ""); // �J�n��(�N)
			ps.addProperty("start_month", ""); // �J�n��(��)
			ps.addProperty("start_day", ""); // �J�n��(��)
		}

		if (endDate != null) { // �����o���\�����(�I����)
			ps.addProperty("end_year", endDate.get(Calendar.YEAR)); // �I����(�N)
			ps.addProperty("end_month", endDate.get(Calendar.MONTH) + 1); // �I����(��)
			ps.addProperty("end_day", endDate.get(Calendar.DAY_OF_MONTH)); // �I����(��)
		} else {
			ps.addProperty("end_year", ""); // �I����(�N)
			ps.addProperty("end_month", ""); // �I����(��)
			ps.addProperty("end_day", ""); // �I����(��)
		}

		if (creator)
			ps.addProperty("creator", 1); // �ǉ��̏����o������
		else
			ps.addProperty("creator", 0); // �ǉ��̏����o������

		it = facility.iterator(); // �{�݃R�[�h
		while (it.hasNext()) {
			ps.addProperty("target[]", "facility:" + it.next().toString());
		}

		if (skipFirst) // �擪�s�̗L��
			ps.addProperty("item_name", 1); // �擪�s�̗L
		else
			ps.addProperty("item_name", 0); // �擪�s�̖�

		if (sjisEncoding == true)
			ps.addProperty("charset", "SJIS-win");
		else
			ps.addProperty("charset", "UTF8");
		ps.close();

		fileWrite(hc, filepath, sjisEncoding); // �{�ݗ\��CSV�t�@�C���̍쐬
	}

	/**
	 * ���[�U�[�Ǘ��pCSV�t�@�C���ւ̏����o�����s���܂��B(�g�D���)<BR>
	 * 
	 * @param filepath
	 *            CSV�t�@�C���p�X
	 * @param skipFirst
	 *            �擪�s�̗L��(true:�L false:��)
	 * @param sjisEncoding
	 *            �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 * @throws NullPointerException
	 *             �K�{���ڂ̃p�����[�^��NULL�̏ꍇ�ɃG���[������
	 */
	public void exportOrganization(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnOrganization_export";
		exportInfo(Page, filepath, skipFirst, sjisEncoding);
	}

	/**
	 * ���[�U�[�Ǘ��pCSV�t�@�C���ւ̏����o�����s���܂��B(�g�D�̏������[�U�[)<BR>
	 * 
	 * @param filepath
	 *            CSV�t�@�C���p�X
	 * @param skipFirst
	 *            �擪�s�̗L��(true:�L false:��)
	 * @param sjisEncoding
	 *            �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 * @throws NullPointerException
	 *             �K�{���ڂ̃p�����[�^��NULL�̏ꍇ�ɃG���[������
	 */
	public void exportOrganizationUser(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnOrganizationUser_export";
		exportInfo(Page, filepath, skipFirst, sjisEncoding);
	}

	/**
	 * ���[�U�[�Ǘ��pCSV�t�@�C���ւ̏����o�����s���܂��B(���[�����)<BR>
	 * 
	 * @param filepath
	 *            CSV�t�@�C���p�X
	 * @param skipFirst
	 *            �擪�s�̗L��(true:�L false:��)
	 * @param sjisEncoding
	 *            �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 * @throws NullPointerException
	 *             �K�{���ڂ̃p�����[�^��NULL�̏ꍇ�ɃG���[������
	 */
	public void exportRole(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnRole_export";
		exportInfo(Page, filepath, skipFirst, sjisEncoding);
	}

	/**
	 * ���[�U�[�Ǘ��pCSV�t�@�C���ւ̏����o�����s���܂��B(���[���̏������[�U�[)<BR>
	 * 
	 * @param filepath
	 *            CSV�t�@�C���p�X
	 * @param skipFirst
	 *            �擪�s�̗L��(true:�L false:��)
	 * @param sjisEncoding
	 *            �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 * @throws NullPointerException
	 *             �K�{���ڂ̃p�����[�^��NULL�̏ꍇ�ɃG���[������
	 */
	public void exportRoleUser(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnRoleUser_export";
		exportInfo(Page, filepath, skipFirst, sjisEncoding);
	}

	/**
	 * ���[�U�[�Ǘ��pCSV�t�@�C���ւ̏����o�����s���܂��B(���[�U�[���)<BR>
	 * 
	 * @param filepath
	 *            CSV�t�@�C���p�X
	 * @param skipFirst
	 *            �擪�s�̗L��(true:�L false:��)
	 * @param sjisEncoding
	 *            �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 * @throws NullPointerException
	 *             �K�{���ڂ̃p�����[�^��NULL�̏ꍇ�ɃG���[������
	 */
	public void exportUser(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnUser_export";
		exportInfo(Page, filepath, skipFirst, sjisEncoding);
	}

	/**
	 * ���[�U�[�Ǘ��pCSV�t�@�C���ւ̏����o�����s���܂��B(���[�U�[�̏����g�D)<BR>
	 * 
	 * @param filepath
	 *            CSV�t�@�C���p�X
	 * @param skipFirst
	 *            �擪�s�̗L��(true:�L false:��)
	 * @param sjisEncoding
	 *            �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 * @throws NullPointerException
	 *             �K�{���ڂ̃p�����[�^��NULL�̏ꍇ�ɃG���[������
	 */
	public void exportUserOrganization(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnUserOrganization_export";
		exportInfo(Page, filepath, skipFirst, sjisEncoding);
	}

	/**
	 * ���[�U�[�Ǘ��pCSV�t�@�C���ւ̏����o�����s���܂��B(���[�U�[�̏������[��)<BR>
	 * 
	 * @param filepath
	 *            CSV�t�@�C���p�X
	 * @param skipFirst
	 *            �擪�s�̗L��(true:�L false:��)
	 * @param sjisEncoding
	 *            �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 * @throws NullPointerException
	 *             �K�{���ڂ̃p�����[�^��NULL�̏ꍇ�ɃG���[������
	 */
	public void exportUserRole(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnUserRole_export";
		exportInfo(Page, filepath, skipFirst, sjisEncoding);
	}

	/**
	 * ���[�U�[�Ǘ��pCSV�t�@�C���̓ǂݍ��݂��s���܂��B(�g�D���)<BR>
	 * 
	 * @param filepath
	 *            CSV�t�@�C���p�X
	 * @param skipFirst
	 *            �擪�s�̗L��(true:�L false:��)
	 * @param sjisEncoding
	 *            �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 * @throws NullPointerException
	 *             �K�{���ڂ̃p�����[�^��NULL�̏ꍇ�ɃG���[������
	 */
	public void importOrganization(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnOrganization_import";
		importInfo(Page, filepath, skipFirst, sjisEncoding);

	}

	/**
	 * ���[�U�[�Ǘ��pCSV�t�@�C���̓ǂݍ��݂��s���܂��B(�g�D�̏������[�U�[)<BR>
	 * 
	 * @param filepath
	 *            CSV�t�@�C���p�X
	 * @param skipFirst
	 *            �擪�s�̗L��(true:�L false:��)
	 * @param sjisEncoding
	 *            �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 * @throws NullPointerException
	 *             �K�{���ڂ̃p�����[�^��NULL�̏ꍇ�ɃG���[������
	 */
	public void importOrganizationUser(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnOrganizationUser_import";
		importInfo(Page, filepath, skipFirst, sjisEncoding);
	}

	/**
	 * ���[�U�[�Ǘ��pCSV�t�@�C���̓ǂݍ��݂��s���܂��B(���[�����)<BR>
	 * 
	 * @param filepath
	 *            CSV�t�@�C���p�X
	 * @param skipFirst
	 *            �擪�s�̗L��(true:�L false:��)
	 * @param sjisEncoding
	 *            �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 * @throws NullPointerException
	 *             �K�{���ڂ̃p�����[�^��NULL�̏ꍇ�ɃG���[������
	 */
	public void importRole(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnRole_import";
		importInfo(Page, filepath, skipFirst, sjisEncoding);

	}

	/**
	 * ���[�U�[�Ǘ��pCSV�t�@�C���̓ǂݍ��݂��s���܂��B(���[���̏������[�U�[)<BR>
	 * 
	 * @param filepath
	 *            CSV�t�@�C���p�X
	 * @param skipFirst
	 *            �擪�s�̗L��(true:�L false:��)
	 * @param sjisEncoding
	 *            �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 * @throws NullPointerException
	 *             �K�{���ڂ̃p�����[�^��NULL�̏ꍇ�ɃG���[������
	 */
	public void importRoleUser(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnRoleUser_import";
		importInfo(Page, filepath, skipFirst, sjisEncoding);

	}

	/**
	 * ���[�U�[�Ǘ��pCSV�t�@�C���̓ǂݍ��݂��s���܂��B(���[�U�[���)<BR>
	 * 
	 * @param filepath
	 *            CSV�t�@�C���p�X
	 * @param skipFirst
	 *            �擪�s�̗L��(true:�L false:��)
	 * @param sjisEncoding
	 *            �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 * @throws NullPointerException
	 *             �K�{���ڂ̃p�����[�^��NULL�̏ꍇ�ɃG���[������
	 */
	public void importUser(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnUser_import";
		importInfo(Page, filepath, skipFirst, sjisEncoding);

	}

	/**
	 * ���[�U�[�Ǘ��pCSV�t�@�C���̓ǂݍ��݂��s���܂��B(���[�U�[�̏����g�D)<BR>
	 * 
	 * @param filepath
	 *            CSV�t�@�C���p�X
	 * @param skipFirst
	 *            �擪�s�̗L��(true:�L false:��)
	 * @param sjisEncoding
	 *            �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 * @throws NullPointerException
	 *             �K�{���ڂ̃p�����[�^��NULL�̏ꍇ�ɃG���[������
	 */
	public void importUserOrganization(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnUserOrganization_import";
		importInfo(Page, filepath, skipFirst, sjisEncoding);

	}

	/**
	 * ���[�U�[�Ǘ��pCSV�t�@�C���̓ǂݍ��݂��s���܂��B(���[���̏������[�U�[)<BR>
	 * 
	 * @param filepath
	 *            CSV�t�@�C���p�X
	 * @param skipFirst
	 *            �擪�s�̗L��(true:�L false:��)
	 * @param sjisEncoding
	 *            �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 * @throws NullPointerException
	 *             �K�{���ڂ̃p�����[�^��NULL�̏ꍇ�ɃG���[������
	 */
	public void importUserRole(String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		String Page = "/coop/grnUserRole_import";
		importInfo(Page, filepath, skipFirst, sjisEncoding);

	}

	/**
	 * �^�C���J�[�h�̓o�^�������s���܂��B<BR/> �w�肳�ꂽ���t�ɂ��āA���ڒP�ʂł̓o�^���\�ł��B
	 * 
	 * @param setDate
	 *            �^�C���J�[�h�̓��t
	 * @param startTime
	 *            �o�Ў���("","*",H:mm�`��)�̂����ꂩ�̒l<BR>
	 *            �l�������ꍇ: ""<BR/> �����l�ύX���Ȃ��ꍇ: "*" �܂��� null<BR/>
	 *            ���Ԃ�V���ɐݒ肷��ꍇ�FH:mm�`��
	 * @param endTime
	 *            �ގЎ���("","*",H:mm�`��)�̂����ꂩ�̒l<BR>
	 *            �l�������ꍇ: ""<BR/> �����l�ύX���Ȃ��ꍇ: "*" �܂��� null<BR/>
	 *            ���Ԃ�V���ɐݒ肷��ꍇ�FH:mm�`��
	 * @param abcencesTimes
	 *            {[�C���O�O�o����],[�C����O�o����],[�C���㕜�A����]} �̂Q�����z��<BR>
	 *            �v�f�̎����ɂ��ẮA("","*",null,H:mm�`��)�̂����ꂩ�̒l<BR/> �l�������̏ꍇ: ""<BR/>
	 *            �����l�ύX���Ȃ��ꍇ: "*" �܂��� null<BR/>
	 *            [�C���O�O�o����]�Ɋ����ݒ莞�����w�肷�邱�Ƃɂ�肻�ꂼ��̕s�ݎ������C�����邱�Ƃ��\�ł��B<BR/>
	 *            [�C���O�O�o����]��""���w�肵���ꍇ�́A�V�K�ɕs�ݎ�����o�^���܂��B<BR/>
	 *            1�����ڂ̔z��̗v�f����3�ȊO�̏ꍇ�́AIllegalArgumentException ���������܂��B
	 * @param memo
	 *            ���l.null�w��\(���l��ύX���܂���)
	 * @param clearFlg
	 *            �^�C���J�[�h�̃N���A�t���O(true:�N���A����,false:�N���A���Ȃ�)<BR/>
	 *            ���ɐݒ肵�Ă�����t(setDate)�̃^�C���J�[�h�����N���A���܂��B<BR/> ���̃t���O�́A���̍��ڂ��D�悳��܂�<BR/>
	 * @param registrant
	 *            �o�^�Ώێ҂̃��O�C����.null�w��\(�o�^�Ώێ҂̓��O�C�����[�U�ƂȂ�܂�)
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 * @throws ParseException
	 *             startTime,endTime,abcencesTimes�̂����ꂩ��Calendar�^�ɕϊ��ł��Ȃ��ꍇ
	 */
	public void putTimecard(Calendar setDate, String startTime, String endTime,
			String[][] abcencesTimes, String memo, boolean clearFlg,
			String registrant) throws IOException, RemoteException,
			ParseException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		String Page = new StringBuffer().append(grnURL).append(
				"/coop/grnTimecard_add").toString();
		super.setPageInfo(URI.create(Page));
		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = getURLEncodingStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "timecard"); // Application

		ps.addProperty("system", "2"); // �����`�F�b�N�p(System)
		ps.addProperty("manage", "timecard"); // �����`�F�b�N�pApplication��

		if (memo != null)
			ps.addProperty("remarks", memo); // ���l�t�@�C��

		if (registrant != null)
			ps.addProperty("registrant", registrant); // �Ώۃ��[�U�[

		if (clearFlg == true) // �N���A�t���O
			ps.addProperty("clear", "");

		if (setDate != null) // ���t
			ps.addProperty("date", new StringBuffer().append(
					setDate.get(Calendar.YEAR)).append("-").append(
					setDate.get(Calendar.MONTH) + 1).append("-").append(
					setDate.get(Calendar.DAY_OF_MONTH)).toString());

		Calendar myCal = Calendar.getInstance();
		;
		SimpleDateFormat sdf = new SimpleDateFormat();
		sdf.applyPattern("H:mm");
		sdf.setLenient(false);

		if (startTime == null) // �o�Ў���
			startTime = "*";

		if (startTime.equals("") || startTime.equals("*")) {
			ps.addProperty("start_hour", startTime);
			ps.addProperty("start_minute", startTime);
		} else {
			myCal.setTime(sdf.parse(startTime));
			ps.addProperty("start_hour", myCal.get(Calendar.HOUR_OF_DAY));
			ps.addProperty("start_minute", myCal.get(Calendar.MINUTE));
		}

		if (endTime == null) // �o�Ў���
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
	 * ���[���A�J�E���g��CSV�t�@�C���ւ̏����o�����s���܂��B<BR>
	 * 
	 * @param filePath
	 *            CSV�t�@�C���p�X
	 * @param skipFirst
	 *            �擪�s�̗L��(true:�L false:��)
	 * @param sjisEncoding
	 *            �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	// 2007/04/16
	// [Java���\�b�h]���[���A�J�E���gCSV�����o�����ACSV�t�@�C���p�X�����Ɂunull�v����ݒ肵���ۂ̃G���[���b�Z�[�W���s���Ǝv����B
	// �s��Ǘ�(212)
	public void exportMailAccount(String filePath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		String Page = new StringBuffer().append(grnURL).append(
				"/coop/grnMailAccount_export").toString();
		super.setPageInfo(URI.create(Page));
		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);

		PostStream ps = super.getURLEncodingStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("system", "2"); // �����`�F�b�N�p(System)
		ps.addProperty("manage", "mail"); // �����`�F�b�N�pApplication��
		if (skipFirst) // �擪�s�̗L��
			ps.addProperty("item_name", 1); // �擪�s�̗L
		else
			ps.addProperty("item_name", 0); // �擪�s�̖�

		if (sjisEncoding == true) // �G���R�[�h
			ps.addProperty("charset", "SJIS-win");
		else
			ps.addProperty("charset", "UTF-8");
		ps.close();

		fileWrite(hc, filePath, sjisEncoding);
	}

	/**
	 * ���[���A�J�E���g��CSV�t�@�C���̓ǂݍ��݂��s���܂��B<BR>
	 * 
	 * @param filePath
	 *            CSV�t�@�C���p�X
	 * @param skipFirst
	 *            �擪�s�̗L��(true:�L false:��)
	 * @param sjisEncoding
	 *            �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	public void importMailAccount(String filePath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		String Page = new StringBuffer().append(grnURL).append(
				"/coop/grnMailAccount_import").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);

		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("system", "2"); // �����`�F�b�N�p(System)
		ps.addProperty("manage", "mail"); // �����`�F�b�N�pApplication��
		if (filePath != null)
			ps.addFile(new File(filePath), new StringBuffer().append("file")
					.toString(), "application/octet-stream");
		if (skipFirst) // �擪�s�̗L��
			ps.addProperty("skip", 1); // �擪�s�̗L
		else
			ps.addProperty("skip", 0); // �擪�s�̖�

		if (sjisEncoding == true) // �G���R�[�h
			ps.addProperty("charset", "SJIS-win");
		else
			ps.addProperty("charset", "UTF-8");
		ps.close();

		processResult(hc, "failed to import csv file.");
	}

	/**
	 * �X�P�W���[���t�H���[�̒ǉ��������s���܂��B<BR/>
	 * 
	 * @param eventId
	 *            �K���[���Q�̃X�P�W���[��ID
	 * @param data
	 *            �t�H���[�̖{��
	 * @param registrant
	 *            �o�^�҂̃��O�C����.null�w��\(�o�^�҂̓��O�C�����[�U�ƂȂ�܂�)
	 * @return �o�^���ꂽ�K���[���Q�̃X�P�W���[���t�H���[ID
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	public String putScheduleFollowAdd(long eventId, String data,
			String registrant) throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		/**
		 * �X�P�W���[���t�H���[�ǉ��pcsp�̌Ăяo����i�[�ϐ�
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopSchedule_follow_add").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);

		PostStream ps = super.getURLEncodingStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "schedule"); // Application
		ps.addProperty("event", String.valueOf(eventId)); // �K���[���Q�̃X�P�W���[��ID

		if (data != null)
			ps.addProperty("data", data); // �t�H���[�̖{��

		if (registrant != null) // �o�^�҂̃��O�C����
			ps.addProperty("registrant", registrant);

		ps.close();
		return processResult(hc, "failed to registrant of schedule follow.");// �߂�l(�X�P�W���[���t�H���[ID)
	}

	/**
	 * �X�P�W���[���t�H���[�̍폜�������s���܂��B<BR/>
	 * 
	 * @param followId
	 *            �K���[���Q�̃X�P�W���[���t�H���[ID
	 * @param registrant
	 *            �폜�҂̃��O�C����.null�w��\(�폜�҂̓��O�C�����[�U�ƂȂ�܂�)
	 * @return �폜���ꂽ�K���[���Q�̃X�P�W���[���t�H���[ID
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	public String putScheduleFollowDelete(long followId, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		/**
		 * �X�P�W���[���폜�pcsp�̌Ăяo����i�[�ϐ�
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopSchedule_follow_delete").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);
		PostStream ps = super.getURLEncodingStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("app", "schedule"); // Application
		ps.addProperty("follow_id", String.valueOf(followId)); // �X�P�W���[���t�H���[ID

		if (registrant != null)
			ps.addProperty("registrant", registrant); // �폜�҂̃��O�C����

		ps.close();
		return processResult(hc, "failed to delete of schedule follow.");// �߂�l(�X�P�W���[���t�H���[ID)
	}

	/**
	 * HTTP �T�[�o�[�Ƃ̒ʐM���ʂŁA�Ԃ��ꂽ�w�b�_���������܂��B<br>
	 * ���̃��\�b�h�ł� "Set-Cookie" �w�b�_���������ACookie �̃��|�W�g���ɒǉ����܂��B<br>
	 * ����Ȃ鏈�����K�v�ȏꍇ�́A���̃��\�b�h���T�u�N���X�ŃI�[�o�[���C�h���܂��B
	 * 
	 * @param hc
	 *            {@link #getConnection} �Ŏ擾���� HttpURLConnection
	 * @param context
	 *            ���̃��\�b�h���Ă΂ꂽ�w�i�ɂ��Ă̕������w�肵�܂��B �����[�g�G���h�ŉ��炩�̃G���[���N�������ꍇ�ɁA
	 *            {@link RemoteException}�̃G���[���b�Z�[�W�̈ꕔ�ɂȂ�܂��B
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	private void checkErrorHeader(HttpURLConnection hc, String context)
			throws IOException, RemoteException {

		String errno = hc.getHeaderField(GASERROR_HEADER);
		if (errno != null) {
			throw new RemoteException(context + "(" + errno + ")");
		}
	}

	/**
	 * ���[�U�[�Ǘ��pCSV�t�@�C���̍쐬���s���܂��B<BR>
	 * 
	 * @param hc
	 *            HttpClient.getConnection(int) ����擾���� HttpURLConnection�B
	 * @param filepath
	 *            CSV�t�@�C���p�X
	 * @param sjisEncoding
	 *            �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	private void fileWrite(java.net.HttpURLConnection hc, String filepath,
			boolean sjisEncoding) throws IOException, RemoteException {

		// �s��Ǘ� 275 csv���o�ŁAClient-Linux�ŏ��o�����CSV�̉��s�R�[�h��LF�ɂȂ� 2008/01/15
		// �o�C�g�X�g���[���ŏ��o���B
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
	 * �K���[���Q�A�g�p�v���O�����̃o�[�W�����擾���s���܂��B
	 * 
	 * @return �A�v���P�[�V�����A�g�̃o�[�W����
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	public String versionInfo() throws IOException, RemoteException {
		/**
		 * �K���[���Q�A�g�p�v���O�����o�[�W�����`�F�b�N�̌Ăяo����i�[�ϐ�
		 */
		String Page = new StringBuffer().append(grnURL).append(
				"/coop/coopLogin").toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);

		PostStream ps = getURLEncodingStream(hc);
		ps.addProperty("version", "0"); // �o�[�W����
		ps.close();
		processResult(hc, "The acquisition of an API version.");

		return hc.getHeaderField("X-Cybozu-API-VERSION");
	}

	/**
	 * ���[�U�[�Ǘ��pCSV�t�@�C���̓ǂݍ��݂��s���܂��B<BR>
	 * 
	 * @param page
	 *            �y�[�W�w��
	 * @param filepath
	 *            CSV�t�@�C���p�X
	 * @param skipFirst
	 *            �擪�s�̗L��(true:�L false:��)
	 * @param sjisEncoding
	 *            �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 * @throws NullPointerException
	 *             �K�{���ڂ̃p�����[�^��NULL�̏ꍇ�ɃG���[������
	 */
	private void importInfo(String page, String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		if (filepath == null)
			filepath = ""; // CSV�t�@�C���p�X

		String Page = new StringBuffer().append(grnURL).append(page).toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);

		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("system", "1"); // �����`�F�b�N�p(System)
		ps.addProperty("manage", "user"); // �����`�F�b�N�pApplication��
		ps.addFile(new File(filepath), new StringBuffer().append("file")
				.toString(), "application/octet-stream");
		if (skipFirst) // �擪�s�̗L��
			ps.addProperty("skip", 1); // �擪�s�̗L
		else
			ps.addProperty("skip", 0); // �擪�s�̖�

		if (sjisEncoding == true) // �G���R�[�h
			ps.addProperty("charset", "SJIS-win");
		else
			ps.addProperty("charset", "UTF8");
            
			ps.addProperty("old", 1); // �s�GRNJAVAAPI-5�̉��C

		ps.close();

		processResult(hc, "failed to upload a CSV file.");
	}

	/**
	 * ���[�U�[�Ǘ��pCSV�t�@�C���̏����o�����s���܂��B<BR>
	 * 
	 * @param page
	 *            �y�[�W�w��
	 * @param filepath
	 *            CSV�t�@�C���p�X
	 * @param skipFirst
	 *            �擪�s�̗L��(true:�L false:��)
	 * @param sjisEncoding
	 *            �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 * @throws NullPointerException
	 *             �K�{���ڂ̃p�����[�^��NULL�̏ꍇ�ɃG���[������
	 */
	private void exportInfo(String page, String filepath, boolean skipFirst,
			boolean sjisEncoding) throws IOException, RemoteException,
			NullPointerException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		if (filepath == null)
			filepath = ""; // CSV�t�@�C���p�X

		String Page = new StringBuffer().append(grnURL).append(page).toString();
		super.setPageInfo(URI.create(Page));
		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);

		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("system", "1"); // �����`�F�b�N�p(System)
		ps.addProperty("manage", "user"); // �����`�F�b�N�pApplication��
		if (skipFirst) // �擪�s�̗L��
			ps.addProperty("title", 1); // �擪�s�̗L
		else
			ps.addProperty("title", 0); // �擪�s�̖�

		if (sjisEncoding == true) // �G���R�[�h
			ps.addProperty("charset", "SJIS-win");
		else
			ps.addProperty("charset", "UTF8");

            ps.addProperty("old", 1); // �s�GRNJAVAAPI-5�̉��C

		ps.close();

		fileWrite(hc, filepath, sjisEncoding); // ���[�U�[�Ǘ��pCSV�t�@�C���̍쐬
	}

	/**
	 * �K���[���Q �t�@�C���Ǘ���̃t�@�C��ID(���� [fileId]) �ɂ��āA<BR/> ����
	 * [items]�ŏo�͎w�肳�ꂽ���ڂ�����XML�t�@�C�����A���� [filePath] �ɏo�͂��܂��B<BR/>
	 * 
	 * @param fileId
	 *            �K���[���Q�̃t�@�C��ID
	 * @param items
	 *            �o�͍���
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * @param registrant
	 *            ���擾���s�����[�U�[�̃��O�C����. null�w��\(���擾���s�����[�U�[�̓��O�C�����[�U�ƂȂ�܂�)
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	// javadoc 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	// directoryPath + "fileinformation.xml" �� filePath
	// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	public void exportXMLCabinetFileInfo(long fileId, FileInfoProperties items,
			String filePath, String registrant) throws IOException,
			RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		// �s����C FolderInfoProperties,FileInfoProperties�g���܂킵���ꍇ�ɁA�������s�� (266)
		HashMap hm = new HashMap();
		if (items != null)
			hm.putAll(items.getParameters());

		hm.put("app", "cabinet");
		hm.put("fid", Long.toString(fileId));

		if (registrant != null)
			hm.put("registrant", registrant);

		// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
		saveResponseDataToFile(getResponseStream(
				"/coop/coopCabinet_fileinfo_exportXML", hm), filePath,
				"failed to export xmlfile of file information.");
	}

	/**
	 * �K���[���Q �t�@�C���Ǘ���̃t�@�C��ID(���� [fileId]) �ɂ��āA<BR/>
	 * �������ȊO�̃t�@�C����񍀖ڂ�����XML�t�@�C�����A���� [filePath] �ɏo�͂��܂��B<BR/>
	 * 
	 * @param fileId
	 *            �K���[���Q�̃t�@�C��ID
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * @param registrant
	 *            ���擾���s�����[�U�[�̃��O�C����. null�w��\(���擾���s�����[�U�[�̓��O�C�����[�U�ƂȂ�܂�)
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	// javadoc 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	// directoryPath + "fileinformation.xml" �� filePath
	// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	public void exportXMLCabinetFileInfo(long fileId, String filePath,
			String registrant) throws IOException, RemoteException {
		// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
		exportXMLCabinetFileInfo(fileId, new FileInfoProperties(), filePath,
				registrant);
	}

	/**
	 * �K���[���Q �t�@�C���Ǘ���̃t�H���_ID(���� [folderId]) �̃t�H���_���ɂ���t�@�C�����X�g�ɂ���<BR/> ����
	 * [items]�ŏo�͎w�肳�ꂽ���ڂ�����XML�t�@�C�����A���� [filePath] �ɏo�͂��܂��B<BR/>
	 * 
	 * @param folderId
	 *            �K���[���Q�̃t�H���_ID
	 * @param items
	 *            �o�͍���
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * @param registrant
	 *            ���擾���s�����[�U�[�̃��O�C����. null�w��\(���擾���s�����[�U�[�̓��O�C�����[�U�ƂȂ�܂�)
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	// javadoc 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	// directoryPath + "fileinformation.xml" �� filePath
	// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	public void exportXMLCabinetFileInfoFolderChild(long folderId,
			FileInfoProperties items, String filePath, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		// �s����C FolderInfoProperties,FileInfoProperties�g���܂킵���ꍇ�ɁA�������s�� (266)
		HashMap hm = new HashMap();
		if (items != null)
			hm.putAll(items.getParameters());

		hm.put("app", "cabinet");
		hm.put("hid", Long.toString(folderId));

		if (registrant != null)
			hm.put("registrant", registrant);

		// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
		saveResponseDataToFile(getResponseStream(
				"/coop/coopCabinet_fileinfo_exportXML", hm), filePath,
				"failed to export xmlfile of file information.");
	}

	/**
	 * �K���[���Q �t�@�C���Ǘ���̃t�H���_�R�[�h(���� [folderCode]) �̃t�H���_���ɂ���t�@�C�����X�g�ɂ���<BR/> ����
	 * [items]�ŏo�͎w�肳�ꂽ���ڂ�����XML�t�@�C�����A���� [filePath] �ɏo�͂��܂��B<BR/>
	 * 
	 * @param folderCode
	 *            �K���[���Q�̃t�H���_�R�[�h
	 * @param items
	 *            �o�͍���
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * @param registrant
	 *            ���擾���s�����[�U�[�̃��O�C����. null�w��\(���擾���s�����[�U�[�̓��O�C�����[�U�ƂȂ�܂�)
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	// javadoc 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	// directoryPath + "fileinformation.xml" �� filePath
	// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	public void exportXMLCabinetFileInfoFolderChild(String folderCode,
			FileInfoProperties items, String filePath, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		// �s����C FolderInfoProperties,FileInfoProperties�g���܂킵���ꍇ�ɁA�������s�� (266)
		HashMap hm = new HashMap();
		if (items != null)
			hm.putAll(items.getParameters());

		hm.put("app", "cabinet");

		if (folderCode != null)
			hm.put("foldercode", folderCode);

		if (registrant != null)
			hm.put("registrant", registrant);

		// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
		saveResponseDataToFile(getResponseStream(
				"/coop/coopCabinet_fileinfo_exportXML", hm), filePath,
				"failed to export xmlfile of file information.");
	}

	/**
	 * �K���[���Q �t�@�C���Ǘ���̃t�H���_ID(���� [folderId]) �̃t�H���_���ɂ���t�@�C�����X�g�ɂ���<BR/>
	 * �������ȊO�̃t�@�C����񍀖ڂ�����XML�t�@�C�����A���� [filePath] �ɏo�͂��܂��B<BR/>
	 * 
	 * @param folderId
	 *            �K���[���Q�̃t�H���_ID
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * @param registrant
	 *            ���擾���s�����[�U�[�̃��O�C����. null�w��\(���擾���s�����[�U�[�̓��O�C�����[�U�ƂȂ�܂�)
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	// javadoc 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	// directoryPath + "fileinformation.xml" �� filePath
	// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	public void exportXMLCabinetFileInfoFolderChild(long folderId,
			String filePath, String registrant) throws IOException,
			RemoteException {
		// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
		this.exportXMLCabinetFileInfoFolderChild(folderId,
				new FileInfoProperties(), filePath, registrant);
	}

	/**
	 * �K���[���Q �t�@�C���Ǘ���̃t�H���_�R�[�h(���� [folderCode]) �̃t�H���_���ɂ���t�@�C�����X�g�ɂ���<BR/>
	 * �������ȊO�̃t�@�C����񍀖ڂ�����XML�t�@�C�����A���� [filePath] �ɏo�͂��܂��B<BR/>
	 * 
	 * @param folderCode
	 *            �K���[���Q�̃t�H���_�R�[�h
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * @param registrant
	 *            ���擾���s�����[�U�[�̃��O�C����. null�w��\(���擾���s�����[�U�[�̓��O�C�����[�U�ƂȂ�܂�)
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	// javadoc 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	// directoryPath + "fileinformation.xml" �� filePath
	// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	public void exportXMLCabinetFileInfoFolderChild(String folderCode,
			String filePath, String registrant) throws IOException,
			RemoteException {
		// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
		this.exportXMLCabinetFileInfoFolderChild(folderCode,
				new FileInfoProperties(), filePath, registrant);
	}

	/**
	 * �K���[���Q �t�@�C���Ǘ���̃t�H���_ID(���� [folderId]) �ɂ�����t�H���_���(�����ȍ~�̃t�H���_�̏��͊܂݂܂���j�ɂ��āA<BR/>
	 * ���� [items]�ŏo�͎w�肳�ꂽ���ڂ�����XML�t�@�C�����A���� [filePath] �ɏo�͂��܂��B<BR/>
	 * 
	 * @param folderId
	 *            �K���[���Q�̃t�H���_ID
	 * @param items
	 *            �o�͍���
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * @param registrant
	 *            ���擾���s�����[�U�[�̃��O�C����. null�w��\(���擾���s�����[�U�[�̓��O�C�����[�U�ƂȂ�܂�)
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	// javadoc 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	// directoryPath + "folderinformation.xml" �� filePath
	// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	public void exportXMLCabinetFolderInfo(long folderId,
			FolderInfoProperties items, String filePath, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		// �s����C FolderInfoProperties,FileInfoProperties�g���܂킵���ꍇ�ɁA�������s�� (266)
		HashMap hm = new HashMap();
		if (items != null)
			hm.putAll(items.getParameters());

		hm.put("app", "cabinet");
		hm.put("type", "0");
		hm.put("hid", Long.toString(folderId));

		if (registrant != null)
			hm.put("registrant", registrant);

		// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
		saveResponseDataToFile(getResponseStream(
				"/coop/coopCabinet_folderinfo_exportXML", hm), filePath,
				"failed to export xmlfile of folder infomation.");
	}

	/**
	 * �K���[���Q �t�@�C���Ǘ���̃t�H���_ID(���� [folderId]) �ɂ�����t�H���_���(�����ȍ~�̃t�H���_�̏��͊܂݂܂���j�ɂ��āA<BR/>
	 * �t�H���_���ƃt�H���_�����̍��ڂ�����XML�t�@�C���� �A���� [filePath] �ɏo�͂��܂��B<BR/>
	 * 
	 * @param folderId
	 *            �K���[���Q�̃t�H���_ID
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * @param registrant
	 *            ���擾���s�����[�U�[�̃��O�C����. null�w��\(���擾���s�����[�U�[�̓��O�C�����[�U�ƂȂ�܂�)
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	// javadoc 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	// directoryPath + "folderinformation.xml" �� filePath
	// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	public void exportXMLCabinetFolderInfo(long folderId, String filePath,
			String registrant) throws IOException, RemoteException {
		FolderInfoProperties fp = new FolderInfoProperties();

		// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
		exportXMLCabinetFolderInfo(folderId, fp, filePath, registrant);
	}

	/**
	 * �K���[���Q �t�@�C���Ǘ���̃t�H���_ID(���� [folderId]) �ɂ�����t�H���_���(�����̎q�t�H���_�̏����܂ށj�ɂ��āA<BR/>
	 * ���� [items]�ŏo�͎w�肳�ꂽ���ڂ�����XML�t�@�C�����A���� [filePath] �ɏo�͂��܂��B<BR/>
	 * 
	 * @param folderId
	 *            �K���[���Q�̃t�H���_ID
	 * @param items
	 *            �o�͍���
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * @param registrant
	 *            ���擾���s�����[�U�[�̃��O�C����. null�w��\(���擾���s�����[�U�[�̓��O�C�����[�U�ƂȂ�܂�)
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	// javadoc 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	// directoryPath + "folderinformation.xml" �� filePath
	// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	public void exportXMLCabinetFolderInfo_Child(long folderId,
			FolderInfoProperties items, String filePath, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		// �s����C FolderInfoProperties,FileInfoProperties�g���܂킵���ꍇ�ɁA�������s�� (266)
		HashMap hm = new HashMap();
		if (items != null)
			hm.putAll(items.getParameters());

		hm.put("app", "cabinet");
		hm.put("type", "1");
		hm.put("hid", Long.toString(folderId));

		if (registrant != null)
			hm.put("registrant", registrant);

		// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
		saveResponseDataToFile(getResponseStream(
				"/coop/coopCabinet_folderinfo_exportXML", hm), filePath,
				"failed to export xmlfile of folder infomation.");
	}

	/**
	 * �K���[���Q �t�@�C���Ǘ���̃t�H���_ID(���� [folderId]) �ɂ�����t�H���_���(�����̎q�t�H���_�̏����܂ށj�ɂ��āA<BR/>
	 * �t�H���_���ƃt�H���_�����̍��ڂ�����XML�t�@�C���� �A���� [filePath] �ɏo�͂��܂��B<BR/>
	 * 
	 * @param folderId
	 *            �K���[���Q�̃t�H���_ID
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * @param registrant
	 *            ���擾���s�����[�U�[�̃��O�C����. null�w��\(���擾���s�����[�U�[�̓��O�C�����[�U�ƂȂ�܂�)
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	// javadoc 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	// directoryPath + "folderinformation.xml" �� filePath
	// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	public void exportXMLCabinetFolderInfo_Child(long folderId,
			String filePath, String registrant) throws IOException,
			RemoteException {
		FolderInfoProperties fp = new FolderInfoProperties();

		// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
		exportXMLCabinetFolderInfo_Child(folderId, fp, filePath, registrant);
	}

	/**
	 * �K���[���Q �t�@�C���Ǘ���̃t�H���_ID(���� [folderId]) �ɂ�����t�H���_���(Tree�\���j�ɂ��āA<BR/> ����
	 * [items]�ŏo�͎w�肳�ꂽ���ڂ�����XML�t�@�C�����A���� [filePath] �ɏo�͂��܂��B<BR/>
	 * 
	 * @param folderId
	 *            �K���[���Q�̃t�H���_ID
	 * @param items
	 *            �o�͍���
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * @param registrant
	 *            ���擾���s�����[�U�[�̃��O�C����. null�w��\(���擾���s�����[�U�[�̓��O�C�����[�U�ƂȂ�܂�)
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	// javadoc 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	// directoryPath + "folderinformation.xml" �� filePath
	// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	public void exportXMLCabinetFolderInfo_Tree(long folderId,
			FolderInfoProperties items, String filePath, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		// �s����C FolderInfoProperties,FileInfoProperties�g���܂킵���ꍇ�ɁA�������s�� (266)
		HashMap hm = new HashMap();
		if (items != null)
			hm.putAll(items.getParameters());

		hm.put("app", "cabinet");
		hm.put("type", "2");
		hm.put("hid", Long.toString(folderId));

		if (registrant != null)
			hm.put("registrant", registrant);

		// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
		saveResponseDataToFile(getResponseStream(
				"/coop/coopCabinet_folderinfo_exportXML", hm), filePath,
				"failed to export xmlfile of folder infomation.");
	}

	/**
	 * �K���[���Q �t�@�C���Ǘ���̃t�H���_ID(���� [folderId]) �ɂ�����t�H���_���(Tree�\���j�ɂ��āA<BR/>
	 * �t�H���_���ƃt�H���_�����̍��ڂ�����XML�t�@�C���� �A���� [filePath] �ɏo�͂��܂��B<BR/>
	 * 
	 * @param folderId
	 *            �K���[���Q�̃t�H���_ID
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * @param registrant
	 *            ���擾���s�����[�U�[�̃��O�C����. null�w��\(���擾���s�����[�U�[�̓��O�C�����[�U�ƂȂ�܂�)
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	// javadoc 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	// directoryPath + "folderinformation.xml" �� filePath
	// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	public void exportXMLCabinetFolderInfo_Tree(long folderId, String filePath,
			String registrant) throws IOException, RemoteException {
		FolderInfoProperties fp = new FolderInfoProperties();

		// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
		exportXMLCabinetFolderInfo_Tree(folderId, fp, filePath, registrant);
	}

	/**
	 * �K���[���Q �t�@�C���Ǘ���̃t�H���_�R�[�h(���� [folderCode])
	 * �ɂ�����t�H���_���(�����ȍ~�̃t�H���_�̏��͊܂݂܂���j�ɂ��āA<BR/> ����
	 * [items]�ŏo�͎w�肳�ꂽ���ڂ�����XML�t�@�C�����A���� [filePath] �ɏo�͂��܂��B<BR/>
	 * 
	 * @param folderCode
	 *            �K���[���Q�̃t�H���_�R�[�h
	 * @param items
	 *            �o�͍���
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * @param registrant
	 *            ���擾���s�����[�U�[�̃��O�C����. null�w��\(���擾���s�����[�U�[�̓��O�C�����[�U�ƂȂ�܂�)
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	// javadoc 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	// directoryPath + "folderinformation.xml" �� filePath
	// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	public void exportXMLCabinetFolderInfo(String folderCode,
			FolderInfoProperties items, String filePath, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		// �s����C FolderInfoProperties,FileInfoProperties�g���܂킵���ꍇ�ɁA�������s�� (266)
		HashMap hm = new HashMap();
		if (items != null)
			hm.putAll(items.getParameters());

		hm.put("app", "cabinet");
		hm.put("type", "0");
		hm.put("foldercode", folderCode);

		if (registrant != null)
			hm.put("registrant", registrant);

		// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
		saveResponseDataToFile(getResponseStream(
				"/coop/coopCabinet_folderinfo_exportXML", hm), filePath,
				"failed to export xmlfile of folder infomation.");
	}

	/**
	 * �K���[���Q �t�@�C���Ǘ���̃t�H���_�R�[�h(���� [folderCode])
	 * �ɂ�����t�H���_���(�����ȍ~�̃t�H���_�̏��͊܂݂܂���j�ɂ��āA<BR/> �t�H���_���ƃt�H���_�����̍��ڂ�����XML�t�@�C���� �A����
	 * [filePath] �ɏo�͂��܂��B<BR/>
	 * 
	 * @param folderCode
	 *            �K���[���Q�̃t�H���_�R�[�h
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * @param registrant
	 *            ���擾���s�����[�U�[�̃��O�C����. null�w��\(���擾���s�����[�U�[�̓��O�C�����[�U�ƂȂ�܂�)
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	// javadoc 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	// directoryPath + "folderinformation.xml" �� filePath
	// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	public void exportXMLCabinetFolderInfo(String folderCode, String filePath,
			String registrant) throws IOException, RemoteException {
		FolderInfoProperties fp = new FolderInfoProperties();

		// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
		exportXMLCabinetFolderInfo(folderCode, fp, filePath, registrant);
	}

	/**
	 * �K���[���Q �t�@�C���Ǘ���̃t�H���_�R�[�h(���� [folderCode]) �ɂ�����t�H���_���(�����̎q�t�H���_�̏����܂ށj�ɂ��āA<BR/>
	 * ���� [items]�ŏo�͎w�肳�ꂽ���ڂ�����XML�t�@�C�����A���� [filePath] �ɏo�͂��܂��B<BR/>
	 * 
	 * @param folderCode
	 *            �K���[���Q�̃t�H���_�R�[�h
	 * @param items
	 *            �o�͍���
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * @param registrant
	 *            ���擾���s�����[�U�[�̃��O�C����. null�w��\(���擾���s�����[�U�[�̓��O�C�����[�U�ƂȂ�܂�)
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	// javadoc 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	// directoryPath + "folderinformation.xml" �� filePath
	// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	public void exportXMLCabinetFolderInfo_Child(String folderCode,
			FolderInfoProperties items, String filePath, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		// �s����C FolderInfoProperties,FileInfoProperties�g���܂킵���ꍇ�ɁA�������s�� (266)
		HashMap hm = new HashMap();
		if (items != null)
			hm.putAll(items.getParameters());

		hm.put("app", "cabinet");
		hm.put("type", "1");
		hm.put("foldercode", folderCode);

		if (registrant != null)
			hm.put("registrant", registrant);

		// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
		saveResponseDataToFile(getResponseStream(
				"/coop/coopCabinet_folderinfo_exportXML", hm), filePath,
				"failed to export xmlfile of folder infomation.");
	}

	/**
	 * �K���[���Q �t�@�C���Ǘ���̃t�H���_�R�[�h(���� [folderCode]) �ɂ�����t�H���_���(�����̎q�t�H���_�̏����܂ށj�ɂ��āA<BR/>
	 * �t�H���_���ƃt�H���_�����̍��ڂ�����XML�t�@�C���� �A���� [filePath] �ɏo�͂��܂��B<BR/>
	 * 
	 * @param folderCode
	 *            �K���[���Q�̃t�H���_�R�[�h
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * @param registrant
	 *            ���擾���s�����[�U�[�̃��O�C����. null�w��\(���擾���s�����[�U�[�̓��O�C�����[�U�ƂȂ�܂�)
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	// javadoc 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	// directoryPath + "folderinformation.xml" �� filePath
	// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	public void exportXMLCabinetFolderInfo_Child(String folderCode,
			String filePath, String registrant) throws IOException,
			RemoteException {
		FolderInfoProperties fp = new FolderInfoProperties();

		// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
		exportXMLCabinetFolderInfo_Child(folderCode, fp, filePath, registrant);
	}

	/**
	 * �K���[���Q �t�@�C���Ǘ���̃t�H���_�R�[�h(���� [folderCode]) �ɂ�����t�H���_���(Tree�\���j�ɂ��āA<BR/> ����
	 * [items]�ŏo�͎w�肳�ꂽ���ڂ�����XML�t�@�C�����A���� [filePath] �ɏo�͂��܂��B<BR/>
	 * 
	 * @param folderCode
	 *            �K���[���Q�̃t�H���_�R�[�h
	 * @param items
	 *            �o�͍���
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * @param registrant
	 *            ���擾���s�����[�U�[�̃��O�C����. null�w��\(���擾���s�����[�U�[�̓��O�C�����[�U�ƂȂ�܂�)
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	// javadoc 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	// directoryPath + "folderinformation.xml" �� filePath
	// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	public void exportXMLCabinetFolderInfo_Tree(String folderCode,
			FolderInfoProperties items, String filePath, String registrant)
			throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		// �s����C FolderInfoProperties,FileInfoProperties�g���܂킵���ꍇ�ɁA�������s�� (266)
		HashMap hm = new HashMap();
		if (items != null)
			hm.putAll(items.getParameters());

		hm.put("app", "cabinet");
		hm.put("type", "2");
		hm.put("foldercode", folderCode);

		if (registrant != null)
			hm.put("registrant", registrant);

		// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
		saveResponseDataToFile(getResponseStream(
				"/coop/coopCabinet_folderinfo_exportXML", hm), filePath,
				"failed to export xmlfile of folder infomation.");
	}

	/**
	 * �K���[���Q �t�@�C���Ǘ���̃t�H���_�R�[�h(���� [folderCode]) �ɂ�����t�H���_���(Tree�\���j�ɂ��āA<BR/>
	 * �t�H���_���ƃt�H���_�����̍��ڂ�����XML�t�@�C���� �A���� [filePath] �ɏo�͂��܂��B<BR/>
	 * 
	 * @param folderCode
	 *            �K���[���Q�̃t�H���_�R�[�h
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * @param registrant
	 *            ���擾���s�����[�U�[�̃��O�C����. null�w��\(���擾���s�����[�U�[�̓��O�C�����[�U�ƂȂ�܂�)
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	// javadoc 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	// directoryPath + "folderinformation.xml" �� filePath
	// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
	public void exportXMLCabinetFolderInfo_Tree(String folderCode,
			String filePath, String registrant) throws IOException,
			RemoteException {
		FolderInfoProperties fp = new FolderInfoProperties();

		// 2007/04/20 XML���o������dirpath��filepath�ɂ��āA�ۑ�����I���\�ɂȂ�ׂ�(233)
		exportXMLCabinetFolderInfo_Tree(folderCode, fp, filePath, registrant);
	}

	/**
	 * ���� [attachedFileId]�̓Y�t�t�@�C�����K���[���Q ���[�N�t���[���_�E�����[�h���A<BR>
	 * ���� ���� [directoryPath]�̃f�B���N�g�� �ɁA���� [fileName] �̃t�@�C�����ŕۑ����܂��B<BR>
	 * 
	 * @param attachedFileId
	 *            �K���[���Q ���[�N�t���[�̓Y�t�t�@�C��ID
	 * @param directoryPath
	 *            �t�@�C����ۑ�����f�B���N�g���p�X.null�w��\(�J�����g�f�B���N�g���ɕۑ����܂��B�j
	 * @param fileName
	 *            �t�@�C����ۑ�����t�@�C����.null�w��\(�K���[���Q ���[�N�t���[�ɓo�^����Ă���Y�t�t�@�C�����ŕۑ����܂��B)
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	public void downloadSystemWorkFlowAttachedFile(long attachedFileId,
			String directoryPath, String fileName) throws IOException,
			RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		SystemWorkFlow workFlow = new SystemWorkFlow(this);
		workFlow.downloadSystemFile(attachedFileId, directoryPath, fileName);
	}

	/**
	 * ���� [attachedFileId]�̓Y�t�t�@�C�����K���[���Q ���[�N�t���[���_�E�����[�h���A<BR>
	 * ���� ���� [directoryPath]�̃f�B���N�g�� �ɁA���� [fileName] �̃t�@�C�����ŕۑ����܂��B<BR>
	 * 
	 * @param attachedFileId
	 *            �K���[���Q ���[�N�t���[�̓Y�t�t�@�C��ID
	 * @param directoryPath
	 *            �t�@�C����ۑ�����f�B���N�g���p�X.null�w��\(�J�����g�f�B���N�g���ɕۑ����܂��B�j
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 */
	public void downloadSystemWorkFlowAttachedFile(long attachedFileId,
			String directoryPath) throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		SystemWorkFlow workFlow = new SystemWorkFlow(this);
		workFlow.downloadSystemFile(attachedFileId, directoryPath);
	}

	/**
	 * �K���[���Q ���[�N�t���[��̐\���f�[�^ID(���� [petitionId]) �ɂ��āA ����
	 * [items]�ŏo�͎w�肳�ꂽ���ڂ�����XML�t�@�C���� ���� [filePath] �ɏo�͂��܂��B
	 * 
	 * @param petitionId
	 *            ���[�N�t���[�̐\��ID
	 * @param items
	 *            �o�͍���
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q��ŃG���[�����������ꍇ
	 */
	public void exportXMLSystemWorkFlowPetitionData(long petitionId,
			WorkFlowdataItemProperties items, String filePath)
			throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		new SystemWorkFlow(this).exportXMLPetitionData(petitionId, items,
				filePath);
	}

	/**
	 * �K���[���Q ���[�N�t���[��̐\���f�[�^ID(���� [petitionId]) �ɂ��āA �o�H���ȊO�̍��ڂ�����XML�t�@�C���� ����
	 * [filePath] �ɏo�͂��܂��B
	 * 
	 * @param petitionId
	 *            ���[�N�t���[�̐\��ID
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q��ŃG���[�����������ꍇ
	 */
	public void exportXMLSystemWorkFlowPetitionData(long petitionId,
			String filePath) throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		new SystemWorkFlow(this).exportXMLPetitionData(petitionId, filePath);
	}

	/**
	 * �K���[���Q ���[�N�t���[��̐\���t�H�[��ID(���� [formId]) ���ɂ����āA
	 * ����[selectProperties]�Ŏw�肳��钊�o�����ɍ��v����\���f�[�^�̈ꗗ�ɂ��āA ����
	 * [items]�ŏo�͎w�肳�ꂽ���ڂ�����XML�t�@�C���� ���� [filePath] �ɏo�͂��܂��B
	 * 
	 * @param formId
	 *            ���[�N�t���[�̐\���t�H�[��ID
	 * @param selectProperties
	 *            ���o����
	 * @param items
	 *            �o�͍���
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q��ŃG���[�����������ꍇ
	 */
	public void exportXMLSystemWorkFlowFormPetitionData(long formId,
			WorkFlowdataSelectProperties selectProperties,
			WorkFlowdataItemProperties items, String filePath)
			throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		new SystemWorkFlow(this).exportXMLFormPetitionData(formId,
				selectProperties, items, filePath);

	}

	/**
	 * �K���[���Q ���[�N�t���[��̐\���t�H�[��ID(���� [formId]) ���ɂ����āA
	 * ����[selectProperties]�Ŏw�肳��钊�o�����ɍ��v����\���f�[�^�̈ꗗ�ɂ��āA �o�H���ȊO�̍��ڂ�����XML�t�@�C���� ����
	 * [filePath] �ɏo�͂��܂��B
	 * 
	 * @param formId
	 *            ���[�N�t���[�̐\���t�H�[��ID
	 * @param selectProperties
	 *            ���o����
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q��ŃG���[�����������ꍇ
	 */
	public void exportXMLSystemWorkFlowFormPetitionData(long formId,
			WorkFlowdataSelectProperties selectProperties, String filePath)
			throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		new SystemWorkFlow(this).exportXMLFormPetitionData(formId,
				selectProperties, filePath);

	}

	/**
	 * �K���[���Q ���[�N�t���[��̐\���t�H�[���R�[�h(���� [formCode]) ���ɂ����āA
	 * ����[selectProperties]�Ŏw�肳��钊�o�����ɍ��v����\���f�[�^�̈ꗗ�ɂ��āA ����
	 * [items]�ŏo�͎w�肳�ꂽ���ڂ�����XML�t�@�C���� ���� [filePath] �ɏo�͂��܂��B
	 * 
	 * @param formCode
	 *            ���[�N�t���[�̐\���t�H�[���R�[�h
	 * @param selectProperties
	 *            ���o����
	 * @param items
	 *            �o�͍���
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q��ŃG���[�����������ꍇ
	 */
	public void exportXMLSystemWorkFlowFormPetitionData(String formCode,
			WorkFlowdataSelectProperties selectProperties,
			WorkFlowdataItemProperties items, String filePath)
			throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		new SystemWorkFlow(this).exportXMLFormPetitionData(formCode,
				selectProperties, items, filePath);

	}

	/**
	 * �K���[���Q ���[�N�t���[��̐\���t�H�[���R�[�h(���� [formCode]) ���ɂ����āA
	 * ����[selectProperties]�Ŏw�肳��钊�o�����ɍ��v����\���f�[�^�̈ꗗ�ɂ��āA �o�H���ȊO�̍��ڂ�����XML�t�@�C��������
	 * [filePath] �ɏo�͂��܂��B
	 * 
	 * @param formCode
	 *            ���[�N�t���[�̐\���t�H�[���R�[�h
	 * @param selectProperties
	 *            ���o����
	 * @param filePath
	 *            XML�t�@�C���p�X
	 * 
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q��ŃG���[�����������ꍇ
	 */
	public void exportXMLSystemWorkFlowFormPetitionData(String formCode,
			WorkFlowdataSelectProperties selectProperties, String filePath)
			throws IOException, RemoteException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		new SystemWorkFlow(this).exportXMLFormPetitionData(formCode,
				selectProperties, filePath);

	}

	/**
	 * ����[hc] ���擾�������X�|���X�f�[�^���t�@�C���ɏo�͂��܂��B
	 * 
	 * @param filepath
	 *            �t�@�C���p�X
	 * @param RemoteExceptionMessage
	 *            RemoteException �������̃��b�Z�[�W
	 * @throws IOException
	 * @throws RemoteException
	 */
	private void saveResponseDataToFile(java.net.HttpURLConnection hc,
			String filePath, String RemoteExceptionMessage) throws IOException,
			RemoteException {
		// �N�b�L�[�̍X�V
		super.processHeader(hc);

		// �G���[�`�F�b�N
		checkErrorHeader(hc, RemoteExceptionMessage);

		new Utils().writeBynaryFile(hc.getInputStream(), filePath);
	}

	/**
	 * ����[hc] ���擾�������X�|���X�f�[�^���t�@�C���ɏo�͂��܂��B
	 * 
	 * @param hc
	 * @param directoryPath
	 *            �f�B���N�g���p�X(null�̏ꍇ�́A�J�����g�f�B���N�g���ɏ��o���܂�)
	 * @param fileName
	 *            �t�@�C����
	 * @param RemoteExceptionMessage
	 *            RemoteException �������̃��b�Z�[�W
	 * @throws IOException
	 * @throws RemoteException
	 */
	private void saveResponseDataToFile(java.net.HttpURLConnection hc,
			String directoryPath, String fileName, String RemoteExceptionMessage)
			throws IOException, RemoteException {
		// �N�b�L�[�̍X�V
		super.processHeader(hc);

		// �G���[�`�F�b�N
		checkErrorHeader(hc, RemoteExceptionMessage);

		new Utils().writeBynaryFile(hc.getInputStream(), directoryPath,
				fileName);
	}

	/**
	 * grnURL + ����[page] �փ��N�G�X�g���΂�(�}���`�p�[�g��POST���܂�)�AHttpURLConnection��Ԃ��܂�
	 * 
	 * 
	 * @param page
	 *            grnURL�ȍ~�̃��N�G�X�g�y�[�W�� ( ex. /coop/coopCabinetAdd)
	 * @param hm
	 *            ���N�G�X�g�p�����[�^�Q
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
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);
		new Utils().postParamaters(ps, hm);
		ps.close();

		return hc;

	}

	/*
	 * (�� Javadoc)
	 * 
	 * @see jp.co.cybozu.garoon2.util.GrnConnector#getResponseStream()
	 */
	public InputStream getResponseStream(String page, HashMap parameters,
			String remoteExceptionMessage) throws IOException, RemoteException {
		java.net.HttpURLConnection hc = getResponseStream(page, parameters);

		// �N�b�L�[�̍X�V
		super.processHeader(hc);

		// �G���[�`�F�b�N
		checkErrorHeader(hc, remoteExceptionMessage);

		return hc.getInputStream();
	}

	/**
	 * ���[�U�[ID�ƃ��O�C�����̃��X�g���擾���܂��B
	 * 
	 * @return ���[�U�[ID(Long)���L�[,���O�C����(String)���l��TreeMap
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q��ŃG���[�����������ꍇ
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
	 * �g�DID�Ƒg�D�R�[�h�̃��X�g���擾���܂��B
	 * 
	 * @return �g�DID(Long)���L�[,�g�D�R�[�h(String)���l��TreeMap
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q��ŃG���[�����������ꍇ
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
	 * �X�g���[������͂���TreeMap��Ԃ��܂��B
	 * 
	 * @param in
	 *            ��͑Ώۂ̃X�g���[��(1�s��[ID],[�Ή�����l]��CSV�`���̃X�g���[��)
	 * @return ��͌��ʂ�TreeMap(key��ID,value���R�[�h���͂���ɏ�����l)
	 * @throws RemoteException
	 *             ��͕s�\��
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
			// ��͕s�\��
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
	 * �A�v���P�[�V�����pCSV�t�@�C���̏����o�����s���܂��B<BR>
	 * 
	 * @param page
	 *            �y�[�W�w��
	 * @param filepath
	 *            CSV�t�@�C���p�X
	 * @param skipFirst
	 *            �擪�s�̗L��(true:�L false:��)
	 * @param sjisEncoding
	 *            �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
	 * @param appName
	 *            �A�v���P�[�V�������W���[����
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 * @throws NullPointerException
	 *             �K�{���ڂ̃p�����[�^��NULL�̏ꍇ�ɃG���[������
	 */
	private void exportInfoApp(String page, String filepath, boolean skipFirst,
			boolean sjisEncoding, String appName) throws IOException,
			RemoteException, NullPointerException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		if (filepath == null)
			filepath = ""; // CSV�t�@�C���p�X

		String Page = new StringBuffer().append(grnURL).append(page).toString();
		super.setPageInfo(URI.create(Page));
		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);

		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("system", "2"); // �����`�F�b�N�p(System)
		ps.addProperty("manage", appName); // �����`�F�b�N�pApplication��
		if (skipFirst) // �擪�s�̗L��
			ps.addProperty("item_name", 1); // �擪�s�̗L
		else
			ps.addProperty("item_name", 0); // �擪�s�̖�

		if (sjisEncoding == true) // �G���R�[�h
			ps.addProperty("charset", "SJIS-win");
		else
			ps.addProperty("charset", "UTF8");
		ps.close();

		fileWrite(hc, filepath, sjisEncoding); // ���[�U�[�Ǘ��pCSV�t�@�C���̍쐬
	}

	/**
	 * �A�v���P�[�V�����pCSV�t�@�C���̓ǂݍ��݂��s���܂��B<BR>
	 * 
	 * @param page
	 *            �y�[�W�w��
	 * @param filepath
	 *            CSV�t�@�C���p�X
	 * @param skipFirst
	 *            �擪�s�̗L��(true:�L false:��)
	 * @param sjisEncoding
	 *            �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
	 * @param appName
	 *            �A�v���P�[�V�������W���[����
	 * @throws IOException
	 *             �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
	 * @throws RemoteException
	 *             �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
	 * @throws NullPointerException
	 *             �K�{���ڂ̃p�����[�^��NULL�̏ꍇ�ɃG���[������
	 */
	private void importInfoApp(String page, String filepath, boolean skipFirst,
			boolean sjisEncoding, String appName) throws IOException,
			RemoteException, NullPointerException {
		// 2007/05/09 �d�l�ύX
		this.login(loginUser, loginPassword);

		if (filepath == null)
			filepath = ""; // CSV�t�@�C���p�X

		String Page = new StringBuffer().append(grnURL).append(page).toString();
		super.setPageInfo(URI.create(Page));

		java.net.HttpURLConnection hc = getConnection(HttpClient.POST);

		PostStream ps = getMultipartStream(hc);
		// 2008/01/15 csrf �Ή�
		if (this.csrfTicket != null)
			ps.addProperty("csrf_ticket", this.csrfTicket);

		ps.addProperty("system", "2"); // �����`�F�b�N�p(System)
		ps.addProperty("manage", appName); // �����`�F�b�N�pApplication��
		ps.addFile(new File(filepath), new StringBuffer().append("file")
				.toString(), "application/octet-stream");
		if (skipFirst) // �擪�s�̗L��
			ps.addProperty("skip", 1); // �擪�s�̗L
		else
			ps.addProperty("skip", 0); // �擪�s�̖�

		if (sjisEncoding == true) // �G���R�[�h
			ps.addProperty("charset", "SJIS-win");
		else
			ps.addProperty("charset", "UTF8");
		ps.close();

		processResult(hc, "failed to upload a CSV file.");
	}
	
	/**
     * �X�P�W���[���F�A�N�Z�X��CSV�t�@�C���ւ̏����o�����s���܂��B<BR>
     * 
     * @param filepath CSV�t�@�C���p�X
     * @param skipFirst �擪�s�̗L��(true:�L false:��)
     * @param sjisEncoding �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
     * @throws IOException �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
     * @throws RemoteException �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
     * @throws NullPointerException �K�{���ڂ̃p�����[�^��NULL�̏ꍇ�ɃG���[������
     */
    public void exportScheduleAccess( String filepath, boolean skipFirst, boolean sjisEncoding )
    throws IOException, RemoteException, NullPointerException
    {
        String Page = "/coop/scheduleAccess_export";
        exportInfoApp( Page,  filepath,  skipFirst,  sjisEncoding , "schedule");
    }

    /**
     * �X�P�W���[���F�A�N�Z�X��CSV�t�@�C���̓ǂݍ��݂��s���܂��B<BR>
     * 
     * @param filepath CSV�t�@�C���p�X
     * @param skipFirst �擪�s�̗L��(true:�L false:��)
     * @param sjisEncoding �t�@�C���̃G���R�[�h�w��(true:Shif_JIS,false:UTF-8)
     * @throws IOException �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
     * @throws RemoteException �K���[���Q�A�g�p�v���O������ŃG���[�����������ꍇ
     * @throws NullPointerException �K�{���ڂ̃p�����[�^��NULL�̏ꍇ�ɃG���[������
     */
    public void importScheduleAccess( String filepath, boolean skipFirst, boolean sjisEncoding )
    throws IOException, RemoteException, NullPointerException
    {
        String Page = "/coop/scheduleAccess_import";
        importInfoApp(  Page,  filepath,  skipFirst,  sjisEncoding , "schedule");

    }

}
