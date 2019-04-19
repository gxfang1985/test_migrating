{if $page_parts[0] == 'system' or $page_parts[1] == 'system'}
    {include file="grn/system_head.tpl"}
    {include file="grn/system_header.tpl"}
    {grn_title title=$page_title class=$page_parts[0]}
{elseif $page_parts[0] == 'personal' or $page_parts[1] == 'personal'}
    {include file="grn/personal_head.tpl"}
    {include file="grn/personal_header.tpl"}
    {grn_title title=$page_title class=$page_parts[0]}
{else}
    {include file="grn/head.tpl"}
    {include file="grn/header.tpl"}
    {grn_title title=$page_title class=""}
{/if}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='grn/command_export_charset'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="page" value="{$page|escape}">
    <table class="std_form">
        <tr>
            <th>{cb_msg module='grn.grn' key='GRN_GRN-1392' replace='true'}</th>
            <td>
                {grn_charset name="charset"}<br>
                <div class="br">&nbsp;</div>
                {capture name='grn_grn_GRN_GRN_1393'}{cb_msg module='grn.grn' key='GRN_GRN-1393' replace='true'}{/capture}{grn_checkbox name="save_charset" id="save_charset" value="1" caption=$smarty.capture.grn_grn_GRN_GRN_1393}
                <br>
                <div class="sub_explanation"><span class="attention">{cb_msg module='grn.grn' key='GRN_GRN-1394' replace='true'}</span></div>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <div class="mTop10">
                    {strip}
                        {capture name='grn_grn_GRN_GRN_1395'}{cb_msg module='grn.grn' key='GRN_GRN-1395' replace='true'}{/capture}
                        {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_grn_GRN_GRN_1395 id="export_button_save" disabled=false auto_disable=false}

                        {grn_button action="cancel" id="export_button_cancel"}
                    {/strip}
                </div>
            </td>
        </tr>
    </table>
</form>

{if $page_parts[0] == 'system' or $page_parts[1] == 'system'}
    {include file="grn/system_footer.tpl"}
{elseif $page_parts[0] == 'personal' or $page_parts[1] == 'personal'}
    {include file="grn/personal_footer.tpl"}
{else}
    {include file="grn/footer.tpl"}
{/if}
