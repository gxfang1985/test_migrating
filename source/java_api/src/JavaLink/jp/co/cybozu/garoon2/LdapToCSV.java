/* LdapToCSV.java */
package jp.co.cybozu.garoon2;

import jp.co.cybozu.text.*;
import jp.co.cybozu.http.*;
import jp.co.cybozu.ldap.DN;
import java.util.*;
import java.io.*;
import javax.naming.*;
import javax.naming.directory.*;

/**
 * ���[�U�[/�������� LDAP �T�[�o�[����擾���ACSV �`���̃f�[�^ �ɕϊ�����B
 * <br>
 * ���̃N���X�ł� JNDI ���g�p���Ă��邽�߁A<a href="http://java.sun.com/products/jndi/tutorial/">JNDI</a> �̊e��ݒ肪�K�v�ƂȂ�B
 * <br>
 * �Ⴆ�΃f�B���N�g���T�[�o�[�ɐڑ����郆�[�U�[�ƃp�X���[�h���ł���B
 * �ڍׂɂ��Ă� JNDI �� API ���AJNDI�`���[�g���A�� ���Q�Ƃ���B 
 * �܂��f�[�^�ϊ��ɂ� {@link LdapConfig} �ŋK�肳���e��̐ݒ肪�K�v�ƂȂ�B
 * <br>
 * �ڍׂ� LdapConfig ���Q�Ƃ���B
 *
 * @author �T�C�{�E�Y
 * @version	1.0.0
 * @see		LdapConfig
 */
public class LdapToCSV extends LdapConfig
{
    /** JNDI properties */
    private Hashtable env;

    /**
     * <var>config</var> �œn�����v���p�e�B�� {@link LdapConfig} �ɓn���āA�V���ȃC���X�^���X���쐬����B<br>
     * JNDI �̃v���p�e�B�� <kbd>jndi.properties</kbd> ����ǂݍ��܂��B
     *
     * @param config �ϊ��p�̃v���p�e�B
     * @see LdapConfig describes the configuration.
     * @see <a href="http://java.sun.com/products/jndi/tutorial/beyond/env/index.html">JNDI Environment Properties</a>
     */
    public LdapToCSV( Properties config )
    {
    	this( config, null );
    }

    /**
     * <var>configIn</var> �œn�����v���p�e�B�ǂݍ��ݗp�̃C���v�b�g �X�g���[���� {@link LdapConfig} �ɓn���āA�V���ȃC���X�^���X���쐬����B<br>
     * JNDI �̃v���p�e�B�� <kbd>jndi.properties</kbd> ����ǂݍ��܂��B
     *
     * @param configIn �ϊ��p�̃v���p�e�B��ǂݍ��ރC���v�b�g�X�g���[��
     * @throws IOException �ʐM�G���[������
     * @throws ParseException ��͒��ɗ\�z�O�̃G���[�������������Ƃ�\���V�O�i���ł��B
     * @see LdapConfig describes the configuration.
     * @see <a href="http://java.sun.com/products/jndi/tutorial/beyond/env/index.html">JNDI Environment Properties</a>
     */
    public LdapToCSV( InputStream configIn )
	throws IOException, ParseException
    {
    	this( configIn, null );
    }

    /**
     * <var>config</var> �œn�����v���p�e�B�� {@link LdapConfig} �ɓn���āA�V���ȃC���X�^���X���쐬����B<br>
     * JNDI �̃v���p�e�B�� <var>env</var> �œn�����B<br>
     * �����ł� {@link InitialDirContext} �̃R���X�g���N�^�ɓn����Ă���B
     *
     * @param config �ϊ��p�̃v���p�e�B
     * @param env JNDI�v���p�e�B
     * @see LdapConfig describes the configuration.
     * @see <a href="http://java.sun.com/products/jndi/tutorial/beyond/env/index.html">JNDI Environment Properties</a>
     */
    public LdapToCSV( Properties config, Hashtable env )
    {
    	super( config );
    	this.env = env;
    }

    /**
     * <var>configIn</var> �œn�����v���p�e�B�ǂݍ��ݗp�̃C���v�b�g �X�g���[���� LdapConfig �ɓn���āA�V���ȃC���X�^���X���쐬����B<br>
     * JNDI �̃v���p�e�B�� <var>env</var> �œn�����B<br>
     * �����ł� {@link InitialDirContext} �̃R���X�g���N�^�ɓn����Ă���B
     *
     * @param configIn �ϊ��p�̃v���p�e�B��ǂݍ��ރC���v�b�g�X�g���[��
     * @param env JNDI�v���p�e�B
     * @throws IOException �ʐM�G���[������
     * @throws ParseException ��͒��ɗ\�z�O�̃G���[�������������Ƃ�\���V�O�i���ł��B
     * @see LdapConfig describes the configuration.
     * @see <a href="http://java.sun.com/products/jndi/tutorial/beyond/env/index.html">JNDI Environment Properties</a>
     */
    public LdapToCSV( InputStream configIn, Hashtable env )
	throws IOException, ParseException
    {
    	super( configIn );
    	this.env = env;
    }

