package jp.co.cybozu.garoon2;

/**
 * ガルーン２パッケージ中のクラスにおいて、必須属性が欠けていたり、 誤った指定がなされている場合に投げられる。
 *
 * @author サイボウズ
 * @version	1.0.0
 */
public class ConfigurationException extends Exception
{
	/**
	 * ガルーン２パッケージ中のクラスにおいて、必須属性が欠けていたり、 誤った指定がなされている場合に投げられる。
	 * 
	 * @param msg エラーメッセージ
	 */
    public ConfigurationException(String msg)
    {
    	super(msg);
    }
}
