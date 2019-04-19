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
 * ユーザー/所属情報を LDAP サーバーから取得し、CSV 形式のデータ に変換する。
 * <br>
 * このクラスでは JNDI を使用しているため、<a href="http://java.sun.com/products/jndi/tutorial/">JNDI</a> の各種設定が必要となる。
 * <br>
 * 例えばディレクトリサーバーに接続するユーザーとパスワード等である。
 * 詳細については JNDI の API か、JNDIチュートリアル を参照せよ。 
 * またデータ変換には {@link LdapConfig} で規定される各種の設定が必要となる。
 * <br>
 * 詳細は LdapConfig を参照せよ。
 *
 * @author サイボウズ
 * @version	1.0.0
 * @see		LdapConfig
 */
public class LdapToCSV extends LdapConfig
{
    /** JNDI properties */
    private Hashtable env;

    /**
     * <var>config</var> で渡されるプロパティを {@link LdapConfig} に渡して、新たなインスタンスを作成する。<br>
     * JNDI のプロパティは <kbd>jndi.properties</kbd> から読み込まれる。
     *
     * @param config 変換用のプロパティ
     * @see LdapConfig describes the configuration.
     * @see <a href="http://java.sun.com/products/jndi/tutorial/beyond/env/index.html">JNDI Environment Properties</a>
     */
    public LdapToCSV( Properties config )
    {
    	this( config, null );
    }

    /**
     * <var>configIn</var> で渡されるプロパティ読み込み用のインプット ストリームを {@link LdapConfig} に渡して、新たなインスタンスを作成する。<br>
     * JNDI のプロパティは <kbd>jndi.properties</kbd> から読み込まれる。
     *
     * @param configIn 変換用のプロパティを読み込むインプットストリーム
     * @throws IOException 通信エラーが発生
     * @throws ParseException 解析中に予想外のエラーが発生したことを表すシグナルです。
     * @see LdapConfig describes the configuration.
     * @see <a href="http://java.sun.com/products/jndi/tutorial/beyond/env/index.html">JNDI Environment Properties</a>
     */
    public LdapToCSV( InputStream configIn )
	throws IOException, ParseException
    {
    	this( configIn, null );
    }

    /**
     * <var>config</var> で渡されるプロパティを {@link LdapConfig} に渡して、新たなインスタンスを作成する。<br>
     * JNDI のプロパティは <var>env</var> で渡される。<br>
     * 内部では {@link InitialDirContext} のコンストラクタに渡されている。
     *
     * @param config 変換用のプロパティ
     * @param env JNDIプロパティ
     * @see LdapConfig describes the configuration.
     * @see <a href="http://java.sun.com/products/jndi/tutorial/beyond/env/index.html">JNDI Environment Properties</a>
     */
    public LdapToCSV( Properties config, Hashtable env )
    {
    	super( config );
    	this.env = env;
    }

    /**
     * <var>configIn</var> で渡されるプロパティ読み込み用のインプット ストリームを LdapConfig に渡して、新たなインスタンスを作成する。<br>
     * JNDI のプロパティは <var>env</var> で渡される。<br>
     * 内部では {@link InitialDirContext} のコンストラクタに渡されている。
     *
     * @param configIn 変換用のプロパティを読み込むインプットストリーム
     * @param env JNDIプロパティ
     * @throws IOException 通信エラーが発生
     * @throws ParseException 解析中に予想外のエラーが発生したことを表すシグナルです。
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
     * ユーザーのエントリを全て検索し、CSV 形式のデータに変換する。<br>
     * ガルーンで使用するためには、<var>o</var> は "Shift_JIS" 形式で 書き込む必要がある。
     *
     * @param o ユーザー CSV データの出力先。
     * @throws IOException 通信エラーが発生
     * @throws NamingException ディレクトリサーバーへの問い合わせに失敗した。
     * @throws ConfigurationException 変換用の設定に矛盾があった。
     * @throws ParseException 解析中に予想外のエラーが発生したことを表すシグナルです。
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
    					if ( i == USER_ACCOUNT )		// ログイン名
    						throw new ConfigurationException("missing a REQUIRED attribute \"account\".");
    					else if ( i == USER_NAME )		// 名前
    						throw new ConfigurationException("missing a REQUIRED attribute \"name\".");
    					else if (i == USER_STATE)		// ユーザー情報
    						csvline[i] = "1";			//  1:使用
    					else
    						csvline[i] = "";
    					
    					continue;
    				}

    				if (i == USER_STATE) {				// ユーザー情報
    					if ( attr.get().equals(USER_STATEUSE) )
    						csvline[i] = "0";			//  0:停止
    					else
    						csvline[i] = "1";			//  1:使用
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
     * LDAPサーバーから組織に所属するユーザーの情報を取得し、 CSV 形式のデータに変換する。<br>
     * ガルーンで使用するためには、<var>o</var> は "Shift_JIS" 形式で 書き込む必要がある。
     * 
     * @param o 所属情報 CSV データの出力先
     * @throws IOException 通信エラーが発生
     * @throws NamingException ディレクトリサーバーへの問い合わせに失敗した。
     * @throws ConfigurationException 変換用の設定に矛盾があった。
     * @throws ParseException 解析中に予想外のエラーが発生したことを表すシグナルです。
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
            	
            	//削除ユーザーなら登録しない(削除フィールド=1の時)
            	if(belongFields[BELONG_DELETE]!=null && attrs.get(belongFields[BELONG_DELETE])!=null ){
		            if ("1".equals(attrs.get(belongFields[BELONG_DELETE]).get().toString())){	            		
	            		continue;
	            	}
    			}
            	           	
            	
    			// CSVファイルの作成(ユーザー所属組織)
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
   							if ( i == BELONG_ACCOUNT )			// ユーザー所属組織情報(ログイン名)
   								throw new ConfigurationException("missing a REQUIRED attribute \"account\".");

   	    						csvline.add( "" );

   						}
   						else {							
   							if ( i == BELONG_ACCOUNT ) {		// ユーザー所属組織情報(ログイン名)
   								csvline.add( attr.get().toString() );
   							}
   							else {								// ユーザー所属組織情報(組織コード)
   								String strBuffer = attr.get().toString();
   								int intCol[] = new int[2];
   								
   								intCol[0] = strBuffer.indexOf(",");
   								if (intCol[0] == -1) {			// ","が存在しなかった場合
   									// 所属コードが１つしか登録されていない場合
   									csvline.add( attr.get().toString() );
   								}
   								else {							// ","が存在した場合
   									// 所属コードが複数登録されている場合
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
