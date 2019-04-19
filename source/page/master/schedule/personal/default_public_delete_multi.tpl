{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<div class="explanation">
    {strip}
        {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-99' replace='true'}
        {$count}
        {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-100' replace='true'}
        {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-101' replace='true'}
    {/strip}
</div>

<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/personal/command_'|cat:$page_info.last}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    {foreach from=$ous_params key=key item=item}
        <input type="hidden" name="{$key|escape}" value="{$item|escape}">
    {/foreach}
    {foreach from=$eid item=item}
        <input type="hidden" name="eid[]" value="{$item|escape}">
    {/foreach}

    <input class="margin" type="button" value="{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-102' replace='true'}" onclick="submit(this.form);">
    <input type="button" value="{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-103' replace='true'}" onclick="location.href='{grn_pageurl page='schedule/personal/default_public_list' params=$ous_params}'">
</form>

{include file='grn/personal_footer.tpl'}
