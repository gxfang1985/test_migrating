{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
<br>
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/personal/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="uid" value="{$user._id|escape}">

{grn_workflow_agent_add form_name=$form_name sUID='sUID[]' CGID='CGID' CID='CID[]' agent_type_list=$agent_type_list agent_type_count=$agent_type_count include_org=$show_organize access_plugin=$plugin cancel_page='workflow/personal/agent_index' oid=$user._id}

</form>

{include file='grn/personal_footer.tpl'}
