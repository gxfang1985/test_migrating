{if ! $elem_name}
 {assign var="elem_name" value="eid"}
{/if}
{if ! $form_name}
 {assign var="form_name" value=$page_info.last}
{/if}
{if ! $func_name}
 {assign var="func_name" value='CheckAll'}
{/if}
<script language="JavaScript" type="text/javascript">
<!--
var enable_shift_click = {if $enable_shift_click}true{else}false{/if};
var element_name = '{$elem_name}';
function {$func_name}()
{literal}
{
    var e = document.forms["{/literal}{$form_name}{literal}"].elements;
    var l = e.length;
    var checked = false;
    for( i = 0 ; i < l ; i ++ ) { if( e[i].name == {/literal}"{$elem_name}"{literal} && e[i].style.display=="" && ! e[i].checked  ) { checked = true;break; } }
    for( i = 0 ; i < l ; i ++ ) { if( e[i].name == {/literal}"{$elem_name}"{literal} && e[i].style.display=="" ) { e[i].checked=checked; } }
    if( typeof setHightlight == 'function' )
        setHightlight();
}

// apply shift click
{/literal}
{if !$space_flag}
applyShiftClick();
{/if}
{literal}
function setHightlight()
{
    if (!enable_shift_click)
        return;

    var table = jQuery("table.list_column").get(0);
    if (table) {
        var rows = jQuery(table).find("tr");
        rows.each(function (index, row) {
            var row_jquery_obj = jQuery(row);
            var chkbox = row_jquery_obj.find("input[type='checkbox']").eq(0);
            if (chkbox.length == 0)
                return;

            if (chkbox.is(":checked")) {
                row_jquery_obj.addClass("row_highlight");
            }
            else {
                row_jquery_obj.removeClass("row_highlight");
            }

        });
    }
}
function applyShiftClick()
{
    if (!enable_shift_click)
        return;

    var list = jQuery("table.list_column").get(0);
    var row = null;
    var row2 = null;
    if (list) {
        var chkboxs = fastGetElementsByName(list, 'input', element_name);
        var i = 0;
        jQuery.each(chkboxs, function (index, chkbox) {
            chkbox.index = i;

            var chkbox_jpuery_object = jQuery(chkbox);
            chkbox_jpuery_object.on("click", function (e) {
                row = chkbox_jpuery_object.parents("tr").eq(0);
                if (this.checked) {
                    row.addClass("row_highlight");
                }
                else {
                    row.removeClass("row_highlight");
                }

                //handle Shift click
                var last_click = list.last_click;
                var last_click_index = last_click ? last_click.index : 0;
                var current = this;
                var current_index = this.index;
                var low = Math.min(last_click_index, current_index);
                var high = Math.max(last_click_index, current_index);

                if (e.shiftKey) {
                    var chkboxs2 = fastGetElementsByName(list, 'input', element_name);
                    jQuery(chkboxs2).each(function (index, item) {
                        row2 = jQuery(item).parents("tr").eq(0);

                        if (item.index >= low && item.index <= high) {
                            item.checked = current.checked;
                        }

                        if (item.checked) {
                            row2.addClass('row_highlight');
                        }
                        else {
                            row2.removeClass('row_highlight');
                        }
                    });
                }
                list.last_click = e.target;
            });
            i++;
        });
    }
}
{/literal}
//-->
</script>
{strip}
{if $mail_flag}
<a href="javascript:" onClick="{$func_name}();return false"><span class="mail-listCheck-grn"></span></a>
{elseif $space_flag}
<span class="js_checkall small_button_base_grn mRight10"><span class="aButtonStandard-grn"><a href="javascript:void(0);" onClick="{$func_name}();return false;"><span class="listcheck_button_grn"></span></a></span></span>
{elseif $notification_flag}
<span class="js_checkall small_button_base_grn mRight10"><span class="aButtonStandard-grn"><a href="javascript:void(0);" onClick="{$func_name}();return false;" role="button" title="{cb_msg module='grn.grn' key='GRN_GRN-431' replace='true'}"><span class="listcheck_button_grn"></span></a></span></span>
{else}
<button class="check_button" style="width:20px; height:20px" onClick="javascript:{$func_name}();return false">{capture name='grn_grn_GRN_GRN_431'}{cb_msg module='grn.grn' key='GRN_GRN-431' replace='true'}{/capture}{grn_image image='check10.gif' alt=$smarty.capture.grn_grn_GRN_GRN_431}</button>
{/if}
{/strip}