/* Ldif.java */
package jp.co.cybozu.ldap;

import jp.co.cybozu.text.*;
import java.io.*;
import java.util.*;
import java.net.URL;


/**
 * LDIF �t�@�C���̓��e��\������B<br>
 * ���Ȃ킿�ALDIF �t�@�C���̃o�[�W������ �܂܂��G���g���̐X�����B<br>
 * ����ɁALDIF �t�@�C������͂��ēǂݍ��ދ@�\ ���񋟂���B
 *
 * @author �T�C�{�E�Y
 * @version	1.0.0
 * @see		<a href="http://www.ietf.org/rfc/rfc2849.txt">RFC2849</a>
 */
public class Ldif
{
    private class ConcatReader extends LineNumberReader
    {
    	public ConcatReader(Reader r)
    	{
    		super(r);
    	}

    	public ConcatReader(Reader r, int sz)
    	{
    		super(r, sz);
    	}

    	private String nextLine	= null;
    	private boolean eofReached	= false;

    	public String readLine()
	    throws IOException
	    {
    		StringBuffer sb = new StringBuffer();

    		if ( nextLine != null ) {
    			sb.append( nextLine );
    			nextLine = null;
    		} else {
    			if ( eofReached )
    			{
    				return null;
    			}

    			String line = super.readLine();
    			if ( line == null )
    			{
    				eofReached = true;
    				return null;
    			}
    			sb.append( line );
    		}

    		while ( ! eofReached )
    		{
    			nextLine = super.readLine();

    			if ( nextLine == null ) {
    				eofReached = true;
    			} else {
    				if ( (nextLine.length() > 0) &&
			             (nextLine.charAt(0) == ' ') ) {
    					sb.append( nextLine.substring(1) );
    					continue;
    				} else {
    					break;
    				}
    			}
    		}
    		return sb.toString();
	    }

    	public int getLineNumber()
    	{
    		int nl = super.getLineNumber();
    		return (nextLine == null) ? nl : nl - 1;
    	}

    	public boolean ready()
	    throws IOException
	    {
    		if ( nextLine != null ) return true;
    		if ( eofReached ) return false;
    		return super.ready();
	    }
    }

    // The LDIF version.  Currently, only 1 is legitimate and therefore
    // is the default.
    private int version = 1;

    /**
     * ���̃I�u�W�F�N�g���\������ LDIF �̃o�[�W�����ԍ���Ԃ��B<br>
     * ���݂� 1 �����K�肳��Ă��Ȃ����߁A��� 1 ���Ԃ�B
     * 
     * @return 1��Ԃ��B
     */
    public int getVersion()
    {
    	return version;
    }

    /**
     * ���� LDIF �I�u�W�F�N�g�����G���g���̃��X�g 
     */
    protected final List entries = new ArrayList(4096);

    /** 
     * DN -> Entry �̃}�b�s���O  
     */
    protected final Map dnToEntry = new HashMap();

    /**
     * ���� LDIF �I�u�W�F�N�g�ɐV���ɃG���g����ǉ�����B<br>
     * �G���g���̐X���č\�z����ɂ́A{@link #resolveRelation} ���Ăяo���K�v������B
     *
     * @param entry �ǉ�����G���g��
     */
    public void addEntry(Entry entry)
    {
    	entries.add( entry );
    	dnToEntry.put( entry.getDN(), entry );
    }

    /**
     * <var>dn</var> �Ŏw�肳�ꂽ�G���g����Ԃ��B
     *
     * @param dn �G���g���� ���ʖ� (DN)
     * @return �G���g���A�����Ȃ���� <kbd>null</kbd>
     */
    public Entry getEntry( DN dn )
    {
    	return (Entry)dnToEntry.get( dn );
    }

    /** Hold roots of entry trees. */
    protected final Entry root = new Entry();

    /**
     * �G���g���̐X�́A���ꂼ��̖؂̃��[�g�́A�ύX�s�\�ȃ��X�g��Ԃ��B
     */
    public List getRootEntries()
    {
    	return Collections.unmodifiableList( root.getChildren() );
    }

