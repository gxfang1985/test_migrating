Event.observe(window.document, 'click', function(e){
    var target = e.element();
    if( target == window.document){return;}
    if(!target.id)
    {
        target = target.up();
    }
    if(target == null){return;}

    $$('span.search-schedule-dropdownContents-open').each(function(f){
        var tag_a = f.down();
        
        if(tag_a.id)
        {
            if(tag_a.id != target.id)
            {
                hide_dropdown(f.down());
            }
        }
        else
        {
            hide_dropdown(f.down());
        }
    });
    
    if(target.id && target.id.indexOf('type_search_schedule') >= 0)
    {
        if(target.up().hasClassName('search-schedule-dropdownContents-open'))
        {
            hide_dropdown(target);
        }
        else
        {
            show_dropdown(target);
            show_divtag(target);
            resize_dialog(target);
        }
    }
});

function resize_dialog(target)
{
    var div_tag = target.next();
    if(div_tag.style.width == '')
    {
        var items_a = div_tag.select('a');
        var max = 0;
        var change = true;
        for (var i = 0; i < items_a.length; i++)
        {
            var str = items_a[i].innerHTML;
            if(max < str.length)
            {
                max = str.length;
                if(max > 40)
                {
                    change = false;
                    break;
                }
            }
        }

        if(change)
        {
            var size_width = 0;
            if(target.getWidth() < size_width )
            {
                div_tag.setStyle({width:size_width + "px"});
            }
            else
            {
                div_tag.setStyle({width:target.getWidth() + "px"});
            }
        }
    }
}

Event.observe( window, 'resize', function(e)
{
    setTimeout(changePositionSearchScheduleType,0);
});

function show_dropdown(target)
{
    target.up().addClassName('search-schedule-dropdownContents-open');
    target.down().removeClassName('search-schedule-ButtonTypeArrowDown-grn');
    target.down().addClassName('search-schedule-ButtonTypeArrowUp-grn');
}

function hide_dropdown(target)
{
    target.up().removeClassName('search-schedule-dropdownContents-open');
    target.down().removeClassName('search-schedule-ButtonTypeArrowUp-grn');
    target.down().addClassName('search-schedule-ButtonTypeArrowDown-grn');
}

function show_divtag(target)
{
    var div_tag = target.next();
    var switchOffset = Position.cumulativeOffset(target);

    div_tag.style.left = switchOffset[0] + 1 + "px";
    div_tag.style.top = switchOffset[1] + 22 + "px";
}

function changePositionSearchScheduleType()
{
    $$('span.search-schedule-dropdownContents-open').each(function(f){
        show_divtag(f.down());
    });
}

YAHOO.util.Event.addListener( window, 'load', function()
{
    var buttonElements = YAHOO.util.Dom.getElementsByClassName('moveButtonBaseDisable-grn','span');
    YAHOO.util.Dom.replaceClass(buttonElements,'moveButtonBaseDisable-grn','moveButtonBase-grn');
    
    var moveButtonArrowLeftTwo = YAHOO.util.Dom.getElementsByClassName('moveButtonArrowLeftTwoDisable-grn','span');
    YAHOO.util.Dom.replaceClass(moveButtonArrowLeftTwo,'moveButtonArrowLeftTwoDisable-grn','moveButtonArrowLeftTwo-grn');
    
    var moveButtonArrowLeft = YAHOO.util.Dom.getElementsByClassName('moveButtonArrowLeftDisable-grn','span');
    YAHOO.util.Dom.replaceClass(moveButtonArrowLeft,'moveButtonArrowLeftDisable-grn','moveButtonArrowLeft-grn');
    
    var moveButtonArrowRight = YAHOO.util.Dom.getElementsByClassName('moveButtonArrowRightDisable-grn','span');
    YAHOO.util.Dom.replaceClass(moveButtonArrowRight,'moveButtonArrowRightDisable-grn','moveButtonArrowRight-grn');
    
    var moveButtonArrowRightTwo = YAHOO.util.Dom.getElementsByClassName('moveButtonArrowRightTwoDisable-grn','span');
    YAHOO.util.Dom.replaceClass(moveButtonArrowRightTwo,'moveButtonArrowRightTwoDisable-grn','moveButtonArrowRightTwo-grn');
});

function check_disable(e)
{
    var tag_span = e.parentNode;
    if(tag_span.className.indexOf("Disable") >= 0)
    {
        return false;
    }
    return true;
}

var arrSearch = [];

(function() {
    var Dom = YAHOO.util.Dom,
        Event = YAHOO.util.Event;
        
    var SearchBox = function(id)
    {
        this.textElement_ = document.getElementById("searchbox-schedule-"+id);
        this.submitButton = document.getElementById("searchbox-submit-schedules-" + id);
        this.firstFlag = true;
        this.textField_ = ( this.textElement_ ) ? Dom.getFirstChild(this.textElement_) : null;
        this.defaultText = ( this.textField_ ) ? this.textField_.value : null;
        this.init();
    };

    SearchBox.prototype.clearSearchHint  = function (){
        if ( ! this.firstFlag ) {
            return true;
        }
        this.textField_.value = '';
        Dom.removeClass(this.textField_, 'prefix-grn');
        this.firstFlag = false;
    };

    SearchBox.prototype.init = function(){
        var seft = this;
        if ( this.textField_ ) {
            
            Event.addListener( this.textField_, 'focus', function() {
                seft.clearSearchHint();
            });

            Event.addListener( this.textField_, 'blur', function() {
                if( seft.textField_.value === '' ) {
                    seft.textField_.value = seft.defaultText;
                    Dom.addClass(seft.textField_, 'prefix-grn');
                    seft.firstFlag = true;
                }
            });
        }

        if( this.submitButton ) {
            Event.addListener( this.submitButton , "click", function() {
                seft.clearSearchHint();
                this.form.submit();
            });
        }
    };
    
    //GTM-2140
    grn.base.namespace("grn.component.schedule.search_box");
    grn.component.schedule.search_box = SearchBox;
    
    Event.onDOMReady(function() {
        var arrSearchBox = YAHOO.util.Dom.getElementsByClassName('searchbox-keyword-schedule','div');

        for(i=0; i<arrSearchBox.length;i++)
        {
            var id = arrSearchBox[i].id.split("searchbox-schedule-")[1];
            arrSearch[id] = new SearchBox(id);
        }
    });
})();

