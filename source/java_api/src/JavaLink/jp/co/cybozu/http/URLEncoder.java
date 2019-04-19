package jp.co.cybozu.http;

import java.io.*;

/**
 * J2SDK1.4.0 �Ɋ܂܂�� {@link URLEncoder} �N���X�̃R���p�`�u���N���X�ł��B
 *
 * @author �T�C�{�E�Y
 * @version	1.0.0
 */
public class URLEncoder
{
    private URLEncoder () {}

    private static final char[] hexChars =
    {
	'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
	'A', 'B', 'C', 'D', 'E', 'F'
    };

    /**
     * ����̕������������g�p���ĕ������ application/x-www-form-urlencoded �`���ɕϊ����܂��B
     *
     * @param s �ϊ��Ώۂ� String
     * @param enc �T�|�[�g�����u�����G���R�[�f�B���O�v�̖��O
     * @return �ϊ���� String 
     * @throws UnsupportedEncodingException �w�肳�ꂽ�����G���R�[�f�B���O���T�|�[�g����Ă��Ȃ��ꍇ
     */
    public static String encode (String s, String enc)
	throws UnsupportedEncodingException
    {
    	if ( s == null )
    		throw new NullPointerException("s is null.");
    	if ( enc == null )
    		throw new NullPointerException("enc is null.");

    	StringBuffer sb = new StringBuffer();
    	byte[] encoded_data = s.getBytes(enc);

    	for ( int i = 0; i < encoded_data.length; i++ )
    	{
    		char c = (char)(encoded_data[i] & 0xff);	// force unsigned
    		if ( ( ('a' <= c) && (c <= 'z') ) ||
		         ( ('A' <= c) && (c <= 'Z') ) ||
		         ( ('0' <= c) && (c <= '9') ) ||
		           ( c == '.' ) ||
		           ( c == '-' ) ||
		           ( c == '*' ) ||
		           ( c == '_' ) )
    		{
    			sb.append(c);
    			continue;
    		}

    		if ( c == ' ' )
    		{
    			sb.append('+');
    			continue;
    		}

    		sb.append('%');
    		sb.append(hexChars[(c / 16)]);
    		sb.append(hexChars[(c % 16)]);
    	}
    	return sb.toString();
    }
}
