grn.base.namespace("grn.component.editor");

(function ($) {
    var ed = grn.component.editor;

    /**
     * @param {string} id
     * @param {string} switch_name
     * @param {number} settings_type
     * @constructor
     */
    ed.Editor = function (id, switch_name, settings_type) {
        this.events_ = $({});
        this.editor_id_ = id;
        this.element_ = $('#' + id);
        this.on_radio_element_ = $('#' + switch_name + '_on');
        this.off_radio_element_ = $('#' + switch_name + '_off');

        if (this.element_.length === 0 || this.off_radio_element_.length === 0) {
            return;
        }

        var settings_type_ = settings_type ? settings_type : 0;
        this.settings_ = ed.Editor.SETTINGS_MAP[settings_type_];
        this.settings_['language'] = ed.Editor.LANGUAGE_MAP[ed.Editor.locale] || "en";

        if( ed.Editor.allowed &&
            this.on_radio_element_.length > 0 &&
            typeof tinymce !== "undefined") {
            // setup rich editor for support browsers
            this.updateStatus_(true); // init tinymce
            this.on_radio_element_.on('click', ed.Editor.prototype.updateStatus_.bind(this));
            this.off_radio_element_.on('click', ed.Editor.prototype.updateStatus_.bind(this));
        }

        if (this.off_radio_element_.prop("checked")) {
            if (this.element_.val() === "") {
                // load initial value for support/nonsupport browsers
                this.element_.val( $('#' + ed.Editor.INITIAL_TEXTAREA_PREFIX + id).val() );
                this.resize();
            } /* else {
                // chrome and IE6 cache html form data, when back button is clicked.
            } */
        }

        ed.Editor.instances.push(this);
    };

    /**
     *
     * @type {Array.<grn.component.editor.Editor>}
     */
    ed.Editor.instances = [];

    /**
     *
     * @param {string} id
     * @return {grn.component.editor.Editor|undefined}
     */
    ed.Editor.getInstanceById = function (id) {
        var ed_editor;
        $.each(grn.component.editor.Editor.instances, function (i, item) {
            if (item.editor_id_ === id) {
                ed_editor = item;
                return false;
            }
        });
        return ed_editor;
    };

    /**
     * @type {String}
     */
    ed.Editor.INITIAL_TEXTAREA_PREFIX = 'initial_textarea_';

    ed.Editor.DEFAULT_SETTINGS_MIN_WIDTH = 420;
    ed.Editor.FULL_SETTINGS_MIN_WIDTH = 460;
    ed.Editor.NO_AUTORESIZE_SETTINGS_MIN_WIDTH = 420;
    ed.Editor.MIN_WIDTH_MAP = [
        ed.Editor.DEFAULT_SETTINGS_MIN_WIDTH,
        ed.Editor.FULL_SETTINGS_MIN_WIDTH,
        ed.Editor.NO_AUTORESIZE_SETTINGS_MIN_WIDTH
    ];

    ed.Editor.filePickerCallback_ = function(callback, value, meta)
    {
        var langCode = ed.Editor.LANGUAGE_MAP[ed.Editor.locale] || "en";
        tinymce.activeEditor.windowManager.open({
            title: tinymce.i18n.data[langCode].grn_common.select_image,
            url: ed.Editor.image_upload_url,
            width: 500,
            height: 100
        }, {
            oninsert: function(image_url)
            {
                callback(image_url);
            }
        });
    };

    /**
     * @type {Object}
     */
    ed.Editor.DEFAULT_SETTINGS = {
        // General
        dialog_type : "modal",
        branding: false,
        object_resizing : false,
        menubar: false,
        toolbar_items_size: 'small',
        resize: 'both',
        elementpath: false,
        min_width: ed.Editor.DEFAULT_SETTINGS_MIN_WIDTH,

        plugins: "grn_langs,tabfocus,autoresize,lists,preview,contextmenu,table,colorpicker,textcolor,link,grn_contextmenu,grn_table",

        contextmenu: "link unlink | inserttable deletetable fillcolor bordercolor",

        fontsize_formats: "8px 12px 14px 18px 22px 26px 32px",
        file_browser_callback_types: 'image',

        toolbar1: "fontsizeselect |  bold italic underline strikethrough | forecolor backcolor | removeformat",
        toolbar2: "bullist numlist | alignleft aligncenter alignright | outdent indent blockquote | link unlink | grn_table | preview",

        element_format : 'html',
        forced_root_block : 'div',  //'p'->'div'
        formats : {
            // style of blockquote should be same as source/code/include/mail/include_send.csp
            'blockquote' : {
                block: 'blockquote',
                classes : 'blockquote_grn',
                attributes : { style:'border-left: 2px solid #C9C9C9; margin: 0 0 0 10px; padding-left: 10px;' },
                wrapper : 1,
                remove : 'all'
            }
        },

        // URL
        convert_urls : false,

        // Layout
        body_class: 're_content',

        // Visual aids
        visual : false,

        // Other options
        paste_webkit_styles: "all",
        paste_retain_style_properties : "all",
        paste_enable_default_filters: false,
        autoresize_bottom_margin : 30
    };

    /**
     * @type {Object}
     */
    ed.Editor.FULL_SETTINGS = (function(){
        var settings = $.extend({}, ed.Editor.DEFAULT_SETTINGS);
        settings['min_width'] = ed.Editor.FULL_SETTINGS_MIN_WIDTH;
        settings['plugins'] += ", image";
        settings['image_advtab'] = true;
        settings['toolbar2'] = "bullist numlist | alignleft aligncenter alignright | outdent indent blockquote | link unlink | grn_table | image | preview";
        settings['file_picker_callback'] = ed.Editor.filePickerCallback_;
        settings['contextmenu'] = "link unlink | image | inserttable deletetable fillcolor bordercolor";
        return settings;
    }());

    /**
     * @type {Object}
     */
    ed.Editor.NO_AUTORESIZE_SETTINGS = (function(){
        var settings = $.extend({}, ed.Editor.DEFAULT_SETTINGS);
        settings['plugins'] = "grn_langs,tabfocus,colorpicker,textcolor,lists,preview,contextmenu,table,link,grn_contextmenu,grn_table";
        settings['height'] = "640";
        return settings;
    }());

    /**
     * @type {Array.<object>}
     */
    ed.Editor.SETTINGS_MAP = [
        ed.Editor.DEFAULT_SETTINGS,
        ed.Editor.FULL_SETTINGS,
        ed.Editor.NO_AUTORESIZE_SETTINGS
    ];

    /**
     * @type {Array.<string, string>}
     */
    ed.Editor.LANGUAGE_MAP = {
        // garoon language code : tinymce language pack name
        'ja' : 'ja',
        'en' : 'en',
        'zh' : 'zh',
        'zh-tw' : 'zh-tw'
    };

    /**
     *
     * @param {string} id
     * @param {Object} settings
     * @returns {tinymce.Editor}
     * @param {?boolean} opt_load_from_initial_value
     * @private
     */
    ed.Editor.create_ = function (id, settings, opt_load_from_initial_value) {
        var element = $('#' + id);
        var settings_ = $.extend({}, settings);
        var min_height = element.css('minHeight');
        if (min_height) {
            element.css({ 'height' :'0px' });
            settings_['autoresize_min_height'] = min_height;
        }

        var plaintext_width = element.outerWidth();
        var min_width = ed.Editor.MIN_WIDTH_MAP[ed.Editor.setting_type];
        settings_["width"] = plaintext_width < min_width ? min_width : plaintext_width;

        settings_['autoresize_on_init'] = false;
        settings_['grn_color_palette'] = ed.Editor.grn_color_palette;
        var font_css_url = grn.component.url.staticUrl('grn/html/font-' + ed.Editor.locale + '.css');
        var std_css_url = grn.component.url.staticUrl('grn/html/std.css');
        var content_css_url = grn.component.url.staticUrl('grn/html/component/editor/content.css');
        settings_['content_css'] = [font_css_url, std_css_url, content_css_url].join(',');

        var editor = new tinymce.Editor(id, settings_, tinymce.EditorManager);
        if( ed.Editor.isEnableFileUpload(editor) )
        {
            editor.on("submit", function() {
                ed.Editor.addAttachedFileIds_(editor);
            });
        }
        editor.on("load", function() {
            setTimeout(function(){ed.Editor.execCommand_(editor,'mceAutoResize');},10);
        });

        editor.on("init", function() {

            if( opt_load_from_initial_value === true )
            {
                if( $('#' + id).val() === "" )
                {
                    editor.setContent($('#' + ed.Editor.INITIAL_TEXTAREA_PREFIX + id).val());
                } /* else {
                    // chrome and IE6 cache html form data, when back button is clicked.
                } */
            }
        });

        editor.render();

        return editor;
    };

    ed.Editor.execCommand_ = function (editor, cmd, ui, val, opt) {
        opt = opt || {};
        opt.skip_focus = 1;
        return editor.execCommand(cmd, ui, val, opt);
    };

    /**
     * @param {?boolean} opt_not_alert
     */
    ed.Editor.prototype.changePlainText = function (opt_not_alert) {
        var content, text, change = opt_not_alert || window.confirm(ed.Editor.confirm_message);
        if(change){
            if (this.editor_) {
                content = this.editor_.getContent({format:"raw"});
                text =  this.htmlToText_(content);
                this.editor_.remove();
                this.editor_ = null;
                this.element_.val( text );

                this.element_.trigger('grn.textarea:resize');

                this.events_.trigger("switch", { type: "PLAIN_TEXT" });
            }

            this.off_radio_element_.prop( "checked", true);
            this.element_.focus();
        } else {
            this.on_radio_element_.prop( "checked", true);
            this.on_radio_element_.focus();
        }
    };

    /**
     * @param {?boolean} opt_load_from_initial_value
     */
    ed.Editor.prototype.changeRichText = function (opt_load_from_initial_value) {
        if(this.editor_) {
            this.editor_.remove();
        }
        if (opt_load_from_initial_value !== true) {
            this.element_.val( this.textToHtml_(this.element_.val()) );
        }
        this.editor_ = ed.Editor.create_(this.editor_id_,this.settings_, opt_load_from_initial_value);
        this.on_radio_element_.prop( "checked", true );

        this.events_.trigger("switch", { type: "RICH_TEXT" });
    };

    /**
     * @param {?boolean} opt_first
     * @private
     */
    ed.Editor.prototype.updateStatus_ = function (opt_first) {
        var load_from_initial_value = opt_first === true;
        if (this.editor_) {
            if (this.off_radio_element_.prop("checked")) {
                this.changePlainText();
            }
        } else {
            if (this.on_radio_element_.prop("checked")) {
                this.changeRichText(load_from_initial_value);
            }
        }
    };

    /**
     * @param {string} text string
     * @returns {string}
     * @private
     */
    ed.Editor.prototype.textToHtml_ = function (text) {
        var html = text;
        html = html.replace( /&/g, "&amp;" );
        html = html.replace( /</g, "&lt;" );
        html = html.replace( />/g, "&gt;" );
        html = html.replace( /\"/g, "&quot;" );
        html = html.replace( / /g, "&nbsp;" );

        if ( grn.browser.msie ) {
            html = html.replace( /(\r?\n)/g, "</DIV>$1<DIV>" );
            html = "<DIV>"+html+"</DIV>";
            html = html.replace( /<DIV><\/DIV>/ig, "<DIV>&nbsp;</DIV>" );
        } else {
            html = html.replace( /(.*)(\r?\n)/g, "<DIV>$1<BR></DIV>" );
        }
        return html;
    };

    /**
     * @param {string} html string
     * @returns {string}
     * @private
     */
    ed.Editor.prototype.htmlToText_ = function (html) {
        var text = html;
        text = text.replace( /[\r\n]/g, "" );
        if (grn.browser.firefox) {
            text = text.replace( /<br\s+data-mce-bogus="[0-9]+">/g, "" );
        }

        var oBlocks = {
                "P":1,
                "H1":1, "H2":1, "H3":1, "H4":1, "H5":1, "H6":1,
                "OL":1, "UL":1, "DIR":1, "MENU":1, "DL":1,
                "LI":1, "DT":1, "DD":1,
                "PRE":1,
                "DIV":1, "NOSCRIPT":1, "BLOCKQUOTE":1, "TABLE":1, "FIELDSET":1, "ADDRESS":1,
                "CENTER":1,
                "ARTICLE":1, "ASIDE":1, "FIGCAPTION":1, "FIGURE":1, "FOOTER":1, "HEADER":1,
                "MAIN":1, "NAV":1, "SECTION":1, "TEMPLATE":1
            },

            oInlines = {
                "TT":1, "I":1, "B":1, "U":1, "S":1, "STRIKE":1, "BIG":1, "SMALL":1,
                "EM":1, "STRONG":1, "DFN":1, "CODE":1, "SAMP":1, "KBD":1, "VAR":1, "CITE":1,
                "ABBR":1, "ACRONYM":1,
                "A":1, "IMG":1, "APPLET":1, "OBJECT":1, "FONT":1, "BASEFONT":1, "SCRIPT":1,
                "MAP":1, "Q":1, "SUB":1, "SUP":1, "SPAN":1, "BDO":1, "IFRAME":1,
                "INPUT":1, "SELECT":1, "TEXTAREA":1, "LABEL":1, "BUTTON":1,
                "BLINK":1, "EMBED":1, "LAYER":1, "ILAYER":1, "NOLAYER":1, "NOBR":1,
                "WBR":1, "RUBY":1, "RB":1, "RP":1, "RT":1, "RTC":1,
                "SPACER":1,
                "AUDIO":1, "BDI":1, "CANVAS":1, "DATA":1, "DATALIST":1, "KEYGEN":1, "MARK":1, "METER":1, "OUTPUT":1, "PROGRESS":1,
                "SOURCE":1, "TIME":1, "TRACK":1, "VIDEO":1, "NOSCRIPT":1, "NOFRAMES":1, "NOEMBED":1
            },
            elm, re, d, lt, gt, i, j, r, m;

        function patBegin(e) {
            return "[ \t\f\v]*<" + e + "((\\s+[^>]*>)|(\\s*>))[ \t\f\v]*";
        }

        function patEnd(e) {
            return "[ \t\f\v]*</" + e + "\\s*>[ \t\f\v]*";
        }

        // インライン要素以外の直前のスペースを削除
        d = [];
        re = new RegExp( "[ \t\f\v]*</?([a-zA-Z]+)((\\s+[^>]*>)|(\\s*>))", "i" );
        while ((m = text.match(re))) {
            var match = m[0];
            elm = RegExp.$1;
            d.push( RegExp.leftContext );
            text = RegExp.rightContext;
            d.push( oInlines[elm.toUpperCase()] ? match : match.replace( /[ \t\f\v]*</g, "<" ) );
        }
        d.push( text );
        text = d.join("");

        // インライン要素以外の直後のスペースを削除
        d = [];
        re = new RegExp( "</?([a-zA-Z]+)((\\s+[^>]*>)|(\\s*>))[ \t\f\v]*", "i" );
        while ((m = text.match(re))) {
            var match = m[0];
            elm = RegExp.$1;
            d.push( RegExp.leftContext );
            text = RegExp.rightContext;
            d.push( oInlines[elm.toUpperCase()] ? match : match.replace( />[ \t\f\v]*/g, ">" ) );
        }
        d.push( text );
        text = d.join("");

        d = [];
        re = new RegExp( "</?([a-zA-Z]+)((\\s+[^>]*>)|(\\s*>))", "i" );
        while ((m = text.match(re))) {
            d.push( RegExp.leftContext );
            if( ! oInlines[RegExp.$1.toUpperCase()] ) d.push( m[0] );
            text = RegExp.rightContext;
        }
        d.push( text );
        text = d.join("");

        for (elm in oBlocks) {
            if( ! text.match( new RegExp( elm, "i" ) ) ) continue;

            re = new RegExp( patBegin(elm)+patEnd(elm), "ig" );
            text = text.replace( re, "" );

            d = [];
            re = new RegExp( "[^<>\\s]"+patBegin(elm), "im" );
            while ((m = text.match(re))) {
                d.push( RegExp.leftContext );
                m = m[0];
                lt = m.lastIndexOf( "<" );
                d.push( m.substring( 0, lt ) );
                d.push( "\n" );
                d.push( m.substr( lt ) );
                text = RegExp.rightContext;
            }
            d.push( text );
            text = d.join("");

            d = [];
            re = new RegExp( patEnd(elm)+"[^<\\s]", "im" );
            while ((m = text.match(re))) {
                d.push( RegExp.leftContext );
                m = m[0];
                if( oBlocks[RegExp.lastMatch] ) {
                    d.push( m );
                } else {
                    gt = m.indexOf(">");
                    d.push( m.substring( 0, gt + 1 ) );
                    d.push( "\n" );
                    d.push( m.substr( gt + 1 ) );
                }
                text = RegExp.rightContext;
            }
            d.push( text );
            text = d.join("");

            d = [];
            re = new RegExp( patEnd(elm)+patBegin("[a-zA-Z]+"), "im" );
            while ((m = text.match(re))) {
                d.push( RegExp.leftContext );
                m = m[0];
                gt = m.indexOf( ">" );
                d.push( m.substring( 0, gt + 1 ) );
                d.push( "\n" );
                d.push( m.substr( gt + 1 ) );
                text = RegExp.rightContext;
            }
            d.push( text );
            text = d.join("");
        }

        if (text.match(/TABLE/i)) {
            text = text.replace( /<\/TR\s*><TR((\s+[^>]*>)|(\s*>))/img, "\n" );
            text = text.replace( /<\/T[DH]\s*><T[DH]((\s+[^>]*>)|(\s*>))/img, " " );
        }

//        text = text.replace( /<BR((\s+[^>]*>)|(\s*>))/ig, "\n" );
//        text = text.replace( /<HR((\s+[^>]*>)|(\s*>))/ig, "\n" );

        d = [];
        var quote = new RegExp( "</?BLOCKQUOTE((\\s+[^>]*>)|(\\s*>))", "im" );
        while ((m = text.match(quote))) {
            d.push( RegExp.leftContext );
            d.push(m[0]);
            text = RegExp.rightContext;
            if (m[0].indexOf("</") == 0) {
                continue;
            }

            var depth = 1;
            while ((m = text.match(quote))) {
                var leftContext = RegExp.leftContext;
                var rightContext = RegExp.rightContext;
                var content = "> " + leftContext.replace( /\n/ig, "\n> ");
                d.push(content);
                d.push(m[0]);
                text = rightContext;
                if (m[0].indexOf("</") == 0) {
                    depth--;
                } else {
                    depth++;
                }
                if (depth == 0) break;
            }
        }
        d.push( text );
        text = d.join("");

        text = text.replace( /<[^>]*>/img, "" );
        text = text.replace( /&nbsp;/ig, " " );
        text = text.replace( /&lt;/ig, "<");
        text = text.replace( /&gt;/ig, ">");
        text = text.replace( /&quot;/ig, "\"");
        text = text.replace( /&amp;/ig, "&");

        return text;
    };

    ed.Editor.prototype.save = function () {
        if (this.editor_) {
            this.editor_.save();
        }
    };

    ed.Editor.prototype.clear = function () {
        if (this.editor_) {
            this.editor_.setContent('');
        }
        this.element_.val('');

        this.resize();
    };

    ed.Editor.prototype.resize = function () {
        if (this.editor_) {
            this.editor_.execCommand('mceAutoResize');
        }
        this.element_.trigger('grn.textarea:resize');
    };

    ed.Editor.prototype.on = function (name, callback) {
        this.events_.on(name, callback);
    };

    ed.Editor.prototype.getRichTextEditor = function () {
        return this.editor_;
    };

    /**
     * @param {tinyMCE.Editor} editor
     * @private
     */
    ed.Editor.addAttachedFileIds_ = function (editor) {
        var html, expr, re, images, fileids, j, image, equal, file_ids_element;
        if (!editor) {
            return;
        }

        html = editor.getContent({format:"raw"});

        expr = ed.Editor.image_download_url + '\\?fileid=[0-9]+';
        expr = expr.replace(/\//g, '\\/');
        expr = expr.replace(/\./g, '\\.');
        re = new RegExp(expr, 'g');

        images = html.match(re);
        if (images != null) {
            fileids = '';
            for (j = 0; j < images.length; ++j) {
                image = images[j];
                equal = image.lastIndexOf('=');
                fileids += ',' + image.substring(equal + 1);
            }
            fileids = fileids.substring(1);
            file_ids_element = document.createElement('input');
            file_ids_element.setAttribute('type', 'hidden');
            file_ids_element.setAttribute('name', $('#' + editor.id).prop('name') + '_fileids');
            file_ids_element.setAttribute('value', fileids);
            editor.formElement.appendChild(file_ids_element);
        }
    };

    /**
     *
     * @param {tinyMCE.Editor} editor
     * @returns {boolean}
     */
    ed.Editor.isEnableFileUpload = function (editor) {
        return !!editor.settings['file_picker_callback'];
    };

    //////// Following parameter is set from template file
    /**
     * locale
     * @type {string} "ja" or "en" or "zh"
     */
    ed.Editor.locale = "en";
    /**
     * プレーンテキストにするときに表示するメッセージ
     * テンプレート側で各言語に対応したものを代入する
     * @type {string}
     */
    ed.Editor.confirm_message = 'OK?';

    /**
     *
     * @type {boolean}
     */
    ed.Editor.allowed = false;
    /**
     * URL for re/add_image.csp
     * @type {string}
     */
    ed.Editor.image_upload_url = "";
    /**
     * URL for re/command_get.csp
     * @type {string}
     */
    ed.Editor.image_download_url = "";


})(jQuery);
