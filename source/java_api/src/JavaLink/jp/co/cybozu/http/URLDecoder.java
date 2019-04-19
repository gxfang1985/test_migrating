package jp.co.cybozu.http;

import java.io.*;

/**
 * J2SDK1.4.0 �Ɋ܂܂�� {@link URLDecoder} �N���X�̃R���p�`�u���N���X�ł�
 *
 * @author �T�C�{�E�Y
 * @version	1.0.0
 */
public class URLDecoder
{
    private URLDecoder () {}

    private static int hexToint (char c)
    {
    	if ( ('a' <= c) && (c <= 'f') )
    	{
    		return (int)(c - 'a') + 10;
    	}

    	if ( ('A' <= c) && (c <= 'F') )
    	{
    		return (int)(c - 'A') + 10;
    	}

    	if ( ('0' <= c) && (c <= '9') )
    	{
    		return (int)(c - '0');
    	}

    	throw new IllegalArgumentException("Illegal hexadecimal character.");
    }

    /**
     * ���ʂȕ������������g�p���� application/x-www-form-urlencoded ������𕜍������܂��B�w�肳�ꂽ�������������g�p���āA�u%xy�v�̌`���̘A���V�[�P���X���\�����������肵�܂��B
     *
     * @param s �������Ώۂ� String
     * @param enc �T�|�[�g�����u�����G���R�[�f�B���O�v�̖��O
     * @return �V�������������ꂽ String 
     * @throws UnsupportedEncodingException �w�肳�ꂽ�����G���R�[�f�B���O���T�|�[�g����Ă��Ȃ��ꍇ
     * @throws IllegalArgumentException If <var>s</var> contains illegal
     * characters.
     */
    public static String decode (String s, String enc)
	throws UnsupportedEncodingException
    {
    	if ( s == null )
    		throw new NullPointerException("s is null.");
    	if ( enc == null )
    		throw new NullPointerException("enc is null.");

    	// WARNING: do not use PIPE since it may cause deadblocks.
    	ByteArrayOutputStream o = new ByteArrayOutputStream();

    	final int len = s.length();
    	for ( int i = 0; i < len; i++ )
    	{
    		char c = s.charAt(i);

    		if ( ( ('a' <= c) && (c <= 'z') ) ||
		         ( ('A' <= c) && (c <= 'Z') ) ||
		         ( ('0' <= c) && (c <= '9') ) ||
		         ( c == '.' ) ||
		         ( c == '-' ) ||
		         ( c == '*' ) ||
		         ( c == '_' ) )
    		{
    			o.write(c);
    			continue;
    		}

    		if ( c == '+' )
    		{
    			o.write(' ');
    			continue;
    		}

    		if ( c == '%' )
    		{
    			if ( i > (len - 3) )
    			{
    				throw new IllegalArgumentException("invalid % escape sequence.");
    			}

    			char c1 = s.charAt(++i);
    			char c2 = s.charAt(++i);
    			int n = hexToint(c1) * 16 + hexToint(c2);
    			o.write(n);
    			continue;
    		}

    		throw new IllegalArgumentException("invalid character in s.");
    	}

    	try {
    		o.close();
    	} catch ( IOException e ) {
    		// ignore it
    	}

    	return new String(o.toByteArray(), enc);
    }
}
