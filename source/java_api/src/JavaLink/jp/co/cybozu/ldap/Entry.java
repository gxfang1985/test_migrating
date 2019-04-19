/* Entry.java */
package jp.co.cybozu.ldap;

import jp.co.cybozu.text.ParseException;
import java.util.*;
import java.io.*;

/**
 * LDAPのエントリをメモリ上に表現する。<br>
 * 具体的には、識別名 (DN) と属性の集合から構成される。
 *
 * @author サイボウズ
 * @version	1.0.0
 */
public class Entry
{
    /** 
     * このエントリの 識別名 (DN)。
     */
    protected final DN		dn;

    /** 
     * このエントリの持つ属性の集合。 
     */
    protected final List	attributes = new ArrayList(16);

    Entry()
    {
    	dn = null;
    }

    /**
     * <var>dn</var> を 識別名 (DN) として持つ、新たなエントリを作成する。
     *
     * @param dn 作成するエントリの 識別名 (DN)
     */
    public Entry(DN dn)
    {
    	this.dn = dn;
    	attributes.add( new Attribute("dn", dn.toString()) );
    }

    /**
     * このエントリの 識別名 (DN) を返す。
     */
    public DN getDN()
    {
    	return dn;
    }

    /**
     * このエントリの持つ属性の集合に、attr を追加する。
     *
     * @param attr 追加する属性。
     */
    public void addAttribute(Attribute attr)
    {
    	attributes.add(attr);
    }

    /**
     * このエントリの持つ属性の集合から、指定された属性の値を返す。
     *
     * @param type 属性名
     * @return もし指定された属性があれば、最初にみつかったその属性の値。 なければ null。
     */
    public String getAttribute(String type)
    {
    	// alias
    	if ( substance != null )
    	{
    		return substance.getAttribute( type );
    	}

    	Iterator it = attributes.iterator();
    	while ( it.hasNext() )
    	{
    		Attribute attr = (Attribute)it.next();
    		if ( attr.type.equalsIgnoreCase( type ) )
    		{
    			return attr.value;
    		}
    	}
    	return null;
    }

    /**
     * このエントリの持つ属性の集合から、指定された属性の値を全て返す。
     *
     * @param type 属性名
     * @return 属性値のリスト
     */
    public List getAttributes(String type)
    {
    	// alias
    	if ( substance != null )
    	{
    		return substance.getAttributes( type );
    	}

    	ArrayList attrs = new ArrayList(8);

    	Iterator it = attributes.iterator();
    	while ( it.hasNext() )
    	{
    		Attribute attr = (Attribute)it.next();
    		if ( attr.type.equalsIgnoreCase( type ) )
    		{
    			attrs.add( attr.value );
    		}
    	}
    	return attrs;
    }


    // tree structure

    protected Entry		parent;
    protected final List	children = new ArrayList(8);

    /**
     * 子エントリを追加する。
     * 
     * @param child 
     */
    public void addChild(Entry child)
    {
    	child.setParent( this );
    	children.add(child);
    }

    private void setParent(Entry parent)
    {
    	if ( this.parent != null )
    	{
    		this.parent.children.remove(this);
    	}
    	this.parent = parent;
    }

    /**
     * 親エントリを返す。
     * 
     * @return 親エントリ、もしなければ null。
     */
    public Entry getParent()
    {
    	return parent;
    }

    /**
     * 子エントリの、変更不可能なリストを返す。
     * 
     * @return 変更不可能なリスト
     */
    public List getChildren()
    {
    	return Collections.unmodifiableList( children );
    }

    /**
     * もしこのエントリが <var>entry</var> の親エントリを表す場合、またその時のみ <kbd>true</kbd> を返す。
     * 
     * @param entry エントリ
     * @return エントリが entry の親エントリを表す場合、またその時のみ true
     */
    public boolean isParent(Entry entry)
    {
    	return dn.isParent(entry.dn);
    }

