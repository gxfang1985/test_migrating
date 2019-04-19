/* LdapConfig.java */
package jp.co.cybozu.garoon2;

import jp.co.cybozu.text.*;
import jp.co.cybozu.ldap.DN;
import java.util.*;
import java.io.*;

/**
 * LDAP からユーザー、所属情報を取り出してガルーンの CSV 形式のデータに変換するための、各種プロパティを保持する。
 * プロパティは {@link Properties} オブジェクトによって渡されるか、{@link ConfigParser#load} で読み込める形式のデータをインプットストリームから 読み込むか、あるいは個別にこのクラス内のメソッドを使用して与えられる。
 * <br> 
 * 有効なプロパティは以下の表で示される。
 * 表中、「要定義」とある場合、その プロパティは必ず定義されていなければならない。
 * 「必須」とある場合、その プロパティは必ず定義されていなければならず、さらに定義された値の属性 (attribute)を組織あるいはユーザーのエントリが持っていなければならない。
 * どちらも指定されていなければ、そのプロパティはオプションである。 
 * <br>
 * <TABLE BORDER="1" CELLPADDING="3" CELLSPACING="0" WIDTH="100%">
 * <TR BGCOLOR="#CCCCFF" CLASS="TableHeadingColor">
 * <TD align="center"><FONT SIZE="+1">
 * <B>設定名</B>
 * </FONT>
 * </TD>
 * <TD align="center"><FONT SIZE="+1">
 * <B>解説</B>
 * </FONT>
 * </TD>
 * </TR>
 * <tr>
 * <td>ldapURL</td>
 * <td>Ldapサーバーのアドレスを指定します。<br>
 * 例) ldap://localhost:389/</td>
 * </tr>
 *
 * <tr>
 * <td>userDN (or userDN1, userDN2, ...)</td>
 * <td>ユーザーのエントリを検索する、基点となるエントリの DN
 * を指定します。複数指定する場合、"userDN1", "userDN2",
 * "userDN3", ... のように、後に数値を付加して指定します。<br><br>
 * 少くとも一つを指定しなければなりません。<br>
 * 【注意】エントリの値の先頭に"#"がある場合,DNは正しく解釈されません。<br>
 * 例) ou=Users,dc=demo,dc=local</td>
 * </tr>
 *
 * <tr>
 * <td>userFilter</td>
 * <td>ユーザーのエントリを検索するための、検索フィルターを指
 * 定します。RFC2254 で規定された形式で指定します。<br><br>
 * 必須設定です。</td>
 * </tr>
 *
 * <tr>
 * <td>account</td>
 * <td>ユーザーのログイン名に変換する属性名を指定します。<br><br>
 * 必須設定です。<br>
 * 例) sAMAccountName</td>
 * </tr>
 *
 * <tr>
 * <td>name</td>
 * <td>ユーザーの名前に変換する属性名を指定します。<br><br>
 * 必須設定です。<br>
 * 例) displayname</td>
 * </tr>
 *
 * <tr>
 * <td>newaccount</td>
 * <td>ユーザーの新ログイン名用のフィールドです。<br><br>
 * 設定する場合は"account"と同じフィールドを指定してください。<br>
 * 何も設定しなかった場合、csvの該当フィールドには*を設定します。</td>
 * </tr>
 *
 * <tr>
 * <td>password</td>
 * <td>ユーザーの平文パスワードに変換する属性名を指定します。<br>
 * 何も設定しなかった場合、csvの該当フィールドには*を設定します。<br>
 * 【注意】大抵のLDAPサーバーにおいて、パスワードは取り出せません。</td>
 * </tr>
 *
 * <tr>
 * <td>priority</td>
 * <td>ユーザーの表示優先度用のフィールドです。<br>
 * 何も設定しなかった場合、csvの該当フィールドには*を設定します。</td>
 * </tr>
 *
 * <tr>
 * <td>state<br>stateUse</td>
 * <td>ユーザーの使用/停止用のフィールドです。<br>
 * (1:使用 /0:停止)<br>
 * LDAPのアカウントが有効の場合は、1:使用が設定され、それ
 * 以外の場合は、0:停止が設定されます。<br>
 * この項目を出力する場合は、stateには無効化フラグが設定される属性名を
 * 指定し、stateUseにはそのフラグ値を指定します。<br>
 * 例) userAccountControl(514)</td>
 * </tr>
 *
 * <tr>
 * <td>delete</td>
 * <td>
 * ユーザーの削除フラグ用のフィールドです。<br>
 * 1：削除<br>
 * 0,空白：削除でない<br>
 * 何も設定しなかった場合、csvの該当フィールドには*を設定します。<br>
 * 上記以外の値の場合、ユーザー情報のガルーン送信時にエラーになり、<br>
 * 登録がおこなわれません。
 * </td>
 * </tr>
 *
 * <tr>
 * <td>phonetic</td>
 * <td>ユーザーのよみ用のフィールドです。<br>
 * 何も設定しなかった場合、csvの該当フィールドには*を設定します。</td>
 * </tr>
 *
 * <tr>
 * <td>mail</td>
 * <td>ユーザーのE-mail用のフィールドです。<br>
 * 何も設定しなかった場合、csvの該当フィールドには*を設定します。</td>
 * </tr>
 *
 * <tr>
 * <td>description</td>
 * <td>ユーザーのメモ用のフィールドです。<br>
 * 何も設定しなかった場合、csvの該当フィールドには*を設定します。</td>
 * </tr>
 *
 * <tr>
 * <td>executive</td>
 * <td>ユーザーの役職用のフィールドです。<br>
 * 何も設定しなかった場合、csvの該当フィールドには*を設定します。</td>
 * </tr>
 *
 * <tr>
 * <td>contact</td>
 * <td>ユーザーの連絡先用のフィールドです。<br>
 * 何も設定しなかった場合、csvの該当フィールドには*を設定します。</td>
 * </tr>
 *
 * <tr>
 * <td>url</td>
 * <td>ユーザーのURL用のフィールドです。<br>
 * 何も設定しなかった場合、csvの該当フィールドには*を設定します。</td>
 * </tr>
 *
 * <tr>
 * <td>userInfo1<br>userInfo2<br>userInfo3</td>
 * <td>ユーザーの拡張フィールド用です。<br>
 * 下記項目のコメントアウトを外すことで、CSVフィールドを追加できます。<br>
 * (最大3つ)</td>
 * </td>
 * </tr>
 *
 * <tr>
 * <td>belongCode</td>
 * <td>ユーザー所属組織の組織コードに変換する属性名を指定します。<br>
 * その属性に格納された文字列のうち、「,」を区切り文字として判断します。</td>
 * </td>
 * </tr>
 * </table>
 *
 * @author サイボウズ
 * @version	1.0.0
 * @see		LdapToCSV
 * @see		ConfigParser
 */
