package jp.co.cybozu.http;

/**
 * J2SDK1.4.0 �ȍ~�� URISyntaxException �N���X�̐����ŃR���p�`�u���N���X�ł��B
 *
 * @author �T�C�{�E�Y
 * @version	1.0.0
 */
public class URISyntaxException extends Exception
{
	/**
	 * �w�肳�ꂽ���͕�����A���R�A����уG���[�C���f�b�N�X����C���X�^���X���\�z���܂��B
	 * 
	 * @param s ���͕�����
	 */
    public URISyntaxException (String s)
    {
    	super(s);
    }
}
