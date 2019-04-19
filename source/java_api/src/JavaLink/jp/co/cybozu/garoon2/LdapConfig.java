/* LdapConfig.java */
package jp.co.cybozu.garoon2;

import jp.co.cybozu.text.*;
import jp.co.cybozu.ldap.DN;
import java.util.*;
import java.io.*;

/**
 * LDAP ���烆�[�U�[�A�����������o���ăK���[���� CSV �`���̃f�[�^�ɕϊ����邽�߂́A�e��v���p�e�B��ێ�����B
 * �v���p�e�B�� {@link Properties} �I�u�W�F�N�g�ɂ���ēn����邩�A{@link ConfigParser#load} �œǂݍ��߂�`���̃f�[�^���C���v�b�g�X�g���[������ �ǂݍ��ނ��A���邢�͌ʂɂ��̃N���X���̃��\�b�h���g�p���ė^������B
 * <br> 
 * �L���ȃv���p�e�B�͈ȉ��̕\�Ŏ������B
 * �\���A�u�v��`�v�Ƃ���ꍇ�A���� �v���p�e�B�͕K����`����Ă��Ȃ���΂Ȃ�Ȃ��B
 * �u�K�{�v�Ƃ���ꍇ�A���� �v���p�e�B�͕K����`����Ă��Ȃ���΂Ȃ炸�A����ɒ�`���ꂽ�l�̑��� (attribute)��g�D���邢�̓��[�U�[�̃G���g���������Ă��Ȃ���΂Ȃ�Ȃ��B
 * �ǂ�����w�肳��Ă��Ȃ���΁A���̃v���p�e�B�̓I�v�V�����ł���B 
 * <br>
 * <TABLE BORDER="1" CELLPADDING="3" CELLSPACING="0" WIDTH="100%">
 * <TR BGCOLOR="#CCCCFF" CLASS="TableHeadingColor">
 * <TD align="center"><FONT SIZE="+1">
 * <B>�ݒ薼</B>
 * </FONT>
 * </TD>
 * <TD align="center"><FONT SIZE="+1">
 * <B>���</B>
 * </FONT>
 * </TD>
 * </TR>
 * <tr>
 * <td>ldapURL</td>
 * <td>Ldap�T�[�o�[�̃A�h���X���w�肵�܂��B<br>
 * ��) ldap://localhost:389/</td>
 * </tr>
 *
 * <tr>
 * <td>userDN (or userDN1, userDN2, ...)</td>
 * <td>���[�U�[�̃G���g������������A��_�ƂȂ�G���g���� DN
 * ���w�肵�܂��B�����w�肷��ꍇ�A"userDN1", "userDN2",
 * "userDN3", ... �̂悤�ɁA��ɐ��l��t�����Ďw�肵�܂��B<br><br>
 * �����Ƃ�����w�肵�Ȃ���΂Ȃ�܂���B<br>
 * �y���Ӂz�G���g���̒l�̐擪��"#"������ꍇ,DN�͐��������߂���܂���B<br>
 * ��) ou=Users,dc=demo,dc=local</td>
 * </tr>
 *
 * <tr>
 * <td>userFilter</td>
 * <td>���[�U�[�̃G���g�����������邽�߂́A�����t�B���^�[���w
 * �肵�܂��BRFC2254 �ŋK�肳�ꂽ�`���Ŏw�肵�܂��B<br><br>
 * �K�{�ݒ�ł��B</td>
 * </tr>
 *
 * <tr>
 * <td>account</td>
 * <td>���[�U�[�̃��O�C�����ɕϊ����鑮�������w�肵�܂��B<br><br>
 * �K�{�ݒ�ł��B<br>
 * ��) sAMAccountName</td>
 * </tr>
 *
 * <tr>
 * <td>name</td>
 * <td>���[�U�[�̖��O�ɕϊ����鑮�������w�肵�܂��B<br><br>
 * �K�{�ݒ�ł��B<br>
 * ��) displayname</td>
 * </tr>
 *
 * <tr>
 * <td>newaccount</td>
 * <td>���[�U�[�̐V���O�C�����p�̃t�B�[���h�ł��B<br><br>
 * �ݒ肷��ꍇ��"account"�Ɠ����t�B�[���h���w�肵�Ă��������B<br>
 * �����ݒ肵�Ȃ������ꍇ�Acsv�̊Y���t�B�[���h�ɂ�*��ݒ肵�܂��B</td>
 * </tr>
 *
 * <tr>
 * <td>password</td>
 * <td>���[�U�[�̕����p�X���[�h�ɕϊ����鑮�������w�肵�܂��B<br>
 * �����ݒ肵�Ȃ������ꍇ�Acsv�̊Y���t�B�[���h�ɂ�*��ݒ肵�܂��B<br>
 * �y���Ӂz����LDAP�T�[�o�[�ɂ����āA�p�X���[�h�͎��o���܂���B</td>
 * </tr>
 *
 * <tr>
 * <td>priority</td>
 * <td>���[�U�[�̕\���D��x�p�̃t�B�[���h�ł��B<br>
 * �����ݒ肵�Ȃ������ꍇ�Acsv�̊Y���t�B�[���h�ɂ�*��ݒ肵�܂��B</td>
 * </tr>
 *
 * <tr>
 * <td>state<br>stateUse</td>
 * <td>���[�U�[�̎g�p/��~�p�̃t�B�[���h�ł��B<br>
 * (1:�g�p /0:��~)<br>
 * LDAP�̃A�J�E���g���L���̏ꍇ�́A1:�g�p���ݒ肳��A����
 * �ȊO�̏ꍇ�́A0:��~���ݒ肳��܂��B<br>
 * ���̍��ڂ��o�͂���ꍇ�́Astate�ɂ͖������t���O���ݒ肳��鑮������
 * �w�肵�AstateUse�ɂ͂��̃t���O�l���w�肵�܂��B<br>
 * ��) userAccountControl(514)</td>
 * </tr>
 *
 * <tr>
 * <td>delete</td>
 * <td>
 * ���[�U�[�̍폜�t���O�p�̃t�B�[���h�ł��B<br>
 * 1�F�폜<br>
 * 0,�󔒁F�폜�łȂ�<br>
 * �����ݒ肵�Ȃ������ꍇ�Acsv�̊Y���t�B�[���h�ɂ�*��ݒ肵�܂��B<br>
 * ��L�ȊO�̒l�̏ꍇ�A���[�U�[���̃K���[�����M���ɃG���[�ɂȂ�A<br>
 * �o�^�������Ȃ��܂���B
 * </td>
 * </tr>
 *
 * <tr>
 * <td>phonetic</td>
 * <td>���[�U�[�̂�ݗp�̃t�B�[���h�ł��B<br>
 * �����ݒ肵�Ȃ������ꍇ�Acsv�̊Y���t�B�[���h�ɂ�*��ݒ肵�܂��B</td>
 * </tr>
 *
 * <tr>
 * <td>mail</td>
 * <td>���[�U�[��E-mail�p�̃t�B�[���h�ł��B<br>
 * �����ݒ肵�Ȃ������ꍇ�Acsv�̊Y���t�B�[���h�ɂ�*��ݒ肵�܂��B</td>
 * </tr>
 *
 * <tr>
 * <td>description</td>
 * <td>���[�U�[�̃����p�̃t�B�[���h�ł��B<br>
 * �����ݒ肵�Ȃ������ꍇ�Acsv�̊Y���t�B�[���h�ɂ�*��ݒ肵�܂��B</td>
 * </tr>
 *
 * <tr>
 * <td>executive</td>
 * <td>���[�U�[�̖�E�p�̃t�B�[���h�ł��B<br>
 * �����ݒ肵�Ȃ������ꍇ�Acsv�̊Y���t�B�[���h�ɂ�*��ݒ肵�܂��B</td>
 * </tr>
 *
 * <tr>
 * <td>contact</td>
 * <td>���[�U�[�̘A����p�̃t�B�[���h�ł��B<br>
 * �����ݒ肵�Ȃ������ꍇ�Acsv�̊Y���t�B�[���h�ɂ�*��ݒ肵�܂��B</td>
 * </tr>
 *
 * <tr>
 * <td>url</td>
 * <td>���[�U�[��URL�p�̃t�B�[���h�ł��B<br>
 * �����ݒ肵�Ȃ������ꍇ�Acsv�̊Y���t�B�[���h�ɂ�*��ݒ肵�܂��B</td>
 * </tr>
 *
 * <tr>
 * <td>userInfo1<br>userInfo2<br>userInfo3</td>
 * <td>���[�U�[�̊g���t�B�[���h�p�ł��B<br>
 * ���L���ڂ̃R�����g�A�E�g���O�����ƂŁACSV�t�B�[���h��ǉ��ł��܂��B<br>
 * (�ő�3��)</td>
 * </td>
 * </tr>
 *
 * <tr>
 * <td>belongCode</td>
 * <td>���[�U�[�����g�D�̑g�D�R�[�h�ɕϊ����鑮�������w�肵�܂��B<br>
 * ���̑����Ɋi�[���ꂽ������̂����A�u,�v����؂蕶���Ƃ��Ĕ��f���܂��B</td>
 * </td>
 * </tr>
 * </table>
 *
 * @author �T�C�{�E�Y
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

	private final String propAccount = "account";					// ���[�U�[���(���O�C����)
	private final String propName = "name";						// ���[�U�[���(���O)
	private final String propNewAccount = "newaccount";			// ���[�U�[���(�V���O�C����)
	private final String propPassword = "password";				// ���[�U�[���(�p�X���[�h)
	private final String propPriority = "priority";				// ���[�U�[���(�\���D��x)
	private final String propState = "state";						// ���[�U�[���(�g�p/��~)
	private final String propDelete = "delete";					// ���[�U�[���(�폜�t���O)
	private final String propPhonetic = "phonetic";				// ���[�U�[���(���)
	private final String propMail = "mail";						// ���[�U�[���(E-mail)
	private final String propDescription = "description";			// ���[�U�[���(����)
	private final String propExecutive = "executive";				// ���[�U�[���(��E)
	private final String propContact = "contact";					// ���[�U�[���(�A����)
	private final String propURL = "url";							// ���[�U�[���(URL)
	private final String propUserInfo1 = "userInfo1";				// ���[�U�[���(�\���P)		
	private final String propUserInfo2 = "userInfo2";				// ���[�U�[���(�\���Q)		
	private final String propUserInfo3 = "userInfo3";				// ���[�U�[���(�\���R)		
	
	private final String propBelongAccount = "belongAccount";		// ���[�U�[�����g�D���(���O�C����)
	private final String propBelongCode = "belongCode";			// ���[�U�[�����g�D���(�g�D�R�[�h)

    private final String propMemberDN = "memberDN";				// 
    private final String propMemberURL = "memberURL";				// 

    /**
     * �v���p�e�B���ЂƂ������Ȃ��ݒ�I�u�W�F�N�g���쐬����B
     */
    public LdapConfig ()
    {
    	config = new Properties();
    }

    /**
     * <var>config</var> �ɂĒ�`�����v���p�e�B�����ݒ�I�u�W�F�N�g�� �쐬����B
     *
     * @param config �v���p�e�B
     */
    public LdapConfig (Properties config)
    {
    	this.config = config;
    }

    /**
     * <var>configIn</var> ����v���p�e�B��ǂݍ��݁A���������ݒ� �I�u�W�F�N�g���쐬����B
     *
     * @param configIn {@link ConfigParser#load} ���ǂݍ��݂Ɏg�p���� �C���v�b�g�X�g���[��
     * @throws IOException IO�G���[����������
     * @throws ParseException �ǂݍ��ޓ��e�̃p�[�X�Ɏ��s����
     * @see ConfigParser describes the configuration file format.
     */
    public LdapConfig ( InputStream configIn )
	throws IOException, ParseException
    {
    	ConfigParser cp = new ConfigParser( configIn );
    	config = cp.getProperties();
    }

    /**
     * "ldapURL" �v���p�e�B���`����B
     *
     * @param ldapURL �l
     */
    public void setLdapURL (String ldapURL)
    {
    	config.setProperty(propLDAPURL, ldapURL);
    }

    /**
     * "userDN" �v���p�e�B���`����B
     *
     * @param userDN �l
     */
    public void setUserDN (String userDN)
    {
    	config.setProperty(propUserDN, userDN);
    }

    /**
     * "userFilter" �v���p�e�B���`����
     *
     * @param userFilter �l
     */
    public void setUserFilter(String userFilter)
    {
    	config.setProperty(propUserFilter, userFilter);
    }

    /**
     * "orgDN" �v���p�e�B���`����
     *
     * @param orgDN �l
     */
    public void setOrgDN (String orgDN)
    {
    	config.setProperty(propOrgDN, orgDN);
    }

    /**
     * "orgFilter" �v���p�e�B���`����
     *
     * @param orgFilter �l
     */
    public void setOrgFilter(String orgFilter)
    {
    	config.setProperty(propOrgFilter, orgFilter);
    }

    /**
     * "" �v���p�e�B���`����
     * 
     * @param attrName
     */
    public void setStateUseAttribute (String attrName)
    {
    	config.setProperty(propStateUse, attrName);
    }
    
    /**
     * "���O�C����" �v���p�e�B���`����
     *
     * @param attrName ������
     */
    public void setAccountAttribute (String attrName)
    {
    	config.setProperty(propAccount, attrName);
    }

    /**
     * "���O" �v���p�e�B���`����
     *
     * @param attrName ������
     */
    public void setNameAttribute (String attrName)
    {
    	config.setProperty(propName, attrName);
    }

    /**
     * "�V���O�C����" �v���p�e�B���`����
     *
     * @param attrName ������
     */
    public void setNewAccountAttribute (String attrName)
    {
    	config.setProperty(propNewAccount, attrName);
    }

    /**
     * "�p�X���[�h" �v���p�e�B���`����
     *
     * @param attrName ������
     */
    public void setPasswordAttribute (String attrName)
    {
    	config.setProperty(propPassword, attrName);
    }

    /**
     * "�\���D��x" �v���p�e�B���`����
     * 
     * @param attrName ������
     */
    public void setPriorityAttribute (String attrName)
    {
    	config.setProperty(propPriority, attrName);
    }
    
    /**
     * "�g�p/��~" �v���p�e�B���`����
     * 
     * @param attrName ������
     */
    public void setStateAttribute (String attrName)
    {
    	config.setProperty(propState, attrName);
    }
    
    /**
     * "�폜�t���O" �v���p�e�B���`����
     * 
     * @param attrName ������
     */
    public void setDeleteAttribute (String attrName)
    {
    	config.setProperty(propDelete, attrName);
    }
    
    /**
     * "���" �v���p�e�B���`����
     *
     * @param attrName ������
     */
    public void setPhoneticAttribute (String attrName)
    {
    	config.setProperty(propPhonetic, attrName);
    }

    /**
     * "E-mail" �v���p�e�B���`����
     *
     * @param attrName ������
     */
    public void setMailAttribute (String attrName)
    {
    	config.setProperty(propMail, attrName);
    }

    /**
     * "����" �v���p�e�B���`����
     *
     * @param attrName ������
     */
    public void setDescriptionAttribute (String attrName)
    {
    	config.setProperty(propDescription, attrName);
    }

    /**
     * "��E" �v���p�e�B���`����
     * 
     * @param attrName ������
     */
    public void setExecutiveAttribute (String attrName)
    {
    	config.setProperty(propExecutive, attrName);
    }

    /**
     * "�A����" �v���p�e�B���`����
     * 
     * @param attrName ������
     */
    public void setContactAttribute (String attrName)
    {
    	config.setProperty(propContact, attrName);
    }

    /**
     * "URL" �v���p�e�B���`����
     * 
     * @param attrName ������
     */
    public void setURLAttribute (String attrName)
    {
    	config.setProperty(propURL, attrName);
    }

    /**
     * "�\���P" �v���p�e�B���`����
     * 
     * @param attrName ������
     */
    public void setUserInfo1Attribute (String attrName)
    {
    	config.setProperty(propUserInfo1, attrName);
    }

    /**
     * "�\���Q" �v���p�e�B���`����
     * 
     * @param attrName ������
     */
    public void setUserInfo2Attribute (String attrName)
    {
    	config.setProperty(propUserInfo2, attrName);
    }

    /**
     * "�\���R" �v���p�e�B���`����
     * 
     * @param attrName ������
     */
    public void setUserInfo3Attribute (String attrName)
    {
    	config.setProperty(propUserInfo3, attrName);
    }

    /**
     * "���O�C����" �v���p�e�B���`����
     * 
     * @param attrName ������
     */
    public void setBelongAccountAttribute (String attrName)
    {
    	config.setProperty(propBelongAccount, attrName);
    }
    
    /**
     * "�g�D�R�[�h" �v���p�e�B���`����
     * 
     * @param attrName ������
     */
    public void setBelongCodeAttribute (String attrName)
    {
    	config.setProperty(propBelongCode, attrName);
    }

    /**
     * "memberDN" �v���p�e�B���`����
     *
     * @param attrName  ������
     */
    public void setMemberDNAttribute( String attrName )
    {
    	config.setProperty(propMemberDN, attrName );
    }

    /**
     * "memberURL" �v���p�e�B���`����
     *
     * @param attrName  ������
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

	protected String[] userFields;							// ���[�U�[���
    protected static int USER_ACCOUNT = -1;				// ���[�U�[���(���O�C����)
    protected static int USER_NAME = -1;					// ���[�U�[���(���O)
    protected static int USER_NEWACCOUNT = -1;			// ���[�U�[���(�V���O�C����)
    protected static int USER_PASSWORD = -1;				// ���[�U�[���(�p�X���[�h)
    protected static int USER_PRIORITY = -1;				// ���[�U�[���(�\���D��x)
    protected static int USER_STATE = -1;					// ���[�U�[���(�g�p/��~)
    protected static int USER_DELETE = -1;				// ���[�U�[���(�폜�t���O)
    protected static int USER_PHONETIC = -1;				// ���[�U�[���(���)
    protected static int USER_MAIL = -1;					// ���[�U�[���(E-mail)
    protected static int USER_DESCRIPTION = -1;			// ���[�U�[���(����)
    protected static int USER_EXECUTIVE = -1;				// ���[�U�[���(��E)
    protected static int USER_CONTACT = -1;				// ���[�U�[���(�A����)
    protected static int USER_URL = -1;					// ���[�U�[���(URL)
    protected static int USER_USERINFO1 = -1;				// ���[�U�[���(�\���P)
    protected static int USER_USERINFO2 = -1;				// ���[�U�[���(�\���Q)
    protected static int USER_USERINFO3 = -1;				// ���[�U�[���(�\���R)
    protected static int USER_MAX = 0;					// ���[�U�[���(��)

	protected String[] belongFields;						// ���[�U�[�����g�D���
	protected static final int BELONG_ACCOUNT = 1;		// ���[�U�[�����g�D���(���O�C����)
	protected static final int BELONG_CODE = 2;			// ���[�U�[�����g�D���(�g�D�R�[�h)
	protected static final int BELONG_DELETE = 0;		//���[�U�[�����g�D���i�폜�t���O�j
	protected static final int BELONG_MAX = 3;			// ���[�U�[�����g�D���(��)
	
	/**
	 * �v���p�e�B�Őݒ肳�ꂽ���e����͂��A�e��ϐ�������������B
	 * 
	 * @throws ConfigurationException �v���p�e�B�̐ݒ���e���������Ȃ�
	 * @throws ParseException ��`����Ă��� DN �̉�͂Ɏ��s����
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
    		else if ( key.equals(propAccount) ) {			// ���[�U�[���(���O�C����)
    			userFields[USER_ACCOUNT] = config.getProperty(key);
    			belongFields[BELONG_ACCOUNT] = config.getProperty(key);
    		}
    		else if ( key.equals(propName) ) {				// ���[�U�[���(���O)
    			userFields[USER_NAME] = config.getProperty(key);
    		}
    		else if ( key.equals(propNewAccount) ) {		// ���[�U�[���(�V���O�C����)
    			userFields[USER_NEWACCOUNT] = config.getProperty(key);
    		}
    		else if ( key.equals(propPassword) ) {			// ���[�U�[���(�p�X���[�h)
    			userFields[USER_PASSWORD] = config.getProperty(key);
    		}
    		else if ( key.equals(propPriority) ) {			// ���[�U�[���(�\���D��x)
    			userFields[USER_PRIORITY] = config.getProperty(key);
    		}
    		else if ( key.equals(propState) ) {				// ���[�U�[���(�g�p/��~)
    			userFields[USER_STATE] = config.getProperty(key);
    		}
    		else if ( key.equals(propDelete) ) {			// ���[�U�[���(�폜�t���O)
    			userFields[USER_DELETE] = config.getProperty(key);
    			belongFields[BELONG_DELETE] = config.getProperty(key);
    		}
    		else if ( key.equals(propPhonetic) ) {			// ���[�U�[���(���)
    			userFields[USER_PHONETIC] = config.getProperty(key);
    		}
    		else if ( key.equals(propMail) ) {				// ���[�U�[���(E-mail)
    			userFields[USER_MAIL] = config.getProperty(key);
    		}
    		else if ( key.equals(propDescription) ) {		// ���[�U�[���(����)
    			userFields[USER_DESCRIPTION] = config.getProperty(key);
    		}
    		else if ( key.equals(propExecutive) ) {			// ���[�U�[���(��E)
    			userFields[USER_EXECUTIVE] = config.getProperty(key);
    		}
    		else if ( key.equals(propContact) ) {			// ���[�U�[���(�A����)
    			userFields[USER_CONTACT] = config.getProperty(key);
    		}
    		else if ( key.equals(propURL) ) {				// ���[�U�[���(URL)
    			userFields[USER_URL] = config.getProperty(key);
    		}
    		else if ( key.equals(propUserInfo1) ) {				// ���[�U�[���(�\���P)
    			userFields[USER_USERINFO1] = config.getProperty(key);
    		}
    		else if ( key.equals(propUserInfo2) ) {				// ���[�U�[���(�\���Q)
    			userFields[USER_USERINFO2] = config.getProperty(key);
    		}
    		else if ( key.equals(propUserInfo3) ) {				// ���[�U�[���(�\���R)
    			userFields[USER_USERINFO3] = config.getProperty(key);
    		}
    		else if ( key.equals(propBelongCode) ) {		// ���[�U�[�����g�D���(�g�D�R�[�h)
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
     * ldap2csv.cfg�t�@�C���Őݒ肳��Ă��鑮�������擾
     * 
     * @param fnm ldap2csv.cfg�t�@�C���̃t���p�X��
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
		    		if ( sb.equals(propAccount) ) {				// ���[�U�[���(���O�C����)
		    			if (USER_ACCOUNT == -1) {
		    				USER_ACCOUNT = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propName) ) {			// ���[�U�[���(���O)
		    			if (USER_NAME == -1) {
		    				USER_NAME = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propNewAccount) ) {		// ���[�U�[���(�V���O�C����)
		    			if (USER_NEWACCOUNT == -1) {
		    				USER_NEWACCOUNT = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propPassword) ) {		// ���[�U�[���(�p�X���[�h)
		    			if (USER_PASSWORD == -1) {
		    				USER_PASSWORD = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propPriority) ) {		// ���[�U�[���(�\���D��x)
		    			if (USER_PRIORITY == -1) {
		    				USER_PRIORITY = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propState) ) {			// ���[�U�[���(�g�p/��~)
		    			if (USER_STATE == -1) {
		    				USER_STATE = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propDelete) ) {			// ���[�U�[���(�폜�t���O)
		    			if (USER_DELETE == -1) {
		    				USER_DELETE = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propPhonetic) ) {		// ���[�U�[���(���)
		    			if (USER_PHONETIC == -1) {
		    				USER_PHONETIC = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propMail) ) {			// ���[�U�[���(E-mail)
		    			if (USER_MAIL == -1) {
		    				USER_MAIL = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propDescription) ) {	// ���[�U�[���(����)
		    			if (USER_DESCRIPTION == -1) {
		    				USER_DESCRIPTION = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propExecutive) ) {		// ���[�U�[���(��E)
		    			if (USER_EXECUTIVE == -1) {
		    				USER_EXECUTIVE = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propContact) ) {		// ���[�U�[���(�A����)
		    			if (USER_CONTACT == -1) {
		    				USER_CONTACT = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propURL) ) {			// ���[�U�[���(URL)
		    			if (USER_URL == -1) {
		    				USER_URL = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propUserInfo1) ) {		// ���[�U�[���(�\���P)
		    			if (USER_USERINFO1 == -1) {
		    				USER_USERINFO1 = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propUserInfo2) ) {		// ���[�U�[���(�\���Q)
		    			if (USER_USERINFO2 == -1) {
		    				USER_USERINFO2 = intCol;
		    				intCol++;
		    			}
		    		}
		    		else if ( sb.equals(propUserInfo3) ) {			// ���[�U�[���(�\���R)
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
