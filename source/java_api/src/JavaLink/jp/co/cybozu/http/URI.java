package jp.co.cybozu.http;

import java.net.*;
import java.util.*;
import java.io.*;

/**
 * J2SDK1.4.0 �ȍ~�� URI �N���X�̐����ŃR���p�`�u���N���X�ł��B
 *
 * @author �T�C�{�E�Y
 * @version	1.0.0
 */
public class URI
{
    private String scheme;				// before ':'
    private String specific;			// after ':'
    private String authority;			// from '://' to the next '/'
    private String path;				// '/'
    private String query;				// after '?'
    private String fragment;			// after '#'

    private String userInfo;			// before '@' in authority
    private String host;				// the middle part in authority
    private int    port = -1;			// after ':' in authority

    private boolean opaque;
	
    private void parseAuthority (String auth)
	throws URISyntaxException
    {
    	if ( auth == null )
    		return;

    	int atPos = auth.indexOf('@');
    	String remain;
    	if ( atPos == -1 ) {
    		remain = auth;
    	} else {
    		userInfo = auth.substring(0, atPos);
    		remain = auth.substring(atPos + 1);
    	}

    	int colPos = remain.indexOf(':');
    	String portString = null;
    	if ( colPos == -1 ) {
    		host = remain;
    	} else {
    		host = remain.substring(0, colPos);
    		portString = remain.substring(colPos + 1);
    	}

    	if ( portString == null )
    		return;

    	try {
    		port = Integer.parseInt(portString);
    	} catch ( NumberFormatException e ) {
    		throw new URISyntaxException("illegal port number: " + portString);
    	}
    }

    private static String encode (String s)
    {
    	if ( s == null )
    		return null;

    	String encoded = null;

    	try {
    		encoded = URLEncoder.encode(s, "UTF8");
    	} catch ( UnsupportedEncodingException e ) {
    		// ignore it
    	}

    	return encoded;
    }

    private void parse (String s)
	throws URISyntaxException
    {
    	int idx = s.indexOf(':');

    	if ( idx == -1 )
    	{
    		// relative URI
    		opaque = false;
    		scheme = null;
    		authority = null;

    		idx = s.lastIndexOf('#');

    		if ( idx == -1 ) {
    			specific = s;
    			fragment = null;
    		} else {
    			specific = s.substring(0, idx);
    			fragment = s.substring(idx + 1);
    		}

    		idx = specific.indexOf('?');
    		if ( idx == -1 ) {
    			path = specific;
    			query = null;
    		} else {
    			path = specific.substring(0, idx);
    			query = specific.substring(idx + 1);
    		}

    		return;
    	}

    	scheme = s.substring(0, idx);
    	String remain = s.substring(idx + 1);

    	idx = remain.lastIndexOf('#');
    	if ( idx == -1 ) {
    		specific = remain;
    		fragment = null;
    	} else {
    		specific = remain.substring(0, idx);
    		fragment = remain.substring(idx + 1);
    	}

    	if ( (specific.length() > 2) &&
	         (specific.charAt(0) == '/') &&
	         (specific.charAt(1) == '/') ) {
    		opaque = false;
    		remain = specific.substring(2);
    	} else {
    		opaque = true;
    		authority = null;
    		path = null;
    		query = null;
    		return;
    	}

    	idx = remain.indexOf('/');
    	if ( idx == -1 )
    	{
    		authority = remain;
    		parseAuthority(authority);
    		path = null;
    		query = null;
    		return;
    	}

    	authority = remain.substring(0, idx);
    	parseAuthority(authority);
    	String pathAndQuery = remain.substring(idx);
    	idx = pathAndQuery.indexOf('?');
    	if ( idx == -1 ) {
    		path = pathAndQuery;
    		query = null;
    	} else {
    		path = pathAndQuery.substring(0, idx);
    		query = pathAndQuery.substring(idx + 1);
    	}

    	return;
    }

    /**
     * �w�肳�ꂽ���������͂��� URI ���쐬���܂��B
     * 
     * @param scheme �X�L�[�}��
     * @param specific 
     * @param fragment �t���O�����g
     */
    static URI create (String scheme, String specific, String fragment)
    {
    	StringBuffer sb = new StringBuffer();

    	if ( scheme != null )
    	{
    		sb.append(scheme);
    		sb.append(':');
    	}
    	if ( specific != null )
    	{
    		sb.append(specific);
    	}
    	if ( fragment != null )
    	{
    		sb.append('#');
    		sb.append(fragment);
    	}
    	return create(sb.toString());
    }

