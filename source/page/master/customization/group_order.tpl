{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page=$command_page}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="cmd" value="order">
    <div id="one_parts">
        <div id="action">
            {grn_change_order form_name=$form_name select_name='order[]' options=$options}
        </div>
    </div>
    {strip}
        <input class="margin" type="submit"
               value="{cb_msg module='grn.customization' key='customization.group_order.button.save' replace='true'}"
               onclick="grn_onsubmit_common(this.form);">
        <input type="button"
               value="{cb_msg module='grn.customization' key='customization.group_order.button.cancel' replace='true'}"
               onclick="location.href='{grn_pageurl page=$redirect_page}'">
    {/strip}
</form>

{include file='grn/system_footer.tpl'}