    /**
     * LDIF �I�u�W�F�N�g���쐬����B
     *
     * @param version LDIF �̃o�[�W����. ���݂͕K�� 1 ���w�肷��B
     */
    public Ldif( int version )
    {
    	this.version = version;
    }

    /**
     * LDIF �t�@�C���� <var>in</var> ����ǂݍ���ŁALDIF �I�u�W�F�N�g ���쐬����B
     *
     * @param in LDIF�t�@�C���̓��e��ǂݍ��ރX�g���[��
     * @throws IOException �ʐM�G���[������
     * @throws ParseException �ǂݍ��� LDIF �t�@�C���̓��e�ɃG���[������ 
     */
    public Ldif( InputStream in )
	throws IOException, ParseException
    {
    	this(in, "UTF8" );
    }

    /**
     * LDIF �t�@�C���� <var>in</var> ����ǂݍ���ŁALDIF �I�u�W�F�N�g ���쐬����B
     * LDIF�t�@�C�����̕������W��(ASCII)�ȊO�ŋL�q���Ă��Ă��A<var>enc</var> �Ŏw�肵�ēǂݍ��ނ��Ƃ��ł���B
     *
     * @param in LDIF�t�@�C���̓��e��ǂݍ��ރX�g���[��
     * @param enc LDIF�t�@�C�����̕�����̃L�����N�^�G���R�[�f�B���O 
     * @throws IOException �ʐM�G���[������
     * @throws ParseException �ǂݍ��� LDIF �t�@�C���̓��e�ɃG���[������B
     */
    public Ldif( InputStream in, String enc )
	throws IOException, ParseException
    {
    	LineNumberReader r =
    		new ConcatReader( new InputStreamReader( in, enc ) );

    	Entry entry = null;
    	while ( true )
    	{
    		String l = r.readLine();
    		if ( l == null )
    		{
    			break;
    		}

    		try {
    			entry  = parseLine( l.toCharArray(), entry );
    		} catch ( ParseException e ) {
    			e.setLineNumber( r.getLineNumber() );
    			throw e;
    		} catch ( IOException e ) {
    			System.err.println( "ignore line " + r.getLineNumber() +
				    " that issues:");
    			System.err.println( e.toString() );
    		}

    	}

    	if ( entry != null )
    	{
// 	    	System.err.println("New Entry");
// 	    	System.err.println( entry.toString() );
    		addEntry( entry );
		}

    	resolveRelation();
    }

    /**
     * LDIF�t�@�C�����̃G���g���̐e�q�֌W����������. �ʖ�(alias)�������ɉ�������B
     *
     * @throws ParseException �ʖ�(alias)�̉����Ɏ��s�����B
     */
    public void resolveRelation()
	throws ParseException
    {
    	Set entrySet = new HashSet( entries );

    	Iterator it = entries.iterator();
    	while ( it.hasNext() )
    	{
    		Entry e = (Entry)it.next();
    		root.addChild( e );
    		e.resolveAlias( dnToEntry );
    	}

    	it = entries.iterator();
    	while ( it.hasNext() )
    	{
    		Entry e1 = (Entry)it.next();

    		Iterator it2 = entrySet.iterator();
    		while ( it2.hasNext() )
    		{
    			Entry e2 = (Entry)it2.next();
    			if ( e1.isParent( e2 ) )
    			{
    				e1.addChild( e2 );
    			}
    		}
    	}
    }