    /**
     * �w�肳�ꂽ���������͂��� URI ���쐬���܂��B
     * 
     * @param scheme �X�L�[�}��
     * @param authority ����
     * @param path �p�X
     * @param query �N�G���[
     * @param fragment �t���O�����g
     */
    static URI create (String scheme, String authority, String path,
		       String query, String fragment)
    {
    	StringBuffer sb = new StringBuffer();
    	if ( scheme != null )
    	{
    		sb.append(scheme);
    		sb.append(':');
    	}
    	if ( authority != null )
    	{
    		sb.append("//");
    		sb.append(authority);
    	}
    	if ( path != null )
    	{
    		sb.append(path);
    	}
    	if ( query != null )
    	{
    		sb.append('?');
    		sb.append(query);
    	}
    	if ( fragment != null )
    	{
    		sb.append('#');
    		sb.append(fragment);
    	}

    	return create(sb.toString());
    }

    /**
     * �w�肳�ꂽ���������͂��� URI ���쐬���܂��B
     * 
     * @param s URI �ɉ�͂���镶����
     * @return �V���� URI 
     */
    public static URI create (String s)
    {
    	try {
    		return new URI(s);
    	} catch (URISyntaxException e) {
    		throw new IllegalArgumentException("Invalid URI: " + s);
    	}
    }

    /**
     * �w�肳�ꂽ���������͂��� URI ���\�z���܂��B 
     * 
     * @param s URI �ɉ�͂���镶����
     * @throws URISyntaxException ��L�̕ύX�Œǉ����ꂽ�悤�ɁA�w�肳�ꂽ������ RFC 2396 �Ɉᔽ���Ă���ꍇ
     */
    public URI (String s)
	throws URISyntaxException
    {
    	parse(s);
    }
    
    /**
     * ���̒��ۃp�X������΂��ǂ����𔻒肵�܂��B
     * 
     * @return ���̒��ۃp�X������΂ł���ꍇ�� true�A�����łȂ��ꍇ�� false
     */
    public boolean isAbsolute ()
    {
    	return (scheme != null);
    }

    /**
     * ���� URI ���s�������ǂ�����ʒm���܂��B 
     * 
     * @return ���� URI ���s�����̏ꍇ���� true
     */
    public boolean isOpaque ()
    {
    	return opaque;
    }

    /**
     * ���̃��\�b�h�̃f�t�H���g�̓���́A���b�v���ꂽ�v���I�u�W�F�N�g�ɑ΂� getScheme() ���Ăяo�����Ƃł��B
     * 
     * @return ���̗v���Ɏg�p�����X�L�[�}�̖��O���i�[���ꂽ String
     */
    public String getScheme ()
    {
    	return scheme;
    }

    /**
     * �T�[�r�X URL �̃z�X�g�����ł��B
     * 
     * @return �T�[�r�X URL �̃z�X�g�����Bnull �͕s��
     */
    public String getHost ()
    {
    	return host;
    }

    /**
     * �T�[�r�X URL �̃|�[�g�ł��B
     * 
     * @return �T�[�r�X URL �̃|�[�g�B���݂��Ȃ��ꍇ�� 0

     */
    public int getPort ()
    {
    	return port;
    }

    /**
     * ���� URI �̂��̂܂܂̃p�X�R���|�[�l���g��Ԃ��܂��B
     * 
     * @return ���� URI �̃p�X�R���|�[�l���g�B�p�X������`�̏ꍇ�� null
     */
    public String getRawPath ()
    {
    	return path;
    }

    /**
     * ���� URI �̂��̂܂܂̃N�G���[�R���|�[�l���g��Ԃ��܂��B
     * 
     * @return ���� URI �̂��̂܂܂̃N�G���[�R���|�[�l���g�B�N�G���[������`�̏ꍇ�� null
     */
    public String getRawQuery ()
    {
    	return query;
    }

