package jp.co.cybozu.garoon2;

/**
 * 通信先のシステムで発生した障害を知らせる。
 *
 * @author サイボウズ
 * @version	1.0.0
 */
public class RemoteException extends Exception
{
    /**
     * 通信先で発生した障害の種類を示す番号
     */
    public final int errno;

    /**
     * 通信先のシステムで発生した障害を知らせる。
     * 
     * @param s エラーメッセージ
     */
    public RemoteException (String s)
    {
    	this(s, 0);
    }

    /**
     * 通信先のシステムで発生した障害を知らせる。
     * 
     * @param s エラーメッセージ
     * @param errno エラー番号
     */
    public RemoteException (String s, int errno)
    {
    	super(s);
    	this.errno = errno;
    }

    /**
     * この Integer の値を表す String オブジェクトを返します。
     */
    public String toString ()
    {
    	if ( errno == 0 )
    		return super.toString();

    	return super.toString() + "\nError Number: " + errno;
    }
}
