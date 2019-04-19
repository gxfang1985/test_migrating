{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/command_'|cat:$page_info.last}" enctype="multipart/form-data" onsubmit="{literal}if (this.cmd.value == ''){return false};{/literal}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<!-- 見通しよくナビゲーション -->

<center>
<table border=0>
 <tr align="center">
  <td class="step_current_grn" valign="middle">{cb_msg module='grn.workflow' key='select_mandator' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_grn" valign="middle">{cb_msg module='grn.workflow' key='select_application_form' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_grn" valign="middle">{cb_msg module='grn.workflow' key='enter_contents' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_grn" valign="middle">{cb_msg module='grn.workflow' key='set_path' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_grn" valign="middle">{cb_msg module='grn.workflow' key='confirm_contents' replace='true'}</td>
 </tr>
</table>
</center>

<!-- ここまで　見通しよくナビゲーション -->

<p class="explanation">{cb_msg module='grn.workflow' key='select_user_delegated' replace='true'}</p>
{assign var='half_width_number' value='1'}

<div class="border-partition-common-grn"></div>

<table class="std_form">
 <tr valign="top">
  <th rowspan="1" align="left" width="30%" nowrap>{cb_msg module='grn.workflow' key='mandator' replace='true'}</th>
  <td nowrap>{grn_select name='mandator' size='1' options=$mandator_users}</td>
 </tr>
 <tr>
  <td></td>
  <td>
   <div class="mTop10">
    {capture name='grn_workflow_select_form'}{cb_msg module='grn.workflow' key='select_form' replace='true'} >>{/capture}
    {grn_button id='workflow_button_select_form' ui='main' auto_disable=true caption=$smarty.capture.grn_workflow_select_form onclick="document.forms['`$form_name`'].cmd.value='next'; grn.component.button.util.submit(this);"}
   </div>
  </td>
 </tr>
</table>

<input type="hidden" name="cmd" value="">

</form>

{include file="grn/footer.tpl"}