    /**
     * ���� URI �̃p�X�𐳋K�����܂��B
     * 
     * @param path �p�X
     * @param getDir
     * @return ���� URI �Ɠ����� URI�B�������A���̃p�X�͐��K�`��
     */
    private String normalize (String path, boolean getDir)
    {
    	if ( path == null )
    		return null;

    	int len = path.length();
    	boolean absPath = false;
    	if ( (len > 0) &&
    		 (path.charAt(0) == '/') )
    	{
    		absPath = true;
    	}
    	boolean isDir = false;

    	StringTokenizer st = new StringTokenizer(path, "/", true);

    	int depth = 0;
    	int nBack = 0;
    	LinkedList pathComponents = new LinkedList();
    	while ( st.hasMoreTokens() )
    	{
    		String token = st.nextToken();

    		if ( token.equals("/") )
    		{
    			isDir = true;
    			continue;
    		}

    		if ( token.equals(".") )
    		{
    			continue;
    		}

    		if ( token.equals("..") )
    		{
    			if ( depth == 0 ) {
    				nBack ++;
    			} else {
    				depth --;
    				pathComponents.removeLast();
    			}
    			continue;
    		}

    		isDir = false;
    		depth ++;
    		pathComponents.addLast(token);
    	}

    	StringBuffer sb = new StringBuffer();

    	if ( absPath )
    	{
    		sb.append('/');
    	}

    	for ( int i = 0; i < nBack; i++ )
    	{
    		sb.append("../");
    	}

    	Iterator it = pathComponents.iterator();
    	while ( it.hasNext() )
    	{
    		sb.append((String)it.next());
    		if ( it.hasNext() )
    		{
    			sb.append('/');
    		}
    	}

    	len = sb.length();
    	if ( isDir && (len > 0) && (sb.charAt(len - 1) != '/') )
    	{
    		sb.append('/');
    	}

    	String normalized = sb.toString();
    	if ( getDir )
    	{
    		int idx = normalized.lastIndexOf('/');
    		if ( idx != -1 )
    		{
    			normalized = normalized.substring(0, idx + 1);
    		}
    	}

    	return normalized;
    }

    /**
     * ���� URI �̃p�X�𐳋K�����܂��B
     * 
     * @return ���ʂ� URI
     */
    public URI normalize ()
    {
    	if ( path == null )	// includes opaque cases
    		return this;

    	return create(scheme, authority, normalize(path, false),
    			query, fragment);
    }

    /**
     * �w�肳�ꂽ URI ������ URI �ɑ΂��ĉ������܂��B
     * 
     * @param s ���� URI �ɑ΂��ĉ�������� URI 
     * @return ���ʂ� URI 
     */
    public URI resolve (String s)
    {
    	return resolve(create(s));
    }
    
    /**
     * �w�肳�ꂽ URI ������ URI �ɑ΂��ĉ������܂��B
     * 
     * @param uri ���� URI �ɑ΂��ĉ�������� URI 
     * @return ���ʂ� URI 
     */
    public URI resolve (URI uri)
    {
    	if ( uri.isAbsolute() )	// includes opaque cases
    		return uri;
    	if ( (! isAbsolute()) || isOpaque() )
    		return uri;

    	// this is an absolute URI and <var>uri</var> is an relative URI.
    	// both are not opaque.

    	if ( uri.fragment != null )
    	{
    		if ( (uri.authority == null) &&
		         (uri.query == null) &&
		         ((uri.path == null) || (uri.path.length() == 0)) )
    			return create(scheme, authority, normalize(path, false),
    					query, uri.fragment);
    	}

    	if ( (path == null) ||
	       ( (uri.path != null) &&
	         (uri.path.length() > 0) &&
	         (uri.path.charAt(0) == '/') ) )
    	{
    		return create(scheme, authority, normalize(uri.path, false),
    				uri.query, uri.fragment);
    	}

    	//int len = path.length();
    	String dir = normalize(path, true);
    	return create(scheme, authority, normalize(dir + uri.path, false),
    			uri.query, uri.fragment);
    }

    /**
     * �w�肳�ꂽ URI ������ URI �ɑ΂��đ��Ή����܂��B
     * 
     * @param s ���� URI �ɑ΂��đ��Ή������ URI 
     * @return ���ʂ� URI 
     */
    public URI relativize (String s)
    {
    	return relativize(create(s));
    }
    
    /**
     * �w�肳�ꂽ URI ������ URI �ɑ΂��đ��Ή����܂��B
     * 
     * @param uri ���� URI �ɑ΂��đ��Ή������ URI 
     * @return ���ʂ� URI 
     */
    public URI relativize (URI uri)
    {
    	if ( isOpaque() || uri.isOpaque() )
    		return uri;
    	if ( (! scheme.equalsIgnoreCase(uri.scheme)) ||
	         (! authority.equals(uri.authority)) )
    		return uri;

    	if ( (path == null) || (uri.path == null) )
    		return uri;

    	String prefix = normalize(path, false);
    	String target = normalize(uri.path, false);
    	if ( ! target.startsWith(prefix) )
    		return uri;

    	String relPath = target.substring(prefix.length());
    	if ( (relPath.length() > 0) && (relPath.charAt(0) == '/') )
    		relPath = relPath.substring(1);
    	return create(null, null, relPath, uri.query, uri.fragment);
    }

    /**
     * ���� URI ���� URL ���\�z���܂��B
     * 
     * @return ���� URI ����\�z���ꂽ URL 
     * @throws MalformedURLException URL �̃v���g�R���n���h���������ł��Ȃ������ꍇ�A�܂��� URL �̍\�z���ɂق��̃G���[�����������ꍇ
     */
    public URL toURL ()
	throws MalformedURLException
    {
    	return new URL(toASCIIString());
    }

