/* CSVWriter.java */
package jp.co.cybozu.text;

import java.util.*;
import java.io.*;

/**
 * CSV �`���̍s���o�͂��܂��B
 * �s�̃J��������ׂ��z�񂠂邢�̓��X�g���A�K�؂ɃG�X�P�[�v���čs�P�ʂŏo�͂��܂��B
 *
 * @author �T�C�{�E�Y
 * @version	1.0.0
 * @see		CSVReader
 */
public class CSVWriter
{
    protected final BufferedWriter o;

    /**
     * CSV �`���̍s���������ރo�b�t�@�t�����C�^�[���쐬���܂��B
     * �o�b�t�@�T�C�Y�̓f�t�H���g�l�ɂȂ�܂��B
     *
     * @param w �����o����� Writer
     */
    public CSVWriter( Writer w )
    {
    	o = new BufferedWriter( w );
    }

    /**
     * CSV �`���̍s���������ރo�b�t�@�t�����C�^�[���쐬���܂�.
     * �o�b�t�@�T�C�Y�� <var>sz</var> �Ŏw�肳�ꂽ�l�ɂȂ�܂��B
     *
     * @param w �����o����
     * @param sz �o�b�t�@�T�C�Y
     */
    public CSVWriter( Writer w, int sz )
    {
    	o = new BufferedWriter( w, sz );
    }

    /**
     * CSV �t�@�C���̍s�������o���܂��B
     * �s�̃J������ <var>line</var> �̗v�f�����ɕ��ׂ����̂ɂȂ�܂��B
     * �e������� CSV �`���ɍ��킹�ăG�X�P�[�v����܂��B
     * �s�̍Ō�ɂ� newline �����������o����܂��B
     *
     * @param line �����o���s�̓��e��\��������̔z��
     * @throws IOException �ʐM�G���[������
     */
    public void println( String[] line )
	throws IOException
    {
    	boolean comma = false;
    	for ( int i = 0; i < line.length; i++ )
    	{
    		if ( comma ) {
    			o.write( ',' & 0xFFFF );
    		} else {
    			comma = true;
    		}

    		printColumn( line[i] );
    	}

    	o.newLine();
    }

    /**
     * CSV �t�@�C���̍s�������o���܂��B
     * �s�̃J������ <var>line</var> �̗v�f�����ɕ��ׂ����̂ɂȂ�܂��B
     * �e������� CSV �`���ɍ��킹�ăG�X�P�[�v����܂��B
     * �s�̍Ō�ɂ� newline �����������o����܂��B
     *
     * @param line �����o���s�̓��e��\��������̃��X�g 
     * @throws IOException �ʐM�G���[������
     */
    public void println( List line )
	throws IOException
    {
    	boolean comma = false;
    	Iterator it = line.iterator();

    	while ( it.hasNext() )
    	{
    		if ( comma ) {
    			o.write( ',' & 0xFFFF );
    		} else {
    			comma = true;
    		}

    		printColumn( (String)it.next() );
    	}

    	o.newLine();
    }

    /**
     * <var>column</var> �� CSV �`���ɓK�؂Ȃ悤�ɃG�X�P�[�v���ďo�͂��܂��B
     *
     * @param column �J�����̓��e������������
     * @throws IOException �ʐM�G���[������
     */
    protected void printColumn( String column )
	throws IOException
    {
    	o.write( '"' & 0xFFFF );

    	char[] ca = column.toCharArray();
    	for ( int i = 0; i < ca.length; i++ )
    	{
    		if ( ca[i] == '\r' )
    		{
    			if ( (i == (ca.length - 1)) || (ca[i+1] != '\n') )
    			{
    				o.write( '\n' & 0xFFFF );
    			}
    			continue;
    		}

    		if ( ca[i] == '"' )
    		{
    			o.write( '"' & 0xFFFF );
    		}

    		o.write( ca[i] & 0xFFFF );
    	}

    	o.write( '"' & 0xFFFF );
    }

    /**
     * ���C�^�[�� flush ���܂��B
     * 
     * @throws IOException �ʐM�G���[������
     */
    public void flush()
	throws IOException
    {
    	o.flush();
    }

    /**
     * ���C�^�[�� close ���܂��B
     * 
     * @throws IOException �ʐM�G���[������
     */
    public void close()
	throws IOException
    {
    	o.close();
    }


    /* test routine */
//     public static void main ( String[] args )
// 	throws IOException
//     {
// 	String[] line = { "abc,������def \"", "ghi\njkl,mn", "opq " };

// 	CSVWriter o = new CSVWriter( new OutputStreamWriter( System.out ) );
// 	o.println(line);
// 	o.close();
//     }
}
