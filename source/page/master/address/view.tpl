{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" enctype="multipart/form-data" action="{grn_pageurl page='address/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<!--menubar-->
<div id="main_menu_part">
    {if $access.modify}<span class="menu_item">{capture name='grn_address_GRN_ADDR_31'}{cb_msg module='grn.address' key='GRN_ADDR-31' replace='true'}{/capture}{grn_link page='address/modify' caption=$smarty.capture.grn_address_GRN_ADDR_31 image='modify20.gif' bid=$book_id cid=$card_id element_id="address_modify" alt=''}</span>{/if}
    {if $access.reuse}<span class="menu_item">{capture name='grn_address_GRN_ADDR_32'}{cb_msg module='grn.address' key='GRN_ADDR-32' replace='true'}{/capture}{grn_link page='address/add' caption=$smarty.capture.grn_address_GRN_ADDR_32 image='reuse20.gif' bid=$book_id cid=$card_id element_id="address_reuse" alt=''}</span>{/if}
    {if $access.delete}
        {grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
        <span class="menu_item">{capture name='grn_address_GRN_ADDR_33'}{cb_msg module='grn.address' key='GRN_ADDR-33' replace='true'}{/capture}{grn_link id = 'lnk_delete'  script="javascript:void(0);" page='address/delete' caption=$smarty.capture.grn_address_GRN_ADDR_33 image='delete20.gif' bid=$book_id cid=$card_id alt=''}</span>
    {/if}
    {if $access.copy}<span class="menu_item">{capture name='grn_address_GRN_ADDR_34'}{cb_msg module='grn.address' key='GRN_ADDR-34' replace='true'}{/capture}{grn_link page='address/copy' caption=$smarty.capture.grn_address_GRN_ADDR_34 image='person20.gif' bid=$book_id cid=$card_id alt=''}</span>{/if}
    <!--GRN2-3211-->
    {if $report_available}
        {if $report_count != 0}
            <span class="menu_item">{capture name='grn_address_view_reports'}{cb_msg module='grn.address' key='view_reports' replace='true'}{/capture}{grn_link page='address/report_list' caption=$smarty.capture.grn_address_view_reports image='report20.gif' bid=$book_id cid=$card_id disabled=false alt=''}</span>
        {/if}
    {/if}
    <!--GRN2-3211-->
</div>
<!--menubar_end-->

{grn_title title=$card.subject class=$page_info.parts[0]|cat:' inline_block_grn mBottom10' no_style=1}

<table class="view_table" width="80%">
    <colgroup>
        <col width="20%">
        <col width="80%">
    </colgroup>
    <tr>
        <th>{$book_info.items.display_name.display_name}</th>
        <td>
            {if $book_id > 0}
                {$book_info.items.display_name.value|escape}
            {else}
                {cb_msg module='grn.address' key='GRN_ADDR-35' replace='true'}{$resources.application_name|escape}
            {/if}
        </td>
    </tr>
    {foreach from=$builtin_items key=item_id item=item}
        {if $item.use}
            {if $item_id != 'route_time' && $item_id != 'route_fare' && $item_id != 'route_detail'}
                {include file='address/_view_item_contents.tpl'}
                {if $item.type == GRN_ADDRESS_ITEM_MULTIPLE_STRING || $item_id == 'route'}
                    <tr valign="top">
                {else}
                    <tr>
                {/if}
                    <th>{$smarty.capture.display_name|grn_noescape}</th>
                    <td id="{$item_id}">
                        {if 0 < strlen( $smarty.capture.body )}
                            {$smarty.capture.head|grn_noescape}{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{$smarty.capture.body|grn_noescape}{else}{grn_sso_link caption=$smarty.capture.body sso_id=$item.sso app_id="address" id_list=$card.sso}{/if}{$smarty.capture.foot|grn_noescape}
                        {else}
                            &nbsp;
                        {/if}
                    </td>
                </tr>
            {/if}
        {/if}
    {/foreach}
    <!--builtin_items_end-->
    <!--extended_items-->
    {foreach from=$extended_items key=item_id item=item}
        {if $item.use}
            {if $item_id != 'route_time' && $item_id != 'route_fare' && $item_id != 'route_detail'}
                {include file='address/_view_item_contents.tpl'}
                {if $item.type == GRN_ADDRESS_ITEM_MULTIPLE_STRING}
                    <tr valign="top">
                {else}
                    <tr>
                {/if}
                    <th>{$smarty.capture.display_name|grn_noescape}</th>
                    <td>
                        {if 0 < strlen( $smarty.capture.body )}
                            {$smarty.capture.head|grn_noescape}{if $item.sso == GRN_ADDRESS_SSO_DEFAULT}{$smarty.capture.body|grn_noescape}{else}{grn_sso_link caption=$smarty.capture.body sso_id=$item.sso app_id="address" id_list=$card.sso}{/if}{$smarty.capture.foot|grn_noescape}
                        {else}
                            &nbsp;
                        {/if}
                    </td>
                </tr>
            {/if}
        {/if}
    {/foreach}
    <!--extended_items_end-->
    <tr valign="top">
        <th>{cb_msg module='grn.address' key='GRN_ADDR-36' replace='true'}</th>
        <td>{grn_user_name uid=$card.creator name=$card.creator_name}{cb_msg module='grn.address' key='GRN_ADDR-37' replace='true'}{grn_date_format date=$card.ctime format="DateTimeMiddle_YMDW_HM"}{cb_msg module='grn.address' key='GRN_ADDR-38' replace='true'}</td>
    </tr>
    <tr valign="top">
        <th>{cb_msg module='grn.address' key='GRN_ADDR-39' replace='true'}</th>
        <td>{grn_user_name uid=$card.modifier name=$card.modifier_name}{cb_msg module='grn.address' key='GRN_ADDR-40' replace='true'}{grn_date_format date=$card.mtime format="DateTimeMiddle_YMDW_HM"}{cb_msg module='grn.address' key='GRN_ADDR-41' replace='true'}</td>
    </tr>
</table>
</form>

{include file="grn/footer.tpl"}