    private Entry parseLine( char[] ca, Entry entry )
	throws IOException, ParseException
    {
    	int i = 0;

    	// skip leading white spaces (out of spec.)
    	for ( ; i < ca.length; i++ )
    	{
    		if ( ! Character.isWhitespace( ca[i] ) )
    			break;
    	}

    	if ( i == ca.length )
    	{
    		if ( entry != null )
    		{
// 				System.err.println("New Entry");
// 				System.err.println( entry.toString() );
    			addEntry( entry );
    		}

    		entry = null;
    		return null;
    	}

    	// read attribute type
    	StringBuffer sbName = new StringBuffer();
    	for ( ; i < ca.length; i++ )
    	{
    		if ( (ca[i] == ';') || (ca[i] == ':') )
    			break;
    		sbName.append( ca[i] );
    	}

    	if ( sbName.length() == 0 )
    		throw new ParseException("empty attribute type");

    	// read options
    	List options = null;
    	while ( (i < ca.length) && (ca[i] == ';') )
    	{
    		if ( options == null )
    			options = new LinkedList();

    		StringBuffer sbOption = new StringBuffer();
    		for ( i = i + 1; i < ca.length; i++ )
    		{
    			if ( (ca[i] == ';') || (ca[i] == ':') )
    				break;
    			sbOption.append( ca[i] );
    		}

    		if ( sbOption.length() == 0 )
    			throw new ParseException("empty attribute option");

    		options.add( sbOption.toString() );
    	}

    	// skip ':'
    	i++;

    	if ( i == ca.length )
    		throw new ParseException("syntax error");

    	boolean inBase64 = false;
    	boolean inURL = false;

    	// check if the value is encoded in Base64, or should be
    	// imported from an external resource located by an URL.
    	if ( ca[i] == ':' ) {
    		i++;
    		inBase64 = true;
    	} else if ( ca[i] == '<' ) {
    		i++;
    		inURL = true;
    	}

    	// skip fill spaces
    	for ( ; i < ca.length; i++ )
    	{
    		if ( ca[i] != ' ' )
    			break;
    	}

    	StringBuffer sbValue = new StringBuffer();
    	for ( ; i < ca.length; i++ )
    	{
    		sbValue.append( ca[i] );
    	}

    	String name = sbName.toString();
    	String valueData = sbValue.toString();

    	// handle "version:" line (extended spec)
    	if ( (entry == null) && name.equals( "version" ) )
    	{
    		try {
    			version = Integer.parseInt( valueData );
    		} catch ( NumberFormatException e ) {
    			throw new ParseException("invalid version: " + valueData);
    		}

    		return null;
    	}

    	// new entry
    	if ( (entry == null) && name.equals( "dn" ) )
    	{
    		if ( inURL )
    			throw new ParseException("invalid DN syntax");

    		String dnspec = valueData;
    		if ( inBase64 )
    		{
    			dnspec = new String(Base64.decode(valueData), "UTF8");
    		}

    		return new Entry( new DN( dnspec ) );
    	}

    	// an attribute
    	if ( entry == null )
    		throw new ParseException("illegal attribute declaration");

    	Attribute attr;
    	if ( inBase64 ) {
    		attr = new Attribute(name, Base64.decode(valueData), options);
    	} else if ( inURL ) {
    		attr = new Attribute(name, new URL(valueData), options);
    	} else {
    		attr = new Attribute(name, valueData, options);
    	}

    	entry.addAttribute( attr );
    	return entry;
    }

    /**
     * ���� LDIF �I�u�W�F�N�g�̓��e�� LDIF �`���ŏ����o���B
     *
     * @param o ���C�^�[
     */
    public void dump( PrintWriter o )
    {
    	// put version
    	o.println("version: " + version);

    	Iterator it = getRootEntries().iterator();
    	while ( it.hasNext() )
    	{
    		o.println();
    		((Entry)it.next()).dump(o);
    	}
    }

//     public static void main( String[] args )
// 	throws IOException, ParseException
//     {
// 	if ( args.length < 1 )
// 	{
// 	    System.err.println("too few arguments.");
// 	    return;
// 	}

// 	Ldif ldif = new Ldif( new FileInputStream( args[0] ) );
// 	PrintWriter o =new PrintWriter(
// 			   new BufferedWriter(
// 			       new OutputStreamWriter( System.out ) ) );
// 	ldif.dump(o);
// 	o.close();
//     }
}
