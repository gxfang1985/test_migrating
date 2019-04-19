{*
    $handle_type is used to determine an event is added or edited.
    $handle_type should contain below values:
        + empty, if $handle_type isn't specified it will be empty.
        + add
        + modify
*}
{include file="grn/error_handler.tpl"}
{grn_load_javascript file="grn/html/page/schedule/add.js"}
{literal}
<script language="JavaScript" type="text/javascript">
<!--
var check_add = false;
var browser_type = {/literal}"{$browser.type}"{literal};
var browser_ver_major = {/literal}"{$browser.ver_major}"{literal};
var allow_file_attachment = {/literal}{if $allow_file_attachment}true{else}false{/if}{literal};
var is_ios = {/literal}{if $is_ios}true{else}false{/if}{literal};
var is_android = {/literal}{if $is_android}true{else}false{/if}{literal};
var handle_type = '{/literal}{if isset($handle_type)}{$handle_type}{/if}{literal}';
function _submitNormal(f,ajax_page)
{
    url_redirect = '{/literal}{grn_pageurl page='schedule/view'}{literal}';
    grn.component.button("#schedule_submit_button").showSpinner();
    grn.component.button("#schedule_submit_button_top").showSpinner();

    var request = new grn.component.ajax.request({
                url: ajax_page,
                dataType: "json",
                data: jQuery(f).serialize(),
                method: "post"
            }
    );

    request.on('beforeShowError', function (event, jqXHR) {
        if (typeof jqXHR.responseJSON !== "undefined") {
            var json_obj = jqXHR.responseJSON;
            if (typeof json_obj.validation !== "undefined" && JSON.parse(json_obj.validation) == false) {
                event.preventDefault();
                $('show_error').setStyle({display: ''});
                window.scrollTo(0, 0);
            }
        }
    });

    request.send()
            .done(function (data, textStatus, jqXHR) {
                // remove ajax flag element
                removeAjaxElement(f);
                // remove refresh status dialog flag element
                removeShowRefreshDialogFlag(f);

                var json_obj = jqXHR.responseText.evalJSON();
                if (json_obj.conflict_facility == 1) {
                    showYN(jqXHR, function (except_date) {
                        //my_callback
                        (function ($) {

                            jQuery("#hfExcept").val(except_date);
                            check_add = false;
                            if (grn.base.isNamespaceDefined("grn.page.schedule.add")) {
                                grn.page.schedule.add.schedule_submit(form_name, ajax_page);
                            }
                        })(jQuery);
                    });
                } else {
                    {/literal}{if $kintone_dialog_mode}{literal}
                    window.opener.location.reload();
                    window.close();
                    {/literal}{else}{literal}
                    var link = json_obj.link;
                    window.location = link;
                    {/literal}{/if}{literal}
                }
            })
            .fail(function () {
                // remove ajax flag element
                removeAjaxElement(f);
                // remove refresh status dialog flag element
                removeShowRefreshDialogFlag(f);

                grn.component.button("#schedule_submit_button").hideSpinner();
                grn.component.button("#schedule_submit_button_top").hideSpinner();
                check_add = false;
            });
}

function _submitUpload(f,ajax_page)
{
    url_redirect = '{/literal}{grn_pageurl page='schedule/view'}{literal}';
    grn.component.button("#schedule_submit_button").showSpinner();
    grn.component.button("#schedule_submit_button_top").showSpinner();
    YAHOO.util.Connect.setForm(f, true); //enable AJAX upload file
    YAHOO.util.Connect.asyncRequest('POST', ajax_page,
    {
        upload: function(request){
            removeAjaxElement(f);
            // remove refresh status dialog flag element
            removeShowRefreshDialogFlag(f);
            if(request.responseText.isJSON())
            {
                var json_obj = request.responseText.evalJSON();
                if(json_obj.code)
                {
                    grn.component.button("#schedule_submit_button").hideSpinner();
                    grn.component.button("#schedule_submit_button_top").hideSpinner();
                    if(!json_obj.validation)
                    {
                        grn.component.error_handler.show(request);
                    }
                    else
                    {
                        $('show_error').setStyle({display:''});
                        window.scrollTo(0,0);
                    }
                    check_add = false;
                }
                else
                {
                    if (json_obj.conflict_facility == 1) {
                        showYN(request, function (except_date) {
                            //my_callback
                            (function ($) {

                                jQuery("#hfExcept").val(except_date);
                                check_add = false;
                                if (grn.base.isNamespaceDefined("grn.page.schedule.add")) {
                                    grn.page.schedule.add.schedule_submit(form_name, ajax_page);
                                }
                            })(jQuery);
                        });
                    } else {
                        {/literal}{if $kintone_dialog_mode}{literal}
                        window.opener.location.reload();
                        window.close();
                        {/literal}{else}{literal}
                        var link = json_obj.link;
                        window.location = link;
                        {/literal}{/if}{literal}
                    }
                }
            }
            else
            {
                setAjaxElement(f);
                setShowRefreshDialogFlag(f);
                _submitNormal(f,ajax_page);
            }
        },
        failure: function(request) {
            // remove ajax flag element
            removeAjaxElement(f);
            // remove refresh status dialog flag element
            removeShowRefreshDialogFlag(f);

            grn.component.button("#schedule_submit_button").hideSpinner();
            grn.component.button("#schedule_submit_button_top").hideSpinner();
            grn.component.error_handler.show(request);
            check_add = false;
        }
    });
}

/**
 * This function is called only from schedule/add.js.
 *
 * @param {HTMLElement} f
 * @param {string} ajax_page
 *
 */
