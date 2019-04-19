{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cabinet/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">

<div class="explanation">
{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-61' replace='true'}<span class="bold">{grn_image image='folder20.gif'}{$node.name|escape}</span>{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-62' replace='true'}
{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-63' replace='true'} 
</div>

{capture name='grn_cabinet_system_GRN_CAB_SY_64'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-64' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_64}
{capture name='grn_cabinet_system_GRN_CAB_SY_65'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-65' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_65}

</form>

{include file='grn/system_footer.tpl'}