(function() {
    var Y = YAHOO.util,
        Dom = YAHOO.util.Dom,
        Event = YAHOO.util.Event;
    var enter = false; //enter
    var opened_dialog_id = ''; // keep the id of dialog which is lastest and is opening.
    GRN_ScheduleSimpleAdd = {
        topTriangle : '<div class="simpleAddTriangle-grn" style="display:none"><span class="simpleAddTriangleTop-grn"></span></div>',
        bottomTriangle : '<div class="simpleAddTriangle-grn" style=""><span class="simpleAddTriangleBottom-grn"></span></div>',
        dummyContent: '<div class="simpleAddBase-grn"><table class="simpleAddTable-grn simpleAddBaseFirst-grn"><tr valign="top" id="schedule_simple_add-header"><td colspan="2" class="header-grn"><div class="date-grn"></div><div class="simpleAddClose-grn" title="閉じめE></div><div class="clear_both_0px"></div></td></tr></table></div>',
        spinner : '<div class="spinnerBoxBase-grn" style="display:none; position:absolute; z-index: 1501"><div class="spinnerBox-grn"></div></div>',
        defaultSettings: null,
        cfg: function( configs ) {
            this.defaultSettings = configs;
        },
        init : function(target)
        {
            if (target.firstInit) {return;}
            Event.removeListener( target, 'dblclick', this.clickHandler );
            Event.addListener(target, 'dblclick', this.clickHandler, this, true);
        },
        dialogInit : function(target, params)
        {
            if (!target) { return; }
            if (target.firstInit) { return; }
            var callback = {
                success: function(o) {
                    if (dlgContent)
                    {
                        dlgContent.innerHTML = o.responseText;
                    }
                    var dd = new YAHOO.util.DD(dialog.id);
                    dd.setHandleElId('schedule_simple_add-header');
                    var dlg = new GRN_ScheduleSimpleAdd.Dialog(target, target.getAttribute('plid'), params);
                    target.dialog = dlg;
                    target.firstInit = true;
                    //GRREQ-492
                    BuilderDropdownColorControl(targetid+'-dialog');
                    //end GRREQ-492
                }
            };
            var url_component = grn.component.url;
            var url_params = {};
            var url = target.getAttribute('rel');

            if(url == null)
            {
                if( params ) {
                    url = params.simpleAddUrl;
                    url_params = {
                        uid: params.uid,
                        gid: params.gid,
                        bdate: target.getAttribute('data-bdate') || params.bdate,
                        referer_key: params.refererKey,
                        members: params.members
                    };
                }
                else
                {
                    url = url_component.page('schedule/simple_add');
                    url_params = {
                        uid: target.getAttribute('data-uid'),
                        gid: target.getAttribute('data-gid'),
                        bdate: target.getAttribute('data-bdate'),
                        referer_key: target.getAttribute('data-referer_key')
                    };
                }
            }
            else
            {
                var url_components = url_component.parse(url);
                url_params = url_component.parseQueryString(url);
                url = url_components.pathname;
            }

            var targetid = Dom.generateId(target, 'sch-simple-add');
            var dialog = Dom.get(targetid+'-dialog');
            /*jshint -W080 */ /* It is not necessary to initialize '{a}' to 'undefined'. */
            var dlgContent = undefined;
            /*jshint +W080 */
            if (!dialog)
            {
                dialog = this.createElement('div', {'id':targetid+'-dialog', 'class':'dialog', 'style':'display:none;z-index:1500;position:absolute'});
                dialog.innerHTML = this.topTriangle + this.dummyContent + this.bottomTriangle + this.spinner;
                document.body.appendChild(dialog);
                dlgContent = Y.Selector.query('#'+dialog.id+' > div.simpleAddBase-grn', null, true);
                if (target.getAttribute('utype') == 'facility')
                {
                    Dom.addClass(dlgContent, 'simpleAddBaseFirstFacility-grn');
                }
                var dd = new YAHOO.util.DD(dialog.id);
                dd.setHandleElId('schedule_simple_add-header');

                var ajaxRequest = new grn.component.ajax.request(
                    {
                        url: url,
                        method: "POST",
                        grnRedirectOnLoginError: true,
                        data: grn.component.url.toQueryString(url_params)
                    }
                );

                ajaxRequest.on("beforeShowError", function()
                {
                    dialog.parentNode.removeChild(dialog);
                });

                ajaxRequest.send().done(function(data, textStatus, jqXHR){
                    callback.success(jqXHR);
                });
            }
        },
        getTarget : function(target)
        {
            if ( !target.tagName || !target.parentNode ) {
                return null;
            }
            var tagName = target.tagName.toLowerCase();
            switch(tagName) {
                case 'table':
                    return null;
                case 'td':
                    return target;
                default:
                    if (target.getAttribute("data-bdate")) {
                        return target;
                    }
            }
            return this.getTarget(target.parentNode);
        },
        lastIntervalID: -1,
        clickHandler : function(ev)
        {
            // close all openned dialog
            Dom.setStyle(Dom.getElementsByClassName('dialog', 'div'), 'display', 'none');
            clearInterval(this.lastIntervalID);

            var target = Event.getTarget(ev);
            if (!target) { return; }
            if (target.tagName)
            {
                var tagName = target.tagName.toLowerCase();
                switch(tagName)
                {
                    case 'a':
                    case 'img':
                        return;
                    case 'div':
                        if (Dom.hasClass(target, 'iconWrite-grn'))
                        {
                            return;
                        }
                        break;
                }
            }
            target = this.getTarget(target);
            if (!target) {
                Event.stopPropagation(ev);
                return;
            }

            // check user have using privilege or not
            var plid_attr = target.getAttribute('plid');
            if(plid_attr > 0)
            {
                if(typeof do_not_have_using_privilege != 'undefined' && typeof do_not_have_using_privilege[plid_attr] != 'undefined' && do_not_have_using_privilege[plid_attr] == 1)
                {
                    return;
                }
            }
            else
            {
                if(typeof do_not_have_using_privilege != 'undefined' && do_not_have_using_privilege == 1)
                {
                    return;
                }
            }

            this.dialogInit(target);
            var position = Event.getXY(ev);
            if (target.dialog)
            {
                target.dialog.showAt(position);
            }
            else
            {
                if( target.clickCount == undefined || !target.clickCount ) {
                    target.clickCount = 1;
                }
                else {
                    target.clickCount = parseInt(target.clickCount) + 1;
                }
                var targetid = Dom.generateId(target, 'sch-simple-add');
                var dialog = Dom.get(targetid+'-dialog');
                if( opened_dialog_id == Dom.getAttribute(dialog, 'id') )
                {
                    return;
                }
                this.showDlgAt(dialog, position);
                opened_dialog_id = Dom.getAttribute(dialog, 'id');
                var spinner = Y.Selector.query('#' + targetid + '-dialog > div.spinnerBoxBase-grn', null, true);
                Dom.setStyle(spinner, 'display', '');
                var region = Dom.getRegion(dialog);
                var x = region.left + region.width / 2 - 32,
                    y = region.top + region.height / 2 - 32;
                Dom.setXY(spinner, [x, y]);
                var t = setInterval(function(){
                    if (target.dialog)
                    {
                        if(target.clickCount == 1){ opened_dialog_id = ''; }
                        target.dialog.showAt(position);
                        clearInterval(t);
                    }
                }, 1);
                this.lastIntervalID = t;
            }
            enter = true; //enter
            Event.stopPropagation(ev);
        },
        doubleClickPersonalHandler : function(ev)
        {
            // close all openned dialog
            Dom.setStyle(Dom.getElementsByClassName('dialog', 'div'), 'display', 'none');
            clearInterval(this.lastIntervalID);

            var target = Event.getTarget(ev);
            target = this.getTarget( target );
            if (!target) { return; }

            var params = this.defaultSettings;
            this.dialogInit(target, params);
            var position = Event.getXY(ev);
            if (target.dialog)
            {
                target.dialog.showAt(position);
            }
            else
            {
                if( target.clickCount == undefined || !target.clickCount ) {
                    target.clickCount = 1;
                }
                else {
                    target.clickCount = parseInt(target.clickCount) + 1;
                }
                var targetid = Dom.generateId(target, 'sch-simple-add');
                var dialog = Dom.get(targetid+'-dialog');
                if( opened_dialog_id == Dom.getAttribute(dialog, 'id') )
                {
                    return;
                }
                this.showDlgAt(dialog, position);
                opened_dialog_id = Dom.getAttribute(dialog, 'id');
                var spinner = Y.Selector.query('#' + targetid + '-dialog > div.spinnerBoxBase-grn', null, true);
                Dom.setStyle(spinner, 'display', '');
                var region = Dom.getRegion(dialog);
                var x = region.left + region.width / 2 - 32,
                    y = region.top + region.height / 2 - 32;
                Dom.setXY(spinner, [x, y]);
                var t = setInterval(function(){
                    if (target.dialog)
                    {
                        if(target.clickCount == 1){ opened_dialog_id = ''; }
                        target.dialog.showAt(position);
                        clearInterval(t);
                    }
                }, 1);
                this.lastIntervalID = t;
            }
            enter = true; //enter
            Event.stopPropagation(ev);
        },
        enableDragAdd: function()
        {
            var self = this;
            this._allowDrag = function( $ ) {
                var $view = $("#personal_calendar_list");
                var container = $view.find(".personal_week_calendar_date");
                if (container.length === 0) {
                    container = $view.find(".personal_day_calendar_date");
                }
                container.find("div.personal_day_calendar_time_row_alt").each( function() {
                    var jObject = $(this);
                    var jObjectParent = jObject.parent();
                    jObject.clone().attr("data-minute", 30).addClass("duplicate").appendTo(jObjectParent);
                });

                var _dragging = function( event, ui ) {
                    if( ui.selecting ) {
                        $(ui.selecting).addClass("drag_add_grn");
                    }
                    else if( ui.unselecting ) {
                        $(ui.unselecting).removeClass("drag_add_grn");
                    }
                    else if( ui.selected ) {
                        $(ui.selected).addClass("drag_add_grn").removeClass("ui-selected");
                    }
                };

                var options = {
                    filter: "div.add_quick div.personal_day_calendar_time_row_alt",
                    distance: 5,
                    appendTo: "#personal_calendar_list",
                    start: function( event, ui ) {
                        container.find("div.drag_add_grn").removeClass("drag_add_grn");
                        $("div.dialog").css("display", "none");
                        opened_dialog_id = "";
                    },
                    stop: function( event, ui ) {
                        var ev = event.originalEvent || event;
                        var selectedEle = container.find("div.drag_add_grn:first");
                        if( selectedEle.length > 0 && $(selectedEle).parent().data("bdate") ) {
                            self.defaultSettings.bdate = $(selectedEle).parent().data("bdate");
                        }
                        var toElement = ev.target ? ev.target : ev.toElement;
                        if( $.contains( this, toElement ) === false ) {
                            container.find("div.drag_add_grn").removeClass("drag_add_grn");
                            return false;
                        }
                        self.doubleClickPersonalHandler( ev );
                    },
                    selecting: function( event, ui ){
                        _dragging( event, ui );
                    },
                    unselecting: function( event, ui ) {
                        _dragging( event, ui );
                    },
                    selected: function( event, ui ) {
                        _dragging( event, ui );
                    }
                };
                container.selectable( options );
            };

            this._allowDrag( jQuery );
        },
        mouseOverHandler : function(e, obj)
        {
            if( obj.className === 'personal_week_calendar_data_cell' || //week view & week portlet
                obj.className === 'personal_day_calendar_data_cell' || //day view
                obj.className === 'v_day_border02' ) // day portlet
            {
                Dom.addClass(obj, 'calendarHover-grn');
            }
            GRN_ScheduleSimpleAdd.init(obj);
        },
        mouseOutHandler : function(e, obj)
        {
            if( obj.className === 'personal_week_calendar_data_cell calendarHover-grn' || //week view & week portlet
                obj.className === 'personal_day_calendar_data_cell calendarHover-grn' || //day view
                obj.className === 'v_day_border02 calendarHover-grn' ) // day portlet
            {
                Dom.removeClass(obj, 'calendarHover-grn');
            }
        },
        showErrMsg : function(o, callback)
        {
            var s = o.responseText;
            if (s.isJSON())
            {
                if (typeof callback == 'function')
                {
                    callback();
                }
                grn.component.error_handler.show(o);
            }
            else
            {
                document.write(s);
                if(YAHOO.env.ua.ie > 7)
                {
                    document.write("<script type='text/javascript'>setTimeout(function(){document.close();},0);<\/script>");
                }
                else
                {
                    document.close();
                }
            }
        },
        createElement : function(tag, configs)
        {
            var el = document.createElement(tag);
            for(var cfg in configs)
            {
                Dom.setAttribute(el, cfg, configs[cfg]);
            }
            return el;
        },
        showDlgAt : function(dialog, position)
        {
            Dom.setStyle(dialog, 'display', '');
            var left = position[0] - dialog.offsetWidth/2,
                top = position[1] + 20;
            var viewportW = Dom.getViewportWidth() + Dom.getDocumentScrollLeft(),
                viewportH = Dom.getViewportHeight() + Dom.getDocumentScrollTop();
            var triangleClass = 'simpleAddTriangleTop-grn';
            var triangleL = dialog.offsetWidth/2;
            if (left + dialog.offsetWidth >= viewportW) {
                left = viewportW - dialog.offsetWidth - 2;
            }
            if (left < 0){
                left = 0;
            }
            var buffer = 37;    // GRN2-7153
            if ((top + dialog.offsetHeight > viewportH) && ((top - dialog.offsetHeight - buffer) > Dom.getDocumentScrollTop()))
            {
                top = top - dialog.offsetHeight - buffer;
                triangleClass = 'simpleAddTriangleBottom-grn';
            }
            else
            {
                top += 2;   // GRN2-7153
            }
            triangleL = position[0] - left;
            Dom.setXY(dialog, [left, top]);
            var triangles = Y.Selector.query('#'+dialog.id+' div.simpleAddTriangle-grn');
            Dom.setStyle(triangles, 'display', 'none');
            var triangle = Y.Selector.query('#'+dialog.id+' span.'+triangleClass, null, true);
            Dom.setStyle(triangle.parentNode, 'display', '');
            Dom.setStyle(triangle, 'left', triangleL + 'px');

            function _focus() {
                var focus2Ctrl = Y.Selector.query('#'+dialog.id + ' input[type=text]', null, true);
                if (focus2Ctrl)
                {
                    focus2Ctrl.focus();
                    return true;
                }
                return false;
            }

            // focus
            if( !_focus() )
            {
                setTimeout( _focus, 1000 );
            }
        }
    };
    
    GRN_ScheduleSimpleAdd.Dialog = function(target, plid, params)
    {
        this.dialogid = target.id + '-dialog';
        this.dialogid_selector = '#' + this.dialogid;
        this.plid = plid;
        this.spinner = Y.Selector.query(this.dialogid_selector + ' > div.spinnerBoxBase-grn', null, true);
        this.errorMsgElements = Y.Selector.query(this.dialogid_selector+' div.simpleAddEventAttentionMessage-grn *');
        this.usingPurposeError = Y.Selector.query(this.dialogid_selector+' div#using_purpose_error');
        this._parent = target;
        this.params = params;
        this.dialog = null;
        this.getDialog = function() {
            if (this.dialog == null) {
                this.dialog = Dom.get(this.dialogid);
            }
            return this.dialog;
        };
        var scheduleSimpleAddObject = this;
        this.close = function(e, dialog) {
            if (dialog == null) { dialog = this.getDialog(); }
            dialog.style.display = 'none';
            Dom.setStyle(this.spinner, 'display', 'none');
            jQuery.resetDropdwonColorControl();
            scheduleSimpleAddObject.clearSelected();
        };

        this.clearSelected = function() {
            Dom.getElementsByClassName( "drag_add_grn", "div", "personal_calendar_list", function() {
                Dom.removeClass( this, "drag_add_grn" );
            } );
        };
        
        this.validateForm = function(form)
        {
            if (!form) { form = Y.Selector.query(self.dialogid_selector+' form', null, true); }
            
            // validator
            var start_hour = form['start_hour'].value,
                start_minute =  form['start_minute'].value,
                end_hour = form['end_hour'].value,
                end_minute = form['end_minute'].value;
            Dom.setStyle(this.errorMsgElements, 'display', 'none');
            if (start_hour == '' && end_hour != '') {
                Dom.setStyle(this.errorMsgElements[0], 'display', '');
                return false;
            }
            if (start_hour !== '' && end_hour !== '') {
                if (start_minute === '') {
                    start_minute = 0;
                }
                if (end_minute === '') {
                    end_minute = 0;
                }
                if (start_hour * 60 + start_minute * 1 > end_hour * 60 + end_minute * 1) {
                    Dom.setStyle(this.errorMsgElements[1], 'display', '');
                    return false;
                }
            }
            enter = true; //enter
            return true;
        };
        //GTM-105(set end_time = start_time + 1 )
        this.setEndTime = function(form)
        {
            if (!form) { form = Y.Selector.query(self.dialogid_selector+' form', null, true); }
            
            var start_hour = form['start_hour'].value,
                start_minute =  form['start_minute'].value,
                end_hour = form['end_hour'].value,
                end_minute = form['end_minute'].value;
            var bar_login = Y.Selector.query("table#event_list" + (this._parent ? this._parent.getAttribute('plid') : '') + " tr.bar_login_timezone", null, true);
            var hour = this._parent.getAttribute('data-hour');
            
            if (start_hour != '' && start_minute == '' && end_hour == '' && end_minute == ''
                && bar_login == null && hour == null )
            {
                if (start_hour == '23') {
                    form['end_hour'].value = parseInt(start_hour);
                }
                else {
                    form['end_hour'].value = parseInt(start_hour) + 1;
                }
                form['start_minute'].value = 0;
                form['end_minute'].value = 0;
            }
        };
        
        this.setTime = function(time)
        {
            var form = Y.Selector.query(this.dialogid_selector + ' form', null, true);
            if (!form) { return; }
            if (!time || !parseInt(time)) { return; }
            if (form['start_hour'].value != time)
            {
                // group_day(view or portlet)
                // if user click on a different time, assign opened_dialog_id to value of empty
                // so that the dialog will be opened.
                opened_dialog_id = '';
            }
            form['start_hour'].value = time;
            form['start_minute'].value = 0;
            form['end_hour'].value = parseInt(time) + 1;
            form['end_minute'].value = 0;
        };
        
        this.setTimePersonal = function(hour,minute)
        {
            var form = Y.Selector.query(this.dialogid_selector + ' form', null, true);
            if (!form) { return; }
            /*jshint -W019 */ /* Use the isNaN function to compare with NaN. */
            if (parseInt(hour) == NaN || parseInt(minute) == NaN) { return; }
            /*jshint +W019 */
            form['start_hour'].value = hour;
            form['start_minute'].value = minute;
            if(parseInt(hour) >= 23)
            {
                form['end_hour'].value = 23;
                form['end_minute'].value = 30;
            }
            else
            {
                form['end_hour'].value = parseInt(hour) + 1;
                form['end_minute'].value = minute;
            }
        };

        this.setCustomTime = function( start, end )
        {
            var form = Y.Selector.query(this.dialogid_selector + ' form', null, true);
            if (!form) { return; }
            // set hour
            form['start_hour'].value = start.hour;
            if( start.hour === end.hour )
            {
                if( start.minute === 30 )
                {
                    end.hour += 1;
                    end.minute = 0;
                }
                else if( start.minute === end.minute ) {
                    end.minute = 30;
                }
                else
                {
                    end.hour += 1;
                    end.minute = 0;
                }
            }
            else
            {
                if( end.minute === 0 )
                {
                    end.minute = 30;
                }
                else
                {
                    end.hour += 1;
                    end.minute = 0;
                }
            }
            if( end.hour >= 24 )
            {
                end.hour = 0;
                end.minute = 0;
            }
            form['end_hour'].value = end.hour;

            // set minute
            form['start_minute'].value = start.minute;
            form['end_minute'].value = end.minute;
        };
        
        this.removePopupTitle = function()
        {
            var popup_title = Y.Selector.query('.showEventTitle');
            for(var i = 0; i < popup_title.length; i++)
            {
                el = popup_title[i];
                el.remove();
            }
        };
        
        this.resetDialog = function()
        {
            var form = Y.Selector.query(this.dialogid_selector + ' form', null, true);
            if (!form) { return; }
            form['start_hour'].selectedIndex = 0;
            form['start_minute'].selectedIndex = 0;
            form['end_hour'].selectedIndex = 0;
            form['end_minute'].selectedIndex = 0;
            form['menu'].selectedIndex = 0;
            form['title'].value = "";
            form['memo'].value = "";
            if(typeof form['using_purpose'] != 'undefined')
            {
                form['using_purpose'].value = "";
            }

            var usingPurposeError = Y.Selector.query(this.dialogid_selector + ' div#using_purpose_error');
            Dom.setStyle(usingPurposeError, 'display', 'none');

            if( jQuery(form).find("input[name='private']:checked").val() == 2)
            {
                jQuery(form).find(".simpleAddEventPrivateSet-grn").show();
            }

            jQuery(form).find("input[name='private']").change(function() {
                if( jQuery(this).val() == 2)
                {
                    jQuery(form).find(".simpleAddEventPrivateSet-grn").show();
                }
                else
                {
                    jQuery(form).find(".simpleAddEventPrivateSet-grn").hide();
                }
            });
        };

        // GTM-1676
        this.validateUsingPurpose = function(form)
        {
            if( form['using_purpose'] != undefined )
            {
                Dom.setStyle( scheduleSimpleAddObject.usingPurposeError, 'display', 'none');
                if( ! YAHOO.lang.trim( form['using_purpose'].value ) )
                {
                    Dom.setStyle( scheduleSimpleAddObject.usingPurposeError , 'display', '');
                    return false;
                }
            }
            enter = true; //enter
            return true;
        };
        // end GTM-1676

        // Dialog settup
        var radios = Y.Selector.query(this.dialogid_selector+' input[type=radio]');
        for(var i = 0; i < radios.length; i++)
        {
            var temp_id = Math.floor(Math.random() * 10000);
            var nextSib = Dom.getNextSibling(radios[i]);
            if (nextSib)
            {
                radios[i].id = temp_id;
                Dom.setAttribute(nextSib, 'for', temp_id);
            }
        }
        
        Event.addListener(Y.Selector.query(this.dialogid_selector+' div.simpleAddClose-grn', null, true), 'click', this.close, this.getDialog());

        Event.addListener(Y.Selector.query(this.dialogid_selector+' select[id]'), 'change', function(e, obj) {
            obj.validateForm(this.form);
        }, this);
        //GTM-105
        Event.addListener(Y.Selector.query(this.dialogid_selector+' select[name="start_hour"]'), 'change', function(e, obj) {
            obj.setEndTime(this.form);
        }, this);
        this.btn = Y.Selector.query(this.dialogid_selector+' div.buttonPostMain-grn a', null, true);
        var self = this;
        this.tranport = false;
        var buttonClick = function(e)
        {
            //check enter variable
            if (!enter) { return; }
            self.removePopupTitle();
            var theForm = Y.Selector.query(self.dialogid_selector+' form', null, true);
            // validator
            validatorTime = self.validateForm(theForm);
            if (validatorTime && theForm['sITEM[]'])
            {
                Dom.setStyle(self.errorMsgElements, 'display', 'none');
                if (theForm['start_hour'].value === '' || theForm['end_hour'].value === '')
                {
                    Dom.setStyle(self.errorMsgElements[2], 'display', '');
                    validatorTime = false;
                }
            }

            validatorUsingPurpose = self.validateUsingPurpose(theForm);
            if( !validatorTime || !validatorUsingPurpose )
            {
                return;
            }

            if (!self.tranport){
                var region = Dom.getRegion(self.dialog);
                var x = region.left + region.width/2 - 32,
                    y = region.top + region.height/2 - 32;
                Dom.setStyle(self.spinner, 'display', '');
                Dom.setXY(self.spinner, [x, y]);

                this.tranport = true;

                var ajaxRequest = new grn.component.ajax.request(
                {
                    url: theForm.action,
                    method: "post",
                    data: jQuery(theForm).serialize()
                });

                ajaxRequest.on("beforeShowError",function()
                {
                    self.close(null, self.dialog);
                });

                ajaxRequest.send().done(function(data, textStatus, jqXHR)
                {
                    if (typeof syncEventList == "function")
                    {
                        var json = YAHOO.lang.JSON.parse(jqXHR.responseText);
                        syncEventList(self.plid, json.event_id);
                        setTimeout(function() {
                            self.close(null, self.dialog);
                        }, 500);
                    }
                    else if (params && typeof params.onAddSuccess == "function") {
                        self.close(null, self.dialog);
                        var json = YAHOO.lang.JSON.parse(jqXHR.responseText);
                        params.onAddSuccess(json.event_id);
                    }
                    else
                    {
                        setTimeout(function() { location.href = location.href; }, 1000);
                    }
                }).always(function()
                {
                    self.tranport = false;
                });
            }
            enter = false;
        };
        Event.addListener(this.btn, 'click', buttonClick);
        
        this.link = Y.Selector.query(this.dialogid_selector+' a.icon-advance-grn', null, true);
        Event.addListener(this.link, 'click', function(e)
        {
            // stop default action of the anchor
            Event.stopEvent(e);
            
            //check enter variable
            if (!enter) { return; }
            enter = false;
            
            var f = Y.Selector.query(self.dialogid_selector+' form', null, true);
            f.target = '_self';
            f.action = this.href;
            f.appendChild(new Element('input',{type:'hidden', name:'tab', value:'add'}));
            f.appendChild(new Element('input',{type:'hidden', name:'referer_key', value:this.getAttribute('referer')}));
            f.submit();
        });
        Event.on(this.dialog, 'keydown', function(e) {
            var keyCode = GRN_Event.keyCode(e);
            switch(keyCode)
            {
                case 27:
                    this.close();
                    jQuery.resetDropdwonColorControl();
                    break;
                case 13:
                    var et = Event.getTarget(e);
                    if (!et || !et.type) { break; }
                    if (et.tagName.toLowerCase() == 'input' && et.type == 'radio' ) //prevent default event of radio
                    {
                        Event.preventDefault(e);
                        buttonClick();
                        break;
                    }
                    if (et.tagName.toLowerCase() != 'textarea' && et != this.link)
                    {
                        Event.preventDefault(e);
                        buttonClick();
                    }
                    break;
                default:
                    return;
            }
        }, this, true);
        
        //close dialog when press ESC
        Event.on(document, 'keydown', function(e){
            var keyCode = GRN_Event.keyCode(e);
            if(keyCode == 27){
                Dom.setStyle(Y.Selector.query('div.dialog'), 'display', 'none');
                jQuery.resetDropdwonColorControl();

                self.clearSelected();
            }
            // when esc all dialog will be closed,
            // assig opened_dialog_id to value of empty
            opened_dialog_id = '';
        });
        
        Event.on(this.dialog, 'click', function(e)
        {
            Event.stopPropagation(e);
        });
    };
    
    GRN_ScheduleSimpleAdd.Dialog.prototype.showAt = function(position)
    {
        this.removePopupTitle();
        this.resetDialog();
        var dialog = this.getDialog();
        if(!dialog){
            return;
        }

        Dom.removeClass(Y.Selector.query('#' + dialog.id + ' div.simpleAddBaseFirstFacility-grn', null, true), 'simpleAddBaseFirstFacility-grn');
        var bar_login = Y.Selector.query("table#event_list" + (this._parent ? this._parent.getAttribute('plid') : '') + " tr.bar_login_timezone", null, true);
        if (bar_login)
        {
            var bar_login_children = bar_login.children;
            var whereX = 0, positionXs = [];
            var clickX = position[0];
            
            if (bar_login.style.display == 'none')
            {
                Dom.setStyle(bar_login, 'display', '');
                positionXs = Dom.getX(bar_login_children);
                Dom.setStyle(bar_login, 'display', 'none');
            }
            else
            {
                positionXs = Dom.getX(bar_login_children);
            }
            
            for(var i = 0; i < positionXs.length; i++)
            {
                if (clickX > positionXs[i]) { continue; }
                whereX = i;
                break;
            }
            whereX = whereX == 0 ? positionXs.length : whereX;
            this.setTime(bar_login_children[whereX - 1].innerHTML);
        }
        var personalCalendar = jQuery("#personal_calendar_list td.personal_week_calendar_date");
        if (personalCalendar.length === 0) {
            personalCalendar = jQuery("#personal_calendar_list td.personal_day_calendar_date");
        }
        var start = personalCalendar.find("div.drag_add_grn:first"),
            end = personalCalendar.find("div.drag_add_grn:last");
        if( start.length != 0 )
        {
            var startTime = {
                hour: parseInt( start.data("hour") ),
                minute: parseInt( start.data("minute") )
            };
            var endTime = {
                hour: parseInt( end.data("hour") ),
                minute: parseInt( end.data("minute") )
            };
            this.setCustomTime( startTime, endTime );
        }
        else
        {
            var hour = this._parent.getAttribute('data-hour');
            if (hour) {
                var minute = this._parent.getAttribute('data-minute');
                this.setTimePersonal(hour,minute);
            }
        }
        // hide spinner
        Dom.setStyle(this.spinner, 'display', 'none');
        if (opened_dialog_id == this.dialogid)
        {
            opened_dialog_id = '';
            return;
        }
        GRN_ScheduleSimpleAdd.showDlgAt(dialog, position);
        opened_dialog_id = this.dialogid;
    };
    
    GRN_ScheduleSimpleAdd.Dialog.Highlight = function()
    {
        function ColorToHex( color )
        {
            if(color.indexOf('rgba') >= 0)
            {
                var m = /rgba?\((\d+), (\d+), (\d+)/.exec( color );
                return m ? '#' + ( m[1] << 16 | m[2] << 8 | m[3] ).toString(16) : color;
            }
            else
            {
                if (color.substr(0, 1) === '#') {
                    return color;
                }
                
                var digits = /(.*?)rgb\((\d+), (\d+), (\d+)\)/.exec(color);

                var red = parseInt(digits[2]);
                var green = parseInt(digits[3]);
                var blue = parseInt(digits[4]);
                
                var rgb = blue | (green << 8) | (red << 16);
                return digits[1] + '#' + rgb.toString(16);
            }
        }
        
        var Y = YAHOO.util,
              Dom = Y.Dom;
        var highlightEls = Y.Selector.query('.newevent-grn');
        Dom.removeClass(highlightEls, 'newevent-grn');
        // Get highlight color
        var tempEl = GRN_ScheduleSimpleAdd.createElement('div', { 'class' : 'addHighlight-grn', 'style' : 'display:none' });
        document.body.appendChild(tempEl);
        var highlightColor = Dom.getStyle(tempEl, 'backgroundColor');
        highlightColor = ColorToHex(highlightColor);

        document.body.removeChild(tempEl);
        // setup color animate
        var anims = [];
        var transparentPattern = /^transparent|rgba\(0, 0, 0, 0\)$/;
        for(var i = 0; i < highlightEls.length; i++)
        {
            var oldBgColor = Dom.getStyle(highlightEls[i], 'backgroundColor');
            var parent = null;
            var bgColor = oldBgColor;
            if (transparentPattern.test(oldBgColor))
            {
                parent = Dom.getAncestorBy(highlightEls[i], function(node) {
                    bgColor = Dom.getStyle(node, 'backgroundColor');
                    return !transparentPattern.test(bgColor);
                });
                if (!parent)
                {
                    bgColor = '#fff';
                }
            }
            bgColor = ColorToHex(bgColor);

            Dom.addClass(highlightEls[i], 'rounded');
            var anim = new Y.ColorAnim(highlightEls[i], { backgroundColor: { from: bgColor, to: highlightColor } }, 0.5, Y.Easing.easeNone);
            anim.onComplete.subscribe(function(){
                var el = this.getEl();
                setTimeout(function(){
                    var fadeOut = new Y.ColorAnim(el, { backgroundColor: { from: highlightColor, to: bgColor } }, 0.5, Y.Easing.easeNone);
                    fadeOut.onComplete.subscribe(function(){
                        if (transparentPattern.test(oldBgColor))
                        {
                            Dom.setStyle(el, 'backgroundColor', oldBgColor);
                        }
                        Dom.removeClass(el, 'rounded');
                    });
                    fadeOut.animate();
                }, 1000);
            });
            anims.push(anim);
        }
        // run animate
        for(var i = 0; i < anims.length; i++)
        {
            anims[i].animate();
        }
    };
    
    GRN_ScheduleTooltipDialog = {
        topTriangle : '<div class="simpleAddTriangle-grn" style="display:none"><span class="simpleAddTriangleTop-grn"></span></div>',
        bottomTriangle : '<div class="simpleAddTriangle-grn" style=""><span class="simpleAddTriangleBottom-grn"></span></div>',
        dummyContent: '<div class="simpleAddBase-grn"><table class="simpleAddTable-grn simpleAddBaseFirst-grn"><tr valign="top" id="schedule_simple_add-header"><td colspan="2" class="header-grn"><div class="date-grn"></div><div class="simpleAddClose-grn" title="閉じめE></div><div class="clear_both_0px"></div></td></tr></table></div>',
        dialogInit : function(target,position)
        {
            if (!target) { return; }

            var targetid = Dom.generateId(target, 'sch-simple-add');
            var dialog = Dom.get(targetid+'-dialog');
            /*jshint -W080 */ /* It is not necessary to initialize '{a}' to 'undefined'. */
            var dlgContent = undefined;
            /*jshint +W080 */
            if (!dialog)
            {
                dialog = GRN_ScheduleSimpleAdd.createElement('div', {'id':targetid+'-dialog', 'class':'tooltip_dialog', 'style':'display:none;z-index:1500;position:absolute'});
                dialog.innerHTML = this.topTriangle + this.dummyContent + this.bottomTriangle;
                document.body.appendChild(dialog);
                dlgContent = Y.Selector.query('#'+dialog.id+' > div.simpleAddBase-grn', null, true);
                var dd = new YAHOO.util.DD(dialog.id);
                dd.setHandleElId('schedule_simple_add-header');
                GRN_ScheduleSimpleAdd.showDlgAt(dialog, position);
            }
        },
        clickHandler : function(ev)
        {
            // close all openned tooltip dialog
            tooltip_dialog = Dom.getElementsByClassName('tooltip_dialog', 'div');
            for(var i = 0; i < tooltip_dialog.length; i++)
            {
                el = tooltip_dialog[i];
                el.remove();
            }
            var target = Event.getTarget(ev);
            if (!target) { return; }
            if (target.tagName)
            {
                var tagName = target.tagName.toLowerCase();
                switch(tagName)
                {
                    case 'div':
                        if (Dom.hasClass(target, 'ui-resizable-handle'))
                        {
                            return;
                        }
                        break;
                }
            }
            target = this.getTarget(target); // get div.critical3
            if (!target) {
                Event.stopPropagation(ev);
                return;
            }
            var position = Event.getXY(ev);
            this.dialogInit(target,position);
            Event.stopPropagation(ev);
        },
        getTarget : function(target)
        {
            if (!target.tagName || !target.parentNode) { return null; }
            if (target.tagName.toLowerCase() == 'table') { return null; }
            if (target.tagName.toLowerCase() == 'div' && target.className.indexOf('critical3') >= 0) {
                return target;
            }
            return this.getTarget(target.parentNode);
        }
    };
    
    Event.on(document, 'keydown', function(e){
    if (typeof Y.Selector === 'undefined')
    {
        return;
    }
    var keyCode = GRN_Event.keyCode(e);
    if(keyCode == 27){
        Dom.setStyle(Y.Selector.query('div.dialog'), 'display', 'none');
        jQuery.resetDropdwonColorControl();
        var tooltip_dialog = Dom.getElementsByClassName('tooltip_dialog', 'div');
        for(var i = 0; i < tooltip_dialog.length; i++)
        {
            el = tooltip_dialog[i];
            el.remove();
        }
    }
    // when esc all dialog will be closed,
    // assig opened_dialog_id to value of empty
    opened_dialog_id = '';
});
    
    Event.onDOMReady(function() {
        var els = Y.Selector.query('td[rel]');
        Event.addListener(els, 'mouseover', function(e)
        {
            GRN_ScheduleSimpleAdd.mouseOverHandler(e,this);
        });
        Event.addListener(els, 'mouseout', function(e)
        {
            GRN_ScheduleSimpleAdd.mouseOutHandler(e,this);
        });

        Event.addListener(window.document, 'click', function(e) {
            // close all opened dialog only if left click is clicked
            if (e.button !== 0) {
                return;
            }

            var eTarget = Event.getTarget( e );
            if( !( eTarget && (Dom.hasClass(eTarget.parentNode, "ui-selectable") || ( eTarget.parentNode && Dom.hasClass(eTarget.parentNode.parentNode, "ui-selectable") ) ) ) )
            {
                Dom.setStyle(Y.Selector.query('div.dialog'), 'display', 'none');
                jQuery.resetDropdwonColorControl();
                opened_dialog_id = '';
                // remove selected elements
                Dom.getElementsByClassName("drag_add_grn", "div", "personal_calendar_list", function() {
                    Dom.removeClass( this, "drag_add_grn" );
                });
            }
            
            var tooltip = Y.Selector.query('div.tooltip_dialog');
            for(var i=0; i< tooltip.length;i++)
            {
                var el = tooltip[i];
                el.remove();
            }
        });
        
        // setTimeout(function(){
            // var schedule_els = Y.Selector.query('div.critical3');
            // Event.addListener(schedule_els, 'click', function(e)
            // {
                //GRN_ScheduleTooltipDialog.clickHandler(e);
            // });
        // },0);
    });
})();

// This AjaxObject is current use only for simple add function
var AjaxObject = {
    processResult : function(o)
    {
        if (typeof processResult == "function")
        {
            processResult(o);
        }
    },
    sendRequest : function(method, url, processResult)
    {
        var self = this;
        self.processResult = processResult;

        var ajaxRequest = new grn.component.ajax.request(
            {
                url: url,
                method: method
            }
        );

        ajaxRequest.send().done(function(data, textStatus, jqXHR )
        {
            self.processResult(jqXHR);
            GRN_ScheduleSimpleAdd.Dialog.Highlight();
        });
    }
};

//GTM-103
//Only use simple add logic
        // Function check japanese character
        function isKanji(str) {
            var strpattern = /[\u3400-\u4DB5\u4E00-\u9FCB\uF900-\uFA6A\u2E80-\u2FD5]/;
            var pattern = new RegExp(strpattern);
            return pattern.test(str);
        }
        function isHiragana(str) {
            var strpattern = /[\u3041-\u3096]/;
            var pattern = new RegExp(strpattern);
            return pattern.test(str);
        }
        function isKatakana(str) {
            var strpattern = /[\u30A0-\u30FF]/;
            var pattern = new RegExp(strpattern);
            return pattern.test(str);
        }
        function isJapanese(str) {
            return isKanji(str) || isHiragana(str) || isKatakana(str);
        }
        function isLatin(str) {
            var rlatins = /[^\u0000-\u007f]/;
            return !rlatins.test(str);
        }
jQuery.extend({
    resetDropdwonColorControl : function () {
            var ul = jQuery("dl.pulldownbutton_standard_grn dd ul.dropdownContents_grn");
            var elespan = jQuery("dl.pulldownbutton_standard_grn dt a").find("span");
            if(elespan != null && elespan.length > 0){
            jQuery(elespan[0]).removeAttr('class');
            jQuery(elespan[1]).text(ul.children(":first").attr('te'));
            jQuery(elespan[2]).removeClass("pulldownbutton_arrow_up_grn").addClass("pulldownbutton_arrow_down_grn");
            ul.css('display', 'none');
        }
    }
});

jQuery(document).ready(function(){
    BuilderDropdownColorControl();
});
//End GTM-103
/* GTM-101 */
/* Drag drop schedule */
function dd_remove(plid)
{
    if((typeof browser_type == "undefined") || (browser_type == 'msie') || true){return;}
    if(isTouchDevice()){return;}
    showing = 0;
    jQuery("#overlay").remove();
    jQuery("#ddpopup").remove();
    var _portal_frame;
    if(typeof plid != "undefined" && plid != "")
    {
        _portal_frame = jQuery("#portal_frame"+plid);
    }
    else
    {
        _portal_frame = jQuery("#mainareaSchedule-grn");
    }
    _portal_frame.find("div.dddummy").remove();
    _portal_frame.find("div.dddummy_move").remove();
    _portal_frame.find("td.ddtd").removeClass("ddtd_hide");
    var ddtd_remove = _portal_frame.find("td.ddtd_remove");
    if(ddtd_remove.hasClass("group_day_calendar_color_conflicted_line"))
    {
        ddtd_remove.addClass("group_day_calendar_item_conflicted").removeClass("group_day_calendar_color_conflicted_line");
    }
    else
    {
        ddtd_remove.addClass("ddtd_middle group_day_calendar_item");
    }
    ddtd_remove.addClass("ddtd group_day_calendar_color_booked");
    ddtd_remove.find("div.normalEventElement").css("visibility","visible");
    if(ddtd_remove.prev().hasClass("group_day_calendar_event_cell"))
    {
        ddtd_remove.removeClass("ddtd_prev_event_cell");
    }
    else
    {
        ddtd_remove.removeClass("ddtd_prev_item");
    }
    if(ddtd_remove.next().hasClass("group_day_calendar_color_conflicted_line") || ddtd_remove.next().hasClass("group_day_calendar_color_available"))
    {
        ddtd_remove.next().removeClass("ddtd_next");
    }
    ddtd_remove.removeClass("ddtd_remove");
}
function dd_remove_before_sync(plid)
{
    if((typeof browser_type == "undefined") || (browser_type == 'msie') || true){return;}
    if(isTouchDevice()){return;}
    showing = 0;
    jQuery("#overlay").remove();
    jQuery("#ddpopup").remove();
    var _portal_frame;
    if(typeof plid != "undefined" && plid != "")
    {
        _portal_frame = jQuery("#portal_frame"+plid);
    }
    else
    {
        _portal_frame = jQuery("#mainareaSchedule-grn");
    }
    _portal_frame.find("div.dddummy").remove();
    _portal_frame.find("div.dddummy_move").remove();
    _portal_frame.find("td.ddtd").removeClass("ddtd_hide");
}
function dd_zoom_display(plid)
{
    if((typeof browser_type == "undefined") || (browser_type == 'msie') || true){return;}
    if(isTouchDevice()){return;}
    var is_portlet;
    var _portal_frame ;
    if(typeof plid != "undefined" && plid != ""){
        _portal_frame = jQuery("#portal_frame"+plid);
        is_portlet = 1;
    }
    else{
        _portal_frame = jQuery("#mainareaSchedule-grn");
        is_portlet = 0;
    }
    var x_array = [];
    var x_array_count = 0;
    var tds;
    if(_portal_frame.has("#show_users_timezone"+plid+":checked").length || _portal_frame.has("#show_users_timezonegroup_day:checked").length)
    {
        tds = _portal_frame.find("tr.bar_user_timezone").eq(1).children("td");
        for (var i = 2; i< tds.length; i++) {
            x_array[x_array_count++] = jQuery(tds[i]).position().left;
        }
        x_array[x_array_count++] = x_array[x_array_count - 2] + tds.last().width();
    }
    else
    {
        tds = _portal_frame.find("tr.bar_login_timezone").eq(1).children("td");
        for (var i = 2; i< tds.length; i++) {
            x_array[x_array_count++] = jQuery(tds[i]).position().left;
        }
        x_array[x_array_count++] = x_array[x_array_count - 2] + tds.last().width();
    }
    var y_array = [];
    var y_array_height = [];
    var y_array_count = 0;
    var trs = _portal_frame.find("table.day_table tbody tr");
    var tr;
    var day_table = _portal_frame.find("table.day_table");
    var offset_top = day_table.eq(0)[0].offsetTop;
    if((typeof browser_type != "undefined") && (browser_type == 'msie') && (browser_ver_major == 9))
    {
        for(var i=0;i<trs.length;i++){
            tr = trs.eq(i)[0];
            y_array[i] = tr.offsetTop + offset_top;
            y_array_height[i] = tr.offsetHeight;
        }
    }
    else
    {
        for(var i=0;i<trs.length;i++){
            tr = trs.eq(i)[0];
            y_array[i] = tr.offsetTop + offset_top;
            y_array_height[i] = tr.clientHeight;
        }
    }
    y_array_count = trs.length;
    _portal_frame.find("div.dddummy").remove();
    _portal_frame.find("td.ddtd").removeClass("ddtd_hide");
    var dddummy_move = _portal_frame.find("div.dddummy_move");
    dddummy_move.css("top", y_array[dddummy_move.data("top_position")]);
    dddummy_move.css("height", y_array_height[dddummy_move.data("top_position")]);
    dddummy_move.css("left", x_array[dddummy_move.data("left_position")]);
    dddummy_move.css("width", x_array[dddummy_move.data("left_position") + dddummy_move.data("duration")] - x_array[dddummy_move.data("left_position")]);
    dddummy_move.find("div.normalEventElement").height(dddummy_move.height());
}
function dd_init(eid,plid)
{
    if((typeof browser_type == "undefined") || (browser_type == 'msie') || true){return;}
    if(isTouchDevice()){return;}
    var is_portlet;
    var _portal_frame;
    if(typeof plid != "undefined" && plid != "")
    {
        _portal_frame = jQuery("#portal_frame"+plid);
        is_portlet = 1;
    }
    else
    {
        _portal_frame = jQuery("#mainareaSchedule-grn");
        is_portlet = 0;
        jQuery("#user-popup-div").css("z-index",31);
        jQuery("#user-popup-if").css("z-index",30);
        jQuery("#facility-popup-div").css("z-index",31);
        jQuery("#facility-popup-if").css("z-index",30);
    }
    var bdate_str;
    var sdate_str;
    var edate_str;
    var ddtd_list = _portal_frame.find("td.ddtd");
    var ddtd;
    var ddtd_nee;
    var dddummy;
    var dddummy_nee;
    var h_array = [];
    var w_array = [];
    var t_array = [];
    var l_array = [];
    var ddimg1;
    var ddimg2;
    for(var i=0;i<ddtd_list.length;i++)
    {
        if(_portal_frame.has("#dddummy"+i).length){return;}
        ddtd = ddtd_list.eq(i);
        if(ddtd.find("div").find("a").length)
        {
            h_array[i] = ddtd.height();
            w_array[i] = ddtd.width();
            t_array[i] = ddtd.position().top;
            l_array[i] = ddtd.position().left;
        }
    }
    for(var i=0;i<ddtd_list.length;i++)
    {
        ddtd = ddtd_list.eq(i);
        ddtd_nee = ddtd.find("div.normalEventElement");
        if(ddtd.find("span.temporary").length){continue;}
        if(ddtd.find("span.share_temporary").length){continue;}
        if(ddtd_nee.data("event_type") == "temporary" || ddtd_nee.data("event_type") == "share_temporary"){continue;}
        if(ddtd.find("div").find("a").length)
        {
            ddtd.addClass("ddtd"+i);
            _portal_frame.append("<div class='dddummy' id='dddummy"+i+"'></div>");
            bdate_str = ddtd_nee.data("event_bdate");
            sdate_str = ddtd_nee.data("event_start_date");
            sdate_str = sdate_str.substr(0,10);
            edate_str = ddtd_nee.data("event_end_date");
            edate_str = edate_str.substr(0,10);
            dddummy = _portal_frame.find("#dddummy"+i);
            if(bdate_str == sdate_str && bdate_str == edate_str)
            {
                dddummy.addClass('dddummy_normal');
                dddummy.append("<div class='ddimg1 ddimg_none'><div class='ddimg_child1'><div class='ddimg_child2'></div></div></div>");
                ddimg1 = dddummy.find("div.ddimg1");
                if(is_portlet)
                {
                    ddimg1.addClass("ddimg1_portlet");
                }
                ddimg1.height(h_array[i] + 2);
                ddimg1.find("div.ddimg_child1").height(h_array[i] + 2);
                dddummy.append("<div class='ddimg2 ddimg_none'><div class='ddimg_child1'><div class='ddimg_child2'></div></div></div>");
                ddimg2 = dddummy.find("div.ddimg2");
                if(is_portlet)
                {
                    ddimg2.addClass("ddimg2_portlet");
                }
                ddimg2.height(h_array[i] + 2);
                ddimg2.find("div.ddimg_child1").height(h_array[i] + 2);
            }
            else if(bdate_str == sdate_str)
            {
                dddummy.addClass('dddummy_left');
                dddummy.append("<div class='ddimg1 ddimg_none'><div class='ddimg_child1'><div class='ddimg_child2'></div></div></div>");
                ddimg1 = dddummy.find("div.ddimg1");
                if(is_portlet)
                {
                    ddimg1.addClass("ddimg1_portlet");
                }
                ddimg1.height(h_array[i] + 2);
                ddimg1.find("div.ddimg_child1").height(h_array[i] + 2);
            }
            else if(bdate_str == edate_str)
            {
                dddummy.addClass('dddummy_right');
                dddummy.append("<div class='ddimg2 ddimg_none'><div class='ddimg_child1'><div class='ddimg_child2'></div></div></div>");
                ddimg2 = dddummy.find("div.ddimg2");
                if(is_portlet)
                {
                    ddimg2.addClass("ddimg2_portlet");
                }
                ddimg2.height(h_array[i] + 2);
                ddimg2.find("div.ddimg_child1").height(h_array[i] + 2);
            }
            else
            {
                dddummy.addClass('dddummy_none');
            }
            dddummy.append(ddtd_nee.clone());
            dddummy_nee = dddummy.find("div.normalEventElement");
            if(_portal_frame.has("#show_full_title"+plid+":checked").length || _portal_frame.has("#show_full_titlegroup_day:checked").length)
            {
                if(ddtd.hasClass("ddtd_middle"))
                {
                    if(grn.browser.firefox)
                    {
                        dddummy_nee.css({"position":"absolute","top":"50%","margin-top":-ddtd_nee.height()/2-2.2});
                    }
                    else
                    {
                        dddummy_nee.css({"position":"absolute","top":"50%","margin-top":-ddtd_nee.height()/2-3.5});
                    }
                }
                dddummy_nee.css({"whiteSpace":"normal","line-height":1.1});
            }
            else
            {
                dddummy_nee.css("whiteSpace","nowrap");
            }
            if(typeof eid != "undefined" && eid != "")
            {
                if( eid == dddummy_nee.data("event_id") )
                {
                    dddummy.addClass("newevent-grn");
                }
            }
            if(grn.browser.firefox)
            {
                dddummy.css({ width : w_array[i]+1 , height : h_array[i]+1.8 , "top" : t_array[i]-1 , "left" : l_array[i]-1 });
            }
            else
            {
                dddummy.css({ width : w_array[i]+2 , height : h_array[i]+3 , "top" : t_array[i] , "left" : l_array[i]-0.5 });
            }
            ddtd.addClass("ddtd_hide");
        }
    }
    if(is_portlet)
    {
        showFullShortTitle('show_full_title'+plid,'portal_frame'+plid,'view_group_day',true);
    }
    else
    {
        showFullShortTitle('show_full_titlegroup_day','mainareaSchedule-grn','group_day',true);
    }
}
function dd_handle(plid)
{
    if((typeof browser_type == "undefined") || (browser_type == 'msie') || true){return;}
    if(isTouchDevice()){return;}
    if(typeof plid != "undefined" && plid != "")
    {
        var _portal_frame = jQuery("#portal_frame"+plid);
        var is_portlet = 1;
    }
    else
    {
        var _portal_frame = jQuery("#mainareaSchedule-grn");
        var is_portlet = 0;
    }
    //create x position array
    var x_array = [];
    var x_array_count = 0;
    var tds;
    if(_portal_frame.has("#show_users_timezone"+plid+":checked").length || _portal_frame.has("#show_users_timezonegroup_day:checked").length)
    {
        tds = _portal_frame.find("tr.bar_user_timezone").eq(1).children("td");
        for (var i = 2; i< tds.length; i++) {
            x_array[x_array_count++] = jQuery(tds[i]).position().left;
        }
        x_array[x_array_count++] = x_array[x_array_count - 2] + tds.last().width();
    }
    else
    {
        tds = _portal_frame.find("tr.bar_login_timezone").eq(1).children("td");
        for (var i = 2; i< tds.length; i++) {
            x_array[x_array_count++] = jQuery(tds[i]).position().left;
        }
        x_array[x_array_count++] = x_array[x_array_count - 2] + tds.last().width();
    }
    var time_pos = 0;
    var x_target_pos = 0;
    var time_str = "";
    var start_hour_str = "";
    var start_minute_str = "";
    var end_hour_str = "";
    var end_minute_str = "";
    var _event = "";
    var _start_hour = 0;
    var _start_minute = 0;
    var _end_hour = 0;
    var _end_minute = 0;
    var duration_hour = 0;
    var duration_minute = 0;
    var set_hour = "";
    var unit = "";
    var offset_hour = "";
    var offset_minute = "";
    var end_datetime_obj = "";
    var dd_tooltip = "";
    var page_x = 0;
    var original_left = 0;
    var original_width = 0;
    var _bdate = "";
    var _sdate = "";
    var _edate = "";
    var unit_count = 1;
    var window_obj = jQuery(window);
    var body_obj = jQuery("body");
    var document_obj = jQuery(document);
    //Draggable
    _portal_frame.find("div.dddummy_normal").draggable({ axis: "x" , cursor: "move" ,
        start: function(ev){
            moving = 1;
            disable_tooltip = 1;
            page_x = ev.pageX;
            var this_obj = jQuery(this);
            original_left = this_obj.position().left;
            original_width = this_obj.width();
            this_obj.addClass("dddummy_move").find("div.ddimg1 , div.ddimg2").addClass("ddimg_none");
            //create tooltip
            jQuery("div.mainarea").append('<div id="ddtooltip" class="showEventTitle"></div>');
        },
        drag: function(ev, ui){
            //datetime
            var this_obj = jQuery(this);
            var this_nee = this_obj.find("div.normalEventElement");
            set_hour = this_nee.data("event_set_hour");
            unit = this_nee.data("event_unit");
            if((_portal_frame.find("#show_users_timezonegroup_day:checked").length) || (is_portlet && _portal_frame.find("#show_users_timezone"+plid+":checked").length))
            {
                offset_hour = this_nee.data("event_offset_hour");
                offset_minute = this_nee.data("event_offset_minute");
            }
            else
            {
                offset_hour = 0;
                offset_minute = 0;
            }
            start_datetime_obj = this_nee.data("event_start_date").split(/\-|\:|\s/);
            end_datetime_obj = this_nee.data("event_end_date").split(/\-|\:|\s/);
            duration_hour = parseInt(end_datetime_obj[3],10) - parseInt(start_datetime_obj[3],10);
            if(duration_hour < 0)
            {
                duration_hour += 24;
            }
            duration_minute = parseInt(end_datetime_obj[4],10) - parseInt(start_datetime_obj[4],10);
            unit_count = Math.ceil(((duration_hour * 60) + duration_minute)/unit);
            if(unit_count == 0)
            {
                unit_count = 1;
            }
            //ui
            if( ev.pageX > x_array[x_array_count - 1 - unit_count] )
            {
                time_pos = x_array_count - 1 - unit_count;
            }
            else
            {
                time_pos = 0;
            }
            x_target_pos = original_left + (ev.pageX - page_x);
            for(var i=0,max=x_array_count-1-unit_count; i<max; i++){
                if(x_target_pos <= x_array[i+1]){
                    time_pos = i;
                    break;
                }
            }
            //snap
            ui.position.left = x_array[time_pos];
            if( (x_array[time_pos] + original_width) > x_array[x_array_count-1] )
            {
                this_obj.width(x_array[x_array_count-1] - x_array[time_pos]);
            }
            else
            {
                this_obj.width(original_width);
            }
            //tooltip text
            _start_minute = parseInt(offset_minute,10) + (parseInt(time_pos,10) * parseInt(unit,10));
            _start_hour = parseInt(set_hour,10) + parseInt(offset_hour,10) + Math.floor(parseInt(_start_minute,10)/60);
            _start_minute = parseInt(_start_minute,10)%60;
            if(_start_hour >= 24)
            {
                _start_hour -= 24;
            }
            else if(_start_hour < 0)
            {
                _start_hour += 24;
            }
            //no end datetime
            if( this_nee.data("event_no_endtime") )
            {
                start_hour_str = ( _start_hour > 9 ) ? _start_hour : ( "0" + _start_hour );
                start_minute_str = ( _start_minute > 9 ) ? _start_minute : ( "0" + _start_minute );
                time_str = start_hour_str + ":" + start_minute_str;
            }
            else
            {
                _end_hour = _start_hour + duration_hour;
                _end_minute = _start_minute + duration_minute;
                if(_end_minute >= 60)
                {
                    _end_hour++;
                    _end_minute -= 60;
                }
                else if(_end_minute < 0)
                {
                    _end_hour--;
                    _end_minute += 60;
                }
                if(_end_hour >= 24)
                {
                    _end_hour -= 24;
                }
                else if(_end_hour < 0)
                {
                    _end_hour += 24;
                }
                start_hour_str = ( _start_hour > 9 ) ? _start_hour : ( "0" + _start_hour );
                start_minute_str = ( _start_minute > 9 ) ? _start_minute : ( "0" + _start_minute );
                end_hour_str = ( _end_hour > 9 ) ? _end_hour : ( "0" + _end_hour );
                end_minute_str = ( _end_minute > 9 ) ? _end_minute : ( "0" + _end_minute );
                time_str = start_hour_str + ":" + start_minute_str + "-" + end_hour_str + ":" + end_minute_str;
            }
            dd_tooltip = jQuery("#ddtooltip").html(time_str);
            //tooltip position
            if(ev.pageX + dd_tooltip.width() > x_array[x_array_count-1] )
            {
                var left_position = ev.pageX - 20 - dd_tooltip.width();
            }
            else
            {
                var left_position = ev.pageX + 10;
            }
            dd_tooltip.css({"top" : ev.pageY + 10 , "left" : left_position});
        },
        stop: function(ev){
            moving = 0;
            showing = 1;
            disable_tooltip = 0;
            var this_obj = jQuery(this);
            var this_nee = this_obj.find("div.normalEventElement");
            if(is_portlet)
            {
                pid = plid;
            }
            else
            {
                pid = "";
            }
            jQuery("#ddtooltip").remove();
            //dddummy position
            time_pos = 0;
            x_target_pos = this_obj.position().left;
            for(var i=0,max=x_array_count-1; i<max; i++){
                if(x_target_pos <= x_array[i+1]-1){
                    time_pos = i;
                    this_obj.css("left", parseInt(x_array[i],10));
                    break;
                }
            }
            //append popup
            body_obj.append('<div id="ddpopup"></div>');
            var ddpopup_obj = jQuery("#ddpopup");
            ddpopup_obj.append(_popup_loading);
            ddpopup_obj.css({"top" : ((window_obj.height() - ddpopup_obj.outerHeight()) / 2) + window_obj.scrollTop() + "px" , "left" : ((window_obj.width() - ddpopup_obj.width()) / 2) + window_obj.scrollLeft() + "px"});
            //show popup
            show_popup("ddpopup", ev.pageX, ev.pageY);
            ddpopup_obj.css("display","inline");
            body_obj.append(jQuery('<div class="ddoverlay" id="overlay"/>').css({'width':document_obj.width()+'px','height':document_obj.height()+'px'}));
            setTimeout(function(){
                ddpopup_obj.find("a.btn_cancel").focus();
            },100);
            //event
            _event = this_nee.data("event_id");
            //date
            _bdate = this_nee.data("event_bdate");
            _sdate = this_nee.data("event_start_date");
            _sdate = _sdate.substr(0,10);
            _edate = this_nee.data("event_end_date");
            _edate = _edate.substr(0,10);
            //time
            set_hour = this_nee.data("event_set_hour");
            unit = this_nee.data("event_unit");
            _start_minute = (parseInt(time_pos,10) * parseInt(unit,10));
            _start_hour = parseInt(set_hour,10) + Math.floor(parseInt(_start_minute,10)/60);
            _start_minute = parseInt(_start_minute,10)%60;
            if(_start_hour >= 24)
            {
                _start_hour -= 24;
            }
            else if(_start_hour < 0)
            {
                _start_hour += 24;
            }
            start_datetime_obj = this_nee.data("event_start_date").split(/\-|\:|\s/);
            end_datetime_obj = this_nee.data("event_end_date").split(/\-|\:|\s/);
            //no end datetime
            if( this_nee.data("event_no_endtime") )
            {
                _edate = "";
                _end_hour = "";
                _end_minute = "";
                if( (parseInt(start_datetime_obj[3],10) == _start_hour) && (parseInt(start_datetime_obj[4],10) == _start_minute) )
                {
                    if(is_portlet)
                    {
                        dd_remove(plid);
                        dd_init("",plid);
                        dd_handle(plid);
                    }
                    else
                    {
                        dd_remove();
                        dd_init();
                        dd_handle();
                    }
                    return;
                }
            }
            else
            {
                duration_hour = parseInt(end_datetime_obj[3],10) - parseInt(start_datetime_obj[3],10);
                duration_minute = parseInt(end_datetime_obj[4],10) - parseInt(start_datetime_obj[4],10);
                if(duration_hour < 0)
                {
                    duration_hour += 24;
                }
                _end_hour = _start_hour + duration_hour;
                _end_minute = _start_minute + duration_minute;
                if(_end_minute >= 60)
                {
                    _end_hour++;
                    _end_minute -= 60;
                }
                else if(_end_minute < 0)
                {
                    _end_hour--;
                    _end_minute += 60;
                }
                if(_end_hour >= 24)
                {
                    _end_hour -= 24;
                }
                else if(_end_hour < 0)
                {
                    _end_hour += 24;
                }
                if( (parseInt(start_datetime_obj[3],10) == _start_hour) && (parseInt(start_datetime_obj[4],10) == _start_minute) && (parseInt(end_datetime_obj[3],10) == _end_hour) && (parseInt(end_datetime_obj[4],10) == _end_minute) )
                {
                    if(is_portlet)
                    {
                        dd_remove(plid);
                        dd_init("",plid);
                        dd_handle(plid);
                    }
                    else
                    {
                        dd_remove();
                        dd_init();
                        dd_handle();
                    }
                    return;
                }
            }
            //hide ddtd
            var ddtd_id = this_obj.prop("id").substr(7);
            var this_ddtd = _portal_frame.find("td.ddtd"+ddtd_id).addClass("ddtd_remove");
            this_ddtd.removeClass("ddtd");
            this_ddtd.removeClass("ddtd_middle");
            this_ddtd.removeClass("group_day_calendar_item");
            this_ddtd.removeClass("group_day_calendar_color_booked");
            this_ddtd.removeClass("ddtd_hide");
            if(this_ddtd.hasClass("group_day_calendar_item_conflicted"))
            {
                this_ddtd.removeClass("group_day_calendar_item_conflicted");
                this_ddtd.addClass("group_day_calendar_color_conflicted_line");
            }
            this_ddtd.find("div.normalEventElement").css("visibility","hidden");
            if(this_ddtd.prev().hasClass("group_day_calendar_event_cell"))
            {
                this_ddtd.addClass("ddtd_prev_event_cell");
            }
            else
            {
                this_ddtd.addClass("ddtd_prev_item");
            }
            if(this_ddtd.next().hasClass("group_day_calendar_color_conflicted_line") || this_ddtd.next().hasClass("group_day_calendar_color_available"))
            {
                this_ddtd.next().addClass("ddtd_next");
            }
            this_obj.css({"padding-left" : "1px", "position" : "absolute"});
            this_obj.attr("data-left_position", time_pos);
            this_obj.attr("data-duration", Math.ceil(((duration_hour*60)+duration_minute)/unit));
            var tr = _portal_frame.find("table.day_table tr");
            for(var i=0; i<tr.length; i++)
            {
                if(tr.eq(i).hasClass("day_table_time_login")){continue;}
                if((this_obj.position().top + (this_obj.height()/2) > tr.eq(i).position().top) && (this_obj.position().top + this_obj.height()/2) < tr.eq(i).position().top + tr.eq(i).height())
                {
                    this_obj.attr("data-top_position", i);
                    break;
                }
            }
            this_obj.removeClass("dddummy");
            //ajax
            jQuery.ajax({
                url: _url_ajax_checking,
                data: {
                    event_id: _event,
                    bdate: _bdate,
                    end_date: _edate,
                    start_date: _sdate,
                    start_hour: _start_hour,
                    start_minute: _start_minute,
                    end_hour: _end_hour,
                    end_minute: _end_minute
                },
                type: "POST",
                success: function(xhr,textStatus,jqXHR){
                    if (grn.component.error_handler.hasCybozuError(jqXHR))
                    {
                        GRN_ScheduleSimpleAdd.showErrMsg(jqXHR);
                        return;
                    }
                    if (grn.component.error_handler.hasCybozuLogin(jqXHR))
                    {
                        location.href = location.href;
                        return;
                    }
                    jQuery("#ddpopup").html(xhr);
                },
                error: function(jqXHR,textStatus,errorThrown){
                    GRN_ScheduleSimpleAdd.showErrMsg(jqXHR);
                },
                complete: function(xhr, status){
                    setTimeout(function(){
                        if(jQuery("span.aButtonStandard-grn").find("a.btn_yes").length){
                            jQuery("a.btn_yes").focus();}
                        else if(jQuery("a.btn_cancel").length){
                            jQuery("a.btn_cancel").focus();}
                    },100);
                }
            });
            
        }
    });
    //Resizable
    _portal_frame.find("div.dddummy_normal").resizable({ handles: "e, w", minWidth: 2,
        start: function(ev, ui){
            resizing = 1;
            disable_tooltip = 1;
            var this_obj = jQuery(this);
            this_obj.addClass("dddummy_move");
            //create tooltip
            jQuery("div.mainarea").append('<div id="ddtooltip" class="showEventTitle"></div>');
            this_obj.find("div.normalEventElement").height(this_obj.height());
        },
        resize: function(ev, ui){
            var this_obj = jQuery(this);
            var this_nee = this_obj.find("div.normalEventElement");
            this_nee.width(this_obj.width());
            //limited area
            //left resize
            if(ui.position.left != ui.originalPosition.left)
            {
                if(ui.position.left < x_array[0])
                {
                    this_obj.css({"left" : x_array[0] , "width" : ui.originalSize.width + ui.originalPosition.left - x_array[0]});
                }
                //snap
                x_target_pos = ui.position.left;
                time_pos = 0;
                for(var i=0,max=x_array_count-1; i<max; i++)
                {
                    if(x_target_pos <= x_array[i+1]){
                        time_pos = i;
                        break;
                    }
                }
                this_obj.css({"left" : x_array[time_pos] , "width" : ui.originalPosition.left + ui.originalSize.width - x_array[time_pos]});
            }
            //right resize
            else
            {
                if( (ui.originalPosition.left + ui.size.width) > x_array[x_array_count-1] )
                {
                    this_obj.width( x_array[x_array_count - 1] - ui.originalPosition.left );
                }
                
                //snap
                x_target_pos = ui.originalPosition.left;
                if( ev.pageX > x_array[x_array_count-1] )
                {
                    time_pos = x_array_count - 1;
                }
                else
                {
                    time_pos = 1;
                }
                for(var i=1; i<x_array_count;i++)
                {
                    if(x_target_pos + ui.size.width <= x_array[i]){
                        time_pos = i;
                        break;
                    }
                }
                this_obj.width( x_array[time_pos] - x_target_pos );
            }
            //tooltip text
            x_target_pos = ui.position.left;
            //right resize
            if(ui.position.left == ui.originalPosition.left)
            {
                set_hour = this_nee.data("event_set_hour");
                unit = this_nee.data("event_unit");
                if((_portal_frame.find("#show_users_timezonegroup_day:checked").length) || (is_portlet && _portal_frame.find("#show_users_timezone"+plid+":checked").length))
                {
                    offset_hour = this_nee.data("event_offset_hour");
                    offset_minute = this_nee.data("event_offset_minute");
                }
                else
                {
                    offset_hour = 0;
                    offset_minute = 0;
                }
                start_datetime_obj = this_nee.data("event_start_date").split(/\-|\:|\s/);
                _start_hour = parseInt(start_datetime_obj[3],10) + parseInt(offset_hour,10);
                _start_minute = parseInt(start_datetime_obj[4],10) + parseInt(offset_minute,10);
                if(_start_minute >= 60)
                {
                    _start_hour++;
                    _start_minute -= 60;
                }
                else if(_start_minute < 0)
                {
                    _start_hour--;
                    _start_minute += 60;
                }
                if(_start_hour >= 24)
                {
                    _start_hour -= 24;
                }
                else if(_start_hour < 0)
                {
                    _start_hour += 24;
                }
                time_pos = x_array_count-1;
                for(var i=1; i<x_array_count; i++)
                {
                    if(x_target_pos + ui.size.width <= x_array[i]){
                        time_pos = i;
                        break;
                    }
                }
                _end_minute = parseInt(offset_minute,10) + (parseInt(time_pos,10) * parseInt(unit,10));
                _end_hour = parseInt(set_hour,10) + parseInt(offset_hour,10) + Math.floor(parseInt(_end_minute,10)/60);
                _end_minute = parseInt(_end_minute,10)%60;
                if(_end_hour >= 24)
                {
                    _end_hour -= 24;
                }
                else if(_end_hour < 0)
                {
                    _end_hour += 24;
                }
            }
            //left resize
            else
            {
                time_pos = 0;
                for(var i=0,max=x_array_count-1; i<max; i++)
                {
                    if(x_target_pos <= x_array[i+1]){
                        time_pos = i;
                        break;
                    }
                }
                set_hour = this_nee.data("event_set_hour");
                unit = this_nee.data("event_unit");
                if((_portal_frame.find("#show_users_timezonegroup_day:checked").length) || (is_portlet && _portal_frame.find("#show_users_timezone"+plid+":checked").length))
                {
                    offset_hour = this_nee.data("event_offset_hour");
                    offset_minute = this_nee.data("event_offset_minute");
                }
                else
                {
                    offset_hour = 0;
                    offset_minute = 0;
                }
                _start_minute = parseInt(offset_minute,10) + (parseInt(time_pos,10) * parseInt(unit,10));
                _start_hour = parseInt(set_hour,10) + parseInt(offset_hour,10) + Math.floor(parseInt(_start_minute,10)/60);
                _start_minute = parseInt(_start_minute,10)%60;
                if(_start_hour >= 24)
                {
                    _start_hour -= 24;
                }
                else if(_start_hour < 0)
                {
                    _start_hour += 24;
                }
                end_datetime_obj = this_nee.data("event_end_date").split(/\-|\:|\s/);
                _end_hour = parseInt(end_datetime_obj[3],10) + parseInt(offset_hour,10);
                _end_minute = parseInt(end_datetime_obj[4],10) + parseInt(offset_minute,10);
                if(_end_minute >= 60)
                {
                    _end_hour++;
                    _end_minute -= 60;
                }
                else if(_end_minute < 0)
                {
                    _end_hour--;
                    _end_minute += 60;
                }
                if(_end_hour >= 24)
                {
                    _end_hour -= 24;
                }
                else if(_end_hour < 0)
                {
                    _end_hour += 24;
                }
            }
            start_hour_str = ( _start_hour > 9 ) ? _start_hour : ( "0" + _start_hour );
            start_minute_str = ( _start_minute > 9 ) ? _start_minute : ( "0" + _start_minute );
            end_hour_str = ( _end_hour > 9 ) ? _end_hour : ( "0" + _end_hour );
            end_minute_str = ( _end_minute > 9 ) ? _end_minute : ( "0" + _end_minute );
            time_str = start_hour_str + ":" + start_minute_str + "-" + end_hour_str + ":" + end_minute_str;
            dd_tooltip = jQuery("#ddtooltip");
            dd_tooltip.html(time_str);
            //tooltip position
            dd_tooltip.css("top", ev.pageY + 10);
            if(ev.pageX + dd_tooltip.width() > x_array[x_array_count-1] )
            {
                dd_tooltip.css("left", ev.pageX - 20 - dd_tooltip.width() );
            }
            else
            {
                dd_tooltip.css("left", ev.pageX + 10);
            }
        },
        stop: function(ev, ui){
            resizing = 0;
            showing = 1;
            disable_tooltip = 0;
            var this_obj = jQuery(this);
            var this_nee = this_obj.find("div.normalEventElement");
            if(typeof plid != "undefined" && plid != "")
            {
                pid = plid;
            }
            else
            {
                pid = "";
            }
            jQuery("#ddtooltip").remove();
            //append popup
            body_obj.append('<div id="ddpopup"></div>');
            var ddpopup_obj = jQuery("#ddpopup");
            ddpopup_obj.append(_popup_loading);
            ddpopup_obj.css({"top" : ((window_obj.height() - ddpopup_obj.outerHeight()) / 2) + window_obj.scrollTop() + "px" , "left" : ((window_obj.width() - ddpopup_obj.width()) / 2) + window_obj.scrollLeft() + "px"});
            //show popup
            show_popup("ddpopup", ev.pageX, ev.pageY);
            ddpopup_obj.css("display","inline");
            var div_overlay = jQuery('<div class="ddoverlay" id="overlay"/>').css({'width':document_obj.width()+'px','height':document_obj.height()+'px'});
            body_obj.append(div_overlay);
            setTimeout(function(){
                if(jQuery("a.btn_cancel").length){
                    jQuery("a.btn_cancel").focus();}
            },100);
            //event
            _event = this_nee.data("event_id");
            //date
            _bdate = this_nee.data("event_bdate");
            _sdate = this_nee.data("event_start_date");
            _sdate = _sdate.substr(0,10);
            _edate = this_nee.data("event_end_date");
            _edate = _edate.substr(0,10);
            //time
            x_target_pos = this_obj.position().left;
            start_datetime_obj = this_nee.data("event_start_date").split(/\-|\:|\s/);
            end_datetime_obj = this_nee.data("event_end_date").split(/\-|\:|\s/);
            //right resize
            if(ui.position.left == ui.originalPosition.left)
            {
                _start_hour = parseInt(start_datetime_obj[3],10);
                _start_minute = parseInt(start_datetime_obj[4],10);
                time_pos = x_array_count-1;
                for(var i=1; i<x_array_count; i++)
                {
                    if(x_target_pos + ui.size.width <= x_array[i]-1){
                        time_pos = i;
                        break;
                    }
                }
                set_hour = this_nee.data("event_set_hour");
                unit = this_nee.data("event_unit");
                _end_minute = (parseInt(time_pos,10) * parseInt(unit,10));
                _end_hour = parseInt(set_hour,10) + Math.floor(parseInt(_end_minute,10)/60);
                _end_minute = parseInt(_end_minute,10)%60;
                if(_start_hour >= 24)
                {
                    _start_hour -= 24;
                }
            }
            //left resize
            else
            {
                time_pos = 0;
                for(var i=0,max=x_array_count-1; i<max ; i++)
                {
                    if(x_target_pos <= x_array[i+1]-1){
                        time_pos = i;
                        break;
                    }
                }
                set_hour = this_nee.data("event_set_hour");
                unit = this_nee.data("event_unit");
                _start_minute = (parseInt(time_pos,10) * parseInt(unit,10));
                _start_hour = parseInt(set_hour,10) + Math.floor(parseInt(_start_minute,10)/60);
                _start_minute = parseInt(_start_minute,10)%60;
                if(_start_hour >= 24)
                {
                    _start_hour -= 24;
                }
                _end_hour = parseInt(end_datetime_obj[3],10);
                _end_minute = parseInt(end_datetime_obj[4],10);
            }
            if( (parseInt(start_datetime_obj[3],10) == _start_hour) && (parseInt(start_datetime_obj[4],10) == _start_minute) && (parseInt(end_datetime_obj[3],10) == _end_hour) && (parseInt(end_datetime_obj[4],10) == _end_minute) )
            {
                if(typeof plid != "undefined" && plid != "")
                {
                    dd_remove(plid);
                    dd_init("",plid);
                    dd_handle(plid);
                }
                else
                {
                    dd_remove();
                    dd_init();
                    dd_handle();
                }
                return;
            }
            //hide ddtd
            var ddtd_id = this_obj.prop("id").substr(7);
            var this_ddtd = _portal_frame.find("td.ddtd"+ddtd_id).addClass("ddtd_remove");
            this_ddtd.removeClass("ddtd");
            this_ddtd.removeClass("ddtd_middle");
            this_ddtd.removeClass("group_day_calendar_item");
            this_ddtd.removeClass("group_day_calendar_color_booked");
            this_ddtd.removeClass("ddtd_hide");
            if(this_ddtd.hasClass("group_day_calendar_item_conflicted"))
            {
                this_ddtd.removeClass("group_day_calendar_item_conflicted");
                this_ddtd.addClass("group_day_calendar_color_conflicted_line");
            }
            this_ddtd.find("div.normalEventElement").css("visibility","hidden");
            if(this_ddtd.prev().hasClass("group_day_calendar_event_cell"))
            {
                this_ddtd.addClass("ddtd_prev_event_cell");
            }
            else
            {
                this_ddtd.addClass("ddtd_prev_item");
            }
            if(this_ddtd.next().hasClass("group_day_calendar_color_conflicted_line") || this_ddtd.next().hasClass("group_day_calendar_color_available"))
            {
                this_ddtd.next().addClass("ddtd_next");
            }
            //right resize
            if(ui.position.left == ui.originalPosition.left)
            {
                this_obj.attr("data-duration", Math.ceil((((_end_hour - _start_hour)*60)+(_end_minute - _start_minute))/unit));
                this_obj.attr("data-left_position", time_pos - Math.ceil((((_end_hour - _start_hour)*60)+(_end_minute - _start_minute))/unit));
            }
            //left resize
            else
            {
                this_obj.attr("data-left_position", time_pos);
                this_obj.attr("data-duration", Math.ceil((((_end_hour - _start_hour)*60)+(_end_minute - _start_minute))/unit));
            }
            this_obj.css({"padding-left" : "1px", "position" : "absolute"});
            var tr = _portal_frame.find("table.day_table").find("tr");
            for(var i=0; i<tr.length; i++)
            {
                if(tr.eq(i).hasClass("day_table_time_login")){continue;}
                if((this_obj.position().top + (this_obj.height()/2) > tr.eq(i).position().top) && (this_obj.position().top + (this_obj.height()/2) < tr.eq(i).position().top + tr.eq(i).height()))
                {
                    this_obj.attr("data-top_position", i);
                    break;
                }
            }
            this_obj.removeClass("dddummy");
            //ajax
            jQuery.ajax({
                url: _url_ajax_checking,
                data: {
                    event_id: _event,
                    bdate: _bdate,
                    end_date: _edate,
                    start_date: _sdate,
                    start_hour: _start_hour,
                    start_minute: _start_minute,
                    end_hour: _end_hour,
                    end_minute: _end_minute
                },
                type: "POST",
                success: function(xhr,textStatus,jqXHR){
                    if (grn.component.error_handler.hasCybozuError(jqXHR))
                    {
                        GRN_ScheduleSimpleAdd.showErrMsg(jqXHR);
                        return;
                    }
                    if (grn.component.error_handler.hasCybozuLogin(jqXHR))
                    {
                        location.href = location.href;
                        return;
                    }
                    jQuery("#ddpopup").html(xhr);
                },
                error: function(jqXHR,textStatus,errorThrown){
                    GRN_ScheduleSimpleAdd.showErrMsg(jqXHR);
                },
                complete: function(xhr, status){
                    setTimeout(function(){
                        if(jQuery("span.aButtonStandard-grn").find("a.btn_yes").length > 0){
                            jQuery("a.btn_yes").focus();}
                        else if(jQuery("a.btn_cancel").length){
                            jQuery("a.btn_cancel").focus();}
                    },100);
                }
            });
        }
    });
    //Left Resizable
    _portal_frame.find("div.dddummy_left").resizable({ handles: "w", minWidth: 2,
        start: function(ev, ui){
            resizing = 1;
            disable_tooltip = 1;
            var this_obj = jQuery(this);
            this_obj.addClass("dddummy_move");
            //create tooltip
            jQuery("div.mainarea").append('<div id="ddtooltip" class="showEventTitle"></div>');
            this_obj.find("div.normalEventElement").height(this_obj.height());
        },
        resize: function(ev, ui){
            var this_obj = jQuery(this);
            var this_nee = this_obj.find("div.normalEventElement");
            this_nee.width(this_obj.width());
            //limited area
            //left resize
            if(ui.position.left < x_array[0])
            {
                this_obj.css("left", x_array[0]);
                this_obj.width(ui.originalSize.width + ui.originalPosition.left - x_array[0]);
            }
            //snap
            x_target_pos = ui.position.left;
            time_pos = 0;
            for(var i=0,max=x_array_count-1; i<max; i++)
            {
                if(x_target_pos <= x_array[i+1]){
                    time_pos = i;
                    break;
                }
            }
            this_obj.css("left", x_array[time_pos]);
            this_obj.width( ui.originalPosition.left + ui.originalSize.width - x_array[time_pos] );
            //tooltip text
            x_target_pos = ui.position.left;
            //left resize
            time_pos = 0;
            for(var i=0,max=x_array_count-1; i<max; i++)
            {
                if(x_target_pos <= x_array[i+1]){
                    time_pos = i;
                    break;
                }
            }
            set_hour = this_nee.data("event_set_hour");
            unit = this_nee.data("event_unit");
            if(_portal_frame.find("#show_users_timezonegroup_day:checked").length > 0)
            {
                offset_hour = this_nee.data("event_offset_hour");
                offset_minute = this_nee.data("event_offset_minute");
            }
            else
            {
                offset_hour = 0;
                offset_minute = 0;
            }
            _start_minute = parseInt(offset_minute,10) + (parseInt(time_pos,10) * parseInt(unit,10));
            _start_hour = parseInt(set_hour,10) + parseInt(offset_hour,10) + Math.floor(parseInt(_start_minute,10)/60);
            _start_minute = parseInt(_start_minute,10)%60;
            if(_start_hour >= 24)
            {
                _start_hour -= 24;
            }
            else if(_start_hour < 0)
            {
                _start_hour += 24;
            }
            start_hour_str = ( _start_hour > 9 ) ? _start_hour : ( "0" + _start_hour );
            start_minute_str = ( _start_minute > 9 ) ? _start_minute : ( "0" + _start_minute );
            end_datetime_obj = this_nee.data("event_end_date").split(/\-|\:|\s/);
            d = new Date(end_datetime_obj[0],end_datetime_obj[1]-1,end_datetime_obj[2]);
            if(typeof _short_date_format != "undefined" && typeof _locale != "undefined")
            {
                time_str = start_hour_str + ":" + start_minute_str + "-"+ parseday(d,_short_date_format,_locale);
            }
            dd_tooltip = jQuery("#ddtooltip");
            dd_tooltip.html(time_str);
            //tooltip position
            dd_tooltip.css("top", ev.pageY + 10);
            if(ev.pageX + dd_tooltip.width() > x_array[x_array_count-1] )
            {
                dd_tooltip.css("left", ev.pageX - 20 - dd_tooltip.width() );
            }
            else
            {
                dd_tooltip.css("left", ev.pageX + 10);
            }
        },
        stop: function(ev, ui){
            resizing = 0;
            showing = 1;
            disable_tooltip = 0;
            var this_obj = jQuery(this);
            var this_nee = this_obj.find("div.normalEventElement");
            if(typeof plid != "undefined" && plid != "")
            {
                pid = plid;
            }
            else
            {
                pid = "";
            }
            jQuery("#ddtooltip").remove();
            //append popup
            body_obj.append('<div id="ddpopup"></div>');
            var ddpopup_obj = jQuery("#ddpopup");
            ddpopup_obj.append(_popup_loading);
            ddpopup_obj.css({'position':'absolute',"top":((window_obj.height() - ddpopup_obj.outerHeight()) / 2) + window_obj.scrollTop() + "px","left":((window_obj.width() - ddpopup_obj.width()) / 2) + window_obj.scrollLeft() + "px"});
            //show popup
            show_popup("ddpopup", ev.pageX, ev.pageY);
            ddpopup_obj.css("display","inline");
            var div_overlay = jQuery('<div class="ddoverlay" id="overlay"/>').css({'width':document_obj.width()+'px','height':document_obj.height()+'px'});
            jQuery('body').append(div_overlay);
            setTimeout(function(){
                if(jQuery("a.btn_cancel").length){
                    jQuery("a.btn_cancel").focus();}
            },100);
            //event
            _event = this_nee.data("event_id");
            //date
            _bdate = this_nee.data("event_bdate");
            _sdate = this_nee.data("event_start_date");
            _sdate = _sdate.substr(0,10);
            _edate = this_nee.data("event_end_date");
            _edate = _edate.substr(0,10);
            //time
            x_target_pos = this_obj.position().left;
            start_datetime_obj = this_nee.data("event_start_date").split(/\-|\:|\s/);
            end_datetime_obj = this_nee.data("event_end_date").split(/\-|\:|\s/);
            //left resize
            time_pos = 0;
            for(var i=0,max=x_array_count-1; i<max; i++)
            {
                if(x_target_pos <= x_array[i+1]-1){
                    time_pos = i;
                    break;
                }
            }
            set_hour = this_nee.data("event_set_hour");
            unit = this_nee.data("event_unit");
            _start_minute = (parseInt(time_pos,10) * parseInt(unit,10));
            _start_hour = parseInt(set_hour,10) + Math.floor(parseInt(_start_minute,10)/60);
            _start_minute = parseInt(_start_minute,10)%60;
            if(_start_hour >= 24)
            {
                _start_hour -= 24;
            }
            _end_hour = parseInt(end_datetime_obj[3],10);
            _end_minute = parseInt(end_datetime_obj[4],10);
            if( (parseInt(start_datetime_obj[3],10) == _start_hour) && (parseInt(start_datetime_obj[4],10) == _start_minute) && (parseInt(end_datetime_obj[3],10) == _end_hour) && (parseInt(end_datetime_obj[4],10) == _end_minute) )
            {
                if(typeof plid != "undefined" && plid != "")
                {
                    dd_remove(plid);
                    dd_init("",plid);
                    dd_handle(plid);
                }
                else
                {
                    dd_remove();
                    dd_init();
                    dd_handle();
                }
                return;
            }
            //hide ddtd
            var ddtd_id = this_obj.prop("id").substr(7);
            var this_ddtd = _portal_frame.find("td.ddtd"+ddtd_id);
            this_ddtd.addClass("ddtd_remove");
            var ddtd_remove = _portal_frame.find("td.ddtd_remove");
            ddtd_remove.removeClass("ddtd");
            ddtd_remove.removeClass("ddtd_middle");
            ddtd_remove.removeClass("group_day_calendar_item");
            ddtd_remove.removeClass("group_day_calendar_color_booked");
            ddtd_remove.removeClass("ddtd_hide");
            if(ddtd_remove.hasClass("group_day_calendar_item_conflicted"))
            {
                ddtd_remove.removeClass("group_day_calendar_item_conflicted");
                ddtd_remove.addClass("group_day_calendar_color_conflicted_line");
            }
            ddtd_remove.find("div.normalEventElement").css("visibility","hidden");
            if(this_ddtd.prev().hasClass("group_day_calendar_event_cell"))
            {
                this_ddtd.addClass("ddtd_prev_event_cell");
            }
            else
            {
                this_ddtd.addClass("ddtd_prev_item");
            }
            if(this_ddtd.next().hasClass("group_day_calendar_color_conflicted_line") || this_ddtd.next().hasClass("group_day_calendar_color_available"))
            {
                this_ddtd.next().addClass("ddtd_next");
            }
            this_obj.css({"padding-left" : "1px", "position" : "absolute"});
            this_obj.attr("data-left_position", time_pos);
            this_obj.attr("data-duration", x_array_count-1-time_pos);
            var tr = _portal_frame.find("table.day_table").find("tr");
            for(var i=0; i<tr.length; i++)
            {
                if(tr.eq(i).hasClass("day_table_time_login")){continue;}
                if((this_obj.position().top + (this_obj.height()/2) > tr.eq(i).position().top) && (this_obj.position().top + (this_obj.height()/2) < tr.eq(i).position().top + tr.eq(i).height()))
                {
                    this_obj.attr("data-top_position", i);
                    break;
                }
            }
            this_obj.removeClass("dddummy");
            //ajax
            jQuery.ajax({
                url: _url_ajax_checking,
                data: {
                    event_id: _event,
                    bdate: _bdate,
                    end_date: _edate,
                    start_date: _sdate,
                    start_hour: _start_hour,
                    start_minute: _start_minute,
                    end_hour: _end_hour,
                    end_minute: _end_minute
                },
                type: "POST",
                success: function(xhr,textStatus,jqXHR ){
                    if (grn.component.error_handler.hasCybozuError(jqXHR))
                    {
                        GRN_ScheduleSimpleAdd.showErrMsg(jqXHR);
                        return;
                    }
                    if (grn.component.error_handler.hasCybozuLogin(jqXHR))
                    {
                        location.href = location.href;
                        return;
                    }
                    jQuery("#ddpopup").html(xhr);
                },
                error: function(jqXHR,textStatus,errorThrown){
                    GRN_ScheduleSimpleAdd.showErrMsg(jqXHR);
                },
                complete: function(xhr, status){
                    setTimeout(function(){
                        if(jQuery(".aButtonStandard-grn").find("a.btn_yes").length){
                            jQuery("a.btn_yes").focus();}
                        else if(jQuery("a.btn_cancel").length){
                            jQuery("a.btn_cancel").focus();}
                    },100);
                }
            });
        }
    });
    //Right Resizable
    _portal_frame.find("div.dddummy_right").resizable({ handles: "e", minWidth: 2,
        start: function(ev, ui){
            resizing = 1;
            disable_tooltip = 1;
            var this_obj = jQuery(this);
            this_obj.addClass("dddummy_move");
            //create tooltip
            jQuery("div.mainarea").append('<div id="ddtooltip" class="showEventTitle"></div>');
            this_obj.find("div.normalEventElement").height(this_obj.height());
        },
        resize: function(ev, ui){
            var this_obj = jQuery(this);
            var this_nee = this_obj.find("div.normalEventElement");
            this_nee.width(this_obj.width());
            //limited area
            //right resize
            if( (ui.originalPosition.left + ui.size.width) > x_array[x_array_count-1] )
            {
                this_obj.width( x_array[x_array_count - 1] - ui.originalPosition.left );
            }
            //snap
            x_target_pos = ui.originalPosition.left;
            if( ev.pageX > x_array[x_array_count-1] )
            {
                time_pos = x_array_count - 1;
            }
            else
            {
                time_pos = 1;
            }
            for(var i=1; i<x_array_count; i++)
            {
                if(x_target_pos + ui.size.width <= x_array[i]){
                    time_pos = i;
                    break;
                }
            }
            this_obj.width( x_array[time_pos] - x_target_pos );
            //tooltip text
            x_target_pos = ui.position.left;
            //right resize
            set_hour = this_nee.data("event_set_hour");
            unit = this_nee.data("event_unit");
            if(_portal_frame.find("#show_users_timezonegroup_day:checked").length > 0)
            {
                offset_hour = this_nee.data("event_offset_hour");
                offset_minute = this_nee.data("event_offset_minute");
            }
            else
            {
                offset_hour = 0;
                offset_minute = 0;
            }
            time_pos = x_array_count-1;
            for(var i=1; i<x_array_count; i++)
            {
                if(x_target_pos + ui.size.width <= x_array[i]){
                    time_pos = i;
                    break;
                }
            }
            _end_minute = parseInt(offset_minute,10) + (parseInt(time_pos,10) * parseInt(unit,10));
            _end_hour = parseInt(set_hour,10) + parseInt(offset_hour,10) + Math.floor(parseInt(_end_minute,10)/60);
            _end_minute = parseInt(_end_minute,10)%60;
            if(_end_hour >= 24)
            {
                _end_hour -= 24;
            }
            else if(_end_hour < 0)
            {
                _end_hour += 24;
            }
            end_hour_str = ( _end_hour > 9 ) ? _end_hour : ( "0" + _end_hour );
            end_minute_str = ( _end_minute > 9 ) ? _end_minute : ( "0" + _end_minute );
            start_datetime_obj = this_nee.data("event_start_date").split(/\-|\:|\s/);
            d = new Date(start_datetime_obj[0],start_datetime_obj[1]-1,start_datetime_obj[2]);
            if(typeof _short_date_format != "undefined" && typeof _locale != "undefined")
            {
                time_str = parseday(d,_short_date_format,_locale) + "-" + end_hour_str + ":" + end_minute_str;
            }
            dd_tooltip = jQuery("#ddtooltip");
            dd_tooltip.html(time_str);
            //tooltip position
            dd_tooltip.css("top", ev.pageY + 10);
            if(ev.pageX + dd_tooltip.width() > x_array[x_array_count-1] )
            {
                dd_tooltip.css("left", ev.pageX - 20 - dd_tooltip.width() );
            }
            else
            {
                dd_tooltip.css("left", ev.pageX + 10);
            }
        },
        stop: function(ev, ui){
            resizing = 0;
            showing = 1;
            disable_tooltip = 0;
            var this_obj = jQuery(this);
            var this_nee = this_obj.find("div.normalEventElement");
            if(typeof plid != "undefined" && plid != "")
            {
                pid = plid;
            }
            else
            {
                pid = "";
            }
            jQuery("#ddtooltip").remove();
            //append popup
            body_obj.append('<div id="ddpopup"></div>');
            var ddpopup_obj = jQuery("#ddpopup");
            ddpopup_obj.append(_popup_loading);
            ddpopup_obj.css({'position':'absolute',"top":((window_obj.height() - ddpopup_obj.outerHeight()) / 2) + window_obj.scrollTop() + "px","left":((window_obj.width() - ddpopup_obj.width()) / 2) + window_obj.scrollLeft() + "px"});
            //show popup
            show_popup("ddpopup", ev.pageX, ev.pageY);
            ddpopup_obj.css("display","inline");
            var div_overlay = jQuery('<div class="ddoverlay" id="overlay"/>').css({'width':document_obj.width()+'px','height':document_obj.height()+'px'});
            jQuery('body').append(div_overlay);
            setTimeout(function(){
                if(jQuery("a.btn_cancel").length){
                    jQuery("a.btn_cancel").focus();}
            },100);
            //event
            _event = this_nee.data("event_id");
            //date
            _bdate = this_nee.data("event_bdate");
            _sdate = this_nee.data("event_start_date");
            _sdate = _sdate.substr(0,10);
            _edate = this_nee.data("event_end_date");
            _edate = _edate.substr(0,10);
            //time
            x_target_pos = this_obj.position().left;
            start_datetime_obj = this_nee.data("event_start_date").split(/\-|\:|\s/);
            end_datetime_obj = this_nee.data("event_end_date").split(/\-|\:|\s/);
            //right resize
            _start_hour = parseInt(start_datetime_obj[3],10);
            _start_minute = parseInt(start_datetime_obj[4],10);
            time_pos = x_array_count-1;
            for(var i=1; i<x_array_count; i++)
            {
                if(x_target_pos + ui.size.width <= x_array[i]-1){
                    time_pos = i;
                    break;
                }
            }
            set_hour = this_nee.data("event_set_hour");
            unit = this_nee.data("event_unit");
            _end_minute = (parseInt(time_pos,10) * parseInt(unit,10));
            _end_hour = parseInt(set_hour,10) + Math.floor(parseInt(_end_minute,10)/60);
            _end_minute = parseInt(_end_minute,10)%60;
            if(_start_hour >= 24)
            {
                _start_hour -= 24;
            }
            if( (parseInt(start_datetime_obj[3],10) == _start_hour) && (parseInt(start_datetime_obj[4],10) == _start_minute) && (parseInt(end_datetime_obj[3],10) == _end_hour) && (parseInt(end_datetime_obj[4],10) == _end_minute) )
            {
                if(typeof plid != "undefined" && plid != "")
                {
                    dd_remove(plid);
                    dd_init("",plid);
                    dd_handle(plid);
                }
                else
                {
                    dd_remove();
                    dd_init();
                    dd_handle();
                }
                return;
            }
            //hide ddtd
            var ddtd_id = this_obj.prop("id").substr(7);
            var this_ddtd = _portal_frame.find("td.ddtd"+ddtd_id);
            this_ddtd.addClass("ddtd_remove");
            var ddtd_remove = _portal_frame.find("td.ddtd_remove");
            ddtd_remove.removeClass("ddtd");
            ddtd_remove.removeClass("ddtd_middle");
            ddtd_remove.removeClass("group_day_calendar_item");
            ddtd_remove.removeClass("group_day_calendar_color_booked");
            ddtd_remove.removeClass("ddtd_hide");
            if(ddtd_remove.hasClass("group_day_calendar_item_conflicted"))
            {
                ddtd_remove.removeClass("group_day_calendar_item_conflicted");
                ddtd_remove.addClass("group_day_calendar_color_conflicted_line");
            }
            ddtd_remove.find("div.normalEventElement").css("visibility","hidden");
            if(this_ddtd.prev().hasClass("group_day_calendar_event_cell"))
            {
                this_ddtd.addClass("ddtd_prev_event_cell");
            }
            else
            {
                this_ddtd.addClass("ddtd_prev_item");
            }
            if(this_ddtd.next().hasClass("group_day_calendar_color_conflicted_line") || this_ddtd.next().hasClass("group_day_calendar_color_available"))
            {
                this_ddtd.next().addClass("ddtd_next");
            }
            this_obj.css({"padding-left" : "1px", "position" : "absolute"});
            this_obj.attr("data-left_position", 0);
            this_obj.attr("data-duration", time_pos);
            var tr = _portal_frame.find("table.day_table").find("tr");
            for(var i=0; i<tr.length; i++)
            {
                if(tr.eq(i).hasClass("day_table_time_login")){continue;}
                if((this_obj.position().top + (this_obj.height()/2) > tr.eq(i).position().top) && (this_obj.position().top + (this_obj.height()/2) < tr.eq(i).position().top + tr.eq(i).height()))
                {
                    this_obj.attr("data-top_position", i);
                    break;
                }
            }
            this_obj.removeClass("dddummy");
            //ajax
            jQuery.ajax({
                url: _url_ajax_checking,
                data: {
                    event_id: _event,
                    bdate: _bdate,
                    end_date: _edate,
                    start_date: _sdate,
                    start_hour: _start_hour,
                    start_minute: _start_minute,
                    end_hour: _end_hour,
                    end_minute: _end_minute
                },
                type: "POST",
                success: function(xhr,textStatus,jqXHR ){
                    if (grn.component.error_handler.hasCybozuError(jqXHR))
                    {
                        GRN_ScheduleSimpleAdd.showErrMsg(jqXHR);
                        return;
                    }
                    if (grn.component.error_handler.hasCybozuLogin(jqXHR))
                    {
                        location.href = location.href;
                        return;
                    }
                    jQuery("#ddpopup").html(xhr);
                },
                error: function(jqXHR,textStatus,errorThrown){
                    GRN_ScheduleSimpleAdd.showErrMsg(jqXHR);
                },
                complete: function(xhr, status){
                    setTimeout(function(){
                        if(jQuery(".aButtonStandard-grn").find("a.btn_yes").length){
                            jQuery("a.btn_yes").focus();}
                        else if(jQuery("a.btn_cancel").length){
                            jQuery("a.btn_cancel").focus();}
                    },100);
                }
            });
        }
    });
    _portal_frame.find("div.dddummy").mouseover(function(){
        if((!resizing) && (!moving))
        {
            jQuery(this).addClass("dddummy_over");
            jQuery(this).find("div.ddimg1").removeClass("ddimg_none");
            jQuery(this).find("div.ddimg2").removeClass("ddimg_none");
        }
    });
    _portal_frame.find("div.dddummy").mouseout(function(){
        if((!resizing) && (!moving))
        {
            jQuery(this).removeClass("dddummy_over");
            jQuery(this).find("div.ddimg1").addClass("ddimg_none");
            jQuery(this).find("div.ddimg2").addClass("ddimg_none");
        }
    });
}

function show_popup(id,x,y)
{
    var w = jQuery("#"+id).width(),
        h = jQuery("#"+id).height();
    var viewportW = jQuery(window).width() + jQuery(window).scrollLeft();
        viewportH = jQuery(window).height() + jQuery(window).scrollTop();
        scrollTop = jQuery(window).scrollTop();
    var maxLeft = (x > viewportW) ? viewportW : x,
        maxTop = (y > viewportH) ? viewportH : y;
    var left = maxLeft - w/2,
        top = maxTop - h;
    if (left + w >= viewportW) {
        left = viewportW - w - 2;
    }
    if (left < 0){
        left = 0;
    }
    if (top < scrollTop + 30)
    {
        top = scrollTop + 30;
    }
    if(top > viewportH)
    {
        top = viewportH - h - 10;
    }
    jQuery("#"+id).css({"top":top, "left":left});
}
function ddpopup_form_submit()
{
    jQuery.each(jQuery(".alter_fid"), function(k, v){
        if( jQuery(this).is(':checked') )
        {
            _alter_fids += jQuery(this).val() + ",";
        }
    });

    jQuery.ajax({
        url: _url_ajax_command,
        data: {
            csrf_ticket: _csrf_ticket,
            event_id: _event,
            bdate: _bdate,
            end_date: _edate,
            start_date: _sdate,
            start_hour: _start_hour,
            start_minute: _start_minute,
            end_hour: _end_hour,
            end_minute: _end_minute,
            conflict_fids: _conflict_fids,
            alter_fids: _alter_fids
        },
        type: "POST",
        success: function(response,textStatus,jqXHR){
            if (grn.component.error_handler.hasCybozuError(jqXHR))
            {
                GRN_ScheduleSimpleAdd.showErrMsg(jqXHR);
                return;
            }
            if (grn.component.error_handler.hasCybozuLogin(jqXHR))
            {
                location.href = location.href;
                return;
            }
            _json = JSON.parse(response || "null");
        },
        error: function(jqXHR,textStatus,errorThrown){
            GRN_ScheduleSimpleAdd.showErrMsg(jqXHR);
        },
        complete: function( jqXHR,textStatus){
            if (grn.component.error_handler.hasCybozuError(jqXHR) || grn.component.error_handler.hasCybozuLogin(jqXHR))
            {
                return;
            }
            if(typeof pid == "undefined")
            {
                dd_remove_before_sync();
                syncEventList();
            }
           else
            {
                dd_remove_before_sync(pid);
                syncEventList(pid);
            }
        }
    });
}
function ddpopup_cancel()
{
    if(typeof pid == "undefined")
    {
        dd_remove();
        dd_init();
        dd_handle();
    }
    else
    {
        dd_remove(pid);
        dd_init("",pid);
        dd_handle(pid);
    }
}
function enable_update_button(enable)
{
    if(enable)
    {
        jQuery("#span_update").addClass("aButtonStandard-grn").removeClass("aButtonStandardDisable-grn");
    }
    else
    {
        jQuery("#span_update").addClass("aButtonStandardDisable-grn").removeClass("aButtonStandard-grn");
    }
}
GRN_DateResource = (function() {
    return {
        'en' : {
            'wdayfull0'    : 'Sunday',//日
            'wdayfull1'    : 'Monday',//月
            'wdayfull2'    : 'Tuesday',//火
            'wdayfull3'    : 'Wednesday',//水
            'wdayfull4'    : 'Thursday',//木
            'wdayfull5'    : 'Friday',//金
            'wdayfull6'    : 'Saturday',//土
            'wdayshort0'   : 'Sun',
            'wdayshort1'   : 'Mon',
            'wdayshort2'   : 'Tue',
            'wdayshort3'   : 'Wed',
            'wdayshort4'   : 'Thu',
            'wdayshort5'   : 'Fri',
            'wdayshort6'   : 'Sat',
            'monthfull1'   : 'January',//1月
            'monthfull2'   : 'February',//2月
            'monthfull3'   : 'March',//3月
            'monthfull4'   : 'April',//4月
            'monthfull5'   : 'May',//5月
            'monthfull6'   : 'June',//6月
            'monthfull7'   : 'July',//7月
            'monthfull8'   : 'August',//8月
            'monthfull9'   : 'September',//9月
            'monthfull10'  : 'October',//10月
            'monthfull11'  : 'November',//11月
            'monthfull12'  : 'December',//12月
            'monthshort1'  : 'Jan',//1月
            'monthshort2'  : 'Feb',//2月
            'monthshort3'  : 'Mar',//3月
            'monthshort4'  : 'Apr',//4月
            'monthshort5'  : 'May',//5月
            'monthshort6'  : 'Jun',//6月
            'monthshort7'  : 'Jul',//7月
            'monthshort8'  : 'Aug',//8月
            'monthshort9'  : 'Sep',//9月
            'monthshort10' : 'Oct',//10月
            'monthshort11' : 'Nov',//11月
            'monthshort12' : 'Dec'//12月
        },
        'ja' : {
            'wdayfull0'    : '日',//日
            'wdayfull1'    : '月',//月
            'wdayfull2'    : '火',//火
            'wdayfull3'    : '水',//水
            'wdayfull4'    : '木',//木
            'wdayfull5'    : '金',//金
            'wdayfull6'    : '土',//土
            'wdayshort0'   : '日',//日
            'wdayshort1'   : '月',//月
            'wdayshort2'   : '火',//火
            'wdayshort3'   : '水',//水
            'wdayshort4'   : '木',//木
            'wdayshort5'   : '金',//金
            'wdayshort6'   : '土',//土
            'monthfull1'   : '1',
            'monthfull2'   : '2',
            'monthfull3'   : '3',
            'monthfull4'   : '4',
            'monthfull5'   : '5',
            'monthfull6'   : '6',
            'monthfull7'   : '7',
            'monthfull8'   : '8',
            'monthfull9'   : '9',
            'monthfull10'  : '10',
            'monthfull11'  : '11',
            'monthfull12'  : '12',
            'monthshort1'  : '1',
            'monthshort2'  : '2',
            'monthshort3'  : '3',
            'monthshort4'  : '4',
            'monthshort5'  : '5',
            'monthshort6'  : '6',
            'monthshort7'  : '7',
            'monthshort8'  : '8',
            'monthshort9'  : '9',
            'monthshort10' : '10',
            'monthshort11' : '11',
            'monthshort12' : '12'
        },
        'zh' : {
            'wdayfull0'  : '星期天',//日
            'wdayfull1'  : '星期一',//月
            'wdayfull2'  : '星期二',//火
            'wdayfull3'  : '星期三',//水
            'wdayfull4'  : '星期四',//木
            'wdayfull5'  : '星期五',//金
            'wdayfull6'  : '星期六',//土
            'wdayshort0' : '周日',//日
            'wdayshort1' : '周一',//月
            'wdayshort2' : '周二',//火
            'wdayshort3' : '周三',//水
            'wdayshort4' : '周四',//木
            'wdayshort5' : '周五',//金
            'wdayshort6' : '周六',//土
            'monthfull1'   : '1',//1月
            'monthfull2'   : '2',//2月
            'monthfull3'   : '3',//3月
            'monthfull4'   : '4',//4月
            'monthfull5'   : '5',//5月
            'monthfull6'   : '6',//6月
            'monthfull7'   : '7',//7月
            'monthfull8'   : '8',//8月
            'monthfull9'   : '9',//9月
            'monthfull10'  : '10',//10月
            'monthfull11'  : '11',//11月
            'monthfull12'  : '12',//12月
            'monthshort1'  : '1',//1月
            'monthshort2'  : '2',//2月
            'monthshort3'  : '3',//3月
            'monthshort4'  : '4',//4月
            'monthshort5'  : '5',//5月
            'monthshort6'  : '6',//6月
            'monthshort7'  : '7',//7月
            'monthshort8'  : '8',//8月
            'monthshort9'  : '9',//9月
            'monthshort10' : '10',//10月
            'monthshort11' : '11',//11月
            'monthshort12' : '12'//12月
        },
        'zh-tw' : {
            'wdayfull0'  : '星期天',//日
            'wdayfull1'  : '星期一',//月
            'wdayfull2'  : '星期二',//火
            'wdayfull3'  : '星期三',//水
            'wdayfull4'  : '星期四',//木
            'wdayfull5'  : '星期五',//金
            'wdayfull6'  : '星期六',//土
            'wdayshort0' : '週日',//日
            'wdayshort1' : '週一',//月
            'wdayshort2' : '週二',//火
            'wdayshort3' : '週三',//水
            'wdayshort4' : '週四',//木
            'wdayshort5' : '週五',//金
            'wdayshort6' : '週六',//土
            'monthfull1'   : '1',//1月
            'monthfull2'   : '2',//2月
            'monthfull3'   : '3',//3月
            'monthfull4'   : '4',//4月
            'monthfull5'   : '5',//5月
            'monthfull6'   : '6',//6月
            'monthfull7'   : '7',//7月
            'monthfull8'   : '8',//8月
            'monthfull9'   : '9',//9月
            'monthfull10'  : '10',//10月
            'monthfull11'  : '11',//11月
            'monthfull12'  : '12',//12月
            'monthshort1'  : '1',//1月
            'monthshort2'  : '2',//2月
            'monthshort3'  : '3',//3月
            'monthshort4'  : '4',//4月
            'monthshort5'  : '5',//5月
            'monthshort6'  : '6',//6月
            'monthshort7'  : '7',//7月
            'monthshort8'  : '8',//8月
            'monthshort9'  : '9',//9月
            'monthshort10' : '10',//10月
            'monthshort11' : '11',//11月
            'monthshort12' : '12'//12月
        }
    };
})();
function parseday(datetime,pattern,locale)
{
    var string_day;
    if(datetime.getDate() < 10)
    {
        string_day = pattern.replace('&&mday&&','0' + datetime.getDate());
    }
    else
    {
        string_day = pattern.replace('&&mday&&',datetime.getDate());
    }
    if(datetime.getMonth() + 1 < 10)
    {
        string_day = string_day.replace('&&mon&&','0' + (datetime.getMonth() + 1));
    }
    else
    {
        string_day = string_day.replace('&&mon&&',datetime.getMonth() + 1);
    }
    string_day = string_day.replace('&&monthfull&&',GRN_DateResource[locale]['monthfull' + (datetime.getMonth() + 1)]);
    string_day = string_day.replace('&&year&&',datetime.getFullYear());
    string_day = string_day.replace('&&wdayshort&&',GRN_DateResource[locale]['wdayshort' + datetime.getDay()]);
    string_day = string_day.replace('&&wdayfull&&',GRN_DateResource[locale]['wdayfull' + datetime.getDay()]);
    return string_day;
}

/**
 * The function to rebuild tooltip of the event title on appointment lists
 * @param {string} portlet_id
 */
function rebuild_popup_title(portlet_id) {
    var is_show_tooltip = function (checkbox_id) {
        var $checkbox = jQuery("#" + checkbox_id);
        return ($checkbox.length > 0 && !$checkbox.checked);
    };
    var id_full_title;

    if (typeof portlet_id === "undefined" || portlet_id === "") {
        id_full_title = "show_full_titlepersonal_month";
        if (is_show_tooltip(id_full_title)) {
            showFullShortTitle(id_full_title, "personal_month_calendar", "personal_month", false);
        }
        return;
    }

    id_full_title = "show_full_titleportlet_personal_month" + portlet_id;
    if (is_show_tooltip(id_full_title)) {
        showFullShortTitle(id_full_title, "view_personal_month_calendar" + portlet_id, "portlet_personal_month", false);
        return;
    }

    id_full_title = "show_full_title" + portlet_id;
    if (is_show_tooltip(id_full_title)) {
        showFullShortTitle(id_full_title, "event_list" + portlet_id, "view_group_day", false);
    }
}
