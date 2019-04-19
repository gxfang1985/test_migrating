// namespace
grn.base.namespace("grn.page.mail._send");

(function () {
    var G = grn.page.mail._send;

    G.ajax_submit = function (form_name, submit_page, button_obj) {
        if (typeof form_name == "undefined" || typeof submit_page == "undefined") {
            return;
        }

        var f = document.forms[form_name];

        if (!confirmIfExistFailedFile()) {
            return false;
        }

        if (!G.checkAddress(f)) {
            return false;
        }

        var element = document.getElementById('selectTo');
        if (typeof element != "undefined") {
            element.setAttribute( 'disabled', 'disabled' );
        }
        element = document.getElementById('selectCC');
        if (typeof element != "undefined") {
            element.setAttribute( 'disabled', 'disabled' );
        }
        element = document.getElementById('selectBCC');
        if (typeof element != "undefined") {
            element.setAttribute( 'disabled', 'disabled' );
        }

        grnEditor = grn.component.editor.Editor.getInstanceById('data_editor_id');
        grnEditor.save();
        grn.component.ajax_submit.ajax_submit(f, submit_page, before_send, after_send);

        function before_send() {
            grn.component.button( jQuery(button_obj).parent() ).showSpinner();
        }

        function after_send(jqXHR) {
            if (jqXHR && !grn.component.error_handler.hasCybozuError(jqXHR) && !jQuery('#show_validation_errors').is(':visible')) {
                return;
            }
            grn.component.button(jQuery(button_obj).parent()).hideSpinner();
        }
    };

    G.popupSelectAddress = function (form, tag_name) {
        window.tag_name = tag_name;
        popupWin(G.popup_address_url,'address','','',0,0,0,1,0,1);
    };

    G.checkAddress = function (frm) {
        var keys = new Array('to', 'cc', 'bcc');
        var addresses = [];
        addresses['to'] = frm.to.value;
        addresses['cc'] = frm.cc.value;
        addresses['bcc'] = frm.bcc.value;

        for (i = 0; i < keys.length; i++) {
            var key = keys[i];
            var field = frm[key];
            var address_length = encodeURIComponent(addresses[key]).replace(/%../g, 'x').length; // get length of string in bytes
            if (field && address_length > field.maxLength) {
                // show error message
                error_msg = G.error_message_1 + field.maxLength + G.error_message_2;
                alert(error_msg);
                field.focus();
                return false;
            }
        }
        return true;
    };

    G.click_show_hide_bcc = function () {
        jQuery("#add_bcc_mail").toggle();
        jQuery("#show_hide_bcc").toggle();
        var addressArea = jQuery("#selectBCC").next();
        grn.component.mail.AddressArea.EventHandler.dispatch(addressArea);
        if(typeof G.selectBCCElement !== 'undefined' && typeof G.selectBCCElement.resizeAreaMethod !== 'undefined') {
            G.selectBCCElement.resizeAreaMethod();
        }
    };

    // Register function auto-complete for three control
    G.initThreeControl = function () {
        var addressControls = jQuery("#selectTo,#selectBCC,#selectCC");
        addressControls.each(function (index, item) {
            var addressDOMElement = jQuery(item).fcbkcomplete(
                {
                    json_url: G.auto_complete_url,
                    addontab: false,
                    maxitems: 1000,
                    input_min_size: 0,
                    height: 10,
                    cache: false,
                    newel: false,
                    firstselected: true,
                    oncreate : function(){
                        var addressArea = jQuery(item).next();
                        grn.component.mail.AddressArea.EventHandler.dispatch(addressArea);
                    },
                    onremove : function(){
                        var addressArea = jQuery(item).next();
                        grn.component.mail.AddressArea.EventHandler.dispatch(addressArea);
                    },
                    resource: {
                        deletetooltip:'delete'
                    }
                });
            if (jQuery(item).attr("id") === "selectBCC") {
                G.selectBCCElement = addressDOMElement;
            }
        });

        //This is logic initialize when page load the first
        var is_dragging = false;
        jQuery(function () {
            jQuery(".holder").sortable(
                {
                    opacity: 0.6,
                    cursor: 'move',
                    tolerance: 'pointer',
                    connectWith: ".holder"
                });
        });

        // Builder emails data before submit to server
        jQuery("form[name='" + G.form_name + "'] span[name='submit_button']").bind('click', do_submit);

        function do_submit(e) {
            var submit_button = grn.component.button(e.currentTarget);
            if (submit_button.isDisabled()) {
                return;
            }
            var selectControls = ['#selectTo', '#selectBCC', '#selectCC'];
            var textareaControls = ['#to', '#bcc', '#cc'];
            jQuery.each(selectControls, function (i, item) {
                jQuery(textareaControls[i]).empty();
                var emails = [];
                jQuery.each(jQuery(item).children('option'), function () {
                    var dis = jQuery.trim(jQuery(this).text());
                    var em = jQuery.trim(jQuery(this).prop('value'));
                    if (dis != em && dis != "" && em != null && em != "") {
                        dis = G.xssDisplay(dis);
                        em = G.xssDisplay(em);
                        dis = dis.replace(/\\/g,'\\\\').replace(/"/g,'\\"');
                        emails.push('"' + dis + '" <' + em + '>');
                    }
                    else {
                        emails.push(G.xssDisplay(em != "" ? em : dis));
                    }
                });
                jQuery(textareaControls[i]).prop('value',emails.join(', '));
            });
            G.ajax_submit(G.form_name, G.command_page, e.target);
        }
    };

    G.xssDisplay = function (string, flag) {
        string = string.toString();
        string = string.replace('\\', "");
        if (typeof flag != "undefined") {
            return string;
        }
        return unescape(string).replace(/&lt;/gi,"<").replace(/&gt;/gi,">").replace(/&quot;/gi,"\"");
    };

    jQuery(function(){
        if (G.mail_bcc && G.mail_bcc.length) {
            jQuery("#show_hide_bcc").show();
            jQuery("#add_bcc_mail").hide();
        }
        G.initThreeControl();
    });
})();

// for address popup
function getFormParams()
{
    var tmpValueTo = [];
    var tmpValueCC = [];
    var tmpValueBCC = [];
    var _strDisplay = "";
    var _strEmail = "";
    jQuery("#selectTo").children('option').each(function()
    {
        _strDisplay = convertHTMLCodeToChar(grn.page.mail._send.xssDisplay(jQuery(this).text()));
        _strEmail = convertHTMLCodeToChar(grn.page.mail._send.xssDisplay(jQuery(this).prop('value')));
        if(jQuery.trim(_strEmail) != "" && _strEmail != _strDisplay)
        {
            tmpValueTo.push('"' + _replace_display_name(_strDisplay) + '" <' + _strEmail + ">");
        }
        else
        {
            tmpValueTo.push(_strEmail);
        }
    });

    jQuery("#selectCC").children('option').each(function()
    {
        _strDisplay = convertHTMLCodeToChar(grn.page.mail._send.xssDisplay(jQuery(this).text()));
        _strEmail = convertHTMLCodeToChar(grn.page.mail._send.xssDisplay(jQuery(this).prop('value')));
        if(jQuery.trim(_strEmail) != "" && _strEmail != _strDisplay)
        {
            tmpValueCC.push('"' + _replace_display_name(_strDisplay) + '" <' + _strEmail + ">");
        }
        else
        {
            tmpValueCC.push(_strEmail);
        }
    });

    jQuery("#selectBCC").children('option').each(function()
    {
        _strDisplay = convertHTMLCodeToChar(grn.page.mail._send.xssDisplay(jQuery(this).text()));
        _strEmail = convertHTMLCodeToChar(grn.page.mail._send.xssDisplay(jQuery(this).prop('value')));
        if(jQuery.trim(_strEmail) != "" && _strEmail != _strDisplay)
        {
            tmpValueBCC.push('"' + _replace_display_name(_strDisplay) + '" <' + _strEmail + ">");
        }
        else
        {
            tmpValueBCC.push(_strEmail);
        }
    });
    function _replace_display_name( displayName )
    {
        return jQuery.trim(displayName).replace(/\\/g,'\\\\').replace(/"/g,'\\"');
    }
    var params = [];
    params['address_to'] = tmpValueTo.join(",");
    params['address_cc'] = tmpValueCC.join(",");
    params['address_bcc'] = tmpValueBCC.join(",");
    params['form_name'] = grn.page.mail._send.form_name;
    params['tag_name'] = window.tag_name;
    params['reset'] = 1;

    return params;
}

// load email address after close popup
function ApplyAddress(object)
{
    if(object != null)
    {
        var partenGetDisplay = new RegExp(/^\"(.+)\"\s*/gi);
        var selectControls = jQuery("#selectTo,#selectCC,#selectBCC");
        var email = "";
        var display = "";
        jQuery("ul.holder").remove();
        selectControls.each(function (index, item)
        {
            var fields = jQuery.trim(object.bcc).match(/("|\s")(\\\"|[^"])*"\s<[^>]+>+|[^,;]+/g);
            if (jQuery(item).attr("id") === "selectTo")
            {
                fields = jQuery.trim(object.to).match(/("|\s")(\\\"|[^"])*"\s<[^>]+>+|[^,;]+/g);
            }
            else if (jQuery(item).attr("id") === "selectCC")
            {
                fields = jQuery.trim(object.cc).match(/("|\s")(\\\"|[^"])*"\s<[^>]+>+|[^,;]+/g);
            }
            if(fields && fields.length > 0)
            {
                jQuery(item).children('option').remove();
                jQuery.each(fields, function(i, displayEmail)
                {
                    email = display = "";
                    displayEmail = jQuery.trim(displayEmail).replace(/\\\"/g, '"').replace(/\\\\/g, '\\');
                    display = jQuery.trim(displayEmail.match(partenGetDisplay));
                    /*jshint -W049 */ /* Unexpected escaped character '{a}' in regular expression. */
                    email = xssPrevent(jQuery.trim(displayEmail.replace(display,'')).replace(/^\<|\>$/g,''), 1);
                    /*jshint +W049 */
                    if(displayEmail != "")
                    {
                        if(display != "" && email != "" && isValidEmailAddress(email))
                        {
                            display = xssPrevent(display.replace(/^\"|\"$/g,'').replace(/\"/gi,"&quot;").replace(/</gi,"&lt;").replace(/>/gi,"&gt;"), 1);
                        }
                        else
                        {
                            email = display = xssPrevent(displayEmail, 1);
                        }
                        jQuery(item).append("<option class='selected' value='" + email + "'>" + display + "</option>");
                    }
                });
                var add_bcc_mail_element = jQuery("#add_bcc_mail");
                if (jQuery(item).attr("id") === "selectBCC" && add_bcc_mail_element.is(":visible"))
                {
                    add_bcc_mail_element.hide();
                    jQuery("#show_hide_bcc").show();
                }
            }
            else if( !fields )
            {
                jQuery(item).children('option').remove();
            }
        });
        // loop register autocomplete for controls
        jQuery(function()
        {
            var addressControls = jQuery("#selectTo,#selectBCC,#selectCC");
            addressControls.each(function (index, item)
            {
                jQuery(item).fcbkcomplete(
                {
                    json_url: grn.page.mail._send.auto_complete_url,
                    addontab: false,
                    maxitems: 1000,
                    input_min_size: 0,
                    height: 10,
                    cache: false,
                    newel: false,
                    oncreate : function(){
                        var addressArea = jQuery(item).next();
                        grn.component.mail.AddressArea.EventHandler.dispatch(addressArea);
                    },
                    onremove : function(){
                        var addressArea = jQuery(item).next();
                        grn.component.mail.AddressArea.EventHandler.dispatch(addressArea);
                    },
                    firstselected: true
                });
            });
        });
        // Register the logic  when rebuilder controls
        var is_dragging = false;
        jQuery(function()
        {
            jQuery(".holder").sortable(
            {
                opacity: 0.6,
                cursor: 'move',
                tolerance: 'pointer',
                connectWith: ".holder"
            });
        });
    }
}