function _submit(f,ajax_page)
{
    if (((browser_type == 'msie' && browser_ver_major < 10) || is_ios || is_android) && allow_file_attachment)
    {
        _submitUpload(f,ajax_page);
    }
    else
    {
        _submitNormal(f,ajax_page);
    }
}

function showYN(request, my_callback) {
    var s = request.responseText;
    if (typeof s != 'undefined') {
        var ob_json = s.evalJSON();
        var title;
        var msg;
        var html_rows = "";
        var html_row_header = "";
        var rows_length = 0;
        var rows_limit = 0;
        var html_row_more = "";
        var is_show_more_text = false;
        var event_except = "";
        jQuery.noConflict();
        (function ($) {
            var events = ob_json.conflict_events;
            if (events != null && events.length > 0) {
                rows_length = events.length;
                rows_limit = events.length;
                if (events.length > 5) {//Limit 5 events are displayed.
                    rows_limit = 5;
                    is_show_more_text = true;
                }

                html_row_header = "<tr><th class='nowrap-grn' style='width:30px;'>{/literal}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-69' replace='true'}{literal}</th><th class='nowrap-grn'>{/literal}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-70' replace='true'}{literal}</th></tr>";
                for (var i = 0; i < rows_limit; i++) {
                    html_rows += "<tr><td class='nowrap-grn'><span class='icon_list_style_grn icon_inline_grn'></span><span>" + events[i].setdatetime + "</span></td><td><span>" + events[i].col_facility + "</span></td></tr>";
                    event_except += ";" + events[i].col_setdatetime;
                }
                for (var j = rows_limit; j < events.length; j++) {
                    event_except += ";" + events[j].col_setdatetime;
                }
            }
        })(jQuery);

        if (is_show_more_text == true) {
            html_row_more = "<div class='mTop7'>...&nbsp;" +
            "{/literal}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-73' replace='true'}{literal}" +
            (rows_length - rows_limit) +
            "{/literal}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-87' replace='true'}{literal}</div>";
        }
        msg = "<div class='mBottom10'><span class='icon_attention_grn attentionMessage-grn bold_grn'>{/literal}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-71' replace='true'}{literal}</span></div>";
        msg += "<table class='table_grn table_list_1_grn'>" + html_row_header + html_rows + "</table>" + html_row_more;
        msg += "<div class='border-partition-common-dot-grn'></div>";
        if (ob_json.conflict_all == 1) {// all event are conflict
            msg += "<div class='bold_grn mTop15'>{/literal}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-74' replace='true'}{literal}</div>";
        }
        else {
            if (handle_type == '' || handle_type == 'add') // event is added
            {
                msg += "<div class='bold_grn mTop15'>{/literal}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-72' replace='true'}{literal}</div>";
            }
            else    // modify
            {
                msg += "<div class='bold_grn mTop15'>{/literal}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-83' replace='true'}{literal}</div>";
            }
        }

        var msgboxButtonType = (ob_json.conflict_all) ? GRN_MsgBoxButtons.ok : GRN_MsgBoxButtons.yesno;

        GRN_MsgBox.show(msg, title, msgboxButtonType, {
            ui: [],
            caption: {
                yes: '{/literal}{cb_msg module='grn.common' key='yes' replace='true'}{literal}',
                no: '{/literal}{cb_msg module='grn.common' key='no' replace='true'}{literal}',
                ok: '{/literal}{cb_msg module='grn.common' key='back' replace='true'}{literal}'
            },
            main_button: {ui: grn.component.button.UI.MAIN, autoDisable: true},
            callback: function (result, form) {
                check_add = false;
                grn.component.button("#schedule_submit_button").hideSpinner();
                grn.component.button("#schedule_submit_button_top").hideSpinner();
                if (result == GRN_MsgBoxResult.yes && typeof my_callback != 'undefined') {
                    my_callback(event_except);
                } else {
                    jQuery("#hfExcept").empty();
                    if (result == GRN_MsgBoxResult.ok) {
                        GRN_MsgBox.close();
                    }
                }
            }
        });
    }
}

function toggle(id)
{
    var loading = $(id + '_loading');
    var button = $(id + '_button');
    
    if (!loading)
    {
        loading.innerHTML = '';
        button.disabled = false;
        isLoading = false;
    }
    else
    {
        loading.innerHTML = '<img src="' + G.spinnerImage + '" />';
        button.disabled = true;
        isLoading = true;
    }
}

function setAjaxElement(f)
{
    if( document.getElementById('use_ajax') ) return false;

    var element = document.createElement("input");
    element.setAttribute("type", "hidden");
    element.setAttribute("id", "use_ajax");
    element.setAttribute("name", "use_ajax");
    element.setAttribute("value", "1");
    f.appendChild(element);
    return true;
}

function removeAjaxElement(f)
{
    var use_ajax = document.getElementById('use_ajax');
    if(use_ajax)
    {
        f.removeChild(use_ajax);
    }
}

function setShowRefreshDialogFlag(f)
{
    if (jQuery("#attendance_check_dialog").is(":visible"))
    {
        if( document.getElementById('show_refresh_status_dialog') ) return;

        var element = document.createElement("input");
        element.setAttribute("type", "hidden");
        element.setAttribute("id", "show_refresh_status_dialog");
        element.setAttribute("name", "show_refresh_status_dialog");
        element.setAttribute("value", "1");
        f.appendChild(element);
    }
}

function removeShowRefreshDialogFlag(f)
{
    var show_refresh_status_dialog = document.getElementById('show_refresh_status_dialog');
    if(show_refresh_status_dialog)
    {
        f.removeChild(show_refresh_status_dialog);
    }
}
//-->
</script>
{/literal}
