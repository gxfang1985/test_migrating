/**
 FCBKcomplete v2.8.9.3 is released under the MIT License <http://www.opensource.org/licenses/mit-license.php>
 - Jquery version required: 1.6.x
*/
/* Based on TextboxList by Guillermo Rauch http://devthought.com/ */
/**
 * width            - element width (by default 512px)
 * json_url         - url to fetch json object
 * cache            - use cache
 * height           - maximum number of element shown before scroll will apear
 * newel            - show typed text like a element
 * firstselected    - automaticly select first element from dropdown
 * filter_case      - case sensitive filter
 * filter_selected  - filter selected items from list
 * filter_begin     - filter only from begin
 * complete_text    - text for complete page
 * maxshownitems    - maximum numbers that will be shown at dropdown list (less better performance)
 * oncreate         - fire event on item create
 * onselect         - fire event on item select
 * onremove         - fire event on item remove
 * maxitimes        - maximum items that can be added
 * delay            - delay between ajax request (bigger delay, lower server time request)
 * addontab         - add first visible element on tab or enter hit
 * addoncomma       - add first visible element when pressing the comma key
 * attachto         - after this element fcbkcomplete insert own elements
 * bricket          - use square bricket with select (needed for asp or php) enabled by default
 * input_tabindex   - the tabindex of the input element
 * input_min_size   - minimum size of the input element (default: 1)
 * input_name       - value of the input element's 'name'-attribute (no 'name'-attribute set if empty)
 * select_all_text  - text for select all link
 * warningInvalid   - execluse style (red backgorund) for item invalid: customize by VT
 * nextFocus        - If is enable, when end user delete system auto selected email next or pre
 * line_height      - each line height of the input field (by default 24px)
 */
