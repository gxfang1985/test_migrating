/* ParseException.java */
package jp.co.cybozu.text;

/**
 * 各種パーサがパーズに失敗した際に投げる例外です. パース中の行番号を持てます。 
 *
 * @author サイボウズ
 * @version	1.0.0
 */
public class ParseException extends Exception
{
    /**
     * 例外が発生した行番号です. もし 0 であれば、行番号が不明であることを示します。
     */
    protected int lineNumber;

    /**
     * 例外を作成します。lineNumber は 0 に設定されます。
     *
     * @param s 例外の理由
     */
    public ParseException( String s )
    {
    	super(s);
    }

    /**
     * 例外を作成します。
     *
     * @param s 例外の理由
     * @param lineNumber 例外が発生した行番号
     * thrown.
     */
    public ParseException( String s, int lineNumber )
    {
    	super(s);

    	this.lineNumber = lineNumber;
    }

    /**
     * lineNumber を返します。
     */
    public int getLineNumber()
    {
    	return lineNumber;
    }

    /**
     * lineNumber を設定します。
     *
     * @param lineNumber 設定する行番号
     */
    public void setLineNumber( int lineNumber )
    {
    	this.lineNumber = lineNumber;
    }

	/**
	 * 
	 * <li>オーバーライド</li>
	 * クラス Throwable 内の {@link #toString}
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