public class LdapConfig
{
    // configurators
    /**
     * Holds configuration properties.
     */
    private final Properties config;
    private static final String DEFAULT_ENCODING = "JISAutoDetect";

    // property keys
    private final String propLDAPURL = "ldapURL";					// 
    private final String propUserDN = "userDN";					// 
    private final String propUserFilter = "userFilter";			// 
    private final String propOrgDN = "orgDN";						// 
    private final String propOrgFilter = "orgFilter";				// 
    private final String propStateUse = "stateUse";				// 

	private final String propAccount = "account";					// ユーザー情報(ログイン名)
	private final String propName = "name";						// ユーザー情報(名前)
	private final String propNewAccount = "newaccount";			// ユーザー情報(新ログイン名)
	private final String propPassword = "password";				// ユーザー情報(パスワード)
	private final String propPriority = "priority";				// ユーザー情報(表示優先度)
	private final String propState = "state";						// ユーザー情報(使用/停止)
	private final String propDelete = "delete";					// ユーザー情報(削除フラグ)
	private final String propPhonetic = "phonetic";				// ユーザー情報(よみ)
	private final String propMail = "mail";						// ユーザー情報(E-mail)
	private final String propDescription = "description";			// ユーザー情報(メモ)
	private final String propExecutive = "executive";				// ユーザー情報(役職)
	private final String propContact = "contact";					// ユーザー情報(連絡先)
	private final String propURL = "url";							// ユーザー情報(URL)
	private final String propUserInfo1 = "userInfo1";				// ユーザー情報(予備１)		
	private final String propUserInfo2 = "userInfo2";				// ユーザー情報(予備２)		
	private final String propUserInfo3 = "userInfo3";				// ユーザー情報(予備３)		
	
