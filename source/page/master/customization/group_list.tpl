{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value="customization/group_list"}

<div id="main_menu_part">
    <span class="menu_item">
        {capture name='grn_customization_group_list_link_add'}{cb_msg module='grn.customization' key='customization.group_list.link.add' replace='true'}{/capture}
        {grn_link image='write20.gif' page=$link_add_page caption=$smarty.capture.grn_customization_group_list_link_add}
    </span>
    <span class="menu_item">
        {capture name='grn_customization_group_list_link_order'}{cb_msg module='grn.customization' key='customization.group_list.link.order' replace='true'}{/capture}
        {grn_link image='modify20.gif' page=$link_order_page caption=$smarty.capture.grn_customization_group_list_link_order disabled=$disable_order}
    </span>
</div>


<form name="{$form_name}">
    <div class="list_menu">
        <span class="list_menu_item">{include file='grn/checkall.tpl' elem_name='ids[]' form_name=$form_name}</span>
        <input id="btn_delete_multi_top" type="button"
               value="{cb_msg module='grn.customization' key='customization.group_list.button.delete' replace='true'}"/>
    </div>

    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}"/>
    <input type="hidden" name="id"/>
    <input type="hidden" name="cmd"/>
    <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
        <colgroup>
            <col width="1%">
            <col width="80%">
            <col width="9%">
        </colgroup>

        <tr>
            <th nowrap></th>
            <th nowrap>{cb_msg module='grn.customization' key='customization.group_list.field_group_name' replace='true'}</th>
            <th nowrap>{cb_msg module='grn.customization' key='customization.group_list.field_status' replace='true'}</th>
        </tr>

        {foreach from=$group_list key=key item=group}
            <tr valign="top">
                <td class="tAlignCenter-grn vAlignMiddle-grn"
                    nowrap>{grn_checkbox name='ids[]' id="group_item_`$key`" value=$group->getId()}</td>
                <td class="vAlignMiddle-grn"
                    nowrap>{grn_link page='schedule/system/customization_group_view' caption=$group->getName() id=$group->getId()}</td>
                <td class="vAlignMiddle-grn" nowrap>
                    {if $group->isActive()}
                        <span class="font_green">
                        {cb_msg module='grn.customization' key='customization.group_list.status_active' replace='true'}
                        </span>
                    {else}
                        <span class="font_red">
                        {cb_msg module='grn.customization' key='customization.group_list.status_deactivate' replace='true'}
                        </span>
                    {/if}
                </td>
            </tr>
        {/foreach}
    </table>

    <div class="list_menu">
        <span class="list_menu_item">{include file='grn/checkall.tpl' elem_name='ids[]' form_name=$form_name}</span>
        <input id="btn_delete_multi_bottom" type="button"
               value="{cb_msg module='grn.customization' key='customization.group_list.button.delete' replace='true'}"/>
    </div>
</form>


{grn_delete
title=$delete_info.title
page=$delete_info.page
data=$delete_info.data
handler=$delete_info.handler
multi_target=$delete_info.multi_target
form_target=$delete_info.form_target}

{include file='grn/system_footer.tpl'}