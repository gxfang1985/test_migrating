{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/personal/command_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.portal.personal' key='GRN_POT_PE-81' replace='true'}<span class="bold delete_count"></span>{cb_msg module='grn.portal.personal' key='GRN_POT_PE-82' replace='true'}{$app_name|escape}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-83' replace='true'}</p>
</form>