//note:
//complete: this is dropdown menu element of html
//holder: this is fiedl to, cc, bcc ul in progress of html
//element: this is selection control of html
(function ($, undefined) {
    $.fn.fcbkcomplete = function (opt) {
        var resizeAreaMethod = {};
        var self = this.queue(function () {
            function init() {
                createFCBK();
                addInput(0);
                handleDragDrop();
                handleClickOutOfRange();
            }
            function createFCBK() {
                holder = $('<ul class="holder"></ul>').width(options.width);
                if (options.attachto) {
                    if (typeof (options.attachto) == "object") {
                        options.attachto.append(holder);
                    } else {
                        $(options.attachto).append(holder);
                    }
                } else {
                    element.after(holder);
               }
                complete = $('<div class="dropdown-auto">').width(options.width);
                //Bind two handlers to the matched elements, to be executed when the mouse pointer enters and leaves the elements.
                complete.hover(function () {
                    complete_hover = 0;
                }, function () {
                    complete_hover = 1;
                });
                feed = $('<ul id="' + elemid + '_feed"></ul>').width(options.width);
                holder.after(complete.prepend(feed));
                elPrepare();
            }

            function elPrepare() {
                name = element.attr("name");
                if (options.bricket) {
                    if (typeof (name) != 'undefined' && name.indexOf("[]") == -1) {
                        name = name + "[]";
                    }
                }
                 var temp_elem = $('<' + element.get(0).tagName + ' name="' + name + '" id="' + elemid + '" multiple="multiple" class="' + element.get(0).className + ' hidden">').data('cache', {});

                $.each(element.children('option'), function (i, option) {
                    option = $(option);
                    //temp_elem.data('cache')[option.val()] = option.text();
                    if (option.hasClass("selected")) {
                        var display = xssDisplay(option.text());
                        if(display.length > 0)
                        {
                            display = xssPrevent($.trim(display), 1);
                        }
                        var id = addItem(display, option.val(), true, option.hasClass("locked"), undefined, undefined, false);
                        temp_elem.append('<option value="' + option.val() + '" selected="selected" id="opt_' + id + '"class="selected">' + display + '</option>');
                    }
                });
                AreaResize();
                element.after(temp_elem);
                element.remove();
                element = temp_elem;

                //public method to add new item
                $(element).bind("addItem", function (event, data) {
                    addItem(data.title, data.value, 0, 0, 0);
                    AreaResize();
                });

                //public method to remove item
                $(element).bind("removeItem", function (event, data) {
                    var item = holder.children('li[rel=' + data.value + ']');
                    if (item.length) {
                        removeItem(item);
                        AreaResize();
                    }
                });

                //public method to remove item
                $(element).bind("destroy", function (event, data) {
                    holder.remove();
                    complete.remove();
                    element.show();
                });
            }

            function addItem(title, value, preadded, locked, focusme, opt_holder, rebuild) {
                //title  = Tran Vien
                //value = vien-tran@cybozu.vn;
                if (!maxItems() || value == null || ($.trim(value).length <= 0 && $.trim(title).length <= 0)) {
                    return false;
                }
                var flag = false;
                if(title == value) {
                    flag = true;
                }
                if(title.length > 1 && title.charAt(0) == "\"" && title.charAt(title.length-1) == "\"") {
                    title = title.substring(1, title.length-1);
                    if(flag) {
                        value = title;
                    }
                }
                if(value == "" && title != "") {
                    value = title;
                }
                var _holder = opt_holder || holder;
                if(typeof opt_holder != 'undefined') {
                    _holder = opt_holder;
                }
                else {
                    _holder = holder;
                }
                title = $.trim(title);
                value = $.trim(value);
                var liclass = "bit-box" + (locked ? " locked" : "");
                var id = randomId();
                rebuild = rebuild === undefined ? true : rebuild;

                var txt = value;
                if (title != value && title.length > 0) {
                    var tmp = convertHTMLCodeToChar(xssDisplay(title));
                    txt = document.createTextNode(tmp + " <" + convertHTMLCodeToChar(xssDisplay(value)) + ">");
                } else {
                    txt = document.createTextNode(convertHTMLCodeToChar(xssDisplay(value)));
                }
                var aclose = $('<a title = "' + options.resource.deletetooltip + '" class="closebutton" href="#"></a>');
                var li = jQuery('<li class=' + liclass + ' rel="' + xssPrevent(xssDisplay(value),1) + '" id="pt_' + id + '"></li>').prepend(txt).append(aclose);
                li.attr("dis", xssPrevent(xssDisplay(title),1));
                if (options.warningInvalid && !isValidEmailAddress(value)) {
                    li.addClass("error");
                }
                if (_holder.find("li.bit-input").length != 0) {
                    li.insertAfter(_holder.find("li.bit-input"));
                } else {
                    _holder.append(li);
                }
                aclose.click(function () {
                    removeItem(jQuery(this).parent("li"));
                    AreaResize();
                    return false;
                });
                li.dblclick(function (sender, e) {
                    $("#opt_" + id + "").remove();
                    editing = id;
                    var holedit = $("#pt_" + id).parent();
                    var input = holedit.find(".maininput");
                    if (input != null && input.length > 0 && input.val().length > 0) {
                        var strEmail = xssPrevent(input.val(), 1);
                        var result = sliptDisplayAndEmail(xssDisplay(strEmail).replace(/"/gi,''));
                        var display = "";
                        var email = "";
                        if (result != null && result.length == 3) {
                            display = result[1];
                            email = result[2];
                        } else {
                            email = input.val().replace(/"/gi,'').replace(/^\<|\>$/g,'');
                        }
                        if (display != "") {
                            display = decorateDisplayOrEmail(display);
                            email = xssPrevent(email, 1);
                            addItem(display, email, 0, 0, 0, holedit);
                            AreaResize();
                            input.val("");
                        } else {
                            email = xssPrevent(email, 1);
                            addItem(email, email, 0, 0, 0, holedit);
                            AreaResize();
                            input.val("");
                        }
                    }
                    editItem(id);
                    // complete_hover = 0;//vt prevent blur event is execute
                    $("#opt_" + id + "").parent().find(".maininput").focus();
                    return false;
                });
                li.click(function (sender, e) {
                    var flagDragDrop = $("#hiDragging").val();
                    if (flagDragDrop == "0") { // prevent firefox run default
                        jQuery(".bit-box").removeClass("deleted");
                        jQuery(this).addClass("deleted");
                    } else {
                        $("#hiDragging").val("0");
                        if(grn.browser.chrome){// this is logic for chorome browser phenomeno the first click not effect after drag form to field to cc field
                            jQuery(".bit-box").removeClass("deleted");
                            jQuery(this).addClass("deleted");
                        }
                    }
                    var input = $(this).parent().find("input.maininput");

                    if (input != null && (input.val()).length > 0) {
                        var strEmail = xssPrevent(input.val(), 1);
                        var result = sliptDisplayAndEmail(xssDisplay(strEmail).replace(/"/gi,''));
                        var display = "";
                        var email = "";
                        if (result != null && result.length == 3) {
                            display = result[1];
                            email = result[2];
                        } else {
                            email = input.val().replace(/"/gi,'').replace(/^\<|\>$/g,'');
                        }
                        if (display != "") {
                            display = decorateDisplayOrEmail(display);
                            email = xssPrevent(email, 1);
                            addItem(display, email, 0, 0, 0, $(this).parent());
                            AreaResize();
                            input.val("");
                            $(this).parent().find("li.bit-input").appendTo($(this).parent()).focus();
                        } else {
                            email = xssPrevent(email, 1);
                            addItem(email, email, 0, 0, 0, $(this).parent());
                            AreaResize();
                            input.val("");
                            $(this).parent().find("li.bit-input").appendTo($(this).parent()).focus();
                        }
                    }else {
                        if(!grn.browser.msie){// if not use logic here ie browser canot edit email
                            $(this).parent().find("input.maininput").focus();
                        }
                    }
                    return false;
                });
                if (!preadded) {
                    $("#" + elemid + "_annoninput").remove();
                    addInput(focusme);
                    if (!isValidEmailAddress(value)) {
                        title = value;
                    }
                    var _item = $('<option value="' + value + '" id="opt_' + id + '" class="selected" selected="selected">' + $.trim(title) + '</option>');
                    element.append(_item);
                    if (options.onselect) {
                        funCall(options.onselect, _item);
                    }
                    element.change();
                }
                holder.children("li.bit-box.deleted").removeClass("deleted");
                clear_feed(1);
                //re initlize select option, when LI is change
                if( rebuild ) {
                    element.children('option').remove();
                    holder.children('li').each(function (index) {
                        var tmpValue = $(this).attr('rel');
                        var tmpTitle = $.trim($(this).attr("dis"));
                        var hasClass = $(this).hasClass("bit-input");
                        if (tmpValue != "" && !hasClass) {
                            element.append('<option value="' + tmpValue + '" selected="selected" id="o' + $(this).attr('id') + '"class="selected">' + tmpTitle + '</option>');
                        }
                    });
                }
                li.hover(function(){li.addClass("hover");},function(){li.removeClass("hover");});// force ie borwser turn off hover properties
                return id;
            }

            function removeItem(item) {
                if (!item.hasClass('locked')) {
                    item.fadeOut("fast");
                    var id = item.attr('id');
                    if (options.onremove) {
                        var _item = id ? $("#o" + id + "") : element.children("option[value=" + item.attr("rel") + "]");
                        funCall(options.onremove, _item);
                    }
                    if (id) {
                        $("#o" + id + "").remove();
                    } else {
                        element.children('option[value="' + item.attr("rel") + '"]').remove();
                    }
                    item.remove();
                    element.change();
                    deleting = 0;
                }
            }

            // vt
            function editItem(item) {
                var em = convertHTMLCodeToChar(xssDisplay($("#pt_" + item).attr("rel")));
                var dis = convertHTMLCodeToChar(xssDisplay($("#pt_" + item).attr("dis")));//.replace(/&lt;/gi,"<").replace(/&gt;/gi,">").replace(/&quot;/gi,"\"");
                var strFull = em;
                var _input = null;
                if (em != "" && dis != "" && em != dis) {
                    strFull = "\"" + dis + "\" <" + em + ">";
                }
                var _holder = $("li#pt_" + item).parent();
                _holder.find("li.bit-input").insertAfter($("li#pt_" + item));
                AutoResize(strFull,_holder.find('.maininput'));
                _input = _holder.find('.maininput');
                _input.hover(function () {
                    complete_hover = 0;
                }, function () {
                    complete_hover = 1;
                });
                $("#pt_" + item).remove();
                _input.val(strFull);
                resizeHolderHeight();

                // Cybozu Hack for IE11
                var user_agent = window.navigator.userAgent;
                var IE11up = (/Trident\/\d{1,2}.\d{1,2};/gi).test(user_agent) && (/rv:([0-9]*)/gi).test(user_agent);
                if( !IE11up )
                {
                    _input.focus().val(strFull);
                }

                if( grn.browser.msie || IE11up ) {//for IE browser
                    $(_input).setCursorPosition(strFull.length);
                }
                return false;
            }
            // vt
            function addInput(focusme) {
                var flag_prevent_double_bind = false;
                var flagJapanese = false;
                var li = $('<li class="bit-input" style="width:100%" id="' + elemid + '_annoninput">');
                var input = $('<input type="text" style="width:100%" class="maininput" size="' + options.input_min_size + '" autocomplete="off">');
                if (options.input_tabindex > 0) input.attr("tabindex", options.input_tabindex);
                if (options.input_name != "") input.attr("name", options.input_name);
                holder.append(li.append(input));
                AreaResize();

                input.focus(function () {
                    isactive = true;
                    if (maxItems()) {
                        complete.fadeIn("fast");
                    }
                });
                var etext = "";
                //This is logic support for inputing chinese and Japanese characters in firefox  
                input.bind("input", function(event) {
                    etext = xssPrevent(input.val(), 1);
                    AutoResize(etext, input);// prevent flashing input control
                    resizeHolderHeight();
                    if(isJapanese(etext)){// performance load in the case latin character
                        flagJapanese = true;
                        load_feed(etext);
                        complete.children(".default").hide();
                    }
                });
                jQuery("li").removeClass("deleted");
                //vt
                input.blur(function () {
                    isactive = false;
                    // if (complete_hover) {//
                    if (input.val().length > 0) {
                        var strEmail = xssPrevent(input.val(), 1);
                        var result = sliptDisplayAndEmails(convertHTMLCodeToChar(xssDisplay(strEmail)));
                        var display = "";
                        var email = "";
                        for (var i = 0; i < result.length; i++) {
                            display = result[i][1];
                            email = result[i][2];
                            if(result[i][1].length == 0)
                            {
                                display = email = decorateDisplayOrEmail(email);
                            }
                            else
                            {
                                display = decorateDisplayOrEmail(display);
                                email = xssPrevent(email, 1);
                            }
                            addItem(display, email, 0, 0, 0, undefined, false);
                        }
                    }
                    AreaResize();
                    // } else {
                    // if($.browser.webkit){

                    // // Chormome steal focus so remove focus at oldcontrol
                    // }else{
                    // input.focus();
                    // }
                    // }
                });
                //evt
                clear_feed(1);
                complete.children(".default").fadeOut('fast');

                holder.click(function () {
                    if (options.input_min_size < 0 && feed.length) {
                        load_feed(xssPrevent(input.val(), 1));
                    }
                    input.focus();
                    if (feed.length && input.val().length > options.input_min_size) {
                        //feed.show();vt, it show drowpdown empty menu when double click 
                    } else {
                        clear_feed(1);
                        complete.children(".default").show();
                    }
                });

                input.keypress(function (event) {
                    if (event.keyCode == _key.enter && $.trim(input.val()).length > 0) {
                        //vt
                        var str = xssPrevent($.trim(input.val()), 1);
                        var result = sliptDisplayAndEmails(xssDisplay(str));
                        var display = "";
                        var email = "";
                        for (var i = 0; i < result.length; i++) {
                            display = result[i][1];
                            email = result[i][2];
                            if(result[i][1].length == 0)
                            {
                                display = email = decorateDisplayOrEmail(email);
                            }
                            else
                            {
                                display = decorateDisplayOrEmail(display);
                                email = xssPrevent(email, 1);
                            }
                            addItem(display, email, 0, 0, 1, undefined, false);
                        }
                        AreaResize();

                        clear_feed(1);
                        complete.hide();
                        return false;
                        //evt
                    } else if (event.keyCode == _key.enter && $.trim(input.val()).length == 0) {
                        input.val("");
                        return false;
                    }
                    //auto expand input
                    AutoResize(input.val(), input);
                    resizeHolderHeight();
                });
                input.keyup(function (event) {
                    //vt: auto expand input control when end user press ctrl + v
                    etext = xssPrevent(input.val(), 1);
                    AutoResize(etext, input);
                    resizeHolderHeight();
                    //vt
                    if (etext.length == 0 && event.keyCode == _key.leftarrow) {
                        var current = $(".deleted");
                        if (current.length == 0) {
                            holder.children("li.bit-box:last").addClass("deleted");
                        } else if (current != holder.children("li.bit-box:first")) {
                            current.removeClass("deleted").prev().addClass("deleted");
                        } else {
                            current.removeClass("deleted");
                            holder.children("li.bit-box:last").addClass("deleted");
                        }
                    } else if (etext.length == 0 && event.keyCode == _key.rightarrow) {
                        var current = $("li.deleted");
                        if (current.length == 0) {
                            holder.children("li.bit-box:first").addClass("deleted");
                        } else if (current.next().find('input').length == 0) {
                            current.removeClass("deleted").next().addClass("deleted");
                        } else {
                            current.removeClass("deleted");
                            holder.children("li.bit-box:first").addClass("deleted");
                        }
                        return false;
                    }
                    if (event.keyCode == _key.esc && $.trim(input.val()).length > 0) {// esc press, dropdown is exit
                        //vt
                        var str = xssPrevent($.trim(input.val()), 1);
                        var result = sliptDisplayAndEmails(xssDisplay(str));
                        var display = "";
                        var email = "";
                        for (var i = 0; i < result.length; i++) {
                            display = result[i][1];
                            email = result[i][2];
                            if(result[i][1].length == 0)
                            {
                                display = email = decorateDisplayOrEmail(email);
                            }
                            else
                            {
                                display = decorateDisplayOrEmail(display);
                                email = xssPrevent(email, 1);
                            }
                            addItem(display, email, 0, 0, 1, undefined, false);
                        }
                        AreaResize();
                        clear_feed(1);
                        complete.hide();
                        return false;
                        //evt
                    } else if (event.keyCode == _key.esc && $.trim(input.val()).length == 0) {
                        input.val("");
                        return false;
                    }
                     //STM-288
                    setTimeout(function() {flag_prevent_double_bind=false}, 1000);
                    //end STM-288
                    //evt
                    if ((event.keyCode == _key.backspace || event.keyCode == _key.del) && etext.length == 0) {
                       //STM-288
                        var user_agent = window.navigator.userAgent;
                        var IE11up = (/Trident\/\d{1,2}.\d{1,2};/gi).test(user_agent) && (/rv:([0-9]*)/gi).test(user_agent);
                        if(flagJapanese && IE11up){ // check input is japanese and browser is ie11
                            if(flag_prevent_double_bind){
                                flag_prevent_double_bind = false;
                                event.preventDefault();
                                return;
                            }
                        }
                        flag_prevent_double_bind = true;
                        //end STM-288
                        clear_feed(1);
                        var _holder = $("li.bit-box.deleted").parent(); //ul.holder, The end user has selected
                        if (!holder.children("li.bit-box:last").hasClass('locked')) {
                            if (_holder.length == 0) { // press backspace keyboard, and current focus, not selected
                                _holder = $(this).parent().parent(); // input>li>ul
                            }
                            if (_holder.children("li.bit-box.deleted").length == 0) {
                                _holder.children("li.bit-box:last").addClass("deleted");
                                return;
                            } else {
                                if (deleting) {
                                    return;
                                }
                                deleting = 1;
                                _holder.children("li.bit-box.deleted").fadeOut("fast", function () {
                                    if(options.nextFocus){
                                    //vt
                                        if (_holder.children("li.bit-box").length > 0) {
                                            if ($(this).next("li.bit-box").length > 0) {
                                                $(this).next().addClass("deleted");
                                            } else {
                                                $(this).prev().addClass("deleted");
                                            }
                                        }
                                    }
                                    //evt
                                    removeItem($(this));
                                    AreaResize();
                                    return false;
                                });
                            }
                        }
                    }

                    if (event.keyCode != _key.downarrow && event.keyCode != _key.uparrow && event.keyCode != _key.leftarrow &&
                    event.keyCode != _key.rightarrow && etext.length > options.input_min_size) {
                        load_feed(etext);
                        complete.children(".default").hide();
                    }
                });
                if (options.oncreate) {
                    funCall(options.oncreate, input);
                }
                if (focusme) {
                    setTimeout(function () {
                        input.focus();
                        complete.children(".default").show();
                    }, 100);
                }
            }

            function resizeInputWidth()
            {
                if (holder.find("li.bit-input").next().length !== 0)
                {
                    return holder.find("li.bit-input").width();
                }

                var holder_show_width = holder.width() - (holder[0].offsetWidth - holder[0].clientWidth);
                var surplus_width, input_new_width;
                var address_left_width = 0;
                var address_outer_width = 0;
                var holder_li = holder.children("li.bit-box");
                if (holder_li.length > 0)
                {
                    var last_li = holder_li.last();
                    address_left_width = last_li.position().left - holder.position().left + holder.scrollLeft();
                    address_outer_width = last_li.outerWidth(true);
                }

                surplus_width = holder_show_width - address_left_width - address_outer_width;
                if (surplus_width <= (holder_show_width * 0.1))
                {
                    input_new_width = holder_show_width;
                }
                else
                {
                    input_new_width = surplus_width - 11;
                }

                holder.find("li.bit-input").width(input_new_width);
                holder.find("li.bit-input > input").width("100%");
                return input_new_width;
            }

            function resizeHolderHeight(input_new_width)
            {
                var line_height = options.line_height;
                var address_top = 0, row_new = 0;
                var holder_li = holder.children("li");
                if (holder_li.length > 0)
                {
                    address_top = holder_li.last().position().top - holder.position().top + holder.scrollTop();
                    if (holder.find("li.bit-input").length == 0 && holder.children("li.bit-box").length > 0)
                    {
                        var holder_show_width = holder.width() - (holder[0].offsetWidth - holder[0].clientWidth);
                        if (input_new_width == holder_show_width)
                        {
                            row_new = 1;
                        }
                    }
                }

                row_new += parseInt(address_top / line_height) + 1;
                row_new = Math.max(row_new, 1);
                row_new = Math.min(row_new, 5);
                holder.height(row_new * line_height + (holder[0].offsetHeight - holder[0].clientHeight));
            }

            function AreaResize()
            {
                var holder_width = holder.width();
                if (holder_width > 0)
                {
                    var input_new_width = resizeInputWidth();
                    resizeHolderHeight(input_new_width);
                }
                else
                {
                    holder.height("0px");
                }
            }

            resizeAreaMethod = function () {
                AreaResize();
            }

            function AutoResize(etext, input){
                var email = xssDisplay(etext);
                var japanese = 0;
                var latin = 0;
                var latinUpperCase = 0;
                var _with = 0;
                var widthJapanese = 0;
                var widthLatin = 0;
                var fontSize = parseInt(input.css('font-size'));
                for(var i = 0; i < email.length; i++) {
                    if(isJapanese(email[i])){
                        japanese += 1;
                    }else if(/[A-Z@%mw]/.test(email[i])){
                        latinUpperCase += 1;
                    }else{
                        latin += 1;
                    }
                }
                if(etext.length > 0){
                    var newsize = (options.input_min_size > input.val().length) ? options.input_min_size : (input.val().length + 1);
                    widthJapanese = fontSize * japanese ;
                    widthLatin = (fontSize * latin * 0.6 ) + (fontSize * latinUpperCase);
                    _with = widthJapanese + widthLatin;
                    if(grn.browser.msie &&  grn.browser.version > 9.0 && newsize > 9){
                        _with += 10;
                    }

                    holder.find("li.bit-input").width(_with);
                    input.attr("size", newsize).width(_with);
                }
                else
                {
                    resizeInputWidth();
                }
                return _with;
            }

            function addMembers(etext, data) {
                feed.html('');
                if (!options.cache && data != null) {
                    cache.clear();
                }
                var maximum = options.maxshownitems < data.length ? options.maxshownitems : data.length;
                var content = '';
                etext = xssDisplay(etext);
                $.each(data, function (i, val) {
                    if (maximum) {
                        if (options.filter_selected && element.children('option[value="' + val + '"]').hasClass("selected")) {
                            //nothing here...
                        } else {
                            var ev_od = "";
                            if (counter % 2 == 0) {
                                ev_od = "odd";
                            }
                            var obkey = convertHTMLCharToCode(val.key);
                            var obvalue = convertHTMLCharToCode(val.value.replace(/^\<|\>$/g,''));
                            content += '<li class="' + ev_od + '" rel="' + xssPrevent(obvalue,1) + '" dis="' + xssPrevent(obkey,1) + '" >' + xssDisplay(itemIllumination( obkey + " &lt;" + obvalue + "&gt;", etext)) + '</li>';
                            counter++;
                            maximum--;
                        }
                    }
                });
                //var feed this is ul of dropdown email
                //var complete this is div containt ul
                if (counter != 0) {
                    feed.append(content);
                    feed.show();
                } else {
                    feed.hide();
                    return; // stop logic computed height div
                }
                if (options.firstselected) {
                    focuson = feed.children("li:visible:first");
                    focuson.addClass("auto-focus");
                }
                if (counter > options.height) {
                    feed.css({
                        "height": (options.height * 24) + "px",
                        "overflow": "auto"
                    });
                } else {
                    feed.css("height", "auto");
                }
                if (maxItems()) { //&& complete.is(':hidden')
                    // complete.show();
                    //feed.show();
                }
            }

            function itemIllumination(value, term) {
                //function itemIllumination(text, etext) {
                // options.filter_begin = true;
                // var string_regex_adder = options.filter_begin ? '': '(.*)';// search any char, but not char break or \n. loop start to end
                // var regex_result = options.filter_begin ? '<em>$1</em>$2' : '$1<em>$2</em>$3';
                // var string_filter_case = (options.filter_case ? "(" + etext + ")(.*)" : "(" + etext.toLowerCase() + ")(.*)");
                // var string_regex = string_regex_adder + string_filter_case;
                // try {
                // var regex = new RegExp(string_regex, ((options.filter_case) ? "g":"gi"));
                // var text = text.replace(regex, regex_result);        
                // } catch(ex) {};
                // return text;

                var patt_search = new RegExp("[/:?*><-@_!~#[\\]()\^&%$|\"\'/:?*><@_!#??()^&%$|”’?]", "i");
                var term_s = term.replace(/([\^\$\(\)\[\]\{\}\*\.\+\?\|\\?])/gi, "\\$1");
                if (term_s.search(patt_search) != 0 && term_s.search(/(\\)/i) != 0 && term_s.search(/(-)/i) != 0) {
                    var patt = new RegExp("\\b(" + term.replace(/([\^\$\(\)\[\]\{\}\*\.\+\?\|\\])/gi, "\\$1") + ")", "i");
                    if (value.match(patt) == null) // have JP
                    {
                        return value.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + term.replace(/([\^\$\(\)\[\]\{\}\*\.\+\?\|\\])/gi, "\\$1") + ")(?![^<>]*>)(?![^&;]+;)", "i"), "<strong>$1</strong>");
                    } else {
                        return value.replace(new RegExp("\\b(?![^&;]+;)(?!<[^<>]*)(" + term.replace(/([\^\$\(\)\[\]\{\}\*\.\+\?\|\\])/gi, "\\$1") + ")(?![^<>]*>)(?![^&;]+;)", "i"), "<strong>$1</strong>");
                    }
                } else {
                    return value;
                }
            }

            function bindFeedEvent() {
                feed.children("li").mouseover(function () {
                    feed.children("li").removeClass("auto-focus");
                    focuson = $(this);
                    focuson.addClass("auto-focus");
                });
                feed.children("li").mouseout(function () {
                    $(this).removeClass("auto-focus");
                    focuson = null;
                });
            }

            function removeFeedEvent() {
                feed.unbind("mouseover").unbind("mouseout").mousemove(function () {
                    bindFeedEvent();
                    feed.unbind("mousemove");
                });
            }

            function bindEvents() {
                var maininput = $("#" + elemid + "_annoninput").children(".maininput");
                bindFeedEvent();

                feed.children("li").unbind("mousedown").mousedown(function () {
                    var option = $(this);
                    addItem(option.attr("dis"), option.attr("rel"), 0, 0, 1);
                    AreaResize();
                    clear_feed(1);
                    complete.hide();
                });

                maininput.unbind("keydown");
                maininput.keydown(function (event) {
                    if (event.keyCode != _key.backspace && event.keyCode != _key.del && event.keyCode != _key.leftarrow && event.keyCode != _key.rightarrow) {
                        holder.children("li.bit-box.deleted").removeClass("deleted");
                    }

                    if ((event.keyCode == _key.enter || event.keyCode == _key.tab || event.keyCode == _key.comma) && checkFocusOn()) {
                        var option = focuson;
                        if (option.parent().length) { // only add when dropdown have items eatless 1
                            addItem(option.attr("dis"), option.attr("rel"), 0, 0, 1);
                            AreaResize();
                            return false;
                        }
                    }
                    // is code not run because, I don't use option newel
                    if ((event.keyCode == _key.enter || event.keyCode == _key.tab || event.keyCode == _key.comma) && !checkFocusOn()) {
                        if (options.newel) {
                            var value = xssPrevent($(this).val());
                            addItem(value, value, 0, 0, 1);
                            AreaResize();
                            return false;
                        }
                        // is code not run because, I don't use option newel
                        if ((options.addontab || options.addoncomma) && options.newel) {
                            focuson = feed.children("li:visible:first");
                            var option = focuson;
                            addItem(option.text(), option.attr("rel"), 0, 0, 1);
                            AreaResize();
                            return _preventDefault(event);
                        }
                    }

                    if (event.keyCode == _key.downarrow) {
                        nextItem('first');
                    }
                    if (event.keyCode == _key.uparrow) {
                        nextItem('last');
                    }
                });
            }

            function nextItem(position) {
                removeFeedEvent();
                if(feed.children("li").length > 0){
                    if (focuson == null || focuson.length == 0) {
                        focuson = feed.children("li:visible:" + position);
                        feed.get(0).scrollTop = position == 'first' ? 0 : parseInt(focuson.get(0).scrollHeight, 10) * (parseInt(feed.children("li:visible").length, 10) - Math.round(options.height / 2));
                    } else {
                        focuson.removeClass("auto-focus");
                        focuson = position == 'first' ? focuson.nextAll("li:visible:first") : focuson.prevAll("li:visible:first");
                        var prev = parseInt(focuson.prevAll("li:visible").length, 10);
                        var next = parseInt(focuson.nextAll("li:visible").length, 10);
                        if (((position == 'first' ? prev : next) > Math.round(options.height / 2) || (position == 'first' ? prev : next) <= Math.round(options.height / 2)) && typeof (focuson.get(0)) != "undefined") {
                            feed.get(0).scrollTop = parseInt(focuson.get(0).scrollHeight, 10) * (prev - Math.round(options.height / 2));
                        }
                    }
                    feed.children("li").removeClass("auto-focus");
                    focuson.addClass("auto-focus");
                }
            }

            function _preventDefault(event) {
                complete.hide();
                event.preventDefault();
                focuson = null;
                return false;
            }

            function maxItems() {
                return options.maxitems != 0 && (holder.children("li.bit-box").length < options.maxitems);
            }

            function addTextItem(value) {
                if (options.newel && maxItems()) {
                    feed.children("li[fckb=1]").remove();
                    if (value.length == 0) {
                        return;
                    }
                    var li = $('<li rel="' + value + '" fckb="1">').html(xssDisplay(value));
                    feed.prepend(li);
                    counter++;
                }
                return;
            }

            function funCall(func, item) {
                var _object = {};
                for (i = 0; i < item.get(0).attributes.length; i++) {
                    if (item.get(0).attributes[i].nodeValue != null) {
                        _object["_" + item.get(0).attributes[i].nodeName] = item.get(0).attributes[i].nodeValue;
                    }
                }
                return func.call(func, _object);
            }

            function checkFocusOn() {
                if (focuson == null || focuson.length == 0) {
                    return false;
                }
                return true;
            }

            function xssPrevent(string, flag) {
                var strR = string;
                if (typeof flag != "undefined") {
                    strR = "";
                    for (i = 0; i < string.length; i++) {
                        var charcode = string.charCodeAt(i);
                        if ((_key.exclamation <= charcode && charcode <= _key.slash) || (_key.colon <= charcode && charcode <= _key.at) || (_key.squarebricket_left <= charcode && charcode <= _key.apostrof)) {
                            strR += escape(string[i]);
                        } else {
                            strR += string[i];
                        }
                    }
                    //strR = strR.replace(/(\{|\}|\*)/i, "\\$1");
                }
                return strR; //.replace(/script(.*)/g, "");
            }

            function xssDisplay(string, flag) {
                string = string.toString();
                //string = string.replace('\\', "");//vt
                if (typeof flag != "undefined") {
                    return string;
                }
                return unescape(string);// do not use becase break in the case email containt special chars .replace(/&lt;/gi,"<").replace(/&gt;/gi,">").replace(/&quot;/gi,"\"");
            }

            function clear_feed(flag) {
                feed.children().remove();
                if (flag) {
                    feed.hide();
                }
            }

            function load_feed(etext) {
                counter = 0;
                if (options.json_url && maxItems()) {
                    getBoxTimeout++;
                    var getBoxTimeoutValue = getBoxTimeout;
                    setTimeout(function () {
                        if (getBoxTimeoutValue != getBoxTimeout) return;
                        $.getJSON(options.json_url, {
                            "q": xssDisplay(etext)
                        }, function (data) {
                            if (!isactive) return; // prevents opening the selection again after the focus is already off
                            addMembers(etext, data);
                            //json_cache_object.set(etext, 1);//vt remove this logic, becasue cache not use
                            bindEvents();
                        });
                    }, options.delay);
                } else {
                    addMembers(etext, []);
                    bindEvents();
                }
            }

            function decorateDisplayOrEmail(display)
            {
                var tmp_display = display;
                if(display.length > 1 && display.charAt(0) == "\"" && display.charAt(display.length-1) == "\"")
                {
                    tmp_display = display.substring(1, display.length - 1);
                }
                return xssPrevent(tmp_display, 1);
            }

            function isValidEmailAddress(emailAddress) {
                emailAddress = convertHTMLCodeToChar(xssDisplay(emailAddress));
                var strpattern = "^[-a-zA-Z0-9.!#$'%&*+\/=?^_`{|}~]{1,64}@[-.0-9A-Za-z]+$";
                var pattern = new RegExp(strpattern); //(/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/gi);
                return pattern.test(emailAddress);
            }
//v2.1
            function sliptDisplayAndEmail(str) {
                var pattern = new RegExp(/(.*[^\s])\s*[<\(]([^>\)]+)[>\)]$/);
                var result = new Array();
                str = $.trim(str);
                var email = str.match(pattern);
                if( email != null ){
                    result[0] = email[0];
                    result[1] = email[1];
                    result[2] = email[2];
                } else {
                    result[0] = str;
                    result[1] = "";
                    result[2] = str.replace(/^<|>$/g,'');
                }
                return result;
            }

            function sliptDisplayAndEmails(str) {
                var fields = jQuery.trim(str).match(/\s*"(\\"|[^"])*"\s*[<\(][^>\)]+[>\)]|\s*"(\\"|[^"])+"@[^,;]+|[^,;]+/g);
                var result = new Array();
                for (var i=0; i < fields.length; i++) {
                    result[i] = sliptDisplayAndEmail(fields[i]);
                }
                return result;
            }

            function convertHTMLCodeToChar(str) {
                return str.replace(/&lt;/gi,"<").replace(/&gt;/gi,">").replace(/&quot;/gi,"\"");
            }
            function convertHTMLCharToCode(str) {
                if( ! str) return '';
                return str.replace(/</gi,"&lt;").replace(/>/gi,"&gt;").replace(/\"/gi,"&quot;");
            }

        // Handler click out of range
            function handleClickOutOfRange() {
                $(document).ready(function(){
                    $(document).click(function(sender, event){
                        $("ul.holder").children().removeClass("deleted");
                    });
                    $("ul.holder").mousemove(function(e){
                        if(is_dragging){
                            var holders = $("ul.holder");
                            var flag1 = false;
                            for (var i = 0; i < holders.length; i++) {
                                var hol_offset = $(holders[i]).offset();
                                var w = $(holders[i]).width();
                                var h = $(holders[i]).height();
                                if (e.pageY >= hol_offset.top && e.pageY <= hol_offset.top + h & e.pageX  >= hol_offset.left && e.pageX  <= hol_offset.left + w) {
                                $(holders[i]).addClass("boxshadow");
                                }else {
                                    $(holders[i]).removeClass("boxshadow");
                                }
                            }
                        }
                    });
                    $(document).mouseup(function(e){
                        if(is_dragging){
                            var holders = $("ul.holder");
                            for (var i = 0; i < holders.length; i++) {
                                var hol_offset = $(holders[i]).offset();
                                var w = $(holders[i]).width();
                                var h = $(holders[i]).height();
                                if (e.pageY >= hol_offset.top && e.pageY <= hol_offset.top + h & e.pageX  >= hol_offset.left && e.pageX  <= hol_offset.left + w) {
                                        $("#hiAcceptDrop").val("1");
                                        break;
                                }else {
                                    //accept = false;
                                }
                            }
                        }
                    });
                });
            }
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

        function isInOtherCaseJapanese(str) {
            var strpattern = /[\u3000-\u303f\u3040-\u309f\u30a0-\u30ff\uff00-\uff9f\u4e00-\u9faf\u3400-\u4dbf]/;
            var pattern = new RegExp(strpattern);
            return pattern.test(str);
        }

        function isJapanese(str) {
            return isKanji(str) || isHiragana(str) || isKatakana(str) || isInOtherCaseJapanese(str);
        }
        
        function isLatin(str) {
            var rlatins = /[^\u0000-\u007f]/;
            return !rlatins.test(str);
        }
        //handle Drag and Drop
            function handleDragDrop() {
                //Drag and drop remove event
                holder.bind("sortremove", function (event, ui) {
                    $("#hiDragging").val("1");
                    element.find("option[value='" + ui.item.attr('rel') + "']").remove();
                    //reInsert item
                    element.children('option').remove();
                    holder.children('li').each(function (index) {
                        if ($(this).text() != "") {
                            element.append('<option value="' + $(this).attr('rel') + '" selected="selected" id="o' + $(this).attr('id') + '"class="selected">' + $(this).attr('dis') + '</option>');
                        }
                    });
                });

                //Drag and drop receive event
                holder.bind("sortreceive", function (event, ui) {
                    var holders = $("ul.holder");
                    $("#hiDragging").val("1");
                    $.fn.fcbkcomplete.dragging = true;
                    var flag = false;
                    for (var i = 0; i < holders.length; i++) {
                        var hol_offset = $(holders[i]).offset();
                        var w = $(holders[i]).width();
                        var h = $(holders[i]).height();
                        if ((ui.offset.top >= hol_offset.top || ui.offset.top + ui.item.height() >= hol_offset.top) && ui.offset.top <= hol_offset.top + h &&
                            (ui.offset.left >= hol_offset.left || ui.offset.left + ui.item.width() >= hol_offset.left )&& ui.offset.left <= hol_offset.left + w) {
                            flag = true;
                            break;
                        }
                    }
                    if ($("#hiAcceptDrop").val() == "0" || $("#hiAcceptDrop").val() == "" || !flag) {//if (!flag) {
                        $(ui.sender).sortable('cancel');
                        $("#hiDragging").val("0");
                        return;
                    }
                    // Change value for option element
                    element.find("option[value='" + ui.item.attr('rel') + "']").remove();
                    element.append('<option value="' + ui.item.attr('rel') + '" selected="selected" id="o' + ui.item.attr('id') + '"class="selected">' + ui.item.attr('dis') + '</option>');
                    $(this).find('.bit-input').appendTo(this);
                    AreaResize();
                    $("li.bit-box").removeClass("deleted");
                    // evt
                    //reInsert item
                    element.children('option').remove();
                    holder.children('li').each(function (index) {
                        if ($(this).text() != "") {
                            element.append('<option value="' + $(this).attr('rel') + '" selected="selected" id="o' + $(this).attr('id') + '"class="selected">' + $(this).attr('dis') + '</option>');
                        }
                    });
                    //accept = false;
                    return;

                });
                // Drag start event
                holder.bind("sortstart", function(event, ui) {
                    is_dragging = true;
                });
                // Drag and Drop stop event
                holder.bind("sortstop", function (event, ui) {
                    var holders = $("ul.holder");
                    $("#hiDragging").val("1");
                    var flag = false;
                    for (var i = 0; i < holders.length; i++) {
                        var hol_offset = $(holders[i]).offset();
                        var w = $(holders[i]).width();
                        var h = $(holders[i]).height();
                        if ((ui.offset.top >= hol_offset.top || ui.offset.top + ui.item.height() >= hol_offset.top) && ui.offset.top <= hol_offset.top + h &&
                            (ui.offset.left >= hol_offset.left || ui.offset.left + ui.item.width() >= hol_offset.left )&& ui.offset.left <= hol_offset.left + w) {
                            flag = true;
                            break;
                        }
                    }
                    if ($("#hiAcceptDrop").val() == "0" || $("#hiAcceptDrop").val() == "" || !flag) {//if (!flag) {
                        $(ui.sender).sortable('cancel');
                        $("#hiDragging").val("0");
                        event.preventDefault();
                    }
                    $(this).find('.bit-input').appendTo(this); //vt: move input control to end element li
                    AreaResize();
                    element.children('option').remove();
                    holder.children('li').each(function (index) {
                        if ($(this).text() != "") {
                            element.append('<option value="' + $(this).attr('rel') + '" selected="selected" id="o' + $(this).attr('id') + '"class="selected">' + $(this).attr('dis') + '</option>');
                        }
                    });
                    $(".bit-box").removeClass("deleted"); // free all item selected
                    //holder.find('.maininput').focus(function(){this.blur();});// turn off focus
                    is_dragging = false;
                    $("#hiAcceptDrop").val("");
                    $("ul.holder").removeClass("boxshadow");
                    $("ul.holder li.bit-box").removeClass("hover");	// force ie borowser turnoff hover properties after drop	    
               });

            }
            var options = $.extend({
                json_url: null,
                line_height: 24,
                width: 715,
                cache: false,
                height: "10",
                newel: false,
                addontab: false,
                addoncomma: false,
                firstselected: true,
                filter_case: false,
                filter_selected: false,
                filter_begin: false,
                complete_text: null,
                select_all_text: null,
                maxshownitems: 10,
                maxitems: 10,
                oncreate: null,
                onselect: null,
                onremove: null,
                attachto: null,
                delay: 300,
                input_tabindex: 0,
                input_min_size: 1,
                input_name: "",
                bricket: false,
                warningInvalid: true,
                nextFocus: false,
                resource: {deletetooltip: 'delete'}
            },
            opt);

            //system variables
            var holder = null;
            var feed = null;
            var complete = null;
            var counter = 0;

            var isactive = false;
            var focuson = null;
            var deleting = 0;
            var complete_hover = 1;
            var input_hover = 1; //vt declare

            var element = $(this);
            var elemid = element.attr("id");
            var getBoxTimeout = 0;
            var editing = null; // vt declare
            var dragDrop = 0; // vt declare
            var is_dragging = false;// vt declare
            $("#hiDragging").val("0");
            var json_cache_object = {
                'set': function (id, val) {
                    var data = element.data("jsoncache");
                    data[id] = val;
                    element.data("jsoncache", data);
                },
                'get': function (id) {
                    return element.data("jsoncache")[id] != 'undefined' ? element.data("jsoncache")[id] : null;
                },
                'init': function () {
                    element.data("jsoncache", {});
                }
            };

            var _key = {
                'enter': 13,
                'tab': 9,
                'comma': 188,
                'backspace': 8,
                'leftarrow': 37,
                'uparrow': 38,
                'rightarrow': 39,
                'downarrow': 40,
                'exclamation': 33,
                'slash': 47,
                'colon': 58,
                'at': 64,
                'squarebricket_left': 91,
                'apostrof': 96,
                'del': 46,
                'esc': 27
            };

            var randomId = function () {
                var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
                var randomstring = '';
                for (var i = 0; i < 32; i++) {
                    var rnum = Math.floor(Math.random() * chars.length);
                    randomstring += chars.substring(rnum, rnum + 1);
                }
                return randomstring;
            };

            var cache = {
                'search': function (text, callback) {
                //text = $.trim(text);
                text = xssDisplay(text);
                text = text.replace(/([\^\$\(\)\[\]\{\}\.\+\?\*\@\|\\])/gi, "\\$1");
                    var temp = new Array();
                    var regex = new RegExp((options.filter_begin ? '^' : '') + text, (options.filter_case ? "g" : "gi"));
                    $.each(element.data("cache"), function (i, _elem) {
                        if (typeof _elem.search === 'function') {
                            if (i.search(regex) != -1 || _elem.search(regex) != -1) {
                                temp.push({
                                    'key': i,
                                    'value': _elem
                                });
                            }
                        }
                    });
                    return temp;
                },
                'set': function (id, val) {
                    var data = element.data("cache");
                    data[id] = val;
                    element.data("cache", data);
                },
                'get': function (id) {
                    return element.data("cache")[id] != 'undefined' ? element.data("cache")[id] : null;
                },
                'clear': function () {
                    element.data("cache", {});
                },
                'length': function () {
                    if (typeof (element.data('cache')) == "object") {
                        var _length = 0;
                        for (i in element.data('cache')) {
                            _length++;
                        }
                        return _length;
                    } else {
                        return element.data("cache").length;
                    }
                },
                'init': function () {
                    if (element.data("cache") == 'undefined') {
                        element.data("cache", {});
                    }
                }
            };

            //initialization
            init();

            //cache initialization
            json_cache_object.init();
            cache.init();

            return this;
        });
        self.resizeAreaMethod = resizeAreaMethod;
        return self;
    };
})(jQuery);
new function($) {
  $.fn.setCursorPosition = function(pos) {
    if ($(this).get(0).setSelectionRange) {
      $(this).get(0).setSelectionRange(pos, pos);
    } else if ($(this).get(0).createTextRange) {
      var range = $(this).get(0).createTextRange();
      range.collapse(true);
      range.moveEnd('character', pos);
      range.moveStart('character', pos);
      range.select();
    }
  }
}(jQuery);
