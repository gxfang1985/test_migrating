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
    if( typeof setHightlight == "function" )
        setHightlight();

    grn.page.mail.mail_3pane.mid = "";
    var count = grn.page.mail.mail_3pane.countCheckedItem();
    if (count > 0)
    {
        grn.page.mail.mail_list.blankMailView(count);
    }
    else
    {
        grn.page.mail.mail_list.blankMailView();
    }
}
function setHightlight()
{
    if( !enable_shift_click )
        return;
    var div = jQuery("div#mail_list").get(0);
    if( div )
    {
        var rows = jQuery(div).find("li[id^='mail_list-row_']");
        rows.each(function(idx, row){
            var row_jquery_obj = jQuery(row);
            var chkbox = row_jquery_obj.find("input[type='checkbox']").eq(0);
            if ( chkbox.length == 0 )
                return;
            if( chkbox.is(":checked") )
            {
                row_jquery_obj.addClass("list_select_grn");
            }
            else
            {
                row_jquery_obj.removeClass("list_select_grn");
            }
        });
    }
}
function applyShiftClick()
{
    if( !enable_shift_click )
        return;
    var list = jQuery("div#mail_list").get(0);
    var row = null;
    var row2 = null;
    if( list )
    {
        var chkboxs = fastGetElementsByName(list, "input", element_name);
        var i=0;
        jQuery(chkboxs).each(function(idx, chkbox)
        {
            // create index for each check box
            chkbox.index = i;

            var chkbox_jquery_obj = jQuery(chkbox);
            chkbox_jquery_obj.on("click", function(e){
                row = chkbox_jquery_obj.parents().parents().parents().parents("li").eq(0);
                if(this.checked)
                    row.addClass("list_select_grn");
                else
                    row.removeClass("list_select_grn");
                // handle Shift click
                var last_click = list.last_click;
                var last_click_index = last_click ? last_click.index : 0;
                var current = this;
                var current_index = this.index;
                var low = Math.min(last_click_index, current_index);
                var high = Math.max(last_click_index, current_index);

                if(e.shiftKey){
                    var chkboxs2 = fastGetElementsByName(list, "input", element_name);
                    jQuery(chkboxs2).each(function(index, item){
                        row2 = jQuery(item).parents().parents().parents().parents("li").eq(0);

                        if(item.index >= low && item.index <= high){
                            item.checked = current.checked;
                        }

                        if(item.checked)
                            row2.addClass("list_select_grn");
                        else
                            row2.removeClass("list_select_grn");
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

<span class="aButtonStandard-grn"><a href="javascript:void(0);" onClick="{$func_name}();return false"><span class="mail-listCheck-grn"></span></a></span>
