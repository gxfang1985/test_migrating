import java.text.SimpleDateFormat;
import java.util.Date;

import jp.co.cybozu.garoon2.CoopLink;
import jp.co.cybozu.garoon2.WorkFlowdataItemProperties;
import jp.co.cybozu.garoon2.WorkFlowdataSelectProperties;

public class TestWorkFlowdataSelectProperties {
	public static void main ( String args[]) throws Exception{
        String url = null;                     // GaroonのURL
        String user = null;                    // ユーザーアカウント名
        String password = null;                // パスワード
        String fid = null;                                      // フォームID
        String filePath = null;                                 // XMLファイルパス
        //試験時，以下変更の必要ありません！のこと////////////////
        Date from =null;
        Date to = null;
        SimpleDateFormat sdf = new SimpleDateFormat();
        sdf.setLenient( false );
        sdf.applyPattern( "yyyy-MM-dd" );
        //////////////////////////////////////////////////////////
        
        WorkFlowdataItemProperties items = new WorkFlowdataItemProperties();
        
        WorkFlowdataSelectProperties selectProperties = new WorkFlowdataSelectProperties();
        //試験時，以下適宜変更のこと///////////////////////////////////////////////////////////
        
        //set系
        //selectProperties.setWherePetitionNumber("文字列");           // 出力条件(申請番号)
        //selectProperties.setWhereTitle("文字列");                    // 出力条件(標題)
        //selectProperties.setWhereCreatorName("文字列");              // 出力条件(申請者名(表示名))
        
        //ステータス
        //selectProperties.setWhereStatusProgressing(false);        // 出力条件(ステータス(進行中))
        //selectProperties.setWhereStatusAcceptance(false);         // 出力条件(ステータス(承認))
        //selectProperties.setWhereStatusReject(false);             // 出力条件(ステータス(却下))
        //selectProperties.setWhereStatusFinish(false);             // 出力条件(ステータス(完了))  
        //selectProperties.setWhereStatusCancel(false);             // 出力条件(ステータス(取消))
        
        //期間      
        //from = sdf.parse( "2007-02-25" );
        //to = sdf.parse( "2007-04-26" );
        //selectProperties.setWhereDate(Integer.valueOf("0"),from,to);    // 出力条件(期間)
        
        //ソート
        //試験時は以下のvalueの値を変えてください。また以下2行+1行（昇降）のコメントアウトを外してください
        //selectProperties.setSortAsc(new Integer("0"));        // 並び順昇順
        //selectProperties.setSortDesc(new Integer("0"));         // 並び順降順 
 
        //get系
        //System.out.println(selectProperties.getWherePetitionNumber());           // 出力条件(申請番号)
        //System.out.println(selectProperties.getWhereTitle());                    // 出力条件(標題)
        //System.out.println(selectProperties.getWhereCreatorName());              // 出力条件(申請者名(表示名))
        
        //ステータス
        //System.out.println(selectProperties.getWhereStatusProgressing());        // 出力条件(ステータス(進行中))
        //System.out.println(selectProperties.getWhereStatusAcceptance());         // 出力条件(ステータス(承認))
        //System.out.println(selectProperties.getWhereStatusReject());             // 出力条件(ステータス(却下))
        //System.out.println(selectProperties.getWhereStatusFinish());             // 出力条件(ステータス(完了))  
        //System.out.println(selectProperties.getWhereStatusCancel());             // 出力条件(ステータス(取消))
        
        //期間      
        //System.out.println(selectProperties.getWhereDateType());    // 出力条件(タイプ)
        //System.out.println(selectProperties.getWhereDateFrom());    // 出力条件(from)
        //System.out.println(selectProperties.getWhereDateTo());    // 出力条件(to)
        
        //ソート
        //System.out.println(selectProperties.getSortField());     //並び順に設定されているフィールドを返します
        //System.out.println(selectProperties.isSortAsc());        //並び順が昇順であるかを返します
        //int sortvalue =Integer.parseInt(value);  
        //System.out.println(selectProperties.setSortAsc(new Integer(sortvalue));        // 並び順昇順
        //System.out.println(selectProperties.setSortDesc(new Integer(sortvalue));         // 並び順降順 
        
        //set系でのみ使用
        // Garoonへの接続&認証(ガルーンのURL,ログイン名,パスワード)
        CoopLink workflowLink = new CoopLink( url, user, password );
        workflowLink.exportXMLSystemWorkFlowFormPetitionData(Long.parseLong(fid),selectProperties,items,filePath);

	
	
	
	}
}
