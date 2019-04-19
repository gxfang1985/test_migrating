{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/personal/command_html_portlet_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="plid" value="{$portlet.plid}">
 <p>{cb_msg module='grn.portal.personal' key='GRN_POT_PE-157' replace='true'}{grn_sentence caption=$portlet.title|cb_mb_truncate image='portlet20.gif' class='bold'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-158' replace='true'}</p>
</form>
