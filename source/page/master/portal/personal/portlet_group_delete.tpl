{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/personal/command_portlet_group_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="plgid" value="{$portlet_group.plgid}">
 <p>{cb_msg module='grn.portal.personal' key='GRN_POT_PE-86' replace='true'}{grn_sentence caption=$portlet_group.title|cb_mb_truncate class='bold'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-87' replace='true'}</p>
</form>