    /**
     * ���� URI �̃R���e���c�� US-ASCII ������Ƃ��ĕԂ��܂��B
     * 
     * @return ���� URI �̕�����`���B�K�v�ɉ����āAUS-ASCII �����Z�b�g�̕����������܂ނ悤�ɕ����������
     */
    public String toASCIIString ()
    {
    	StringBuffer sb = new StringBuffer();

    	if ( scheme != null )
    	{
    		sb.append(scheme);
    		sb.append(':');
    	}

    	if ( isOpaque() )
    	{
    		if ( specific != null )
    		{
    			sb.append(specific);
    		}
    		if ( fragment != null )
    		{
    			sb.append('#');
    			sb.append(encode(fragment));
    		}
    		return sb.toString();
    	}

    	if ( authority != null )
    	{
    		sb.append("//");
    		sb.append(authority);
    	}
    	if ( path != null )
    	{
    		sb.append(path);
    	}
    	if ( query != null )
    	{
    		sb.append('?');
    		sb.append(query);
    		
    	}
    	if ( fragment != null )
    	{
    		sb.append('#');
    		sb.append(encode(fragment));
    	}

    	return sb.toString();
    }

    /**
     * ���� URI �̃R���e���c�𕶎���Ƃ��ĕԂ��܂��B
     * 
     * @return ���� URI �̕�����`��
     */
    public String toString()
    {
    	return toASCIIString();
    }

    /**
     * ���� URI ���ʂ̃I�u�W�F�N�g�Ɠ��������ǂ����𔻒肵�܂��B
     * 
     * @param o ���̃I�u�W�F�N�g�Ɣ�r����I�u�W�F�N�g 
     * @return �w�肳�ꂽ�I�u�W�F�N�g������ URI �Ɠ��� URI �ł���ꍇ���� true
     */
    public boolean equals (Object o)
    {
    	if ( (o == null) || (! (o instanceof URI)) )
    		return false;

    	URI uri = (URI)o;

    	if ( (scheme == null) && (uri.scheme != null) )
    		return false;
    	if ( (scheme != null) &&
	       (! scheme.equalsIgnoreCase(uri.scheme)) )
    		return false;

    	if ( isOpaque() )
    	{
    		if ( (specific == null) && (uri.specific != null) )
    			return false;
    		if ( (specific != null) &&
		       (! specific.equals(uri.specific)) )
    			return false;

    		if ( (fragment == null) && (uri.fragment != null) )
    			return false;
    		if ( (fragment != null) &&
		       (! fragment.equals(uri.fragment)) )
    			return false;

    		return true;
    	}

    	if ( (authority == null) && (uri.authority != null) )
    		return false;
    	if ( (authority != null) &&
	       (! authority.equals(uri.authority)) )
    		return false;

    	String norm1 = normalize(path, false);
    	String norm2 = normalize(uri.path, false);
    	if ( (norm1 == null) && (norm2 != null) )
    		return false;
    	if ( (norm1 != null) &&
	       (! norm1.equals(norm2)) )
    		return false;

    	if ( (fragment == null) && (uri.fragment != null) )
    		return false;
    	if ( (fragment != null) &&
	       (! fragment.equals(uri.fragment)) )
    		return false;

    	return true;
    }

    // test routines
    void dump ()
    {
    	System.err.println("Scheme: " + scheme);
    	System.err.println("Specific: " + specific);
    	System.err.println("Authority: " + authority);
    	System.err.println("UserInfo: " + userInfo);
    	System.err.println("Host: " + host);
    	System.err.println("Port: " + port);
    	System.err.println("Path: " + path);
    	System.err.println("Query: " + query);
    	System.err.println("Fragment: " + fragment);
    	System.err.println("Opaque: " + opaque);
    	System.err.println();
    }

//	public static void main (String[] args)
//	{
//		try {
//			URI a = new URI("http://devnt.dev.cybozu.co.jp/");
//			a.dump();
//			URI b = new URI("../foobar/zot.c?page=File#review");
//			b.dump();
//
//			URI c = a.resolve(b);
//			c.dump();
//			URI d = a.relativize(c);
//			d.dump();
//
//			URI e = new URI("/abc/def//../../ghi/./foo.c/");
//
//			e.normalize().dump();
//			URI f = new URI("http://ymmt@cybozu.co.jp:39/abc/#eof");
//			f.dump();
//
//		} catch (URISyntaxException e) {
//			e.printStackTrace();
//		}
//	}
}