	private final String propBelongAccount = "belongAccount";		// ユーザー所属組織情報(ログイン名)
	private final String propBelongCode = "belongCode";			// ユーザー所属組織情報(組織コード)

    private final String propMemberDN = "memberDN";				// 
    private final String propMemberURL = "memberURL";				// 

    /**
     * プロパティをひとつも持たない設定オブジェクトを作成する。
     */
    public LdapConfig ()
    {
    	config = new Properties();
    }

    /**
     * <var>config</var> にて定義されるプロパティを持つ設定オブジェクトを 作成する。
     *
     * @param config プロパティ
     */
    public LdapConfig (Properties config)
    {
    	this.config = config;
    }

    /**
     * <var>configIn</var> からプロパティを読み込み、それらを持つ設定 オブジェクトを作成する。
     *
     * @param configIn {@link ConfigParser#load} が読み込みに使用する インプットストリーム
     * @throws IOException IOエラーが発生した
     * @throws ParseException 読み込む内容のパースに失敗した
     * @see ConfigParser describes the configuration file format.
     */
    public LdapConfig ( InputStream configIn )
	throws IOException, ParseException
    {
    	ConfigParser cp = new ConfigParser( configIn );
    	config = cp.getProperties();
    }

    /**
     * "ldapURL" プロパティを定義する。
     *
     * @param ldapURL 値
     */
    public void setLdapURL (String ldapURL)
    {
    	config.setProperty(propLDAPURL, ldapURL);
    }

    /**
     * "userDN" プロパティを定義する。
     *
     * @param userDN 値
     */
    public void setUserDN (String userDN)
    {
    	config.setProperty(propUserDN, userDN);
    }

    /**
     * "userFilter" プロパティを定義する
     *
     * @param userFilter 値
     */
    public void setUserFilter(String userFilter)
    {
    	config.setProperty(propUserFilter, userFilter);
    }

    /**
     * "orgDN" プロパティを定義する
     *
     * @param orgDN 値
     */
    public void setOrgDN (String orgDN)
    {
    	config.setProperty(propOrgDN, orgDN);
    }

    /**
     * "orgFilter" プロパティを定義する
     *
     * @param orgFilter 値
     */
    public void setOrgFilter(String orgFilter)
    {
    	config.setProperty(propOrgFilter, orgFilter);
    }

    /**
     * "" プロパティを定義する
     * 
     * @param attrName
     */
    public void setStateUseAttribute (String attrName)
    {
    	config.setProperty(propStateUse, attrName);
    }
    
    /**
     * "ログイン名" プロパティを定義する
     *
     * @param attrName 属性名
     */
    public void setAccountAttribute (String attrName)
    {
    	config.setProperty(propAccount, attrName);
    }

    /**
     * "名前" プロパティを定義する
     *
     * @param attrName 属性名
     */
    public void setNameAttribute (String attrName)
    {
    	config.setProperty(propName, attrName);
    }

    /**
     * "新ログイン名" プロパティを定義する
     *
     * @param attrName 属性名
     */
    public void setNewAccountAttribute (String attrName)
    {
    	config.setProperty(propNewAccount, attrName);
    }