    /**
     * ���[�U�[�̃G���g����S�Č������ACSV �`���̃f�[�^�ɕϊ�����B<br>
     * �K���[���Ŏg�p���邽�߂ɂ́A<var>o</var> �� "Shift_JIS" �`���� �������ޕK�v������B
     *
     * @param o ���[�U�[ CSV �f�[�^�̏o�͐�B
     * @throws IOException �ʐM�G���[������
     * @throws NamingException �f�B���N�g���T�[�o�[�ւ̖₢���킹�Ɏ��s�����B
     * @throws ConfigurationException �ϊ��p�̐ݒ�ɖ������������B
     * @throws ParseException ��͒��ɗ\�z�O�̃G���[�������������Ƃ�\���V�O�i���ł��B
     */
    public void exportUser( String file, CSVWriter o )
	throws IOException, NamingException, ConfigurationException, ParseException
    {
    	// reset configuration
    	configure(file);
    	configure();
    	
    	if ( (ldapURL == null) || (ldapURL.length() == 0 ) )
    		throw new ConfigurationException("MANDATORY property ldapURL is not configured.");

    	int nattrs = 0;
    	for ( int i = 0; i < userFields.length; i++ ) {
    		if ( (userFields[i] != null) &&
		         (userFields[i].length() != 0) ) {
    			nattrs ++;
    		}
    	}
    	String[] attrIDs = new String[nattrs];
    	nattrs = 0;
    	for ( int i = 0; i < userFields.length; i++ ) {
    		if ( (userFields[i] != null) &&
		         (userFields[i].length() != 0) ) 
    		{
    			attrIDs[nattrs++] = userFields[i];
    		}
    	}

    	DirContext init = new InitialDirContext( env );

    	SearchControls ctrls = new SearchControls();
    	ctrls.setReturningAttributes(attrIDs);
    	ctrls.setReturningObjFlag(true);
    	ctrls.setSearchScope(SearchControls.SUBTREE_SCOPE);
    	ctrls.setTimeLimit(0);

    	Iterator it = userDNs.iterator();
    	while ( it.hasNext() ) {
    		DN dn = (DN)it.next();

    		String escaped = null;
    		try {
    			escaped = URLEncoder.encode( dn.toString(), "UTF8");
    		} 
    		catch ( UnsupportedEncodingException e ) {
    			// ignore it.
    		}

    		URI uri = URI.create(ldapURL).resolve(escaped);
    		DirContext ctxt = (DirContext)init.lookup(uri.toASCIIString());
    		ctxt.addToEnvironment("java.naming.ldap.derefAliases", "always");

    		NamingEnumeration users = ctxt.search("", userFilter, ctrls);
    		while ( users.hasMore() ) {
    			SearchResult user = (SearchResult)users.next();
    			Attributes attrs = user.getAttributes();
    			String[] csvline = new String[USER_MAX];

    			// compose a CSV line
    			for ( int i = 0; i < userFields.length; i++ ) {
    				if ( (userFields[i] == null) ||
			             (userFields[i].length() == 0) ) {
    					csvline[i] = "*";
    					continue;
    				}

    				if ( userFields[i].equalsIgnoreCase( "dn" ) ) {
    					DirContext userEntry = (DirContext)user.getObject();
    					csvline[i] = userEntry.getNameInNamespace();
    					userEntry.close();
    					continue;
    				}

    				Attribute attr = attrs.get(userFields[i]);
    				if ( (attr == null) ||
			             (attr.get().toString().length() == 0) ) {
    					if ( i == USER_ACCOUNT )		// ���O�C����
    						throw new ConfigurationException("missing a REQUIRED attribute \"account\".");
    					else if ( i == USER_NAME )		// ���O
    						throw new ConfigurationException("missing a REQUIRED attribute \"name\".");
    					else if (i == USER_STATE)		// ���[�U�[���
    						csvline[i] = "1";			//  1:�g�p
    					else
    						csvline[i] = "";
    					
    					continue;
    				}

    				if (i == USER_STATE) {				// ���[�U�[���
    					if ( attr.get().equals(USER_STATEUSE) )
    						csvline[i] = "0";			//  0:��~
    					else
    						csvline[i] = "1";			//  1:�g�p
    				}
    				else {
    					csvline[i] = attr.get().toString();
    				}
    			}

    			o.println( csvline );
    		}
    		ctxt.close();
    	}
    	init.close();
    }

