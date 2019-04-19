{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<div class="explanation">
    {strip}
        {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-651' replace='true'}
        <span class="bold">{grn_user_name uid=$user_id}</span>
        {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-652' replace='true'}
        {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-653' replace='true'}
    {/strip}
</div>

<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    {foreach from=$ous_params key=key item=item}
        <input type="hidden" name="{$key|escape}" value="{$item|escape}">
    {/foreach}

    <input class="margin" type="button" value="{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-654' replace='true'}" onclick="submit(this.form);">
    <input type="button" value="{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-655' replace='true'}" onclick="location.href='{grn_pageurl page='schedule/system/default_public_list' params=$ous_params}'">
</form>

{include file='grn/system_footer.tpl'}
