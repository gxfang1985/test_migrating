/* ParseException.java */
package jp.co.cybozu.text;

/**
 * �e��p�[�T���p�[�Y�Ɏ��s�����ۂɓ������O�ł�. �p�[�X���̍s�ԍ������Ă܂��B 
 *
 * @author �T�C�{�E�Y
 * @version	1.0.0
 */
public class ParseException extends Exception
{
    /**
     * ��O�����������s�ԍ��ł�. ���� 0 �ł���΁A�s�ԍ����s���ł��邱�Ƃ������܂��B
     */
    protected int lineNumber;

    /**
     * ��O���쐬���܂��BlineNumber �� 0 �ɐݒ肳��܂��B
     *
     * @param s ��O�̗��R
     */
    public ParseException( String s )
    {
    	super(s);
    }

    /**
     * ��O���쐬���܂��B
     *
     * @param s ��O�̗��R
     * @param lineNumber ��O�����������s�ԍ�
     * thrown.
     */
    public ParseException( String s, int lineNumber )
    {
    	super(s);

    	this.lineNumber = lineNumber;
    }

    /**
     * lineNumber ��Ԃ��܂��B
     */
    public int getLineNumber()
    {
    	return lineNumber;
    }

    /**
     * lineNumber ��ݒ肵�܂��B
     *
     * @param lineNumber �ݒ肷��s�ԍ�
     */
    public void setLineNumber( int lineNumber )
    {
    	this.lineNumber = lineNumber;
    }

	/**
	 * 
	 * <li>�I�[�o�[���C�h</li>
	 * �N���X Throwable ���� {@link #toString}
	 */
    public String toString()
    {
    	StringBuffer sb = new StringBuffer();
    	sb.append( super.toString() );

    	if ( lineNumber > 0 )
    	{
    		sb.append( " at line " );
    		sb.append( lineNumber );
    	}

    	sb.append( "." );
    	return sb.toString();
    }
}
