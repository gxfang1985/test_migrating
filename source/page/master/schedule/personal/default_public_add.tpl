{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<p></p>
{include file='grn/member_select_add.tpl' json_page='personal/org_json' is_system=false}

<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/personal/command_'|cat:$page_info.last}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    {foreach from=$ous_params key=key item=item}
        <input type="hidden" name="{$key|escape}" value="{$item|escape}">
    {/foreach}

    <input class="margin" type="button" value="{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-92' replace='true'}" onclick="submit(this.form);">
    <input type="button" value="{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-93' replace='true'}" onclick="location.href='{grn_pageurl page='schedule/personal/default_public_list' params=$ous_params}'">
</form>

{include file='grn/personal_footer.tpl'}
