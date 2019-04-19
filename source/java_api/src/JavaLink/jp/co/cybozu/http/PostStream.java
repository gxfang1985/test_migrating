/* PostStream.java */
package jp.co.cybozu.http;

import java.io.*;
import java.net.*;

/**
 * HTTP POST ���N�G�X�g�̓��e���쐬����f�[�^�X�g���[���ł��B<br>
 * ���̃N���X�͈ȉ��� 2 �̃��[�h�������Ă��܂��B 
 * <ul>
 * <li>�uURL�G���R�[�h�v���[�h�ł́AContent-Type �� "application/x-www-form-urlencoded" �ł��郊�N�G�X�g���쐬���܂��B</li> 
 * <li>�u�}���`�p�[�g�v���[�h�ł́AContent-Type �� "multipart/form-data" �ł��郊�N�G�X�g���쐬���܂��B</li>
 * </ul>
 * ���[�h�̓C���X�^���X�̍쐬���ɁA�ǂ̃R���X�g���N�^���g�p���邩�Ō��肳��܂��B
 * <br> 
 * <font color="red">�t�@�C����Y�t����ɂ́A�u�}���`�p�[�g�v���[�h�ł���K�v������܂��B</font>
 * <br>
 * POST ���N�G�X�g�̒��g��S�Ēǉ����I������A�f�[�^�X�g���[�����N���[�Y����K�v������܂��B 
 *
 * @author �T�C�{�E�Y
 * @version	1.0.0
 * @see #PostStream(OutputStream)
 * @see #PostStream(OutputStream, String)
 * @see #close()
 */
public class PostStream
{
    protected final DataOutputStream out;
    protected final Writer wout;

    private final String boundary;
    private static final String SEPARATOR = "--";
    private static final byte[] CRLF = { 0x0d, 0x0a };
    private boolean needDelimeter = false;

    /**
     * �uURL�G���R�[�h�v���[�h�̃f�[�^�X�g���[�����쐬���܂��B<br>
     * addProperty(java.lang.String, java.lang.String) �Œǉ������f�[�^�͓K�؂� URL �G���R�[�h����܂��B<br>
     * close() ����ƁAContent-Type �� "application/x-www-urlencoded" �Ƃ��� POST ���N�G�X�g�����s���܂��B
     *
     * @param o URLConnection.getOutputStream() �ŕԂ���� {@link URLConnection#getOutputStream}
     */
    public PostStream (OutputStream o)
    {
    	this(o, null);
    }

    /**
     * �u�}���`�p�[�g�v���[�h�̃f�[�^�X�g���[�����쐬���܂�. addProperty(java.lang.String, java.lang.String) �� addFile(java.io.File, java.lang.String, java.lang.String) �Œǉ������f�[�^�̓}���`�p�[�g MIME �`���Ƀt�H�[�}�b�g����܂��B
     * close() ����ƁAContent-Type �� "multipart/form-data" �Ƃ��� POST ���N�G�X�g�����s���܂��B
     *
     * @param o {@link URLConnection#getOutputStream} �ŕԂ���� OutputStream
     * @param boundary �}���`�p�[�g MIME �̋�ؕ�����
     */
    public PostStream (OutputStream o, String boundary)
    {
    	if ( o == null )
    		throw new NullPointerException("o is null.");

    	out = new DataOutputStream(o);
    	Writer tmp_wout = null;
    	try {
    		tmp_wout = new OutputStreamWriter(out, "UTF-8");
//    		tmp_wout = new OutputStreamWriter(out, "Shift_JIS");
    	} catch (UnsupportedEncodingException e) {
    		// ignore it
    	} finally {
    		wout = tmp_wout;
    	}

    	this.boundary = boundary;
    }

    /**
     * 
     * @param s
     * @return
     */
    private static String encode (String s)
    {
    	String encoded = null;
    	try {
    		encoded = URLEncoder.encode(s, "UTF-8");
//    		encoded = URLEncoder.encode(s, "Shift_JIS");
    	} catch ( UnsupportedEncodingException e ) {
    		// ignore it
    	}
    	return encoded;
    }

