/****************************************************************  
* 機　能： ターゲット日付を変えて画面を更新する
* 引　数： fname：サブミットするフォーム名
*       ： date：日付文字列
*       ： aName：アンカー名（オプショナル）
* 戻り値： 正常終了：true　フォームが無い：false 
****************************************************************/
function dateChange( fname, date, aName )
{
    var form    = document.forms[fname];
    if(form)
    {
        $('bdate').value    = date;

        if(aName)
        {
            form.action = form.action + '#' + aName;
        }

        form.submit();

        return true;
    }

    return false;
}


/****************************************************************  
* 機　能： 親画面の日時をセットする
* 引　数： isSetParentDate：日付をセットするかフラグ
****************************************************************/
function reflectTime( isSetParentDate )
{
    //実行順序に注意  _setParentDateより前にsetParentTimeを呼び出さないこと
    if(isSetParentDate)
    {
        _setParentDate();
    }

    _setParentTime();

    window.close();
}

/****************************************************************  
* 機　能： 親画面の日付をセットする
****************************************************************/
function _setParentDate()
{
    var start_time_hour     = $("start_hour").value;
    var start_time_minute   = $("start_minute").value;
    var end_time_hour       = $("end_hour").value;
    var end_time_minute     = $("end_minute").value;
    /*jshint -W053 */ /* Do not use {a} as a constructor. */
    var str_bdate           = new String($("bdate").value);
    /*jshint +W053 */
    var parent          = window.opener;
    var parentDocument  = parent.document;

    var startDateObj;
    var endDateObj;

    //日付の妥当性をチェック
    if( _validateDateStr(str_bdate) )
    {
        var tempStartDateSplit  = str_bdate.split("-");
        startDateObj            = new Date(tempStartDateSplit[0], tempStartDateSplit[1] - 1, tempStartDateSplit[2]);
    }
    else
    {
        //不正ならクライアントシステム日付を代入
        startDateObj    = new Date();
    }

    //日マタギチェック、数字でない場合は固定値を代入
    var tempStartHour   = _isNumeric(start_time_hour) ?     start_time_hour   : 0;
    var tempStartMinute = _isNumeric(start_time_minute) ?   start_time_minute : 0;
    var tempEndHour     = _isNumeric(end_time_hour) ?       end_time_hour     : 23;
    var tempEndMinute   = _isNumeric(end_time_minute) ?     end_time_minute   : 59;
    var isStepsOverOnTheDay = false;
    if( _isStartDateBig( startDateObj, tempStartHour, tempStartMinute, startDateObj, tempEndHour, tempEndMinute) )
    {
        isStepsOverOnTheDay = true;
    }
    else if( tempStartHour == tempEndHour && tempStartMinute == tempEndMinute )
    {
        isStepsOverOnTheDay = true;
    }

    //日マタギか？
    if( isStepsOverOnTheDay )
    {
        endDateObj  = _computeDate( startDateObj.getFullYear(), startDateObj.getMonth() + 1, startDateObj.getDate(), 1 );
    }
    else
    {
        endDateObj  = startDateObj;
    }

    // 親ウィンドウに日付を反映、イベントの発火
    parentDocument.getElementById("start_year").value   = startDateObj.getFullYear();
    parent.GRN_Event.fireEvent(parentDocument.getElementById("start_year"), 'change');
    parentDocument.getElementById("start_month").value  = startDateObj.getMonth() + 1;
    parent.GRN_Event.fireEvent(parentDocument.getElementById("start_month"), 'change');
    parentDocument.getElementById("start_day").value    = startDateObj.getDate();
    parent.GRN_Event.fireEvent(parentDocument.getElementById("start_day"), 'change');
    parentDocument.getElementById("end_year").value     = endDateObj.getFullYear();
    parent.GRN_Event.fireEvent(parentDocument.getElementById("end_year"), 'change');
    parentDocument.getElementById("end_month").value    = endDateObj.getMonth() + 1;
    parent.GRN_Event.fireEvent(parentDocument.getElementById("end_month"), 'change');
    parentDocument.getElementById("end_day").value      = endDateObj.getDate();
    parent.GRN_Event.fireEvent(parentDocument.getElementById("end_day"), 'change');
}

/****************************************************************  
* 機　能： 親画面の時間をセットする
****************************************************************/
function _setParentTime()
{
    var start_time_hour     = $("start_hour").value;
    var start_time_minute   = $("start_minute").value;
    var end_time_hour       = $("end_hour").value;
    var end_time_minute     = $("end_minute").value;
    var parent          = window.opener;
    var parentDocument  = parent.document;

    // 親ウィンドウに時間を反映、イベントの発火
    parentDocument.getElementById("start_hour").value   = start_time_hour;
    parent.GRN_Event.fireEvent(parentDocument.getElementById("start_hour"), 'change');
    parentDocument.getElementById("start_minute").value = start_time_minute;
    parent.GRN_Event.fireEvent(parentDocument.getElementById("start_minute"), 'change');
    parentDocument.getElementById("end_hour").value     = end_time_hour;
    parent.GRN_Event.fireEvent(parentDocument.getElementById("end_hour"), 'change');
    parentDocument.getElementById("end_minute").value   = end_time_minute;
    parent.GRN_Event.fireEvent(parentDocument.getElementById("end_minute"), 'change');
}