    /**
     * "パスワード" プロパティを定義する
     *
     * @param attrName 属性名
     */
    public void setPasswordAttribute (String attrName)
    {
    	config.setProperty(propPassword, attrName);
    }

    /**
     * "表示優先度" プロパティを定義する
     * 
     * @param attrName 属性名
     */
    public void setPriorityAttribute (String attrName)
    {
    	config.setProperty(propPriority, attrName);
    }
    
    /**
     * "使用/停止" プロパティを定義する
     * 
     * @param attrName 属性名
     */
    public void setStateAttribute (String attrName)
    {
    	config.setProperty(propState, attrName);
    }
    
    /**
     * "削除フラグ" プロパティを定義する
     * 
     * @param attrName 属性名
     */
    public void setDeleteAttribute (String attrName)
    {
    	config.setProperty(propDelete, attrName);
    }
    
    /**
     * "よみ" プロパティを定義する
     *
     * @param attrName 属性名
     */
    public void setPhoneticAttribute (String attrName)
    {
    	config.setProperty(propPhonetic, attrName);
    }

    /**
     * "E-mail" プロパティを定義する
     *
     * @param attrName 属性名
     */
    public void setMailAttribute (String attrName)
    {
    	config.setProperty(propMail, attrName);
    }

    /**
     * "メモ" プロパティを定義する
     *
     * @param attrName 属性名
     */
    public void setDescriptionAttribute (String attrName)
    {
    	config.setProperty(propDescription, attrName);
    }

    /**
     * "役職" プロパティを定義する
     * 
     * @param attrName 属性名
     */
    public void setExecutiveAttribute (String attrName)
    {
    	config.setProperty(propExecutive, attrName);
    }

    /**
     * "連絡先" プロパティを定義する
     * 
     * @param attrName 属性名
     */
    public void setContactAttribute (String attrName)
    {
    	config.setProperty(propContact, attrName);
    }

    /**
     * "URL" プロパティを定義する
     * 
     * @param attrName 属性名
     */
    public void setURLAttribute (String attrName)
    {
    	config.setProperty(propURL, attrName);
    }

    /**
     * "予備１" プロパティを定義する
     * 
     * @param attrName 属性名
     */
    public void setUserInfo1Attribute (String attrName)
    {
    	config.setProperty(propUserInfo1, attrName);
    }

    /**
     * "予備２" プロパティを定義する
     * 
     * @param attrName 属性名
     */
    public void setUserInfo2Attribute (String attrName)
    {
    	config.setProperty(propUserInfo2, attrName);
    }

    /**
     * "予備３" プロパティを定義する
     * 
     * @param attrName 属性名
     */
    public void setUserInfo3Attribute (String attrName)
    {
    	config.setProperty(propUserInfo3, attrName);
    }

    /**
     * "ログイン名" プロパティを定義する
     * 
     * @param attrName 属性名
     */
    public void setBelongAccountAttribute (String attrName)
    {
    	config.setProperty(propBelongAccount, attrName);
    }
    
    /**
     * "組織コード" プロパティを定義する
     * 
     * @param attrName 属性名
     */
    public void setBelongCodeAttribute (String attrName)
    {
    	config.setProperty(propBelongCode, attrName);
    }

    /**
     * "memberDN" プロパティを定義する
     *
     * @param attrName  属性名
     */
    public void setMemberDNAttribute( String attrName )
    {
    	config.setProperty(propMemberDN, attrName );
    }

    /**
     * "memberURL" プロパティを定義する
     *
     * @param attrName  属性名
     */
    public void setMemberURLAttribute( String attrName )
    {
    	config.setProperty(propMemberURL, attrName );
    }
    
    // configuration settings
	protected List userDNs, orgDNs;
	protected String ldapURL, userFilter, orgFilter;
	protected String memberDN, memberURL;
	
