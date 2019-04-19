/* RDN.java */
package jp.co.cybozu.ldap;

import java.util.*;

/**
 * LDAP の 相対識別名 (RDN) を表現する。<br>
 * RDN は属性 (Attribute) の集合として表現される。 
 *
 * @author サイボウズ
 * @version	1.0.0
 */
public class RDN
{
    private final Set components = new HashSet(1);

    /**
     * この 相対識別名 (RDN) を構成する属性の、変更不可能な集合を返す。
     */
    public Set getComponents()
    {
    	return Collections.unmodifiableSet( components );
    }

    /**
     * 名前用属性を含まない、相対識別名 (RDN) オブジェクトを作成する。
     */
    public RDN() {}

    /**
     * <var>attr</var> を唯一つの名前用属性とする 相対識別名 (RDN) オブジェクトを作成する
     *
     * @param attr 名前用属性
     */
    public RDN(Attribute attr)
    {
    	addComponent(attr);
    }

    /**
     * この 相対識別名 (RDN) の名前用属性を追加する。
     *
     * @param attr 名前用属性
     */
    public void addComponent(Attribute attr)
    {
    	components.add(attr);
    }

    /**
     * 識別名 (DN) 中に含めるために適切にエスケープされた、この 相対識別名 (RDN) の UTF-8 文字列 表現を返す。
     *
     * @see Attribute#toEscapedString
     * @see <a href="http://www.ietf.org/rfc/rfc2253.txt">RFC2253</a>
     */
    public String toString()
    {
    	StringBuffer sb = new StringBuffer();
    	toString( sb );
    	return sb.toString();
    }

    /**
     * 文字列バッファ sb に、識別名 (DN) 中に含めるために適切にエスケープ された、この 相対識別名 (RDN) の UTF-8 文字列表現を返す。
     *
     * @param sb このオブジェクトの文字列表現
     * @see Attribute#toEscapedString
     * @see <a href="http://www.ietf.org/rfc/rfc2253.txt">RFC2253</a>
     */
    public void toString( StringBuffer sb )
    {
    	boolean needPlus = false;
    	Iterator it = components.iterator();
    	while ( it.hasNext() )
    	{
    		if ( needPlus )
    		{
    			sb.append( '+' );
    		}

    		Attribute attr = (Attribute)it.next();
    		attr.toEscapedString( sb );

    		needPlus = true;
    	}
    }

    /**
     * このオブジェクトと他のオブジェクトが等しいかどうかを示します。
     * 
     * @param o 比較対象の参照オブジェクト
     * @return obj 引数に指定されたオブジェクトとこのオブジェクトが等しい場合は true、そうでない場合は false
     */
    public boolean equals( Object o )
    {
    	if ( ! ( o instanceof RDN ) )
    		return false;

    	RDN rdn = (RDN)o;
    	return components.equals( rdn.components );
    }

    /**
     * オブジェクトのハッシュコード値を返します。
     * 
     * @return このオブジェクトのハッシュコード値
     */
    public int hashCode()
    {
    	return components.hashCode();
    }
}
