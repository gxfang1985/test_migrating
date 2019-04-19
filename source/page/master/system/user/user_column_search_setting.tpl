{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

{if count($extension_columns) > 0}
<p>
<div class="explanation">
{cb_msg module='grn.system.user' key='GRN_SY_US-705' replace='true'}
</div>
{assign var="form_name" value="user_column_search_setting"}
<form name="{$form_name}" method="post" action="{cb_pageurl page='system/user/command_user_column_search_setting_modify'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <p>
    <table class="list_column" border="1" cellspacing="0" cellpadding="2" style="width: 400px;">
        <tr>
            <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-252' replace='true'}</th>
            <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-701' replace='true'}</th>
        </tr>
        {foreach from=$extension_columns key=clid item=column}
            <tr valign="top">
                {strip}
                <td nowrap>{$column.display_name}
                    {if $column.show !== '1'}
                        {cb_msg module='grn.system.user' key='GRN_SY_US-706' replace='true'}
                    {/if}
                </td>
                {/strip}
                <td align="center" nowrap>{grn_checkbox name="extension_columns[$clid][search]" id="search_$key" value=1 checked=$column.search disabled=$column.search_disabled}</td>
            </tr>
        {/foreach}
    </table>
    <input class="margin" type="submit" value="{cb_msg module='grn.system.user' key='GRN_SY_US-260' replace='true'}">
    {grn_button_cancel page='system/common_list' id='user'}
</form>
{else}
<p>
    {cb_msg module='grn.system.user' key='GRN_SY_US-707' replace='true'}
</p>
{/if}
{include file='grn/system_footer.tpl'}