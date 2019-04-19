/* RDN.java */
package jp.co.cybozu.ldap;

import java.util.*;

/**
 * LDAP �� ���Ύ��ʖ� (RDN) ��\������B<br>
 * RDN �͑��� (Attribute) �̏W���Ƃ��ĕ\�������B 
 *
 * @author �T�C�{�E�Y
 * @version	1.0.0
 */
public class RDN
{
    private final Set components = new HashSet(1);

    /**
     * ���� ���Ύ��ʖ� (RDN) ���\�����鑮���́A�ύX�s�\�ȏW����Ԃ��B
     */
    public Set getComponents()
    {
    	return Collections.unmodifiableSet( components );
    }

    /**
     * ���O�p�������܂܂Ȃ��A���Ύ��ʖ� (RDN) �I�u�W�F�N�g���쐬����B
     */
    public RDN() {}

    /**
     * <var>attr</var> ��B��̖��O�p�����Ƃ��� ���Ύ��ʖ� (RDN) �I�u�W�F�N�g���쐬����
     *
     * @param attr ���O�p����
     */
    public RDN(Attribute attr)
    {
    	addComponent(attr);
    }

    /**
     * ���� ���Ύ��ʖ� (RDN) �̖��O�p������ǉ�����B
     *
     * @param attr ���O�p����
     */
    public void addComponent(Attribute attr)
    {
    	components.add(attr);
    }

    /**
     * ���ʖ� (DN) ���Ɋ܂߂邽�߂ɓK�؂ɃG�X�P�[�v���ꂽ�A���� ���Ύ��ʖ� (RDN) �� UTF-8 ������ �\����Ԃ��B
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
     * ������o�b�t�@ sb �ɁA���ʖ� (DN) ���Ɋ܂߂邽�߂ɓK�؂ɃG�X�P�[�v ���ꂽ�A���� ���Ύ��ʖ� (RDN) �� UTF-8 ������\����Ԃ��B
     *
     * @param sb ���̃I�u�W�F�N�g�̕�����\��
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
     * ���̃I�u�W�F�N�g�Ƒ��̃I�u�W�F�N�g�����������ǂ����������܂��B
     * 
     * @param o ��r�Ώۂ̎Q�ƃI�u�W�F�N�g
     * @return obj �����Ɏw�肳�ꂽ�I�u�W�F�N�g�Ƃ��̃I�u�W�F�N�g���������ꍇ�� true�A�����łȂ��ꍇ�� false
     */
    public boolean equals( Object o )
    {
    	if ( ! ( o instanceof RDN ) )
    		return false;

    	RDN rdn = (RDN)o;
    	return components.equals( rdn.components );
    }

    /**
     * �I�u�W�F�N�g�̃n�b�V���R�[�h�l��Ԃ��܂��B
     * 
     * @return ���̃I�u�W�F�N�g�̃n�b�V���R�[�h�l
     */
    public int hashCode()
    {
    	return components.hashCode();
    }
}
