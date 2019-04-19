{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
<br>
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="oid" value="{$org_id|escape}">
<input type="hidden" name="uid" value="{$user._id|escape}">

{grn_workflow_agent_add form_name=$form_name user=$user sUID='sUID[]' CGID='CGID' CID='CID[]' agent_type_list=$agent_type_list agent_type_count=$agent_type_count include_org=$show_organize access_plugin=$plugin cancel_page='workflow/system/agent_index' oid=$org_id sf=1 system_flag=TRUE}

</form>

{include file="grn/system_footer.tpl"}