	protected static String USER_STATEUSE;

	protected String[] userFields;							// ユーザー情報
    protected static int USER_ACCOUNT = -1;				// ユーザー情報(ログイン名)
    protected static int USER_NAME = -1;					// ユーザー情報(名前)
    protected static int USER_NEWACCOUNT = -1;			// ユーザー情報(新ログイン名)
    protected static int USER_PASSWORD = -1;				// ユーザー情報(パスワード)
    protected static int USER_PRIORITY = -1;				// ユーザー情報(表示優先度)
    protected static int USER_STATE = -1;					// ユーザー情報(使用/停止)
    protected static int USER_DELETE = -1;				// ユーザー情報(削除フラグ)
    protected static int USER_PHONETIC = -1;				// ユーザー情報(よみ)
    protected static int USER_MAIL = -1;					// ユーザー情報(E-mail)
    protected static int USER_DESCRIPTION = -1;			// ユーザー情報(メモ)
    protected static int USER_EXECUTIVE = -1;				// ユーザー情報(役職)
    protected static int USER_CONTACT = -1;				// ユーザー情報(連絡先)
    protected static int USER_URL = -1;					// ユーザー情報(URL)
    protected static int USER_USERINFO1 = -1;				// ユーザー情報(予備１)
    protected static int USER_USERINFO2 = -1;				// ユーザー情報(予備２)
    protected static int USER_USERINFO3 = -1;				// ユーザー情報(予備３)
    protected static int USER_MAX = 0;					// ユーザー情報(列数)

	protected String[] belongFields;						// ユーザー所属組織情報
	protected static final int BELONG_ACCOUNT = 1;		// ユーザー所属組織情報(ログイン名)
	protected static final int BELONG_CODE = 2;			// ユーザー所属組織情報(組織コード)
	protected static final int BELONG_DELETE = 0;		//ユーザー所属組織情報（削除フラグ）
	protected static final int BELONG_MAX = 3;			// ユーザー所属組織情報(列数)
	
