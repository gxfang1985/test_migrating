/* ConfigParser.java */
package jp.co.cybozu.text;

import java.util.*;
import java.io.*;
//import jp.co.cybozu.garoon2.*;

/**
 * {@link Properties} �N���X�Ɠ��l�̐ݒ�t�@�C���p�[�T�ł��B<br>
 * �B��̈Ⴂ�́A���̃N���X�� load �œǂݍ��߂�t�@�C���́A������G���R�[�f�B���O���w��\�Ȃ��Ƃł��B<br>
 * ���̂��߁AASCII �ȊO�̌`���ŋL�q���ꂽ�ݒ�t�@�C����ǂݍ��߂܂��B
 *
 * @author �T�C�{�E�Y
 * @version	1.0.0
 */
public class ConfigParser extends HashMap
{
    private class ConcatReader extends LineNumberReader
    {
    	public ConcatReader(Reader r)
    	{
    		super(r);
    	}

    	public ConcatReader(Reader r, int sz)
    	{
    		super(r, sz);
    	}

    	private boolean eofReached = false;

    	public String readLine()
	    throws IOException
	    {
    		if ( eofReached )
    		{
    			return null;
    		}

    		String l = super.readLine();
    		if ( l == null )
    		{
    			eofReached = true;
    			return null;
    		}

    		while ( true )
    		{
    			if ( ! l.endsWith("\\") )
    				break;

    			l = l.substring(0, l.length() - 1);

    			String nextl = super.readLine();
    			if ( nextl == null )
    			{
    				eofReached = true;
    				return l;
    			}

    			int LEN = nextl.length();
    			int i;
    			for ( i = 0; i < LEN; i++ )
    			{
    				if ( ! Character.isWhitespace( nextl.charAt(i) ) )
    					break;
    			}

    			l += nextl.substring(i);
    		}
    		return l;
	    }
    }


    /**
     * {@link #load(InputStream)} �Ŏg�p�����f�t�H���g�̕�����G���R�[�f�B���O�B<br>
     * ���݂� "JISAutoDetect" �ł��B
     */
    public static final String DEFAULT_ENCODING = "JISAutoDetect";

    /**
     * �v���p�e�B����؎����Ȃ���ԂŁA�p�[�U�[���쐬���܂��B
     */
    public ConfigParser()
    {
    	super();
    }

    /**
     * �p�[�T���쐬���A<var>in</var> �Ŏw�肳�ꂽ�ݒ�t�@�C���� {@link #load} �œǂݍ��݂܂��B<br>
     * �ݒ�t�@�C���̕�����G���R�[�f�B���O�ɂ� {@link #DEFAULT_ENCODING} ���g�p����܂��B
     *
     * @param in �p�[�X����ݒ�t�@�C���̃X�g���[��
     * @throws IOException <var>in</var> ����̓ǂݍ��݂Ɏ��s���� 
     * @throws ParseException �ݒ�t�@�C���̋L�q���s��
     */
    public ConfigParser( InputStream in )
	throws IOException, ParseException
    {
    	super();
    	load( in );
    }

    /**
     * �p�[�T���쐬���A<var>in</var> �Ŏw�肳�ꂽ�ݒ�t�@�C���� {@link #load load} �œǂݍ��݂܂��B
     *
     * @param in �p�[�X����ݒ�t�@�C���̃X�g���[��
     * @param enc �X�g���[���̕�����G���R�[�f�B���O
     * @throws IOException <var>in</var> ����̓ǂݍ��݂Ɏ��s�����A���邢�͕s���ȕ�����G���R�[�f�B���O���w�肵���B
     * @throws ParseException �ݒ�t�@�C���̋L�q���s��
     */
    public ConfigParser( InputStream in, String enc )
	throws IOException, ParseException
    {
    	super();
    	load( in, enc );
    }