    /**
     * �p�����[�^���X�g���[���ɒǉ����܂��B
     *
     * @param name �p�����[�^��
     * @param value �p�����[�^�̒l
     * @throws IOException �������ݎ��ɃG���[����������
     */
    public void addProperty (String name, String value)
	throws IOException
    {
    	if ( boundary == null )
    	{
    		if ( needDelimeter )
    			wout.write('&');
            // ******************************************************************
    		// 2007/03/22 �p�����[�^�l��[&],[+]�̏ꍇ�ɕs������ (�s��Ǘ� 188)
            // ******************************************************************
    		String encoded = encode(name) + "=" + encode(value);
    		wout.write(encoded);
    		wout.flush();
    		needDelimeter = true;
    		return;
    	}

    	out.writeBytes(SEPARATOR);
    	out.writeBytes(boundary);
    	out.write(CRLF);
    	wout.write("Content-Disposition: form-data; name=\"" + name + "\"");
    	wout.flush();
    	out.write(CRLF);
    	out.write(CRLF);
    	wout.write(value);
    	wout.flush();
    	out.write(CRLF);
    }

    /**
     * �p�����[�^���X�g���[���ɒǉ����܂��B
     *
     * @param name �p�����[�^��
     * @param value �p�����[�^�̒l
     * @throws IOException �ʐM�G���[������
     */
    public void addProperty (String name, int value)
	throws IOException
    {
    	addProperty(name, Integer.toString(value));
    }

    /**
     * �t�@�C���̓��e���X�g���[���ɒǉ����܂��B<br>
     * �u�}���`�p�[�g�v���[�h�̃X�g���[���ł����g�p�ł��܂���B
     *
     * @param file �ǉ�����t�@�C��
     * @param name �p�����[�^��
     * @param mimeType ���̃t�@�C���� MIME �^�C�v
     * @throws IOException �ʐM�G���[������
     * @see #writeFileEntry
     */
    public void addFile (File file, String name, String mimeType)
	throws IOException
    {
    	if ( boundary == null )
    		throw new IllegalStateException("could not add a file for this stream.");

    	out.writeBytes(SEPARATOR);
    	out.writeBytes(boundary);
    	out.write(CRLF);
    	wout.write("Content-Disposition: form-data; name=\"" + name +
		   "\"; filename=\"" + file.getName() + "\"");
    	wout.flush();
    	out.write(CRLF);
    	wout.write("Content-Type: ");
    	wout.flush();
    	out.writeBytes(mimeType);
    	out.write(CRLF);
    	out.write(CRLF);

        // ************���ʑΉ�(�o�O�C��)*****************
        // put file contents
        FileInputStream reader = null;
        try{
            reader = new FileInputStream(file);
            final int BUFSIZE = 4096;
            byte[] buffer = new byte[BUFSIZE];
            while ( true )
            {
                int nRead = reader.read(buffer);
                if ( nRead == -1 )
                    break;
                out.write(buffer, 0, nRead);
            }
        }finally{
            if(reader!=null) try{reader.close();}catch(Exception e){};
        }

    	out.write(CRLF);
    }

    /**
     * �t�@�C����ǉ����邽�߂́A"Content-Disposition" �w�b�_�������o���܂��B<br>
     * �t�@�C���̓��e�� write ���\�b�h���g�p���Ă��̌�ɒǉ����܂��B<br>
     * �t�@�C���̖����ł� {@link #writeFileEnd} ���Ăяo���܂��B<br>
     * �u�}���`�p�[�g�v���[�h�̃X�g���[���ł����g�p�ł��܂���B
     *
     * @param name The name of this file property.
     * @param fileName �ǉ�����t�@�C��
     * @param mimeType ���̃t�@�C���� MIME �^�C�v
     * @throws IOException �ʐM�G���[������
     * @see #writeFileEnd
     */
    public void writeFileEntry (String name, String fileName, String mimeType)
	throws IOException
    {
    	if ( boundary == null )
    		throw new IllegalStateException("could not add a file for this stream.");

    	out.writeBytes(SEPARATOR);
    	out.writeBytes(boundary);
    	out.write(CRLF);
    	wout.write("Content-Disposition: form-data; name=\"" + name +
    			"\"; filename=\"" + fileName + "\"");
    	wout.flush();
    	out.write(CRLF);
    	wout.write("Content-Type: ");
    	wout.flush();
    	out.writeBytes(mimeType);
    	out.write(CRLF);
    	out.write(CRLF);
    }

