/**
 * resources
 * see 'page/schedule/portlet/view_user_week.tpl' to fit
 */
// 日付表示更新時に使う曜日
//var cy_schedule_gw_wday_name = new Array("日", "月", "火", "水", "木", "金", "土");

/**
 * グループ週スケジューラプロパティ
 * Group Week Schedule Property
 */
var CyScheduleGwProperty = function(day_buffer, ajax_url, startwday, plid, post_body){
    this.initialize(day_buffer, ajax_url, startwday, plid, post_body);
};
CyScheduleGwProperty.prototype = {
    baseline_id : 0,
    buffer_count : 21,
    init_flag : false,
    getting_next : false,
    getting_prev : false,
    day_buffer : null,
    ajax_url : '',
    startwday : 0,
    plid : '',
    post_body: '',
    initialize: function(day_buffer, ajax_url, startwday, plid, post_body){
        this.day_buffer = day_buffer;
        this.ajax_url = ajax_url;
        this.startwday = startwday;
        this.plid = plid;
        this.post_body = post_body;
    }
};

/**
 * Group Week Schedule Function
 */
var CyScheduleGw = {
    ctrl : function( func, plid ) {
        // プロパティを取得 (p = CyScheduleGwProperty)
        var p = plid_array[plid];

        // ユーザー・施設が空の場合は終了
        if ( ! p.day_buffer[0] ) {
            return;
        }

        // ボタンを無効にする
        CyScheduleGw.set_disable();

        var eid = arguments.length == 3 ? arguments[2] : '';
        var callback = function() {
            // バッファの初期化確認
            if (!p.init_flag) {
                CyScheduleGw.init_buffer( p, func );
            }
            if (func == 'refresh')
            {
                CyScheduleGw.routing( p, func, eid );
                return;
            }
            CyScheduleGw.routing( p, func );
        };
        timer = setTimeout(callback, 0);
    },
    // 指定した処理を実行
    routing : function( p, func ) {
        switch (func) {
            case 'day_next' :
                this.day_next(p);
                break;
            case 'day_prev' :
                this.day_prev(p);
                break;
            case 'week_next' :
                this.week_next(p);
                break;
            case 'week_prev' :
                this.week_prev(p);
                break;
            case 'refresh' :
                var eid = arguments.length == 3 ? arguments[2] : '';
                this.refresh(p, eid);
                break;
            default:
                break;
        }
        // ボタンを有効にする
        this.remove_disable();
    },
    // 前日移動
    day_prev : function(p) {
        // 1日過去のバッファの存在確認
        if ( ! p.day_buffer[(p.baseline_id - 1)] ) {
            // バッファが1日も無ければ、過去のバッファを取得して終了
            return this.get_prev_buffer( p,1);
        }
        // 1日過去を表示する
        var baseline_id = p.baseline_id - 1;

        // スケジュールテーブルを描画する
        this.draw_table( p, baseline_id );

        // ベースラインを更新
        p.baseline_id = baseline_id;

        // 日付表示を更新する
        var baseline_str = this.update_date_title(p);

        // buffer management
        return this.get_prev_buffer( p, p.buffer_count );
    },
    // 翌日移動
    day_next : function(p) {
        // 1日未来のバッファの存在確認
        if ( ! p.day_buffer[( p.baseline_id + 7 )] ) {
            // バッファが1日も無ければ、未来のバッファを取得して終了
            return this.get_next_buffer( p, 7 );
        }

        // 1日未来を表示する
        var baseline_id = p.baseline_id + 1;

        // スケジュールテーブルを描画する
        this.draw_table( p, baseline_id );

        // ベースラインを更新
        p.baseline_id = baseline_id;

        // 日付表示を更新する
        var baseline_str = this.update_date_title( p );

        return this.get_next_buffer( p, p.buffer_count + 7 );
    },
    // 前週移動
    week_prev : function(p) {
        // 1週間過去のバッファの存在確認
        if ( ! p.day_buffer[( p.baseline_id - 7 )] ) {
            // 1週間過去のバッファが無ければ、過去のバッファを取得して終了
            return this.get_prev_buffer( p, 7 );
        }

        // 1日ずつ過去に表示を戻す
        var baseline_id = p.baseline_id;
        for ( var i = 0; i < 7; i++ ) {
            // バッファばあれば、1日過去に戻す
            if ( p.day_buffer[(baseline_id - 1)] ) {
                baseline_id--;
            }
            // 開始曜日であれば抜ける
            if ( this.is_first_wday( p, baseline_id) ) {
                break;
            }
        }

        // スケジュールテーブルを描画する
        this.draw_table( p, baseline_id );

        // ベースラインを更新
        p.baseline_id = baseline_id;

        // 日付表示を更新する
        var baseline_str = this.update_date_title(p);

        // buffer management
        return this.get_prev_buffer( p, p.buffer_count );
    },
    // 翌週移動
    week_next : function(p) {
        // 1週間未来のバッファの存在確認
        if ( ! p.day_buffer[(p.baseline_id + 13)] ) {
            // 1週間未来のバッファが無ければ、未来のバッファを取得して終了
            return this.get_next_buffer( p, 13 );
        }

        // 1日ずつ未来に表示を送る
        var baseline_id = p.baseline_id;
        for ( var i = 0; i < 7; i++ ) {
            // バッファがあれば1日未来に送る
            // It comes for one day.
            if ( p.day_buffer[( baseline_id + 7 )] ) {
                baseline_id++;
            }
            // 開始曜日であれば終了
            if ( this.is_first_wday( p, baseline_id)  ) {
                break;
            }
        }

        // スケジュールテーブルを描画する
        this.draw_table( p, baseline_id );

        // ベースラインを更新
        p.baseline_id = baseline_id;

        // 日付表示を更新する
        var baseline_str = this.update_date_title(p);

        // buffer management
        return this.get_next_buffer( p, p.buffer_count + 7 );
    },
    // スケジュールテーブル描画
    draw_table : function( p, baseline_id )
    {
        // カウンター
        var counter = {
            baseline_id : baseline_id,
            date_counter : 0,
            user_counter : 0
        };

        function tableTag(p)
        {
            var schedule_groupweek_id =  "schedule_groupweek_" + p.plid;
            var origin_fontsize = $(schedule_groupweek_id).style.fontSize;
            var classNames = gw_portlet_table_template[p.plid]["classes"].join(" ");
            var tag_template = gw_portlet_table_template[p.plid]["template"].join("")
                                                                            .replace( "CLASSES_NAME", classNames)
                                                                            .replace("PORTLET_ID", p.plid);
            return  tag_template.replace("schedule_groupweek_id",schedule_groupweek_id ).replace(/font-size:\d*%/,"font-size:"+origin_fontsize);
        }
        
        var gw_table_prefix_process = tableTag(p);
        var new_table = [];
        new_table.push(gw_table_prefix_process);
        this.table_handling( p, counter, new_table );
        new_table.push(gw_table_suffix);
        document.getElementById('gw_' + p.plid + '_cal_div').innerHTML = new_table.join('');
        if(typeof register_schedule_star_user_week == 'function')
        {
            register_schedule_star_user_week();
        }
        // for process username when using ajax GRN2-2678
        if(typeof processDisplayUserName == 'function')
        {
            processDisplayUserName('schedule_groupweek_' + p.plid);
        }
        // for refresh view when using ajax GRN2-2287
        if(typeof refreshShowFullShortTitleByAjax == 'function')
        {
            refreshShowFullShortTitleByAjax(p.plid);
        }
        
        // for refresh view when using ajax GRN2-2718
        if(typeof refreshShowUsersTimezoneByAjax == 'function')
        {
            refreshShowUsersTimezoneByAjax(p.plid);
        }

        if (grn.base.isNamespaceDefined("garoon.schedule.data")
            && garoon.schedule.data.isCustomizationAvailable
            && garoon.schedule.data['schedule.calendar.groupWeekIndex.show'].portletId == p.plid) {
            var baseline_id = counter.baseline_id;
            var week = [];
            for (var i = 0; i < 7; i++) {
                week.push(p.day_buffer[baseline_id++]);
            }
            var event_data = {"viewType": "GROUP_WEEK", "dates": week};
            garoon.events.trigger('schedule.calendar.groupWeekIndex.show', event_data);
        }
    },
    // TBODY以下を処理
    table_handling : function( p, counter, new_table )
    {
        for (var i = 0; i < p.user_counter; i++)
        {
            // 日付行
            if (i%5 == 0) {
                this.date_tr_handling( p, counter, new_table );
            }
            // ユーザー行
            this.user_tr_handling( p, counter, new_table );
        }
        return new_table;
    },
    // 日付行を処理
    date_tr_handling : function( p, counter, new_table )
    {
        var baseline_id = counter.baseline_id;

        //GRN2-3233
        // trタグを追加
        new_table.push('<tr class="schedule_date_tr"><td class="calendar_date_week"><span class="domain">'+gw_timezone+'</span></td>');
        //GRN2-3233
        
        // 1週間分のTDノードを追加
        for (var i = 0; i < 7; i++) {
            new_table.push('<td class="' + gw_date[p.plid][baseline_id]['class_name']
                + '" align="center" nowrap>' + gw_date[p.plid][baseline_id++]['text'] + '</td>');
        }
        // 日付TRカウンタをアップ
        counter.date_counter++;
        // 新tbodyに新trを追加
        new_table.push("</tr>\n");
    },
    // ユーザー行を処理
    user_tr_handling : function( p, counter, new_table )
    {
        if (p.user_counter <= counter.user_counter) {
            return;
        }
        var baseline_id = counter.baseline_id;

        // trタグを追加
        var user_id = gw_user[p.plid]['user_id'][counter.user_counter];
        var tr_class_name = 'schedule_user_tr js_customization_schedule_user_id_' + user_id;
        new_table.push('<tr class="' + tr_class_name + '"><td valign="top" class="calendar_rb_week userBox">' + gw_user[p.plid]['user'][counter.user_counter] + '</td>');

        var tdElm = '<td class="s_user_week normalEvent" valign="top"';
        if (typeof GRN_ScheduleSimpleAdd !== 'undefined') {
            tdElm += ' onmouseover="GRN_ScheduleSimpleAdd.mouseOverHandler(event, this)" onmouseout="GRN_ScheduleSimpleAdd.mouseOutHandler(event, this)"';
        }
        // 1週間分のTDノードを追加
        for (var i = 0; i < 7; i++) {
            var td_html = tdElm + ' rel="' + gw_simple_add_url[p.plid][counter.user_counter][baseline_id] + '" plid="' + p.plid +'">';
            var user_schedule = jQuery(gw_user[p.plid][counter.user_counter][baseline_id++]);
            var a_elements  = user_schedule.find("a");
            var container = jQuery('<div></div>');

            for (var j = 0; j < a_elements.length; j++) {
                if (a_elements[j].target != '_blank') {
                    a_elements[j].href = a_elements[j].href + '&referer_bdate=' + p.day_buffer[counter.baseline_id];
                }
            }

            jQuery.each(user_schedule, function(i,val) {
                container.append(val);
            });
            var schedule_html = container.html();
            new_table.push(td_html + schedule_html + '</td>');
        }

        // 新tbodyに新trを追加
        new_table.push("</tr>\n");
        // バナー行を処理
        this.banner_tr_handling( p, counter, new_table);
        counter.user_counter++;
    },
    // バナー行を処理
    banner_tr_handling : function( p, counter, new_table )
    {
        if (! gw_banner[p.plid][counter.user_counter][counter.baseline_id]) {
            return;
        }
        // バナー追加
        new_table.push(gw_banner[p.plid][counter.user_counter][counter.baseline_id] + "\n");
    },
    // 表示tableの要素をオブジェクトに格納
    get_table_object : function( p )
    {
        // カウンター
        var counter = {
            user : 0
        };
        
        var display_tbody = document.getElementById('gw_' + p.plid + '_cal_tbody');
        this.get_tbody( p, display_tbody, counter);
    },
    // 各表示tableの要素をオブジェクトに格納
    get_tbody : function( p, display_tbody, counter )
    {
        // 子ノード数
        var childNodes_length = display_tbody.childNodes.length;
        for (var i = 0; i < childNodes_length; i++) {
            // 子ノードを取得
            var node = display_tbody.childNodes[i];

            // TRノードであれば処理
            if ( node.tagName == 'TR' ) {
                // ユーザー行
                if (node.className.indexOf('schedule_user_tr') !== -1) {
                    this.get_user_td(p, node, counter);
                }
            }
        }
    },
    // 表示tableのTD要素をオブジェクトに格納
    get_user_td : function( p, tr_node, counter )
    {
        // 子ノード数
        var childNodes_length = tr_node.childNodes.length;
        for (var i = 0; i < childNodes_length; i++) {
            // 子ノードを取得
            var node = tr_node.childNodes[i];

            // TDノードであれば処理
            if (node.tagName == 'TD') {
                gw_user[p.plid]['user'][counter.user] = node.innerHTML;
                break;
            }
        }
        counter.user++;
        p.user_counter = counter.user;
    },
    // 初期バッファ処理
    init_buffer : function( p, func )
    {
        this.get_table_object(p);

        // 移動量を計算して、初期状態の前後1週間ではなく、移動後の前後1週間を取得する
        // バッファ取得位置の移動量
        var move_line = 0;
        // ベースラインの日付
        var baseline_date = this.get_str2date(p.day_buffer[0]);
        switch (func) {
            case 'day_next' :
                move_line++;
                break;
            case 'day_prev' :
                move_line--;
                break;
            case 'week_next' :
                // 翌週移動の移動日数計算
                for ( var i = 0; i < 7; i++ ) {
                    // 1日進める
                    baseline_date.setDate(baseline_date.getDate() + 1);
                    move_line++;
                    // 開始曜日であれば抜ける
                    if ( baseline_date.getDay() == p.startwday ) {
                        break;
                    }
                }
                break;
            case 'week_prev' :
                // 前週移動の移動日数計算
                for ( var i = 0; i < 7; i++ ) {
                    // 1日戻す
                    baseline_date.setDate(baseline_date.getDate() - 1);
                    move_line--;
                    // 開始曜日であれば抜ける
                    if ( baseline_date.getDay() == p.startwday ) {
                        break;
                    }
                }
                break;
            default:
                break;
        }

        var post_body = p.post_body
            + '&bdate=' + p.day_buffer[0]
            + '&move=' + (-7 + move_line)
            + '&tdid=' + (-7 + move_line)
            + '&dummy=' + Math.floor(Math.random() * 10000000);
        this.send_req( p.ajax_url, move_line, 'init', p, false, post_body );

        p.init_flag = true;
    },
    // 過去のバッファを取得する
    get_prev_buffer : function( p, i)
    {
        // バッファが足りていれば終了
        if ( p.day_buffer[( p.baseline_id - i )] ) {
            return true;
        }
        // バッファ取得中であれば終了
        if ( p.getting_prev ) {
            // バッファが少なければ『読み込み中』を表示
            if ( !p.day_buffer[( p.baseline_id - 7 )] ) {
                this.show_loading();
                return false;
            }
            return true;
        }

        while( i >= 0 ) {
            if ( p.day_buffer[( p.baseline_id - i )] ) {
                p.getting_prev = true;
                var post_body = p.post_body + '&bdate='
                    + p.day_buffer[( p.baseline_id - i )] + '&move=-'
                    + p.buffer_count + '&tdid='
                    + ( p.baseline_id - i - p.buffer_count )
                    + '&dummy=' + Math.floor(Math.random() * 10000000);
                this.send_req( p.ajax_url, p.baseline_id - i, 'prev', p, true, post_body );
                break;
            }
            i--;
        }
        return true;
    },
    // 未来のバッファを取得する
    get_next_buffer : function( p, i)
    {
        // バッファが足りていれば終了
        if ( p.day_buffer[( p.baseline_id + i )] ) {
            return true;
        }
        // バッファ取得中であれば終了
        if ( p.getting_next ) {
            // バッファが少なければ『読み込み中』を表示
            if ( !p.day_buffer[( p.baseline_id + 13 )] ) {
                this.show_loading();
                return false;
            }
            return true;
        }

        while( i >= 0 ) {
            if ( p.day_buffer[( p.baseline_id + i )] ) {
                p.getting_next = true;
                var tdid = p.baseline_id + i + 1;
                var post_body = p.post_body + '&bdate='
                    + p.day_buffer[( p.baseline_id + i )] + '&move=1&tdid=' + tdid
                    + '&dummy=' + Math.floor(Math.random() * 10000000);
                this.send_req( p.ajax_url, p.baseline_id + i, 'next', p, true, post_body );
                break;
            }
            i--;
        }
        return true;
    },
     // バッファを取得するためにリクエストする
    send_req : function( url, tdid, way, p, asynchronous, post_body )
    {
        var oj = new Ajax.Request(
            url,
            {
                method     : 'POST',
                asynchronous : asynchronous,
                postBody: post_body,
                onComplete : function( roj )
                {
                    // X-Cybozu-Errorチェック
                    var headers = roj.getAllResponseHeaders();
                    var regex = new RegExp( /X-Cybozu-Error/i );
                    if ( headers.match( regex ) ) {
                        document.write(roj.responseText);
                        document.close();
                        return false;
                    }
                    
                    // GRB-15162
                    dataJSON = roj.responseText.evalJSON();
                    CyScheduleGw.parseDataJSON(dataJSON);
                    
                    // バッファ管理テーブルを更新
                    if (way !== 'refresh')
                    {
                        CyScheduleGw.add_day_buffer( p, tdid, way );
                    }
                    if ( way == 'next' ) {
                        p.getting_next = false;
                    } else if ( way == 'prev' ) {
                        p.getting_prev = false;
                    }
                    else if (way === 'refresh')
                    {
                        // refresh after using simple add function
                        CyScheduleGw.draw_table(p, p.baseline_id);
                        if (GRN_ScheduleSimpleAdd) {
                            GRN_ScheduleSimpleAdd.Dialog.Highlight();
                        }
                    }
                    // 『読み込み中』を隠す
                    $('loading').hide();
                    CyScheduleGw.remove_disable();
                    //GRREQ-492
                    if(typeof rebuildUI == "function")
                    {
                        rebuildUI();
                    }
                    //End GRREQ-492
                },
                onFailure : function( roj )
                {
                    if ( way == 'next' ) {
                        p.getting_next = false;
                    } else if ( way == 'prev' ) {
                        p.getting_prev = false;
                    }
                    // 『読み込み中』を隠す
                    $('loading').hide();
                    CyScheduleGw.remove_disable();
                },
                onException : function( roj )
                {
                    if ( way == 'next' ) {
                        p.getting_next = false;
                    } else if ( way == 'prev' ) {
                        p.getting_prev = false;
                    }
                    // 『読み込み中』を隠す
                    $('loading').hide();
                    CyScheduleGw.remove_disable();
                }
            }
        );
    },
    // バッファ管理テーブルに、追加したバッファの管理情報を追加
    add_day_buffer : function( p, tdid, way )
    {
        var target_date;

        if ( way == 'init' ) {
            // バッファ初期化時は0から計算する
            target_date = CyScheduleGw.get_str2date(p.day_buffer[0]);
            target_date.setDate((target_date.getDate() - 8 + tdid));
            tdid = tdid - 8;
        } else {
           target_date = CyScheduleGw.get_str2date(p.day_buffer[tdid]);
        }
        
        if ( way == 'prev' ) {
            target_date.setDate((target_date.getDate() - 22));
            tdid = tdid - p.buffer_count -1;
        }

        for( var i=0; i < p.buffer_count; i++ ) {
            target_date.setDate( target_date.getDate() + 1 );
            tdid++;
            p.day_buffer[tdid] = CyScheduleGw.get_date2str(target_date);
        }
    },
    // 開始曜日かどうかの確認
    is_first_wday : function( p, baseline_id)
    {
        var baseline_date = this.get_str2date(p.day_buffer[baseline_id]);
        if ( baseline_date.getDay() == p.startwday ) {
            return true;
        }
        return false;
    },
    // 日付表示を更新する
    update_date_title : function( p )
    {
        var date_title = new Object();
        var baseline_str = p.day_buffer[p.baseline_id];
        var baseline_date = this.get_str2date(baseline_str);

        $('schedule_gw_' + p.plid + '_date_title').innerHTML = this.getLocalizedDateStr( baseline_date, "DateFull_YMDW");

        // hidden値を更新する
        if (document.forms['personal_day' + p.plid]) {
            document.forms['personal_day' + p.plid].bdate.value = baseline_str;
        }
        return baseline_str;
    },
    // ボタンをdisableにする処理
    set_disable : function()
    {
        var buttonElements = document.getElementsByName('onloadAble');
        for(var i = 0; i < buttonElements.length; i++) {
            buttonElements[i].setAttribute('disabled', true);
        }
    },
    // ボタンのdisable属性を削除する処理
    remove_disable : function()
    {
        var buttonElements = document.getElementsByName('onloadAble');
        for(var i = 0; i < buttonElements.length; i++) {
            buttonElements[i].removeAttribute('disabled');
        }
    },
    // 『読み込み中』を表示する
    show_loading : function()
    {
        var item = $('loading');
        Element.show(item);

        // アイテムの縦・横のサイズを取得
        var item_dim = Element.getDimensions(item);
        var item_obj = jQuery("#loading");

        // 座標を取得
        var left_position = (item_obj.parent().width() - item_dim.width) / 2;
        var top_position = (item_obj.parent().height() - item_dim.height) / 2;

        // 座標を指定する
        Element.setStyle(item, {
            "left":left_position+"px",
            "top":top_position+"px",
            "z-index":"1000"
        });
    },
    // Dateを文字列（YYYY-MM-DD）で返す
    get_date2str : function(target_date)
    {
        var temp_date = {};
        temp_date['year'] = target_date.getYear();
        if ( temp_date['year'] < 2000 ) { temp_date['year'] += 1900; }
        temp_date['month'] = target_date.getMonth() + 1;
        if ( temp_date['month'] < 10 ) { temp_date['month'] = "0" + temp_date['month']; }
        temp_date['date'] = target_date.getDate();
        if ( temp_date['date'] < 10 ) { temp_date['date'] = "0" + temp_date['date']; }

        return temp_date['year'] + '-' + temp_date['month'] + '-' + temp_date['date'];
    },
    // 文字列（YYYY-MM-DD）をDateで返す
    get_str2date : function(target_date_str)
    {
        var target_date = new Date( target_date_str.substring( 0, 4 ) ,
            target_date_str.substring( 5, 7 ) - 1 ,
            target_date_str.substring( 8, 10 ));

        return target_date;
    },
    convertResponse : function( text )
    {
        if( navigator.appVersion.indexOf( "KHTML" ) > -1 )
        {
            var esc = escape( text );
            if( esc.indexOf( "%u" ) < 0 && esc.indexOf( "%" ) > -1 )
            {
                text = decodeURIComponent( esc );
            }
        }
        return text;
    },
    getLocalizedDateStr : function( target_date, format )
    {
        var date_format_template = cy_schedule_gw_date_format_template( format );
        var date_format_params = cy_schedule_gw_date_params( target_date );
        return new Template( date_format_template,
                             /(.?)(&&(\w+)&&)/
                           ).evaluate( date_format_params );
    },
    setInitFlagFalse : function(plid)
    {
        if( typeof plid_array[plid] === "undefined" ) { return ;}
        plid_array[plid].init_flag = false;
    },
    refresh : function(p, eid)
    {
        var tdid = p.baseline_id;
        var post_body = p.post_body + '&bdate='
            + p.day_buffer[p.baseline_id] + '&move=0&tdid=' + tdid
            + '&event=' + eid
            + '&dummy=' + Math.floor(Math.random() * 10000000);
        this.send_req( p.ajax_url, p.baseline_id, 'refresh', p, true, post_body );
    },
    parseDataJSON : function(data)
    {
        gw_date = jQuery.extend(true,gw_date,data.gw_date);
        gw_banner = jQuery.extend(true,gw_banner,data.gw_banner);
        gw_simple_add_url = jQuery.extend(true,gw_simple_add_url,data.gw_simple_add_url);
        gw_user = jQuery.extend(true,gw_user,data.gw_user);
        gw_timezone = data.gw_timezone;
    }
};
/**
 * URLにdummyパラメータを追加してリクエストする
 */