    /**
     * <var>in</var> ����ݒ�t�@�C���̓��e��ǂݍ��݁A��`����Ă���v���p�e�B��ǉ����܂��B<br>
     * �ǂݍ��݂Ɏg�p���郋�[���� {@link Properties#load} �Ɠ����ł��B<br>
     * �ݒ�t�@�C���̕�����G���R�[�f�B���O�� {@link #DEFAULT_ENCODING} �Ɖ��肵�܂��B
     *
     * @param in �p�[�X����ݒ�t�@�C���̃X�g���[��
     * @throws IOException <var>in</var> ����̓ǂݍ��݂Ɏ��s�����B
     * @throws ParseException �ݒ�t�@�C���̋L�q���s��
     */
    public void load( InputStream in )
	throws IOException, ParseException
    {
    	load(in, DEFAULT_ENCODING);
    }

    /**
     * <var>in</var> ����ݒ�t�@�C���̓��e��ǂݍ��݁A��`����Ă���v���p�e�B��ǉ����܂��B<br>
     * �ǂݍ��݂Ɏg�p���郋�[���� {@link Properties#load} �Ɠ����ł��B<br>
     * �ݒ�t�@�C���̕�����G���R�[�f�B���O�� <var>enc</var> �Ɖ��肵�܂��B
     *
     * @param in �p�[�X����ݒ�t�@�C���̃X�g���[��
     * @param enc �X�g���[���̕�����G���R�[�f�B���O
     * @throws IOException <var>in</var> ����̓ǂݍ��݂Ɏ��s�����A���邢�͕s���ȕ�����G���R�[�f�B���O���w�肵���B
     * @throws ParseException �ݒ�t�@�C���̋L�q���s��
     */
    public void load( InputStream in, String enc )
	throws IOException, ParseException
    {
    	LineNumberReader lin =
    		new ConcatReader(
    		new InputStreamReader( in, enc ) );

    	READLINE:
	    while ( true )
	    {
	    	String line = lin.readLine();
	    	if ( line == null )
	    	{
	    		break;
	    	}
	    	StringReader sr = new StringReader( line );
	    	StringBuffer sbKey = new StringBuffer();
	    	StringBuffer sbValue = new StringBuffer();
	    	StringBuffer sb = sbKey;
	    	boolean escaping = false;
	    	boolean seenseparator = false;
	    	int step = 0;
	    	while ( true )
	    	{
	    		int ic = sr.read();
	    		if ( (ic == -1) )
	    		{
	    			break;
	    		}
	    		char c = (char)ic;

	    		if ( (step == 0) &&
		           ( (c == '#') || (c == '!') ) )
	    		{
	    			sr.close();
	    			continue READLINE;
	    		}

	    		if ( Character.isWhitespace( c ) )
	    		{
	    			if ( (step == 0) ||
	    	 			 (step == 2) )
	    			{
	    				continue;
	    			}

	    			if ( escaping || (step == 3) )
	    			{
	    				escaping = false;
	    				sb.append(c);
	    				continue;
	    			}

	    			// step == 1
	    			step ++;
	    			sb = sbValue;
	    			continue;
	    		}

	    		if ( c == '\\' )
	    		{
	    			if ( (step == 0) || (step == 2) )
	    			{
	    				step ++;
	    			}

	    			if ( escaping ) {
	    				sb.append('\\');
	    				escaping = false;
	    			} else {
	    				escaping = true;
	    			}
	    			continue;
	    		}

	    		if ( (! seenseparator) && ( (c == '=') || (c == ':') ) )
	    		{
	    			seenseparator = true;

	    			if ( step == 0 )
	    				throw new ParseException("syntax error",
	    						lin.getLineNumber());

	    			if ( step == 2 )
	    			{
	    				continue;
	    			}

	    			if ( escaping )
	    			{
	    				escaping = false;
	    				sb.append(c);
	    				continue;
	    			}

	    			if ( step == 1 )
	    			{
	    				step ++;
	    				sb = sbValue;
	    				continue;
	    			}

	    			if ( step == 3 )
	    			{
	    				sb.append(c);
	    				continue;
	    			}
	    		}

	    		if ( escaping )
	    		{
	    			escaping = false;
	    			if ( step == 1 )
	    			{
	    				sb.append(c);
	    				continue;
	    			}

	    			if ( c == 't' )
	    			{
	    				sb.append('\t');
	    				continue;
	    			}
	    			if ( c == 'n' )
	    			{
	    				sb.append('\n');
	    				continue;
	    			}
	    			if ( c == 'r' )
	    			{
	    				sb.append('\r');
	    				continue;
	    			}
	    			if ( c == 'u' )
	    			{
	    				StringBuffer ub = new StringBuffer();
	    				for (int i = 0; i < 4; i++ )
	    				{
	    					int d = sr.read();
	    					if ( (d == -1) )
	    						throw new ParseException("unexpected end of line",
	    								lin.getLineNumber());
	    					ub.append((char)d);
	    				}

	    				try {
	    					sb.append( (char)Integer.parseInt(ub.toString(), 16) );
	    				} catch (NumberFormatException e) {
	    					throw new ParseException("illegal unicode escape: " + ub.toString(),
	    							lin.getLineNumber());
	    				}
	    				continue;
	    			}

	    			sb.append( c );
	    			continue;
    			}

	    		if ( (step == 0) || (step == 2) )
	    		{
	    			step ++;
	    		}
	    		sb.append( c );
	    	}

	    	sr.close();

	    	if ( step > 0 )
	    	{
	    		setProperty( sbKey.toString(), sbValue.toString() );
	    	}
	    }
    }