    /**
     * LDAP�T�[�o�[����g�D�ɏ������郆�[�U�[�̏����擾���A CSV �`���̃f�[�^�ɕϊ�����B<br>
     * �K���[���Ŏg�p���邽�߂ɂ́A<var>o</var> �� "Shift_JIS" �`���� �������ޕK�v������B
     * 
     * @param o ������� CSV �f�[�^�̏o�͐�
     * @throws IOException �ʐM�G���[������
     * @throws NamingException �f�B���N�g���T�[�o�[�ւ̖₢���킹�Ɏ��s�����B
     * @throws ConfigurationException �ϊ��p�̐ݒ�ɖ������������B
     * @throws ParseException ��͒��ɗ\�z�O�̃G���[�������������Ƃ�\���V�O�i���ł��B
     */
    public void exportBelong( CSVWriter o )
	throws IOException, NamingException, ConfigurationException, ParseException
    {
    	// reset configuration
       	configure();
    	if ( (ldapURL == null) || (ldapURL.length() == 0 ) )
    		throw new ConfigurationException("MANDATORY property ldapURL is not configured.");

       	if ( orgDNs == null ) {
    		// nothing to do
    		return;
    	}

    	int nattrs = 0;
    	for ( int i = 0; i < belongFields.length; i++ ) {   		
    		if ( (belongFields[i] != null) &&
		         (belongFields[i].length() != 0) ) {
    			nattrs ++;
    		}
    	}
    	String[] attrIDs = new String[nattrs];
    	
    	nattrs = 0;
   	
    	for ( int i = 0; i < belongFields.length; i++ ) {
     		
    		if ( (belongFields[i] != null) &&
		         (belongFields[i].length() != 0) ) {
    			attrIDs[nattrs++] = belongFields[i];
    		}
    	}

    	DirContext init = new InitialDirContext( env );

    	SearchControls ctrls = new SearchControls();
    	ctrls.setReturningAttributes(attrIDs);
    	ctrls.setReturningObjFlag(true);
    	ctrls.setSearchScope(SearchControls.SUBTREE_SCOPE);
    	ctrls.setTimeLimit(0);

    	Iterator it = orgDNs.iterator();
    	
    	while ( it.hasNext() ) {
    		DN dn = (DN)it.next();

    		String escaped = null;
    		try {
    			escaped = URLEncoder.encode( dn.toString(), "UTF8");
    		} 
    		catch ( UnsupportedEncodingException e ) {
    			// ignore it.
    		}

    		URI uri = URI.create(ldapURL).resolve(escaped);
    		DirContext ctxt = (DirContext)init.lookup(uri.toASCIIString());
    		ctxt.addToEnvironment("java.naming.ldap.derefAliases", "always");

    		NamingEnumeration users = ctxt.search("", userFilter, ctrls);

    		while ( users.hasMore() ) {
    			SearchResult user = (SearchResult)users.next();
    			
    			Attributes attrs = user.getAttributes();

            	List csvline = new ArrayList(4);
            	
            	//�폜���[�U�[�Ȃ�o�^���Ȃ�(�폜�t�B�[���h=1�̎�)
            	if(belongFields[BELONG_DELETE]!=null && attrs.get(belongFields[BELONG_DELETE])!=null ){
		            if ("1".equals(attrs.get(belongFields[BELONG_DELETE]).get().toString())){	            		
	            		continue;
	            	}
    			}
            	           	
            	
    			// CSV�t�@�C���̍쐬(���[�U�[�����g�D)
    			for ( int i = BELONG_ACCOUNT; i < belongFields.length; i++ ) {
    				
    				if ( (belongFields[i] == null) ||
   			             (belongFields[i].length() == 0) ) {
    						csvline.add( "*" );
       				}
       				else if ( belongFields[i].equalsIgnoreCase( "dn" ) ) {
       					DirContext userEntry = (DirContext)user.getObject();

        				csvline.add( userEntry.getNameInNamespace() );
       					userEntry.close();
       				}
       				else {
   						Attribute attr = attrs.get(belongFields[i]);
   						
   						if ( (attr == null) ||
		                     (attr.get().toString().length() == 0) ) {
   							if ( i == BELONG_ACCOUNT )			// ���[�U�[�����g�D���(���O�C����)
   								throw new ConfigurationException("missing a REQUIRED attribute \"account\".");

   	    						csvline.add( "" );

   						}
   						else {							
   							if ( i == BELONG_ACCOUNT ) {		// ���[�U�[�����g�D���(���O�C����)
   								csvline.add( attr.get().toString() );
   							}
   							else {								// ���[�U�[�����g�D���(�g�D�R�[�h)
   								String strBuffer = attr.get().toString();
   								int intCol[] = new int[2];
   								
   								intCol[0] = strBuffer.indexOf(",");
   								if (intCol[0] == -1) {			// ","�����݂��Ȃ������ꍇ
   									// �����R�[�h���P�����o�^����Ă��Ȃ��ꍇ
   									csvline.add( attr.get().toString() );
   								}
   								else {							// ","�����݂����ꍇ
   									// �����R�[�h�������o�^����Ă���ꍇ
   									for (int j = 0; j < strBuffer.length(); j++) {
   										if (j == 0) 
   											intCol[0] = 0;
   										else
	   										intCol[0] = intCol[1] + 1;
   										
   										intCol[1] = strBuffer.indexOf(",", intCol[0]);
   										if (intCol[1] > -1)
   											csvline.add( strBuffer.substring(intCol[0], intCol[1]) );
   										else {
   											csvline.add( strBuffer.substring(intCol[0]) );
   											break;
   										}
   									}
   								}
   							}
   						}
       				}
    			}
    			o.println( csvline );
    		}
    		ctxt.close();
    	}
    	init.close();
    }
}