    /**
     * もしこのエントリが <var>entry</var> より上の位置のエントリであれば、 またその時のみ <kbd>true</kbd> を返す。
     * 
     * @param entry エントリ
     * @return エントリが entry より上の位置のエントリであれば、 またその時のみ true
     */
    public boolean isAncestor(Entry entry)
    {
    	return dn.isAncestor(entry.dn);
    }

    /**
     * もしこのエントリが <var>entry</var> の子エントリを表す場合、 またその時のみ <kbd>true</kbd> を返す。
     *  
     * @param entry エントリ
     * @return エントリが entry の子エントリを表す場合、 またその時のみ true
     */
    public boolean isChild(Entry entry)
    {
    	return dn.isChild(entry.dn);
    }

    /**
     * もしこのエントリが <var>entry</var> より下の位置のエントリであれば、 またその時のみ <kbd>true</kbd> を返す。
     *  
     * @param entry エントリ
     * @return エントリが entry より下の位置のエントリであれば、 またその時のみ true
     */
    public boolean isDescendant(Entry entry)
    {
    	return dn.isDescendant(entry.dn);
    }

    /**
     * もしこのエントリがルートであれば、すなわち親エントリを持たなければ、 またその時のみ <kbd>true</kbd> を返す。
     */
    public boolean isRoot()
    {
    	return (parent == null);
    }


    // alias dereference
    private Entry substance = null;	// dereferenced entry.

    /**
     * もしこのエントリが別名 <kbd>alias</kbd> エントリであれば、またその時のみ <kbd>true</kbd> を返す。
     */
    public boolean isAlias()
    {
    	Iterator it = attributes.iterator();
    	while ( it.hasNext() )
    	{
    		Attribute attr = (Attribute)it.next();
    		if ( attr.type.equalsIgnoreCase( "objectclass" ) &&
    				attr.value.equals( "alias" ) )
    		{
    			return true;
    		}
    	}
    	return false;
    }

    /**
     * もしこのエントリが別名 (alias) エントリであれば、その参照先の エントリを返す。<br>
     * 別名エントリでないか、あるいは参照先のエントリが 存在しなければ、<kbd>null</kbd> を返す。
     */
    public Entry derefAlias()
    {
    	return substance;
    }

    /**
     * Resolve alias iff this entry is an alias entry.  If not, this
     * does nothing.
     *
     * @param dnToEntry mapping from DN to the corresponding entry.
     * @throws ParseException if the value of <kbd>aliasedObjectName</kbd>
     * attribute is not valid DN string.
     */
    public void resolveAlias(Map dnToEntry)
	throws ParseException
    {
    	if ( substance != null )
    		return;

    	boolean isAliasClass = false;
    	String aliasDN = null;

    	Iterator it = attributes.iterator();
    	while ( it.hasNext() )
    	{
    		Attribute attr = (Attribute)it.next();
    		if ( attr.type.equalsIgnoreCase( "objectclass" ) &&
		         attr.value.equals( "alias" ) )
    		{
    			isAliasClass = true;
    		}

    		if ( attr.type.equalsIgnoreCase( "aliasedObjectName" ) )
    		{
    			aliasDN = attr.value;
    		}
    	}

    	if ( ( ! isAliasClass ) || (aliasDN == null) )
    		return;

    	substance = (Entry)dnToEntry.get( new DN(aliasDN) );
    }


    public String toString()
    {
    	StringBuffer sb = new StringBuffer();

    	Iterator it = attributes.iterator();
    	while ( it.hasNext() )
    	{
    		Attribute attr = (Attribute)it.next();
    		sb.append( attr.toString() );
    		sb.append( '\n' );
    	}
    	return sb.toString();
    }

    /**
     * <var>o</var> にこのエントリを LDIF 形式で書き出す。 
     *
     * @param o ライター
     */
    public void dump( PrintWriter o )
    {
    	Iterator it = attributes.iterator();
    	while ( it.hasNext() )
    	{
    		Attribute attr = (Attribute)it.next();
    		o.println( attr.toLdif() );
    		//o.println( attr.toString() );
    	}

    	it = children.iterator();
    	while ( it.hasNext() )
    	{
    		o.println();
    		((Entry)it.next()).dump(o);
    	}
    }
}