	/**
	 * プロパティで設定された内容を解析し、各種変数を初期化する。
	 * 
	 * @throws ConfigurationException プロパティの設定内容が正しくない
	 * @throws ParseException 定義されている DN の解析に失敗した
	 */
    protected void configure ()
	throws ConfigurationException, ParseException
    {
    	// reset configuration
    	userDNs = new LinkedList();
    	orgDNs = new LinkedList();
    	ldapURL = null;
    	userFilter = null;
    	orgFilter = null;
    	USER_STATEUSE = null;

    	userFields = new String[USER_MAX];
    	belongFields = new String[BELONG_MAX];
    	
    	// read from configuration properties.
    	Enumeration en = config.propertyNames();
    	while ( en.hasMoreElements() ) {
    		String key = (String)en.nextElement();
    		if ( key.equals(propLDAPURL) ) {
    			ldapURL = config.getProperty(key);
    			if ( ldapURL!=null && ldapURL.length()>0 && ! ldapURL.endsWith("/") )
    				ldapURL += "/";
    		}
    		else if ( key.startsWith(propUserDN) && "".equals(config.getProperty(key))==false ) {
    			userDNs.add( new DN(config.getProperty(key)) );
    			orgDNs.add( new DN(config.getProperty(key)) );
    		}
    		else if ( key.equals(propUserFilter) ) {
    			userFilter = config.getProperty(key);
    			orgFilter = config.getProperty(key);
    		}
    		else if ( key.equals(propStateUse) ) {
    			USER_STATEUSE = config.getProperty(key);
    		}
    		else if ( key.equals(propAccount) ) {			// ユーザー情報(ログイン名)
    			userFields[USER_ACCOUNT] = config.getProperty(key);
    			belongFields[BELONG_ACCOUNT] = config.getProperty(key);
    		}
    		else if ( key.equals(propName) ) {				// ユーザー情報(名前)
    			userFields[USER_NAME] = config.getProperty(key);
    		}
    		else if ( key.equals(propNewAccount) ) {		// ユーザー情報(新ログイン名)
    			userFields[USER_NEWACCOUNT] = config.getProperty(key);
    		}
    		else if ( key.equals(propPassword) ) {			// ユーザー情報(パスワード)
    			userFields[USER_PASSWORD] = config.getProperty(key);
    		}
    		else if ( key.equals(propPriority) ) {			// ユーザー情報(表示優先度)
    			userFields[USER_PRIORITY] = config.getProperty(key);
    		}
    		else if ( key.equals(propState) ) {				// ユーザー情報(使用/停止)
    			userFields[USER_STATE] = config.getProperty(key);
    		}
    		else if ( key.equals(propDelete) ) {			// ユーザー情報(削除フラグ)
    			userFields[USER_DELETE] = config.getProperty(key);
    			belongFields[BELONG_DELETE] = config.getProperty(key);
    		}
    		else if ( key.equals(propPhonetic) ) {			// ユーザー情報(よみ)
    			userFields[USER_PHONETIC] = config.getProperty(key);
    		}
    		else if ( key.equals(propMail) ) {				// ユーザー情報(E-mail)
    			userFields[USER_MAIL] = config.getProperty(key);
    		}
    		else if ( key.equals(propDescription) ) {		// ユーザー情報(メモ)
    			userFields[USER_DESCRIPTION] = config.getProperty(key);
    		}
    		else if ( key.equals(propExecutive) ) {			// ユーザー情報(役職)
    			userFields[USER_EXECUTIVE] = config.getProperty(key);
    		}
    		else if ( key.equals(propContact) ) {			// ユーザー情報(連絡先)
    			userFields[USER_CONTACT] = config.getProperty(key);
    		}
    		else if ( key.equals(propURL) ) {				// ユーザー情報(URL)
    			userFields[USER_URL] = config.getProperty(key);
    		}
    		else if ( key.equals(propUserInfo1) ) {				// ユーザー情報(予備１)
    			userFields[USER_USERINFO1] = config.getProperty(key);
    		}
    		else if ( key.equals(propUserInfo2) ) {				// ユーザー情報(予備２)
    			userFields[USER_USERINFO2] = config.getProperty(key);
    		}
    		else if ( key.equals(propUserInfo3) ) {				// ユーザー情報(予備３)
    			userFields[USER_USERINFO3] = config.getProperty(key);
    		}
    		else if ( key.equals(propBelongCode) ) {		// ユーザー所属組織情報(組織コード)
    			belongFields[BELONG_CODE] = config.getProperty(key);
    		}
    		else if ( key.equals(propMemberDN) ) {
    			memberDN = config.getProperty(key);
    			if ( memberDN.length() == 0 ) {
    				memberDN = null;
    			}
    		}
    		else if ( key.equals(propMemberURL) ) {
    			memberURL = config.getProperty(key);
    			if ( memberURL.length() == 0 ) {
    				memberURL = null;
    			}
    		}
    	}
    	
    	if (belongFields[BELONG_CODE] == null || belongFields[BELONG_CODE].length()==0) {
    		belongFields[BELONG_ACCOUNT] = null;
    		orgDNs = null;
    	}
    	
    	// test configuration
    	if ( userDNs.size() == 0 )
    		throw new ConfigurationException("MANDATORY property userDN is not configured.");
    	if ( (userFilter == null) || (userFilter.length() == 0) )
    		throw new ConfigurationException("MANDATORY property userFilter is not configured.");
    	if ( (orgFilter == null) || (orgFilter.length() == 0) )
    		throw new ConfigurationException("MANDATORY property orgFilter is not configured.");
    	if ( (USER_ACCOUNT == -1) || (userFields[USER_ACCOUNT].length() == 0) )
    		throw new ConfigurationException("REQUIRED property account is not configured.");
    	if ( (USER_NAME == -1) || (userFields[USER_NAME].length() == 0) )
       		throw new ConfigurationException("REQUIRED property name is not configured.");

    }

