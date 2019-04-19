{assign var="form_name" value=$smarty.template|basename}
{capture name=sub_explanation}{cb_msg module='grn.system.user' key='GRN_SY_US-574' replace='true'}{/capture}
{include file='system/user/_user_csv_columns.tpl'}
{include file='grn/std_import1.tpl' config_id='system' cancel_page='system/user/org_import_index' post_page='system/user/command_user_import1' column_explanation=$smarty.capture.explanation sub_explanation=$smarty.capture.sub_explanation delete_user_message=TRUE}
{*
{include file="grn/for-screenshot.tpl"}
<script>{literal}
document.observe("dom:loaded",function(){
GrnDoc_Clip("1","div.horizontal div:nth-child(3)");
GrnDoc_Clip("2","div.horizontal div:nth-child(4)");
GrnDoc_Clip("3","div.horizontal div:nth-child(7)");
GrnDoc_Clip("4","div.horizontal div:nth-child(8)");
GrnDoc_Clip("5","table.std_form tr:nth-child(4) th");
GrnDoc_Clip("6","table.std_form tr:nth-child(4) td");
});
{/literal}</script>
*}