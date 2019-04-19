package jp.co.cybozu.ldap;

import jp.co.cybozu.text.Base64;
import java.io.*;
import java.util.*;
import java.net.*;

/**
 * LDAP�̑���(Attribute)��\������B<br>
 * �f�[�^�����o�[�͑S�ĕύX�s�\(immutable)�ł���B
 *
 * @author �T�C�{�E�Y
 * @version	1.0.0
 */
public class Attribute
{
    /**
     * ������ 
     */
    public final String	type;

    /** 
     * �����l  
     */
    public final String	value;

    /**
     * ���̑����ɕt������Ă���I�v�V�����́A�ύX�s�\�ȃ��X�g�B
     */
    public final List	options;

    /**
     * �V���ɑ������쐬����B
     *
     * @param type ������
     * @param value �����l
     */
    public Attribute(String type, String value)
    {
    	this(type, value, null);
    }

    /**
     * �V���ɑ������쐬����B
     *
     * @param type ������
     * @param value �����l
     * @param options �����ɕt������Ă���I�v�V�����̃��X�g
     */
    public Attribute(String type, String value, List options)
    {
    	this.type = type;
    	this.value = value;
    	if ( options != null ) {
    		this.options = Collections.unmodifiableList( options );
    	} else {
    		this.options = null;
    	}
    }

    /**
     * �V���ɑ������쐬����B
     *
     * @param type ������
     * @param value �����l
     */
    public Attribute(String type, byte[] value)
    {
    	this(type, value, null);
    }

    /**
     * �V���ɑ������쐬����B
     *
     * @param type ������
     * @param value �����l
     * @param options �����ɕt������Ă���I�v�V�����̃��X�g
     */
    public Attribute(String type, byte[] value, List options)
    {
    	this.type = type;
    	if ( options != null ) {
    		this.options = Collections.unmodifiableList( options );
    	} else {
    		this.options = null;
    	}

    	String tv = null;
    	try {
    		tv = new String(value, "UTF8");
    	} catch ( UnsupportedEncodingException e ) {
    		// ignore it.
    	}
    	this.value = tv;
    }

    /**
     * �V���ɑ������쐬����. �����l�� <var>url</var> �Ŏw�肳�ꂽ URL ����擾�����B
     *
     * @param type ������
     * @param url �����l�̃f�[�^�\�[�X
     */
    public Attribute(String type, URL url)
	throws IOException
    {
    	this(type, url, null);
    }

    /**
     * �V���ɑ������쐬����. �����l�� <var>url</var> �Ŏw�肳�ꂽ URL ����擾�����B 
     *
     * @param type ������
     * @param url �����l�̃f�[�^�\�[�X
     * @param options �����ɕt������Ă���I�v�V�����̃��X�g
     * @throws IOException �ʐM�G���[����������
     */
    public Attribute(String type, URL url, List options)
	throws IOException
    {
    	this.type = type;
    	if ( options != null ) {
    		this.options = Collections.unmodifiableList( options );
    	} else {
    		this.options = null;
    	}

    	ByteArrayOutputStream o = new ByteArrayOutputStream();
    	InputStream in = url.openStream();
    	byte[] buf = new byte[1024];
    	while ( true )
    	{
    		int nread = in.read(buf);
    		if ( nread == -1 )
    		{
    			in.close();
    			break;
    		}

    		o.write( buf, 0, nread );
    	}

    	this.value = o.toString( "UTF8" );
    }

    /**
     * ���̑����̕�����\����Ԃ��B<br>
     * ���ʂ̕�����͐l�ԂɂƂ��Č��Ղ��`���ŁA�����ȕ��@�͂Ȃ��B<br>
     * �����ɒ�`���ꂽ�`���̕�����\���ɂ� {@link #toEscapedString} ���邢�� {@link #toLdif} ���g�p����B
     * 
     * @return ������\��
     */
    public String toString()
    {
    	StringBuffer sb = new StringBuffer();
    	sb.append(type);

    	if ( options != null )
    	{
    		Iterator it = options.iterator();
    		while ( it.hasNext() )
    		{
    			sb.append( ';' );
    			sb.append( it.next().toString() );
    		}
    	}

    	sb.append( ": " );
    	sb.append( value );

    	return sb.toString();
    }

