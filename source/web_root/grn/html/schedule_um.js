/**
 * resources
 * see 'page/shcedule/portlet/view_personal_month.tpl' to fit
 * see 'page/shcedule/personal_month.tpl' to fit
 *
 * // It is a baseline as for the first week.
 * var cy_schedule_um_baseline_id = 5;
 * // It is a number during the displayed week.
 * var cy_schedule_um_week_display = 5;
 * // Buffer table
 * var cy_schedule_um_week_buffer = new Object();
 * cy_schedule_um_week_buffer['week_0'] = '2007-01-21';
 * // Ajax request url
 * var cy_schedule_um_ajax_url = '';
 * // capacity of buffer
 * var cy_schedule_um_buffer_count = 15;
 */

/**
 * User Month Schedule Property
 */
var CyScheduleUmProperty = function(baseline_id, week_display, week_buffer, ajax_url, plid, is_appli, startwday){
    this.initialize(baseline_id, week_display, week_buffer, ajax_url, plid, is_appli, startwday);
};
CyScheduleUmProperty.prototype = {
    getting_next : false,
    getting_prev : false,
    buffer_count : 15,
    callback_history_obj : null,
    default_hash : '',
    current_hash : '',
    iframe: null,
    default_baseline_id : 0,
    baseline_id : 0,
    week_display : 0,
    week_buffer : null,
    ajax_url : '',
    plid : '',
    is_appli : false,
    startwday : 0,
    initialize: function(baseline_id, week_display, week_buffer, ajax_url, plid, is_appli, startwday) {
        this.default_baseline_id = baseline_id;
        this.baseline_id = baseline_id;
        this.week_display = week_display;
        this.week_buffer = week_buffer;
        this.ajax_url = ajax_url;
        this.plid = plid;
        this.is_appli = is_appli;
        this.startwday = startwday;
    }
};

/**
 * 月スケジューラ処理
 * User Month Schedule Function
 */