    /**
     * ldap2csv.cfgファイルで設定されている属性名を取得
     * 
     * @param fnm ldap2csv.cfgファイルのフルパス名
     * @throws IOException
     * @throws ParseException
     */
    public void configure( String fnm )
	throws IOException, ParseException
    {
    	int intCol = 0;
    	
        FileInputStream in  = new FileInputStream(fnm);
        BufferedReader lin = new BufferedReader(new InputStreamReader(in, DEFAULT_ENCODING));
        String line;

        READLINE:
        while ((line = lin.readLine()) != null) {
        	if ( line == null ) break;
        	
	    	StringReader sr = new StringReader( line );
	    	String sb = "";
        	while(true)
        	{
	    		int ic = sr.read();
	    		if (ic == -1) break;

	    		char c = (char)ic;

	    		if ( (c == '#') || (c == '!') )
	    		{
	    			sr.close();
	    			continue READLINE;
	    		}
    			sr.close();
	    		
	    		int pos = line.indexOf('=')>0?line.indexOf('='):line.length();
	    		//if (pos == -1)     				
	    		//	break;
	    		//else
	    		//{
	    		
	    			sb = line.substring(0, pos).trim();
		    		if ( sb.equals(propAccount) ) {				// ユーザー情報(ログイン名)
		    			if (USER_ACCOUNT == -1) {
		    				USER_ACCOUNT = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propName) ) {			// ユーザー情報(名前)
		    			if (USER_NAME == -1) {
		    				USER_NAME = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propNewAccount) ) {		// ユーザー情報(新ログイン名)
		    			if (USER_NEWACCOUNT == -1) {
		    				USER_NEWACCOUNT = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propPassword) ) {		// ユーザー情報(パスワード)
		    			if (USER_PASSWORD == -1) {
		    				USER_PASSWORD = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propPriority) ) {		// ユーザー情報(表示優先度)
		    			if (USER_PRIORITY == -1) {
		    				USER_PRIORITY = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propState) ) {			// ユーザー情報(使用/停止)
		    			if (USER_STATE == -1) {
		    				USER_STATE = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propDelete) ) {			// ユーザー情報(削除フラグ)
		    			if (USER_DELETE == -1) {
		    				USER_DELETE = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propPhonetic) ) {		// ユーザー情報(よみ)
		    			if (USER_PHONETIC == -1) {
		    				USER_PHONETIC = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propMail) ) {			// ユーザー情報(E-mail)
		    			if (USER_MAIL == -1) {
		    				USER_MAIL = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propDescription) ) {	// ユーザー情報(メモ)
		    			if (USER_DESCRIPTION == -1) {
		    				USER_DESCRIPTION = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propExecutive) ) {		// ユーザー情報(役職)
		    			if (USER_EXECUTIVE == -1) {
		    				USER_EXECUTIVE = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propContact) ) {		// ユーザー情報(連絡先)
		    			if (USER_CONTACT == -1) {
		    				USER_CONTACT = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propURL) ) {			// ユーザー情報(URL)
		    			if (USER_URL == -1) {
		    				USER_URL = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propUserInfo1) ) {		// ユーザー情報(予備１)
		    			if (USER_USERINFO1 == -1) {
		    				USER_USERINFO1 = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propUserInfo2) ) {		// ユーザー情報(予備２)
		    			if (USER_USERINFO2 == -1) {
		    				USER_USERINFO2 = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propUserInfo3) ) {			// ユーザー情報(予備３)
		    			if (USER_USERINFO3 == -1) {
		    				USER_USERINFO3 = intCol;
		    				intCol++;
		    			}
		    		}
	    			continue READLINE;
	    		//}
        	}
        	sr.close();
        }
    	if (intCol > 0) USER_MAX = intCol;

        lin.close();
    }
}
