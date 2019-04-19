/* CSVReader.java */
package jp.co.cybozu.text;

import java.io.*;
import java.util.*;

/**
 * CSV �`���̃t�@�C����ǂݍ��݁A������̔z��Ƃ��ĕԂ��܂��B
 *
 * @author �T�C�{�E�Y
 * @version	1.0.0
 * @see		CSVWriter
 */
public class CSVReader
{
    private final BufferedReader in;
    private int lineNumber = 0;

    /**
     * CSV �`���̃t�@�C����ǂݍ��ރo�b�t�@�t�����[�_�[���쐬���܂��B
     * �o�b�t�@�T�C�Y�̓f�t�H���g�l�ɂȂ�܂��B
     *
     * @param r �ǂݍ��ތ��� Reader
     */
    public CSVReader (Reader r)
    {
    	in = new BufferedReader( r );
    }

    /**
     * CSV �`���̃t�@�C����ǂݍ��ރo�b�t�@�t�����[�_�[���쐬���܂��B
     * �o�b�t�@�T�C�Y�� <var>sz</var> �Ŏw�肳�ꂽ�l�ɂȂ�܂��B 
     *
     * @param r �ǂݍ��ތ��� Reader
     * @param sz �o�b�t�@�T�C�Y
     */
    public CSVReader (Reader r, int sz)
    {
    	in = new BufferedReader( r, sz );
    }

    /**
     * CSV �`���̈�s��ǂݍ��݂܂��B
     * �ǂݍ��񂾍s�� String �̔z��Ƃ��ĕԂ���܂��B
     * EOF �ɒB�������ꍇ�Anull ���Ԃ�܂��B
     *
     * @return CSV�̍s��\��������̔z��
     * @throws IOException �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
     * @throws ParseException �t�@�C���̏I�[���s���ł������ꍇ
     */
    public String[] readLine ()
	throws IOException, ParseException
    {
    	String line = in.readLine();
    	if ( line == null )
    	{
    		in.close();
    		return null;
    	}

    	lineNumber ++;

    	// data buffers
    	final StringBuffer buf = new StringBuffer();
    	final List l = new ArrayList(16);
	
    	// state variables
    	boolean quoting = false;		// changed by '"'

    	while ( true )
    	{
    		char[] ca = line.toCharArray();

    		int i;
    		for ( i = 0; i < ca.length; i++ )
    		{
    			if ( quoting )
    			{
    				if ( ca[i] == '"' )
    				{
    					if ( (i < (ca.length - 1)) && (ca[i+1] == '"' ) ) {
    						buf.append( ca[++i] );

    					} else {
    						quoting = false;
    					}
    					continue;
    				}

    				buf.append( ca[i] );
    				continue;
    			}

    			if ( ca[i] == '"' )
    			{
    				quoting = true;
    				continue;
    			}

    			if ( ca[i] == ',' )
    			{
    				l.add( buf.toString() );
    				buf.setLength(0);
    				continue;
    			}

    			buf.append( ca[i] );
    		}

    		if ( quoting )
    		{
    			line = in.readLine();
    			if ( line == null )
    				throw new ParseException("unbalanced \" .", lineNumber);

    			buf.append('\n');
    			continue;
    		}

    		l.add( buf.toString() );

    		break;
    	}


    	String[] csvline = new String[l.size()];
    	for ( int i = 0; i < csvline.length; i++ )
    	{
    		csvline[i] = (String)l.get(i);
    	}
    	return csvline;
    }

    /**
     * �Ō�ɓǂݍ��񂾍s�̍s�ԍ���Ԃ��܂��B
     */
    public int getLineNumber ()
    {
    	return lineNumber;
    }

    /**
     * ���[�_�[�� close ���܂��B
     * 
     * @throws IOException �ڑ����m���ł��Ȃ����ʐM��̃G���[�����������ꍇ
     */
    public void close()
	throws IOException
    {
    	in.close();
    }

    /* test routine */
//     public static void main (String[] args)
// 	throws IOException, ParseException
//     {
// 	if ( args.length < 1 )
// 	{
// 	    System.err.println("Usage: java jp.co.cybozu.text.CSVReader FILE");
// 	    return;
// 	}

// 	CSVReader parser = new CSVReader(
// 			       new InputStreamReader(
// 				   new FileInputStream(args[0]),
// 				   "JISAutoDetect"));

// 	while ( true )
// 	{
// 	    String[] l = parser.readLine();
// 	    if ( l == null )
// 		break;

// 	    System.out.println("Columns: " + l.length);
// 	    for ( int i = 0; i < l.length; i++ )
// 	    {
// 		char[] ca = l[i].toCharArray();
// 		System.out.print("\"");
// 		for ( int j = 0; j < ca.length; j++ )
// 		{
// 		    if ( ca[j] == '\n' ) {
// 			System.out.print("\\n");
// 		    } else {
// 			System.out.print( ca[j] );
// 		    }
// 		}
// 		System.out.print("\"");

// 		if ( i < (l.length - 1 ) )
// 		    System.out.print(",");
// 	    }
// 	    System.out.println();
// 	}

// 	parser.close();

// 	return;
//     }
}