    /**
     * �t�@�C����ǉ����邽�߂́A"Content-Disposition" �w�b�_�������o���܂��B<br>
     * �t�@�C���̓��e�� write ���\�b�h���g�p���Ă��̌�ɒǉ����܂��B<br>
     * �t�@�C���̖����ł� {@link #writeFileEnd} ���Ăяo���܂��B<br>
     * �u�}���`�p�[�g�v���[�h�̃X�g���[���ł����g�p�ł��܂���B
     *
     * @param name The name of this file property.
     * @param fileName �ǉ�����t�@�C��
     * @param mimeType ���̃t�@�C���� MIME �^�C�v
	 * @param contType �t�@�C���̎�ނŁAMIME�i�}�C���j�`�����w��(�R���e���g�^�C�v)
     * @throws IOException �ʐM�G���[������
     * @see #writeFileEnd
     */
    public void writeFileEntry (String name, 
    		                    String fileName, 
    		                    String mimeType,
    		                    String contType)
	throws IOException
    {
    	if ( boundary == null )
    		throw new IllegalStateException("could not add a file for this stream.");

    	out.writeBytes(SEPARATOR);
    	out.writeBytes(boundary);
    	out.write(CRLF);
    	wout.write("Content-Disposition: form-data; name=\"" + name +
    			"\"; filename=\"" + fileName + "\"");
    	wout.flush();
    	out.write(CRLF);
    	wout.write("Content-Type: " + contType);
    	wout.flush();
    	//out.writeBytes(mimeType);
    	out.write(CRLF);
    	out.write(CRLF);
    }

    /**
     * �t�@�C����ǉ����邽�߂́A"Content-Disposition" �w�b�_�������o���܂��B<br>
     * �t�@�C���̓��e�� write ���\�b�h���g�p���Ă��̌�ɒǉ����܂��B<br>
     * �t�@�C���̖����ł� {@link #writeFileEnd} ���Ăяo���܂��B<br>
     * �u�}���`�p�[�g�v���[�h�̃X�g���[���ł����g�p�ł��܂���B
     * 
     * @param accept
     * @throws IOException �ʐM�G���[������
     */
    public void writeFileEntry2(String accept)
    throws IOException
    {
    	if ( boundary == null )
    		throw new IllegalStateException("could not add a file for this stream.");

    	//out.writeBytes(SEPARATOR);
    	//out.writeBytes(boundary);
    	//out.write(CRLF);
    	//wout.write("Content-Disposition: form-data; name=\"" + name +
    	//		"\"; filename=\"" + fileName + "\"");
    	//wout.flush();
    	out.write(CRLF);
    	wout.write("Accept-Encoding: " + accept);
    	wout.flush();
    	//out.writeBytes(mimeType);
    	out.write(CRLF);
    	out.write(CRLF);
    }
    
    /**
     * �t�@�C���̓��e���X�g���[���ɒǉ����܂��B
     *
     * @param data �ǉ�����I�N�e�b�g�f�[�^
     * @throws IOException �ʐM�G���[������
     * @see #writeFileEntry
     */
    public void write (byte[] data)
	throws IOException
    {
    	out.write(data);
    }

    /**
     * �t�@�C���̓��e���X�g���[���ɒǉ����܂��B<br>
     * ������� "Shift_JIS" �ɃG���R�[�h����܂��B
     *
     * @param s �ǉ����镶����
     * @throws IOException �ʐM�G���[������
     * @see #writeFileEntry
     */
    public void write (String s)
	throws IOException
    {
    	wout.write(s);
    	wout.flush();
    }

    /**
     * �t�@�C���̖����̃Z�p���[�^�������o���܂��B
     *
     * @throws IOException �ʐM�G���[������
     * @see #writeFileEntry
     */
    public void writeFileEnd ()
	throws IOException
    {
    	out.write(CRLF);
    }

    /**
     * �X�g���[�����N���[�Y���܂��B<br>
     * �u�}���`�p�[�g�v���[�h�̏ꍇ�́A�I�[�L�������̑O�ɏ����o���܂��B
     * 
     * @throws IOException �ʐM�G���[������
     */
    public void close ()
	throws IOException
    {
    	if ( boundary != null )
    	{
    		out.writeBytes(SEPARATOR);
    		out.writeBytes(boundary);
    		out.writeBytes(SEPARATOR);
    		out.write(CRLF);
    	}
    	wout.close();
    }
}
