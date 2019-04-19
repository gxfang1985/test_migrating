(function()
{
    "use strict";
    if (grn.base.isNamespaceDefined("grn.page.mail.mobile.send"))
    {
        return;
    }

    grn.base.namespace("grn.page.mail.mobile.send");
    var G = grn.page.mail.mobile.send;

    jQuery(document).ready(function()
    {
        var openCcAndBcc = jQuery("#openccbcc");
        var cc = jQuery("#div_cc");
        var bcc = jQuery("#div_bcc");

        openCcAndBcc.click(function()
        {
            cc.css("display", "block");
            bcc.css("display", "block");
            openCcAndBcc.remove();
        });

        jQuery("#div_to, #div_cc, #div_bcc").change(function() {
            var errmsg = jQuery("#error_msg");
            if (errmsg.width() > 0 )
            {
                errmsg.remove();
            }
        });

        var addressControls = ["selectTo","selectBCC","selectCC"];
        jQuery.each(addressControls, function(i, item)
        {
            jQuery("#"+item).fcbkcomplete(
            {
                width: jQuery("document").width(),
                json_url: G.auto_complete_url,
                line_height: 36,
                addontab: false,
                maxitems: 1000,
                input_min_size: 0,
                height: 10,
                cache: false,
                newel: false,
                firstselected: true,
                oncreate : function(){
                    var addressArea = jQuery("#" + item).next();
                    grn.component.mail.AddressArea.EventHandler.dispatch(addressArea);
                },
                onremove : function(){
                    var addressArea = jQuery("#" + item).next();
                    grn.component.mail.AddressArea.EventHandler.dispatch(addressArea);
                },
                resource: {
                    deletetooltip:"delete"
                }
            });
        });

        //This is logic initialize when page load the first
        jQuery().ready(function()
        {
            jQuery(".holder").sortable(
                {
                    opacity: 0.6,
                    cursor: "move",
                    tolerance: "pointer",
                    connectWith: ".holder"
                });
            jQuery(".holder").removeAttr("style");
            jQuery(".holder").addClass(G.holder_class);
        });

        jQuery(".dropdown-auto").css("z-index", "200");
        jQuery("#data_editor_id").removeClass("ui-textinput-autogrow");
    });

    // Builder emails data before submit to server
    G.do_mobile_submit = function (e, cmd)
    {
        if(!e)
        {
            e = window.event;
        }

        var selectControls = ["#selectTo","#selectBCC","#selectCC"];
        var textareaControls = ["#to","#bcc","#cc"];
        jQuery.each(selectControls, function(i, item)
        {
            jQuery(textareaControls[i]).empty();
            var emails = new Array();
            jQuery.each(jQuery(item).children("option"), function(index,obemail)
            {
                var dis = jQuery.trim(jQuery(this).text());
                var em = jQuery.trim(jQuery(this).prop("value"));
                if(dis !== em && dis !== "" && em != null && em !== "")
                {
                    dis = G.xssDisplay(dis);
                    em = G.xssDisplay(em);
                    dis = dis.replace(/\\/g,'\\\\').replace(/"/g,'\\"');
                    emails.push('"' + dis + '" <' + em + '>');
                }
                else
                {
                    emails.push(G.xssDisplay(em !== "" ? em : dis));
                }
            });
            jQuery(textareaControls[i]).prop("value",emails.join(", "));
        });
        return G.form_submit(e, G.form_name, G.command_page, cmd);
    };

    G.xssDisplay = function(string, flag)
    {
        string = string.toString();
        string = string.replace("\\", "");
        if (typeof flag !== "undefined")
        {
            return string;
        }
        return unescape(string).replace(/&lt;/gi,"<").replace(/&gt;/gi,">").replace(/&quot;/gi,"\"");
    };

    G.form_submit = function(e, form_name, submit_page, command)
    {
        if (typeof form_name === "undefined" || typeof submit_page === "undefined")
        {
            return false;
        }

        var f = document.forms[form_name];

        if (! G.checkAddress(f, command))
        {
            if(e.stopPropagation) {
                e.stopPropagation();
            } else {
                e.cancelBubble = true;
            }
            return false;
        }
        else
        {
            f.cmd.value = command;
            f.submit();
            return true;
        }
    };

    G.checkAddress = function(frm, command)
    {
        var keys = new Array("to", "cc", "bcc");
        var addresses = [];
        addresses["to"] = frm.to.value;
        addresses["cc"] = frm.cc.value;
        addresses["bcc"] = frm.bcc.value;
        var list = jQuery("#show_validation_errors");
        var errmsg = jQuery("#error_msg");
        if (errmsg.width() > 0 )
        {
            errmsg.remove();
        }

        var i;
        var error_msg = "";
        var addresses_length = 0;
        for(i=0; i<keys.length; i++)
        {
            var key = keys[i];
            var field = frm[key];
            var address_length = encodeURIComponent(addresses[key]).replace(/%../g, "x").length; // get length of string in bytes
            if( field && address_length > field.maxLength )
            {
                // show error message
                error_msg = G.error_message_1 + field.maxLength + G.error_message_2;
            }

            addresses_length += address_length;
        }
        if ( command !== "draft" && addresses_length === 0 )
        {
            // show error message
            error_msg = G.error_message_3;
        }

        if ( error_msg !== "" )
        {
            list.append("<div id= 'error_msg' style='color:#FF0000;'>" +
                        "<span class='bold'>" +
                        "<span style='white-space:nowrap;'>" +
                        "<span class='height: 20px;'>" + error_msg + "</span></span></span></div>");
            return false;
        }
        return true;
    };

    G.changeSign = function()
    {
        var signlist = G.sign_list;
        var signDate = jQuery("#sign_value_id");
        var signPosition = jQuery("#position_id");
        var signid = jQuery("#sign_id").val();

        if ( signid !== "")
        {
            signDate.val(signlist[signid]["data"]);
            signPosition.val(signlist[signid]["position"]);
        }
    };
})(jQuery);

