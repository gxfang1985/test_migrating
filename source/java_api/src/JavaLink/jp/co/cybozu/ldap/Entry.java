/* Entry.java */
package jp.co.cybozu.ldap;

import jp.co.cybozu.text.ParseException;
import java.util.*;
import java.io.*;

/**
 * LDAP�̃G���g������������ɕ\������B<br>
 * ��̓I�ɂ́A���ʖ� (DN) �Ƒ����̏W������\�������B
 *
 * @author �T�C�{�E�Y
 * @version	1.0.0
 */
public class Entry
{
    /** 
     * ���̃G���g���� ���ʖ� (DN)�B
     */
    protected final DN		dn;

    /** 
     * ���̃G���g���̎������̏W���B 
     */
    protected final List	attributes = new ArrayList(16);

    Entry()
    {
    	dn = null;
    }

    /**
     * <var>dn</var> �� ���ʖ� (DN) �Ƃ��Ď��A�V���ȃG���g�����쐬����B
     *
     * @param dn �쐬����G���g���� ���ʖ� (DN)
     */
    public Entry(DN dn)
    {
    	this.dn = dn;
    	attributes.add( new Attribute("dn", dn.toString()) );
    }

    /**
     * ���̃G���g���� ���ʖ� (DN) ��Ԃ��B
     */
    public DN getDN()
    {
    	return dn;
    }

    /**
     * ���̃G���g���̎������̏W���ɁAattr ��ǉ�����B
     *
     * @param attr �ǉ����鑮���B
     */
    public void addAttribute(Attribute attr)
    {
    	attributes.add(attr);
    }

    /**
     * ���̃G���g���̎������̏W������A�w�肳�ꂽ�����̒l��Ԃ��B
     *
     * @param type ������
     * @return �����w�肳�ꂽ����������΁A�ŏ��ɂ݂��������̑����̒l�B �Ȃ���� null�B
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
     * ���̃G���g���̎������̏W������A�w�肳�ꂽ�����̒l��S�ĕԂ��B
     *
     * @param type ������
     * @return �����l�̃��X�g
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
     * �q�G���g����ǉ�����B
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
     * �e�G���g����Ԃ��B
     * 
     * @return �e�G���g���A�����Ȃ���� null�B
     */
    public Entry getParent()
    {
    	return parent;
    }

    /**
     * �q�G���g���́A�ύX�s�\�ȃ��X�g��Ԃ��B
     * 
     * @return �ύX�s�\�ȃ��X�g
     */
    public List getChildren()
    {
    	return Collections.unmodifiableList( children );
    }

    /**
     * �������̃G���g���� <var>entry</var> �̐e�G���g����\���ꍇ�A�܂����̎��̂� <kbd>true</kbd> ��Ԃ��B
     * 
     * @param entry �G���g��
     * @return �G���g���� entry �̐e�G���g����\���ꍇ�A�܂����̎��̂� true
     */
    public boolean isParent(Entry entry)
    {
    	return dn.isParent(entry.dn);
    }

    /**
     * �������̃G���g���� <var>entry</var> ����̈ʒu�̃G���g���ł���΁A �܂����̎��̂� <kbd>true</kbd> ��Ԃ��B
     * 
     * @param entry �G���g��
     * @return �G���g���� entry ����̈ʒu�̃G���g���ł���΁A �܂����̎��̂� true
     */
    public boolean isAncestor(Entry entry)
    {
    	return dn.isAncestor(entry.dn);
    }

    /**
     * �������̃G���g���� <var>entry</var> �̎q�G���g����\���ꍇ�A �܂����̎��̂� <kbd>true</kbd> ��Ԃ��B
     *  
     * @param entry �G���g��
     * @return �G���g���� entry �̎q�G���g����\���ꍇ�A �܂����̎��̂� true
     */
    public boolean isChild(Entry entry)
    {
    	return dn.isChild(entry.dn);
    }

    /**
     * �������̃G���g���� <var>entry</var> ��艺�̈ʒu�̃G���g���ł���΁A �܂����̎��̂� <kbd>true</kbd> ��Ԃ��B
     *  
     * @param entry �G���g��
     * @return �G���g���� entry ��艺�̈ʒu�̃G���g���ł���΁A �܂����̎��̂� true
     */
    public boolean isDescendant(Entry entry)
    {
    	return dn.isDescendant(entry.dn);
    }

    /**
     * �������̃G���g�������[�g�ł���΁A���Ȃ킿�e�G���g���������Ȃ���΁A �܂����̎��̂� <kbd>true</kbd> ��Ԃ��B
     */
    public boolean isRoot()
    {
    	return (parent == null);
    }


    // alias dereference
    private Entry substance = null;	// dereferenced entry.

    /**
     * �������̃G���g�����ʖ� <kbd>alias</kbd> �G���g���ł���΁A�܂����̎��̂� <kbd>true</kbd> ��Ԃ��B
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
     * �������̃G���g�����ʖ� (alias) �G���g���ł���΁A���̎Q�Ɛ�� �G���g����Ԃ��B<br>
     * �ʖ��G���g���łȂ����A���邢�͎Q�Ɛ�̃G���g���� ���݂��Ȃ���΁A<kbd>null</kbd> ��Ԃ��B
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
     * <var>o</var> �ɂ��̃G���g���� LDIF �`���ŏ����o���B 
     *
     * @param o ���C�^�[
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
