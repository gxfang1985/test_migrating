(function()
{
    if (grn.base.isNamespaceDefined("grn.component.msgbox_mobile"))
    {
        return;
    }

    grn.base.namespace("grn.component.msgbox_mobile");

    var G = grn.component.msgbox_mobile;

    G.MsgBox = {
        default_settings: {
            caption:    { ok: 'OK', cancel: 'Cancel', yes: 'Yes', no: 'No' },
            ui:         { width: null, height: null },
            callback:   function(result, form){},
            html_id:    { overlay: 'overlay', msgbox: 'msgbox' }
        },

        // private properties
        settings: {},
        overlay: null,
        msgbox: null,
        loaded: false,

        // public methods
        show: function(message, title, type, options)
        {
            var title = title || '';
            var type = type || G.MsgBoxButtons.ok;
            if(typeof message == 'undefined') throw 'missing parameter "message"';

            // ----- private variables -----
            var fn = G.MsgBox;
            if (fn.loaded) return;

            var settings = {};
            jQuery.extend(settings, fn.default_settings);
            jQuery.extend(settings, options);
            fn.settings = settings;

            var body = jQuery('body');

            // ----- render layout ----- 
            var overlay = jQuery('<div id=' + settings.html_id.overlay + ' class="overlay-grn" style=""></div>');
            fn.overlay = overlay;
            body.append(overlay);

            var msgbox = jQuery('<div id=' + settings.html_id.msgbox + ' class="frame-message-grn"></div>');

            var ui = settings.ui;
            if(ui.width)  msgbox.css({width: ui.width});
            if(ui.height) msgbox.css({height: ui.height});

            var html = "";
            html += '<div><span class="bigicon-error-grn"></span>';
            html += '<span class="content-error-grn">' + message + '</span></div>';
            html += '<div class="mobile-buttonArea-grn">';

            if((type & G.MsgBoxResult.ok) == G.MsgBoxResult.ok)
            {
                html += '<div class="mobile-buttonNormal-grn button-grn">';
                html += '<input type="button" value="' + settings.caption.ok + '" data-inline="true" id="' + settings.html_id.msgbox + '_btn_ok"/></div>';
            }
            if((type & G.MsgBoxResult.yes) == G.MsgBoxResult.yes)
            {
                html += '<div class="mobile-buttonNormal-grn button-grn">';
                html += '<input type="button" value="' + settings.caption.yes + '" data-inline="true" id="' + settings.html_id.msgbox + '_btn_yes"/></div>';
            }
            if((type & G.MsgBoxResult.no) == G.MsgBoxResult.no)
            {
                html += '<div class="mobile-buttonNormal-grn button-grn">';
                html += '<input type="button" value="' + settings.caption.no + '" data-inline="true" id="' + settings.html_id.msgbox + '_btn_no"/></div>';
            }
            if((type & G.MsgBoxResult.cancel) == G.MsgBoxResult.cancel)
            {
                html += '<div class="mobile-buttonNormal-grn button-grn">';
                html += '<input type="button" value="' + settings.caption.cancel + '" data-inline="true" id="' + settings.html_id.msgbox + '_btn_cancel"/></div>';
            }
            html += "</div>";

            msgbox.html(html);
            fn.msgbox = msgbox;

            msgbox.css({top: 0, left: 0});
            body.append(msgbox.trigger('create'));

            // set position
            fn._setPosition();

            if((type & G.MsgBoxResult.ok) == G.MsgBoxResult.ok)
                $(document).on("click", "#" + settings.html_id.msgbox + "_btn_ok", function(){fn._callback(G.MsgBoxResult.ok);});
            if((type & G.MsgBoxResult.cancel) == G.MsgBoxResult.cancel)
                $(document).on("click", "#" + settings.html_id.msgbox + "_btn_cancel", function(){fn._callback(G.MsgBoxResult.cancel);});
            if((type & G.MsgBoxResult.yes) == G.MsgBoxResult.yes)
                $(document).on("click", "#" + settings.html_id.msgbox + "_btn_yes", function(){fn._callback(G.MsgBoxResult.yes);});
            if((type & G.MsgBoxResult.no) == G.MsgBoxResult.no)
                $(document).on("click", "#" + settings.html_id.msgbox + "_btn_no", function(){fn._callback(G.MsgBoxResult.no);});

            fn.loaded = true;
        },
        show_error: function(message, title, type, options)
        {
            var title = '';
            var type = type || G.MsgBoxButtons.ok;
            if(typeof message == 'undefined') throw 'missing parameter "message"';

            // ----- private variables -----
            var fn = G.MsgBox;
            if (fn.loaded) return;

            var settings = {};
            jQuery.extend(settings, fn.default_settings);
            jQuery.extend(settings, options);
            fn.settings = settings;

            var body = jQuery('body');

            // ----- render layout -----
            var overlay = jQuery('<div id=' + settings.html_id.overlay + ' class="overlay-grn" style=""></div>');
            fn.overlay = overlay;
            body.append(overlay);

            var msgbox = jQuery('<div id=' + settings.html_id.msgbox + ' class="farm-message-grn mobile_titlebar_div_grn mobile_error_div_grn"></div>');

            var ui = settings.ui;
            if(ui.width)  msgbox.css({width: ui.width});
            if(ui.height) msgbox.css({height: ui.height});

            msgbox.html(message);
            fn.msgbox = msgbox;

            msgbox.css("z-index", 1001);
            body.append(msgbox.trigger('create'));

            // set height and width
            body.scrollTop(0);
            fn.setArea();
            fn.adjustPosition();
            jQuery(window).resize(function(){
                fn.setArea();
                fn.adjustPosition();
            });
            jQuery(window).scroll(function(){
                fn.adjustPosition();
            });
            if((type & G.MsgBoxResult.ok) == G.MsgBoxResult.ok)
                $(document).on("click", "#" + settings.html_id.msgbox + "_btn_ok", function(){fn._callback(G.MsgBoxResult.ok);});
            if((type & G.MsgBoxResult.cancel) == G.MsgBoxResult.cancel)
                $(document).on("click", "#" + settings.html_id.msgbox + "_btn_cancel", function(){fn._callback(G.MsgBoxResult.cancel);});
            if((type & G.MsgBoxResult.yes) == G.MsgBoxResult.yes)
                $(document).on("click", "#" + settings.html_id.msgbox + "_btn_yes", function(){fn._callback(G.MsgBoxResult.yes);});
            if((type & G.MsgBoxResult.no) == G.MsgBoxResult.no)
                $(document).on("click", "#" + settings.html_id.msgbox + "_btn_no", function(){fn._callback(G.MsgBoxResult.no);});

            fn.loaded = true;
        },

        showDeleteConfirm: function(message, options)
        {
            var type = G.MsgBoxButtons.yesno;
            if (typeof message === "undefined")
            {
                throw 'missing parameter "message"';
            }

            // ----- private variables -----
            var fn = G.MsgBox;
            if (fn.loaded)
            {
                return;
            }

            var settings = {};
            jQuery.extend(settings, fn.default_settings);
            jQuery.extend(settings, options);
            fn.settings = settings;

            var body = jQuery("body");

            // ----- render layout -----
            var overlay = jQuery('<div id=' + settings.html_id.overlay + ' class="overlay-grn" style="height: 100%; width: 100%"></div>');
            fn.overlay = overlay;
            body.find("div.ui-page-active[data-role=page]").append(overlay);

            var msgbox = jQuery('<div id=' + settings.html_id.msgbox + ' class="mobile_titlebar_div_grn mobile_delete_confirm_div_grn"></div>');

            msgbox.html(message);
            fn.msgbox = msgbox;

            msgbox.css("z-index", 1006);
            overlay.css("z-index", 1005);
            body.find("div.ui-page-active[data-role=page]").append(msgbox).trigger('create');

            // set height and width
            fn.setArea();
            fn.adjustPosition();
            jQuery(window).resize(function(){
                fn.setArea();
                fn.adjustPosition();
            });

            jQuery(window).scroll(function(){
                fn.adjustPosition();
            });

            if ((type & G.MsgBoxResult.yes) == G.MsgBoxResult.yes)
            {
                $(document).on("click", "#" + settings.html_id.msgbox + "_btn_yes", function()
                {
                    fn._callback(G.MsgBoxResult.yes);
                });
            }
            if ((type & G.MsgBoxResult.no) == G.MsgBoxResult.no)
            {
                $(document).on("click", "#" + settings.html_id.msgbox + "_btn_no", function()
                {
                    fn._callback(G.MsgBoxResult.no);
                });
            }

            fn.loaded = true;
        },

        showAttendanceCheck: function(message, options)
        {
            var type = G.MsgBoxButtons.yesno;
            if (typeof message === "undefined")
            {
                throw 'missing parameter "message"';
            }

            // ----- private variables -----
            var fn = G.MsgBox;
            if (fn.loaded)
            {
                return;
            }

            var settings = {};
            jQuery.extend(settings, fn.default_settings);
            jQuery.extend(settings, options);
            fn.settings = settings;

            var body = jQuery("body");

            // ----- render layout -----
            var overlay = jQuery('<div id=' + settings.html_id.overlay + ' class="overlay-grn" style="height: 100%; width: 100%"></div>');
            fn.overlay = overlay;
            body.find("div.ui-page-active[data-role=page]").append(overlay);

            var msgbox = jQuery('<div id=' + settings.html_id.msgbox + ' class="mobile_titlebar_div_grn mobile_delete_confirm_div_grn"></div>');

            msgbox.html(message);
            fn.msgbox = msgbox;

            msgbox.css("z-index", 1006);
            overlay.css("z-index", 1005);
            body.find("div.ui-page-active[data-role=page]").append(msgbox);

            // set height and width
            fn.setArea();
            fn.adjustPosition();
            jQuery(window).resize(function(){
                fn.setArea();
                fn.adjustPosition();
            });

            jQuery(window).scroll(function(){
                fn.adjustPosition();
            });

            if ((type & G.MsgBoxResult.yes) == G.MsgBoxResult.yes)
            {
                $(document).on("click", "#" + settings.html_id.msgbox + "_btn_yes", function()
                {
                    fn._callback(G.MsgBoxResult.yes);
                });
            }
            if ((type & G.MsgBoxResult.no) == G.MsgBoxResult.no)
            {
                $(document).on("click", "#" + settings.html_id.msgbox + "_btn_no", function()
                {
                    fn._callback(G.MsgBoxResult.no);
                });
            }

            fn.loaded = true;
        },

        setArea: function()
        {
            with(this)
            {
                var height = jQuery(window).height() - msgbox.find("div.mobile_titlebar_grn").height() - 24;
                var width = jQuery(window).width() - 20;
                msgbox.find("div.mobile_ul_grn").css({height: height, width: width});
            }
        },

        adjustPosition: function()
        {
            with(this)
            {
                msgbox.css({top: jQuery(window).scrollTop()});
            }
        },

        close: function()
        {
            with(this)
            {
                _remove();
            }
        },

        // private methods
        _setPosition: function()
        {
            with(this)
            {
                overlay.css({width : jQuery('html').width(), height : jQuery('html').height()});
                msgbox.css({top: (jQuery(window).height() - msgbox.height())/2 + jQuery(window).scrollTop() - 30,
                            left: (jQuery(window).width() - msgbox.width())/2 - 30});
            }
        },

        _callback: function(result)
        {
            with(this)
            {
                var form = msgbox.find("form") || null; //get form
                settings.callback(result, form);
                if( result == G.MsgBoxResult.no || result == G.MsgBoxResult.cancel )
                    _remove();
            }
        },

        _remove: function()
        {
            with(this)
            {
                overlay.remove();
                msgbox.remove();
                loaded = false;
            }
        }
    };

    G.MsgBoxResult  = { ok: 1, cancel: 2, yes: 4, no: 8 };
    G.MsgBoxButtons = { ok: G.MsgBoxResult.ok,
                        okcancel: G.MsgBoxResult.ok | G.MsgBoxResult.cancel,
                        yesno: G.MsgBoxResult.yes | G.MsgBoxResult.no,
                        yesnocancel: G.MsgBoxResult.yes | G.MsgBoxResult.no | G.MsgBoxResult.cancel };
})();