    /**
     * ������o�b�t�@ <var>sb</var> �ɁA���̑����� ���Ύ��ʖ� (RDN)�Ƃ��Ďg�p���邽�ߓK�؂ɃG�X�P�[�v���ꂽ UTF-8 ������\�� ��ǉ�����B
     *
     * @param sb 
     * @see <a href="http://www.ietf.org/rfc/rfc2253.txt">RFC2253</a>
     */
    public void toEscapedString( StringBuffer sb )
    {
    	sb.append( type );
    	sb.append( '=' );

    	byte[] ba = null;
    	try {
    		ba = value.getBytes( "UTF8" );
    	} catch ( UnsupportedEncodingException e ) {
    		// ignore it.
    	}

    	ByteArrayOutputStream o = new ByteArrayOutputStream();
    	for ( int i = 0; i < ba.length; i++ )
    	{
    		if ( ba[i] == '\r' )
    		{
    			o.write( '\\' );
    			o.write( '0' );
    			o.write( 'D' );
    			continue;
    		}
    		if ( ba[i] == '\n' )
    		{
    			o.write( '\\' );
    			o.write( '0' );
    			o.write( 'A' );
    			continue;
    		}
    		if ( (ba[i] == '#') ||
		         (ba[i] == ' ') ||
		         (ba[i] == ',') ||
		         (ba[i] == '+') ||
		         (ba[i] == '"') ||
		         (ba[i] == '\\') ||
		         (ba[i] == '<') ||
		         (ba[i] == '>') ||
		         (ba[i] == ';') )
    		{
    			o.write( '\\' );
    		}

    		o.write( ba[i] & 0xFF );
    	}

    	try {
    		sb.append( o.toString( "UTF8" ) );
    	} catch ( UnsupportedEncodingException e ) {
    		// ignore it.
    	}
    }

    /**
     * LDIF�t�@�C�����̑�����`�Ƃ��ēK�؂ȁA���̑����̕�����\����Ԃ��B
     * 
     * @return LDIF�`���̕�����\��
     */
    public String toLdif()
    {
    	StringBuffer sb = new StringBuffer();
    	sb.append(type);

    	if ( options != null )
    	{
    		Iterator it = options.iterator();
    		while ( it.hasNext() )
    		{
    			sb.append( ';' );
    			sb.append( it.next().toString() );
    		}
    	}

    	sb.append( ":: " );
    	sb.append( Base64.encode(value) );

    	return sb.toString();
    }

    /**
     * ���̃I�u�W�F�N�g���w�肳�ꂽ�I�u�W�F�N�g�Ɣ�r���܂��B���ʂ� true �ɂȂ�̂́A������ null �ł͂Ȃ��A���̃I�u�W�F�N�g�Ɠ��� int �l���܂� Integer �I�u�W�F�N�g�ł���ꍇ�����ł��B
     * 
     * @param o ��r�Ώۂ̃I�u�W�F�N�g 
     * @return �I�u�W�F�N�g�������ł���ꍇ�� true�A�����łȂ��ꍇ�� false
     */
    public boolean equals( Object o )
    {
    	if ( ! ( o instanceof Attribute ) )
    		return false;

    	Attribute attr = (Attribute)o;
    	if ( ! type.equals( attr.type ) )
    		return false;

    	return value.equals( attr.value );
    }

    /**
     * Integer �̃n�b�V���R�[�h��Ԃ��܂��B 
     * 
     * @return ���̃I�u�W�F�N�g�̃n�b�V���R�[�h�l�B���� Integer �I�u�W�F�N�g���\���v���~�e�B�u�^ int �l�ɓ�����
     */
    public int hashCode()
    {
    	return ( type.hashCode() ^ value.hashCode() );
    }
}
