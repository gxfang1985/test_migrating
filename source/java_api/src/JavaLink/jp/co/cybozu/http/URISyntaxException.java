package jp.co.cybozu.http;

/**
 * J2SDK1.4.0 以降の URISyntaxException クラスの制限版コンパチブルクラスです。
 *
 * @author サイボウズ
 * @version	1.0.0
 */
public class URISyntaxException extends Exception
{
	/**
	 * 指定された入力文字列、理由、およびエラーインデックスからインスタンスを構築します。
	 * 
	 * @param s 入力文字列
	 */
    public URISyntaxException (String s)
    {
    	super(s);
    }
}
