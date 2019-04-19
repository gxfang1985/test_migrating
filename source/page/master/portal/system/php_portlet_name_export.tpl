{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_php_portlet_name_export' postfix='php_portlet_name.csv'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">


{include file='portal/system/_export_local_name.tpl'}

{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.portal.system' key='GRN_POT_SY-529' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.portal.system' key='GRN_POT_SY-520' replace='true'}</div> 
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.portal.system' key='GRN_POT_SY-530' replace='true'}</div> 
{/capture}

{include file='grn/csv_columns.tpl' column_explanation=$smarty.capture.explanation type='export'}

</form>
{include file="grn/system_footer.tpl"}