function url_add_dummy(url)
{
    // ?で分割
    var url_array = url.split('?');

    // ?で分割できなければ処理終了
    if ( url_array.length < 2) {
        return;
    }

    // URLパラメータをHashオブジェクトに変換
    var url_params = new Hash(url_array[1].toQueryParams());
    // dummyパラメータを追加
    url_params.set( 'dummy', Math.floor(Math.random() * 10000000) );

    // #で分割
    var hash_array = url.split('#');

    // #で分割できなければ処理終了
    if ( hash_array.length < 2) {
        return;
    }

    // dummyパラメータを追加したURLでhrefを更新する
    location.href = url_array[0] + '?' + url_params.toQueryString() + '#' + hash_array[1];
}
// refere_bdateを付加する
function cy_gw_rd(link_element, plid)
{
    cy_schedule_gw_date_rewritten(link_element, plid, 'referer_bdate');
}
// bdateを更新する
function cy_gw_bd(link_element, plid)
{
    cy_schedule_gw_date_rewritten(link_element, plid, 'bdate');
}
// 引数部分を書き換える
function cy_schedule_gw_date_rewritten(link_element, plid, param_name)
{
    // 日付文字列
    var date_str = '';

    if ( plid && document.forms['personal_day' + plid]) {
        date_str = document.forms['personal_day' + plid].bdate.value;
    } else {
        return;
    }

    // bdateの値がなければ処理終了
    if ( date_str == '') {
        return;
    }

    // href属性の値
    var href_query = link_element.getAttribute('href');
    // ?で分割
    var href_query_array = href_query.split('?');
    // ?で分割できなければ処理終了
    if ( href_query_array.length < 2) {
        return;
    }

    // URLパラメータをHashオブジェクトに変換
    var url_params = new Hash(href_query_array[1].toQueryParams());
    // 指定したパラメータ名の値を更新
    url_params.set( param_name, date_str );

    // 指定したパラメータを更新したパラメータでhrefを更新する
    link_element.setAttribute('href', href_query_array[0] + '?' + url_params.toQueryString());
    return;
}
