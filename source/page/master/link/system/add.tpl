{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

    <p><div class="explanation">{cb_msg module='grn.link.system' key='GRN_LNK_SY-54' replace='true'}</div></p>
    
    {include file="grn/show_validation_errors.tpl"}
    {include file='grn/indispensable.tpl'}
    
    {include file='link/system/_add.tpl' button_file='link/system/_add_buttons.tpl'}
    
    <input type="hidden" name="cid" value="{$category.cid}">
</form>

{include file="grn/system_footer.tpl"}
