{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/personal/command_portlet_group_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.portal.personal' key='GRN_POT_PE-152' replace='true'}<span class="bold delete_count">{$delete_item.delete_numbers}</span>{cb_msg module='grn.portal.personal' key='GRN_POT_PE-153' replace='true'}</p>
</form>
