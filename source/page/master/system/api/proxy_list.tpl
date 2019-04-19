{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

{grn_customization_disabled_warning}

<div id="main_menu_part">
    <span class="menu_item">
        {capture name='grn_system_proxy_api_add'}{cb_msg module='grn.system.api' key='proxy_api_add' replace='true'}{/capture}
        {grn_link page='system/api/proxy_add' caption=$smarty.capture.grn_system_proxy_api_add image='write20.gif'}
    </span>
</div>

<form name="system/api/proxy_list" method="post" action="{grn_pageurl page='system/api/command_proxy_list'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}"/>
    <input type="hidden" name="id"/>
    {include file='grn/checkall.tpl' elem_name='proxy_ids[]' form_name='system/api/proxy_list'}
    <input id="btn_delete_multi_top" class="js_btn_delete" type="button"
           value="{cb_msg module='grn.system.api' key='proxy_api_delete' replace='true'}"/>
    <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
        <colgroup>
            <col width="1%">
            <col width="80%">
            <col width="9%">
        </colgroup>

        <tr>
            <th nowrap></th>
            <th nowrap>{cb_msg module='grn.system.api' key='proxy_api_field_id' replace='true'}</th>
            <th nowrap>{cb_msg module='grn.system.api' key='proxy_api_field_status' replace='true'}</th>
        </tr>

        {foreach from=$proxy_list key=key item=proxy}
            <tr valign="top">
                <td class="tAlignCenter-grn vAlignMiddle-grn" nowrap>{grn_checkbox name='proxy_ids[]' id="proxy_item_`$key`" value=$proxy->getId()}</td>
                <td class="vAlignMiddle-grn" nowrap>{grn_link page='system/api/proxy_view' caption=$proxy->getCode() id=$proxy->getId()}</td>
                <td class="vAlignMiddle-grn" nowrap>
                    {if $proxy->getActive()}
                        <span class="font_green">
                            {cb_msg module='grn.system.api' key='proxy_field_status_apply' replace='true'}
                        </span>
                    {else}
                        <span class="font_red">
                            {cb_msg module='grn.system.api' key='proxy_field_status_not_apply' replace='true'}
                        </span>
                    {/if}
                </td>
            </tr>
        {/foreach}
    </table>

    {include file='grn/checkall.tpl' elem_name='proxy_ids[]' form_name='system/api/proxy_list'}
    <input id="btn_delete_multi_bottom" class="js_btn_delete" type="button"
           value="{cb_msg module='grn.system.api' key='proxy_api_delete' replace='true'}"/>
</form>

{grn_delete
    title=$deletion_info.title
    page=$deletion_info.page
    data=$deletion_info.data
    handler=$deletion_info.handler
    multi_target=$deletion_info.multi_target
    form_target=$deletion_info.form_target}

{include file='grn/system_footer.tpl'}