var CyScheduleUm = {
    ctrl : function( func, plid ) {
        // プロパティを取得 (p = CyScheduleUmProperty)
        var p = plid_array[plid];

        // フラグメント監視を停止
        if (p.is_appli) {
            clearInterval(p.callback_history_obj);
        }

        // ボタンを無効にする
        CyScheduleUm.set_disable();

        var eid = arguments.length == 3 ? arguments[2] : '';
        var callback = function() {
            if (func == 'refresh')
            {
                CyScheduleUm.routing( p, func, eid );
                return;
            }
            CyScheduleUm.routing( p, func );
        };
        timer = setTimeout(callback, 0);
    },
    // 指定した処理を実行
    routing : function( p, func ) {
        switch (func) {
            case 'week_next' :
                this.week_next(p);
                break;
            case 'week_prev' :
                this.week_prev(p);
                break;
            case 'month_next' :
                this.month_next(p);
                break;
            case 'month_prev' :
                this.month_prev(p);
                break;
            case 'refresh':
                var eid = arguments.length == 3 ? arguments[2] : '';
                this.refresh(p, eid);
                break;
            default:
                break;
        }
        // ボタンを有効にする
        this.remove_disable();
        // フラグメント監視を実行
        this.callback_history(p, 100);
        if(func !== 'refresh'){
            this.triggerJsApiMonthIndexShow(p);
        }
        return true;
    },
    // 前週移動
    week_prev : function(p)
    {
        if ( ! p.week_buffer[(p.baseline_id - 1)] ) {
            // buffer management
            this.get_prev_buffer( p, 1);
            return;
        }
        this.show_row('um_' + p.plid + '_' + (p.baseline_id - 1));
        this.hide_row('um_' + p.plid + '_' + (p.baseline_id + (p.week_display - 1)));
        p.baseline_id--;

        if ( this.is_first_week(p) ) {
            this.reset_week_display(p);
        }

        // buffer management
        this.get_prev_buffer( p, p.buffer_count);

        this.update_date_title(p, true);
        return;
    },
    // 翌週移動
    week_next : function(p)
    {
        //It comes for one week.
        if ( ! p.week_buffer[(p.baseline_id + p.week_display)] ) {
            // buffer management
            this.get_next_buffer( p, p.week_display);
            return;
        }
        this.show_row('um_' + p.plid + '_' + (p.baseline_id + p.week_display));
        this.hide_row('um_' + p.plid + '_' + p.baseline_id);
        p.baseline_id++;

        if ( this.is_first_week(p) ) {
            this.reset_week_display(p);
        }

        // buffer management
        this.get_next_buffer( p, p.buffer_count + p.week_display);

        this.update_date_title(p, true);
        return;
    },
    // 前月移動
    month_prev : function(p)
    {
        if ( ! p.week_buffer[(p.baseline_id - 5)] ) {
            // buffer management
            this.get_prev_buffer( p, 5);
            return true;
        }

        for ( var i = 0; i < 5; i++ ) {
            if ( p.week_buffer[(p.baseline_id - 1)] ) {
                this.show_row('um_' + p.plid + '_' + (p.baseline_id - 1));
                this.hide_row('um_' + p.plid + '_' + (p.baseline_id + (p.week_display - 1)));
                p.baseline_id--;
            }
            if ( this.is_first_week(p) ) {
                this.reset_week_display(p);
                break;
            }
        }
        // buffer management
        this.get_prev_buffer( p, p.buffer_count);

        this.update_date_title(p, true);
        return true;
    },
    // 翌月移動
    month_next : function(p)
    {
        if ( ! p.week_buffer[(p.baseline_id + p.week_display + 4)] ) {
            // buffer management
            this.get_next_buffer( p, p.week_display + 4);
            return true;
        }
        for ( var i = 0; i < 5; i++ ) {
            //It comes for one week.
            if (p.week_buffer[(p.baseline_id + p.week_display)]) {
                this.show_row('um_' + p.plid + '_' + (p.baseline_id + p.week_display));
                this.hide_row('um_' + p.plid + '_' + p.baseline_id);
                p.baseline_id++;
            }
            if ( this.is_first_week(p) ) {
                this.reset_week_display(p);
                break;
            }
        }
        // buffer management
        this.get_next_buffer( p, p.buffer_count + p.week_display);
        this.update_date_title(p, true);
        return true;
    },
    /**
     *
     * @param {Object} portlet_information
     * @returns {boolean}
     * @private
     */
    _isAvailableForJsApiTrigger: function (portlet_information) {
        var is_available_trigger = portlet_information.plid == "";
        if (!is_available_trigger
            && garoon.schedule
            && garoon.schedule.data
            && garoon.schedule.data.hasOwnProperty("schedule.calendar.monthIndex.show")) {
            is_available_trigger = garoon.schedule.data["schedule.calendar.monthIndex.show"].portletId == portlet_information.plid;
        }
        
        if (grn.base.isNamespaceDefined("garoon.schedule.data")
            && garoon.schedule.data.isCustomizationAvailable
            && is_available_trigger) {
            return true;
        }
        return false;
    },
    /**
     *
     * @param {Object} portlet_information
     */
    triggerJsApiMonthIndexShow: function (portlet_information) {
        if (!this._isAvailableForJsApiTrigger(portlet_information)) {
            return;
        }
        var dates = [];
        var selector_calendar = "#um__body";
        if ( typeof portlet_information.plid !== "undefined" && portlet_information.plid !== "") {
            selector_calendar = "#um_" + portlet_information.plid + "_body";
        }
        var $calendar_container = jQuery(selector_calendar);
        var $customization_spaces = $calendar_container.find("tr").has(":visible").find("[class^='js_customization_schedule_date_']");
        $customization_spaces.each(function () {
            dates.push(jQuery(this).attr("data-date"));
        });
        // Empty content of customization spaces before triggering
        $customization_spaces.empty();
        var event_data = {"type": "schedule.calendar.monthIndex.show", "viewType": "MONTH", "dates": dates};
        garoon.events.trigger("schedule.calendar.monthIndex.show", event_data);
    },
    // 指定IDの行を表示する
    show_row : function (id)
    {
        Element.show(id);
        // バナーを表示する
        id_prefix = id + '_';
        var i = 0;
        while ( $(id_prefix + i) ) {
            if( navigator.userAgent.indexOf("MSIE 9") > 0 )
            {
                $(id_prefix + i).style.visibility ='';
            }
            Element.show( id_prefix + i );
            i++;
        }
    },
    // 指定IDの行を隠す
    hide_row : function (id)
    {
        Element.hide(id);
        // バナーを隠す
        id_prefix = id + '_';
        var i = 0;
        while ( $(id_prefix + i) ) {
            if( navigator.userAgent.indexOf("MSIE 9") > 0 )
            {
                $(id_prefix + i).style.visibility ='collapse';
            }
            else
            {
                Element.hide( id_prefix + i );
            }
            i++;
        }
    },
    // その月に必要な週分だけ表示する
    reset_week_display : function(p)
    {
        var target_date = this.get_str2date(p.week_buffer[(p.baseline_id)]);

        // 3週間後にセット
        target_date.setDate(target_date.getDate() + 21);
        var third_line_month = target_date.getMonth();
        var week_display_new;

        for ( var i = 4; i <= 6; i++ ) {
            // 1週間進める
            target_date.setDate(target_date.getDate() + 7);

            // 3週目（当月）と異なったら翌月と判断
            if (third_line_month != target_date.getMonth()) {
                week_display_new = i;
                break;
            }
        }

        if ( p.week_display < week_display_new ) {
            this.show_row('um_' + p.plid + '_' + (p.baseline_id + p.week_display));
            p.week_display = week_display_new;
        } else if ( p.week_display > week_display_new ) {
            p.week_display = week_display_new;
            this.hide_row('um_' + p.plid + '_' + (p.baseline_id + p.week_display));
        }
    },
    // 第1週かどうかを確認する
    is_first_week : function(p)
    {
        var baseline_date = this.get_str2date(p.week_buffer[(p.baseline_id)]);

        // ベースラインの一番右の列が7日以下であれば第1週と判断する
        baseline_date.setDate(baseline_date.getDate() + 6);
        if (baseline_date.getDate() <= 7) {
            return true;
        }
        return false;
    },
    // 過去のバッファを取得する
    get_prev_buffer : function( p, i )
    {
        // バッファが足りていれば終了
        if ( p.week_buffer[(p.baseline_id - i)] ) {
            return;
        }
        // バッファ取得中であれば終了
        if ( p.getting_prev ) {
            // バッファが少なければ『読み込み中』を表示
            if ( !p.week_buffer[(p.baseline_id - 5)] ) {
                this.loading_show();
            }
            return;
        }

        while( i >= 0 ) {
            if ( p.week_buffer[(p.baseline_id - i)] ) {
                p.getting_prev = true;
                var request_url = p.ajax_url + '&bdate=' + p.week_buffer[(p.baseline_id - i)]
                    + '&move=-' + p.buffer_count + '&trid=' + (p.baseline_id - i - p.buffer_count)
                    + '&dummy=' + Math.floor(Math.random() * 10000000);
                this.send_req( request_url, p.baseline_id - i, 'prev', p );
                break;
            }
            i--;
        }
        return;
    },
    // 未来のバッファを取得する
    get_next_buffer : function(p, i)
    {
        // バッファが足りていれば終了
        if ( p.week_buffer[(p.baseline_id + i)] ) {
            return;
        }
        // バッファ取得中であれば終了
        if ( p.getting_next ) {
            // バッファが少なければ『読み込み中』を表示
            if ( !p.week_buffer[(p.baseline_id + p.week_display + 4 )] ) {
                this.loading_show();
            }
            return;
        }

        while( i >= 0 ) {
            if ( p.week_buffer[(p.baseline_id + i)] ) {
                p.getting_next = true;
                var request_url = p.ajax_url + '&bdate=' + p.week_buffer[(p.baseline_id + i)]
                    + '&move=1&trid=' + (p.baseline_id + i + 1)
                    + '&dummy=' + Math.floor(Math.random() * 10000000);
                this.send_req( request_url, p.baseline_id + i, 'next', p );
                break;
            }
            i--;
        }
        return;
    },
    // バッファを取得するためにリクエストする
    send_req : function( url, trid, way, p)
    {
        var oj = new Ajax.Request(
            url,
            {
                method     : 'GET',
                onComplete : function( roj )
                {
                    // X-Cybozu-Errorチェック
                    var headers = roj.getAllResponseHeaders();
                    var regex = new RegExp( /X-Cybozu-Error/i );
                    if( headers.match( regex ) )
                    {
                        document.write(roj.responseText);
                        document.close();
                        return false;
                    }

                    if (way !== 'refresh')
                    {
                        CyScheduleUm.add_week_buffer( p, trid, way );
                    }
                    if ( way == 'next' ) {
                        new Insertion.Bottom('um_' + p.plid + '_body', roj.responseText);
                    } else if ( way == 'prev' ) {
                        new Insertion.Top('um_' + p.plid + '_body', roj.responseText);
                    }
                    else if (way === 'refresh')
                    {
                        var dummy_table = $('um_' + p.plid + '_dummy');
                        if (!dummy_table)
                        {
                            dummy_table = new Element('table', {id:'um_' + p.plid + '_dummy',style:'display:none'});
                            document.body.appendChild(dummy_table);
                        }
                        dummy_table.update(roj.responseText);
                        
                        var tempEls = $$('#um_' + p.plid + '_body > tr');
                        var arr = [];
                        $$('#um_' + p.plid + '_dummy tr').each(function(row) {
                            if (row.id) {
                                arr[row.id] = row;
                            }
                        });
                        tempEls.each(function(row){
                            if (row.style.display != 'none' && arr[row.id])
                            {
                                $(row).update(arr[row.id].innerHTML);
                                if (i >= p.week_display) {return;}
                            }
                        });
                        if (GRN_ScheduleSimpleAdd) {
                            GRN_ScheduleSimpleAdd.Dialog.Highlight();
                        }
                        dummy_table.update('');
                        CyScheduleUm.triggerJsApiMonthIndexShow(p);
                    }

                    if ( way == 'next' ) {
                        p.getting_next = false;
                    } else if ( way == 'prev' ) {
                        p.getting_prev = false;
                    }
                    // 『読み込み中』を隠す
                    Element.hide($('loading'));
                    CyScheduleUm.remove_disable();
                    //GRREQ-492, this is method for month-view and portlet month-view
                    if(typeof rebuildUI == "function")
                    {
                        rebuildUI();
                    }
                    //End GRREQ-492
                    rebuild_popup_title(p.plid);
                },
                onFailure : function( roj )
                {
                    if ( way == 'next' ) {
                        p.getting_next = false;
                    } else if ( way == 'prev' ) {
                        p.getting_prev = false;
                    }
                    // 『読み込み中』を隠す
                    Element.hide($('loading'));
                    CyScheduleUm.remove_disable();
                },
                onException : function( roj )
                {
                    if ( way == 'next' ) {
                        p.getting_next = false;
                    } else if ( way == 'prev' ) {
                        p.getting_prev = false;
                    }
                    // 『読み込み中』を隠す
                    Element.hide($('loading'));
                    CyScheduleUm.remove_disable();
                }
            }
        );
    },
    // バッファ管理テーブルに、追加したバッファの管理情報を追加
    add_week_buffer : function( p, trid, way )
    {
        var temp_date = new Object();
        var target_date = this.get_str2date(p.week_buffer[trid]);

        // this.buffer_count = 15
        if ( way == 'prev' ) {
            target_date.setDate((target_date.getDate() - 112));
            trid = trid - p.buffer_count -1;
        }

        for( var i=0; i < p.buffer_count; i++ ) {
            target_date.setDate( target_date.getDate() + 7 );
            trid++;
            p.week_buffer[trid] = this.get_date2str(target_date);
        }
    },
    // 日付表示を更新する
    update_date_title : function(p, update_hash_flag)
    {
        var date_title = new Object();
        var baseline_str = p.week_buffer[(p.baseline_id)];
        var target_date = this.get_str2date(baseline_str);
        
        // register schedule star event
        if(typeof register_schedule_star_personal_month == 'function')
        {
            register_schedule_star_personal_month();
        }
        if(typeof register_schedule_star_view_personal_month == 'function')
        {
            register_schedule_star_view_personal_month();
        }
        
        target_date.setDate(target_date.getDate() + 6);
        if (target_date.getDate() <= 7) {
            // 通常月表示
            date_title['year'] = target_date.getYear();
            if (date_title['year'] < 2000) { date_title['year'] += 1900; }
            date_title['month'] = target_date.getMonth() + 1;
            date_title['month00'] = target_date.getMonth() + 1;
            if ( date_title['month00'] < 10 ) { date_title['month00'] = "0" + date_title['month00']; }

            var keys = new Array( 'year', 'month' , 'month00');
            var replaces = new Array( date_title['year'], cy_schedule_um_mon_name[target_date.getMonth()] , date_title['month00'] );

            $('schedule_um_' + p.plid + '_date_title').innerHTML = Cb_i18n.cb_msg( cy_schedule_um_dateformat_short, keys, replaces );

            // 0埋め
            temp_month = date_title['month'];
            if ( temp_month < 10 ) { temp_month = "0" + temp_month; }
            // hidden値を更新する
            var date_str = date_title['year'] + '-' + temp_month + '-01';
            this.update_date_param( p, date_str);
            if (update_hash_flag) {
                this.update_location_hash( p, date_str );
                p.current_hash = location.hash;
            }
            
            // process link in print schedule personal month and ical calendar export.
            var print_personal_month_element = $$('a.schedule_print_personal_month');
            if( print_personal_month_element.length > 0 )
            {
                var print_date = date_title['year'] + '-' + temp_month + '-01';
                print_personal_month_element.each(function(e){
                    var print_bdate_index = e.href.indexOf('bdate');
                    var print_begin_link = e.href.substr(0,print_bdate_index);
                    e.href = print_begin_link + 'bdate=' + print_date;
                });
                
            }
            
            return date_str;
        } else {
            // 月またぎ表示
            target_date.setDate(target_date.getDate() - 6);
            date_title['year'] = target_date.getYear();
            if (date_title['year'] < 2000) { date_title['year'] += 1900; }

            date_title['month00'] = target_date.getMonth() + 1;
            if ( date_title['month00'] < 10 ) { date_title['month00'] = "0" + date_title['month00']; }
            date_title['day00'] = target_date.getDate();
            if ( date_title['day00'] < 10 ) { date_title['day00'] = "0" + date_title['day00']; }

            var keys = new Array( 'year', 'month', 'day', 'month00', 'day00' );
            var start_replaces = new Array( date_title['year'],
                cy_schedule_um_mon_name[target_date.getMonth()],
                target_date.getDate(),
                date_title['month00'],
                date_title['day00']
            );

            target_date.setDate(target_date.getDate() + ((p.week_display * 7 - 1)));
            date_title['end_year'] = target_date.getYear();
            if (date_title['end_year'] < 2000) { date_title['end_year'] += 1900; }
            date_title['month00'] = target_date.getMonth() + 1;
            if ( date_title['month00'] < 10 ) { date_title['month00'] = "0" + date_title['month00']; }
            date_title['day00'] = target_date.getDate();
            if ( date_title['day00'] < 10 ) { date_title['day00'] = "0" + date_title['day00']; }

            var end_replaces = new Array( date_title['end_year'],
                cy_schedule_um_mon_name[target_date.getMonth()],
                target_date.getDate(),
                date_title['month00'],
                date_title['day00']
            );

            $('schedule_um_' + p.plid + '_date_title').innerHTML =
                Cb_i18n.cb_msg( cy_schedule_um_dateformat_long,
                    keys,
                    start_replaces )
                + cy_schedule_um_dateformat_tilda
                + Cb_i18n.cb_msg( cy_schedule_um_dateformat_long,
                    keys,
                    end_replaces );
        }
        return baseline_str;
    },
    // 画面リンク部分の日付を更新するために、hidden値を更新する
    update_date_param : function( p, date_str)
    {
        // ポータルとアプリ版で処理を分岐
        if (document.forms['personal_month' + p.plid]) {
            // ポータル
            document.forms['personal_month' + p.plid].bdate.value = date_str;
        } else {
            // アプリ
            // name="bdate" の全エレメントの値を更新する
            var param_elements = document.getElementsByName('bdate');
            for( var i = 0; i < param_elements.length; i++ ) {
                param_elements[i].setAttribute('value', date_str);
            }
        }
    },
    // フラグメントを書き換える
    update_location_hash : function(p, baseline_str)
    {
        if (!p.is_appli) {
            return;
        }
        // bookmark対応の為に、location.hashを更新する
        var hash_array = location.hash.split('bdate=');
        if (hash_array.length > 1) {
            // # を削除
            if (hash_array[0].substring(0, 1) == '#') {
                hash_array[0] = hash_array[0].substring(1);
            }
            // bdateを書き換え
            location.hash = hash_array[0] + 'bdate=' + baseline_str;
        } else {
            // bdateを追加
            location.hash += 'bdate=' + baseline_str;
        }
    },
    // ヒストリー管理
    // フラグメントの変更を監視する
    callback_history : function(p, msec)
    {
        if (!p.is_appli) {
            return;
        }
        p.callback_history_obj = setInterval( function () {
            var target_hash = '';
            // フラグメントに変更がなければ終了
            if (location.hash == p.current_hash) {
                return;
            }
            target_hash = location.hash;

            // フラグメント保持変数を更新
            p.current_hash = target_hash;
            var baseline_id_new = null;
            var hash_array = target_hash.split('bdate=');

            // デフォルトのフラグメントであれば初期状態を表示
            if (p.default_hash == p.current_hash) {
                baseline_id_new = p.default_baseline_id;
            } else if (hash_array.length > 1 && hash_array[1].match(/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/)) {
                // フラグメントに"bdate="があり、日付のフォーマットが正しければ、その日付を表示
                // 日付がバッファのどのキーなのかを確認
                // 曜日を取り出す
                var bdate = new Date( hash_array[1].substring( 0, 4 ) ,
                    hash_array[1].substring( 5, 7 ) - 1 ,
                    hash_array[1].substring( 8, 10 ));
                // bdateの曜日
                var bdate_wday = bdate.getDay();
                // bdateからbaseline_dateまでの移動量
                var move = 0;
                if (p.startwday == 1 && bdate_wday == 0) {
                    move = -6;
                } else {
                    move = p.startwday - bdate_wday;
                }
                bdate.setDate(bdate.getDate() + move);
                var baseline_date_str = CyScheduleUm.get_date2str(bdate);

                for (var i in p.week_buffer) {
                    if (p.week_buffer[i] == baseline_date_str) {
                        // キーはStringなので、Numberに変換
                        baseline_id_new = parseInt(i);
                        break;
                    }
                }
                // キーを取得できなければ終了
                if (baseline_id_new == null) {
                    return;
                }
            } else {
                return;
            }

            // ベースラインを更新
            p.baseline_id = baseline_id_new;

            // スケジュールテーブルを描画する
            if (!CyScheduleUm.draw_table( p )) {
                return;
            }

            // 日付表示を更新する
            CyScheduleUm.update_date_title( p, false );
        }, msec );
    },
    // 指定baselineから1ヶ月間のスケジュールを表示する
    draw_table : function( p )
    {
        var target_date = this.get_str2date(p.week_buffer[(p.baseline_id)]);

        // 3週間後にセット
        target_date.setDate(target_date.getDate() + 21);
        var third_line_month = target_date.getMonth();

        for ( var i = 4; i <= 6; i++ ) {
            // 1週間進める
            target_date.setDate(target_date.getDate() + 7);

            // 3週目（当月）と異なったら翌月と判断
            if (third_line_month != target_date.getMonth()) {
                p.week_display = i;
                break;
            }
        }

        // 保持バッファ内かどうか確認
        if (!p.week_buffer[(p.baseline_id)]
        || !p.week_buffer[(p.baseline_id + p.week_display - 1)]) {
            // 保持バッファ外であれば、location.hrefを書き換えて、再度リクエストする。
            var hash_array = location.hash.split('bdate=');
            var href_query_array = location.href.split('?');
            if (hash_array.length > 1 && href_query_array.length > 1 && hash_array[1].match(/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/)) {
                // URLパラメータをHashオブジェクトに変換
                var url_params = new Hash(location.href.toQueryParams());
                // bdateパラメータ名の値を更新
                url_params.set( 'bdate', hash_array[1] );

                // オリジナルのフラグメント対応
                var hash_param = '';
                if (hash_array[0].length > 1) {
                    hash_param = hash_array[0];
                }

                // hrefを更新する
                location.href = href_query_array[0] + '?' + url_params.toQueryString() + hash_param;
            }
            return false;
        }

        // 一旦、全てのTRタグを非表示にする
        for (var i in p.week_buffer) {
            this.hide_row('um_' + p.plid + '_' + i);
        }

        // スケジュールを表示する
        for ( var i = 0; i < p.week_display; i++ )
        {
            this.show_row('um_' + p.plid + '_' + (p.baseline_id + i));
        }
        return true;
    },
    // 『読み込み中』を表示する
    loading_show : function()
    {
        var item = $('loading');
        Element.show(item);

        // 縦・横のサイズを取得
        var item_dim = Element.getDimensions(item);

        // 画面の縦・横のサイズを取得
        var win_height, win_width;
        if (window.innerHeight) {
            win_height = window.innerHeight;
            win_width = window.innerWidth;
        } else {
            win_height = window.document.body.clientHeight;
            win_width = window.document.body.clientWidth;
        }

        // 座標を取得
        var left_position = (win_width - item_dim.width) / 2 + document.body.scrollLeft;
        var top_position = (win_height - item_dim.height) / 2 + document.body.scrollTop;

        // 座標を指定する
        Element.setStyle(item, {
            left:left_position+"px",
            top:top_position+"px"
        });
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
    // eid : id of event which will be highlighted
    refresh : function(p, eid)
    {
        var request_url = p.ajax_url + '&bdate=' + p.week_buffer[(p.baseline_id)]
            + '&move=0&trid=' + (p.baseline_id)
            + '&event=' + eid
            + '&dummy=' + Math.floor(Math.random() * 10000000);
        this.send_req( request_url, p.baseline_id, 'refresh', p );
    }
};
// refere_bdateを付加する
function cy_um_rd(link_element, plid)
{
    cy_schedule_um_date_rewritten(link_element, plid, 'referer_bdate');
}
// bdateを更新する
function cy_um_bd(link_element, plid)
{
    cy_schedule_um_date_rewritten(link_element, plid, 'bdate');
}
// 引数部分を書き換える
function cy_schedule_um_date_rewritten(link_element, plid, param_name)
{
    // 日付文字列
    var date_str = '';

    // ポータルとアプリ版で処理を分岐
    if ( plid && document.forms['personal_month' + plid]) {
        // ポータル
        date_str = document.forms['personal_month' + plid].bdate.value;
    } else {
        // アプリ
        // name="bdate" のエレメントを確認する
        var param_elements = document.getElementsByName('bdate');
        for( var i = 0; i < param_elements.length; i++ ) {
            if (param_elements[i].getAttribute('value')) {
                // bdateに値があれば、日付文字列を更新
                date_str = param_elements[i].getAttribute('value');
                break;
            }
        }
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
