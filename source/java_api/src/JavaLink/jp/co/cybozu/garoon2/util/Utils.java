package jp.co.cybozu.garoon2.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;

import jp.co.cybozu.garoon2.RemoteException;
import jp.co.cybozu.http.PostStream;
import jp.co.cybozu.http.URI;
/**
 * ガルーン２との連携用ユーティリティクラスです。
 *
 * @author サイボウズ
 * @version    1.1.0
 */
public class Utils {

    public void writeBynaryFile(InputStream in,String filePath) throws FileNotFoundException,IOException{
        OutputStream out = null;
        
        try {
            out = new FileOutputStream(filePath);
            
               final int BUFSIZE = 4096;
               byte[] buffer = new byte[BUFSIZE];
               while ( true )
               {
                   int nRead = in.read(buffer);
                   
                   if ( nRead == -1 )
                       break;
                   out.write(buffer, 0, nRead);
               }

        } finally {
            try {
                    if (in != null) {
                        in.close();
                    }
                    if (out != null) {
                        out.flush();
                        out.close();
                    }
            } catch (Exception e) {
            }
        }
        
    }
    
    public void writeBynaryFile(InputStream responseIn,
                                 String directoryPath,
                                 String fileName)
    throws IOException, RemoteException
    {
        if(directoryPath==null) directoryPath = "./";
        
        // 2007/04/13 [Javaメソッド]ファイルDL時、directoryPathに「""」空文字を入力し実行するとエラーにならない 不具合管理(221)
        if (directoryPath.equals("") || !new File(directoryPath).exists()) {
        	throw new FileNotFoundException("(No such directory)");
        }
        
        // 出力先のPATH
        StringBuffer path = null;
        
        // directoryPath の末尾が システムに依存するデフォルトの名前区切り文字でなければ、ディレクトリパスとファイル名の間にセパレータ追加
        path =new StringBuffer().append(directoryPath).append(java.io.File.separatorChar).append(fileName);
        
        writeBynaryFile(responseIn,path.toString());
    }
    
    public  String getPageName(String url,String enc) throws UnsupportedEncodingException 
    {
        String strFileName = null;
        if(url!=null){
            String path = URI.create(url).getRawPath();
            
            int iLast=path.lastIndexOf('/');
            if(iLast!=(-1)){
                strFileName=path.substring(iLast+1);
                strFileName = java.net.URLDecoder.decode(strFileName,enc);
            }

        }
        return strFileName;
    }
    
    
    public void postParamaters(PostStream ps,HashMap hm) throws IOException{
        Iterator it = hm.keySet().iterator();
        Object key;
        Object val;
        while (it.hasNext()) {
            
               key = it.next();
               if (key==null) continue;
                   
               val = hm.get(key);
               if (val==null) continue;
                                  
            if ( "java.util.ArrayList".equals(val.getClass().getName()) ){
                this.postParamaters(ps,key.toString(),(Collection)val);    
            } 
            else if( "java.io.File".equals(val.getClass().getName())) {
                ps.addFile((File)val,key.toString(),"application/octet-stream");
                
            }
            else {
                ps.addProperty(key.toString(),val.toString());
            }
        }

    }
    
    public void postParamaters(PostStream ps,String key,Collection val) throws IOException{
        Object obj;
        Iterator it = val.iterator();
        while (it.hasNext()) {
               obj = it.next();
               if (obj==null)
                   continue;
            if( "java.io.File".equals(obj.getClass().getName()) ) {
                ps.addFile( (File)obj,key ,"application/octet-stream");
            }else{
                ps.addProperty(key,obj.toString());
                
            }
        }
    }
    
    public BufferedReader processBufferResult (InputStream responseIn)
    throws IOException, RemoteException
    {
        // process output
        BufferedReader in = null;
        try {
            in = new BufferedReader(
                     new InputStreamReader(responseIn, "UTF8"));
        } catch ( UnsupportedEncodingException e ) {
            // do nothing
        }

        return in;
    }
}
