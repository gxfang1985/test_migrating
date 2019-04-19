{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/command_'|cat:$page_info.last postfix='users.csv'}">
{include file='system/user/_export.tpl'}
</form>

<hr>
<p>
{capture name=sub_explanation}{cb_msg module='grn.system.user' key='GRN_SY_US-677' replace='true'}{/capture}
{include file='system/user/_user_csv_columns.tpl'}
{include file='grn/csv_columns.tpl' column_explanation=$smarty.capture.explanation type='export' sub_explanation=$smarty.capture.sub_explanation}
{include file="grn/system_footer.tpl"}
{*
{include file="grn/for-screenshot.tpl"}
<script>{literal}
document.observe("dom:loaded",function(){
GrnDoc_Clip("1","div.horizontal div:nth-child(3)");
GrnDoc_Clip("2","div.horizontal div:nth-child(4)");
GrnDoc_Clip("3","div.horizontal div:nth-child(7)");
GrnDoc_Clip("4","div.horizontal div:nth-child(8)");
GrnDoc_Clip("5","table.std_form tr:nth-child(3) th");
GrnDoc_Clip("6","table.std_form tr:nth-child(3) td");
});
{/literal}</script>
*}