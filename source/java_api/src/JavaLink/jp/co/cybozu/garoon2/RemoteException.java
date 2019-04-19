package jp.co.cybozu.garoon2;

/**
 * �ʐM��̃V�X�e���Ŕ���������Q��m�点��B
 *
 * @author �T�C�{�E�Y
 * @version	1.0.0
 */
public class RemoteException extends Exception
{
    /**
     * �ʐM��Ŕ���������Q�̎�ނ������ԍ�
     */
    public final int errno;

    /**
     * �ʐM��̃V�X�e���Ŕ���������Q��m�点��B
     * 
     * @param s �G���[���b�Z�[�W
     */
    public RemoteException (String s)
    {
    	this(s, 0);
    }

    /**
     * �ʐM��̃V�X�e���Ŕ���������Q��m�点��B
     * 
     * @param s �G���[���b�Z�[�W
     * @param errno �G���[�ԍ�
     */
    public RemoteException (String s, int errno)
    {
    	super(s);
    	this.errno = errno;
    }

    /**
     * ���� Integer �̒l��\�� String �I�u�W�F�N�g��Ԃ��܂��B
     */
    public String toString ()
    {
    	if ( errno == 0 )
    		return super.toString();

    	return super.toString() + "\nError Number: " + errno;
    }
}