/****************************************************************  
* 機　能： 数値かどうかチェックする
* 引　数： value：チェックしたい値
* 戻り値： 数値：true　空文字または数値でない：false 
****************************************************************/
function _isNumeric( value )
{
    return ( isNaN(value) == false && value.length > 0 ) ? true : false;
}

/****************************************************************  
* 機　能： 開始日時の方が大きいかチェックする
* 引　数： sDateObj：開始日　sHour：開始時　sMinute：開始分　eDateObj：終了日　eHour：終了時　eMinute：終了分
* 戻り値： 開始日時の方が大きい：true　開始日時と終了日時が同じか、終了日時の方が大きい：false  
****************************************************************/
function _isStartDateBig( sDateObj, sHour, sMinute, eDateObj, eHour, eMinute )
{
    var startTime   = Date.parse( sDateObj.getFullYear() + "/" + (sDateObj.getMonth()+1) + "/" + sDateObj.getDate() + " " + sHour + ":" + sMinute );
    var endTime     = Date.parse( eDateObj.getFullYear() + "/" + (eDateObj.getMonth()+1) + "/" + eDateObj.getDate() + " " + eHour + ":" + eMinute );

    return ( startTime > endTime ) ? true : false;
}

/****************************************************************  
* 機　能： 日付の加減
* 引　数： year：計算対象年　month：計算対象月　day：計算対象日　addDays：加減数
* 戻り値： 加減後のDateオブジェクト
****************************************************************/
function _computeDate(year, month, day, addDays) {
    var dt = new Date(year, month - 1, day);
    var baseSec = dt.getTime();
    var addSec = addDays * 86400000;//日数 * 1日のミリ秒数
    var targetSec = baseSec + addSec;
    dt.setTime(targetSec);
    return dt;
}

/****************************************************************  
* 機　能： 入力された値が日付でYYYY-MM-DD形式になっているか調べる  
* 引　数： datestr　入力された値  
* 戻り値： 正：true　不正：false  
****************************************************************/
function _validateDateStr( datestr )
{
    // 正規表現による書式チェック  
    if(!datestr.match(/^\d{4}-\d{2}-\d{2}$/)){
        return false;
    }

    var vYear = datestr.substr(0, 4) - 0;
    var vMonth = datestr.substr(5, 2) - 1; // Javascriptは、0-11で表現
    var vDay = datestr.substr(8, 2) - 0;

    // 月,日の妥当性チェック  
    if(vMonth >= 0 && vMonth <= 11 && vDay >= 1 && vDay <= 31)
    {
        var vDt = new Date(vYear, vMonth, vDay);

        if( isNaN(vDt) )
        {
            return false;
        }
        else if( vDt.getFullYear() == vYear && vDt.getMonth() == vMonth && vDt.getDate() == vDay )
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    else
    {
        return false;
    }
}

/****************************************************************  
* function： move the date of free time confirmation window keeping time setting 
* valuable： desturl : URL to open the confirmation window
****************************************************************/
function moveCalendar(desturl, anchor)
{
    var start_hour     = $("start_hour") ? $("start_hour").value : '';
    var start_minute   = $("start_minute") ? $("start_minute").value : '';
    var end_hour       = $("end_hour") ? $("end_hour").value : '';
    var end_minute     = $("end_minute") ? $("end_minute").value : '';
    
    desturl += "&start_hour=" + start_hour + "&start_minute=" + start_minute;
    desturl += "&end_hour=" + end_hour + "&end_minute=" + end_minute;
    
    // add anchor
    if( typeof anchor !== 'undefined' )
    {
        desturl += anchor;
    }
    
    location.href = desturl;
}

//GTM-105 set end_time = start_time + 1
function setEndTime(id)
{
    if ( id == 'start_hour')
    {
        var startHour     = $("start_hour");
        var startMinute   = $("start_minute");
        var endHour       = $("end_hour");
        var endMinute     = $("end_minute");
        if (startHour.value != '' && startMinute.value == '' && endHour.value == '' && endMinute.value == '' )
        {
            if (startHour.value == '23') {
                endHour.value = parseInt(startHour.value);
            }
            else {
                endHour.value = parseInt(startHour.value) + 1;
            }
            endMinute.value = 0;
            startMinute.value = 0;
        }
    }
}