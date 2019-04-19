{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class='cabinet'}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cabinet/system/command_folder_modify'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{capture name='grn_cabinet_system_GRN_CAB_SY_56'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-56' replace='true'}{/capture}{include file='cabinet/_folder_form.tpl' submit_caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_56 cancel_page='cabinet/system/folder_view'}

</form>
{include file="grn/system_footer.tpl"}
