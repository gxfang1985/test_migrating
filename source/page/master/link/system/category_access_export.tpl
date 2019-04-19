{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class='bulletin'}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/system/command_'|cat:$page_info.last postfix=$file_name}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="file_name" value="{$file_name|escape}">

<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.link.system' key='GRN_LNK_SY-149' replace='true'}</th>
  <td>{grn_charset name="charset" bom='TRUE'}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.link.system' key='GRN_LNK_SY-150' replace='true'}</th>
  <td>
      {capture name='grn_link_system_GRN_LNK_SY_151'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-151' replace='true'}{/capture}{grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.grn_link_system_GRN_LNK_SY_151 checked=0}&nbsp;{capture name='grn_link_system_GRN_LNK_SY_152'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-152' replace='true'}{/capture}{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.grn_link_system_GRN_LNK_SY_152 checked=1}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_link_system_GRN_LNK_SY_153'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-153' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_link_system_GRN_LNK_SY_153}
       {grn_button_cancel page="system/application_list" app_id="link"}
  </td>
 </tr>
</table>
</form>
<hr>
<p>
{include file="link/system/_access_csv_columns.tpl"} 
{include file="grn/csv_columns.tpl"  column_explanation=$smarty.capture.explanation type="export"}
{include file="grn/system_footer.tpl"}
