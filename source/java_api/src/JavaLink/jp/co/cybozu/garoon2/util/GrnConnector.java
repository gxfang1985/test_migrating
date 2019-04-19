package jp.co.cybozu.garoon2.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;

import jp.co.cybozu.garoon2.RemoteException;


public interface GrnConnector {
      
    InputStream getResponseStream(String page,
                                  HashMap parameters,
                                  String RemoteExceptionMessage) throws IOException, RemoteException;
}