    /**
     * �w�肳�ꂽ�L�[�̃v���p�e�B���������ĕԂ��܂��B
     *
     * @param key �v���p�e�B�̃L�[
     * @return �����L�[�ɓK������v���p�e�B������΁A���̒l�B�Ȃ���� null�B
     */
    public String getProperty(String key)
    {
    	return get(key).toString();
    }

    /**
     * {@link HashMap#put} ���Ăяo���ăv���p�e�B��ݒ肵�܂��B<br>
     * �Ԃ����l�́A{@link HashMap#put} �ŕԂ������̂ł��B
     *
     * @param key �v���p�e�B�̃L�[
     * @param value �v���p�e�B�̒l 
     * @return �ȑO�ɓ����L�[�̃v���p�e�B���ݒ肳��Ă���΁A�ȑO�̒l�B�Ȃ���� <kbd>null</kbd>�B
     */
    public Object setProperty(String key, String value)
    {
    	return put(key, value);
    }

    /**
     * �ݒ肳�ꂽ�S�Ẵv���p�e�B���������A{@link Properties}�I�u�W�F�N�g���쐬���Ԃ��܂��B
     *
     * @return {@link Properties}�I�u�W�F�N�g���쐬���Ԃ��܂��B
     */
    public Properties getProperties()
    {
    	Properties props = new Properties();

    	Iterator it = entrySet().iterator();
    	while ( it.hasNext() )
    	{
    		Map.Entry ent = (Map.Entry)it.next();
    		props.setProperty( ent.getKey().toString(),
    				ent.getValue().toString() );
    	}

    	return props;
    }

    /**
     * �ݒ肳�ꂽ�S�Ẵv���p�e�B���������A{@link Properties}�I�u�W�F�N�g���쐬���Ԃ��܂��B<br>
     * ���̍ہA�v���p�e�B�̃f�t�H���g�l��񋟂��� <var>defaults</var> ���w�肵�܂��B
     *
     * @param defaults �f�t�H���g�v���p�e�B
     * @return {@link Properties}�I�u�W�F�N�g���쐬���Ԃ��܂��B
     */
    public Properties getProperties( Properties defaults )
    {
    	Properties props = new Properties( defaults );

    	Iterator it = entrySet().iterator();
    	while ( it.hasNext() )
    	{
    		Map.Entry ent = (Map.Entry)it.next();
	    	props.setProperty( ent.getKey().toString(),
			       ent.getValue().toString() );
    	}

    	return props;
    }
}
