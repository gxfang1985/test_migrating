{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.workflow.system' key='w_enter_app_form_info_y' replace='true'}</div>
<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}

<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_category'}{cb_msg module='grn.workflow.system' key='w_category' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_category}</th>
  <td>
      {if $category_id == GRN_WORKFLOW_CATEGORY_NONPARTY_ID}{grn_image image='category_trush20.gif'}{cb_msg module='grn.workflow.system' key='w_unlabeled' replace='true'}{else}{grn_image image='category20.gif'}{$category.name|escape}{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_workflow_system_petition_csv_form_name'}{cb_msg module='grn.workflow.system' key='petition_csv_form_name' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_petition_csv_form_name necessary=true}</th>
  <td>
      {capture name='grn_workflow_system_w_app_form_name_required_y'}{cb_msg module='grn.workflow.system' key='w_app_form_name_required_y' replace='true'}{/capture}{validate form=$form_name field="name" criteria="notEmpty" message=$smarty.capture.grn_workflow_system_w_app_form_name_required_y transform="cb_trim" append="validation_errors"}{grn_text name='name' size='50' disable_return_key=true value=$name}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_app_form_code_y'}{cb_msg module='grn.workflow.system' key='w_app_form_code_y' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_app_form_code_y necessary=true}</th>
  <td>
      {capture name='grn_workflow_system_w_app_form_code_required_y'}{cb_msg module='grn.workflow.system' key='w_app_form_code_required_y' replace='true'}{/capture}{validate form=$form_name field="foreign_key" criteria="notEmpty" message=$smarty.capture.grn_workflow_system_w_app_form_code_required_y transform="cb_trim" append="validation_errors"}{grn_text name='foreign_key' size='50' value=$foreign_key}
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.workflow.system' key='w_enter_unique_app_form_code_y' replace='true'}</div>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_workflow_system_w_description_y'}{cb_msg module='grn.workflow.system' key='w_description_y' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_description_y}</th>
  <td>
      {grn_textarea name="memo" rows="10" value=$memo}
  </td>
 </tr>
{if $smarty.const.ON_FOREST !== 1}
 <tr valign="top">
  <th nowrap>{capture name='grn_workflow_system_w_automatic_export_of_app_data_y'}{cb_msg module='grn.workflow.system' key='w_automatic_export_of_app_data_y' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_automatic_export_of_app_data_y}</th>
  <td>
   {capture name='grn_workflow_system_w_export_automatically_y'}{cb_msg module='grn.workflow.system' key='w_export_automatically_y' replace='true'}{/capture}{grn_checkbox name="auto_export" id="auto_export_id" value="1" checked=$auto_export caption=$smarty.capture.grn_workflow_system_w_export_automatically_y onclick="changeDisableById('login_name_export_id:top_line_export_id', this.checked)"}
   <div class="br">&nbsp;</div><br>
   {capture name='grn_workflow_system_w_export_applicants_login_name_y'}{cb_msg module='grn.workflow.system' key='w_export_applicants_login_name_y' replace='true'}{/capture}{grn_checkbox name="login_name_export" id="login_name_export_id" value="1" checked=$login_name_export caption=$smarty.capture.grn_workflow_system_w_export_applicants_login_name_y}
   <div class="br">&nbsp;</div>
   {capture name='grn_workflow_system_w_export_top_line_y'}{cb_msg module='grn.workflow.system' key='w_export_top_line_y' replace='true'}{/capture}{grn_checkbox name="top_line_export" id="top_line_export_id" value="1" checked=$top_line_export caption=$smarty.capture.grn_workflow_system_w_export_top_line_y}
   <div class="br">&nbsp;</div><br>
   {cb_msg module='grn.workflow.system' key='w_directory_name_export_app_data_colon_y' replace='true'}{capture name='grn_workflow_system_key_156'}{cb_msg module='grn.workflow.system' key='key_156' replace='true'}{/capture}{validate form=$form_name field="export_folder" criteria="isRegExp" empty=true expression="/^[\da-zA-Z_\-]+$/" message=$smarty.capture.grn_workflow_system_key_156 transform="cb_trim" append="validation_errors"}{grn_text name='export_folder' size='50' value=$export_folder}
   <div class="sub_explanation">{cb_msg module='grn.workflow.system' key='w_app_data_saved_below_y' replace='true'}<br />{$dir}/workflow/"{cb_msg module='grn.workflow.system' key='w_directory_name' replace='true'}"</div>
  </td>
 </tr>
{/if}
 <tr>
  <td></td>
  <td>
      {capture name='grn_workflow_system_w_do_add_y'}{cb_msg module='grn.workflow.system' key='w_do_add_y' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_do_add_y}
      {grn_button_cancel page='workflow/operation/form_list' cid=$category_id sf=1}
  </td>
 </tr>
</table>

<input type="hidden" name="cid" value="{$category_id|escape}">
</form>
{if $smarty.const.ON_FOREST !== 1}
<script type="text/javascript" language="javascript">
<!--
{literal}
function changeDisableById(ids, type)
{
    var id = new Array();
    if(ids.match(/:/))
    {
        id = ids.split(':');
    }
    else
    {
        id = new Array(ids);
    }
    for(i=0;i<id.length;i++)
    {
        var ec = document.getElementById(id[i]);
        var el = document.getElementById(id[i]+'_label');
        if(ec)
        {
            ec.checked = type? ec.checked : false;
            ec.disabled = !type;
        }
        if(el)
        {
            if(type)
            {
                el.className = '';
                el.onmouseover = function(){this.style.color='#ff0000'}
                el.onmouseout = function(){this.style.color=''}
            }
            else
            {
                el.className = 'form_disable';
                el.onmouseover = function(){}
                el.onmouseout = function(){}
            }
        }
    }
    return;
}
var auto_export = document.getElementById('auto_export_id');
changeDisableById('login_name_export_id:top_line_export_id', auto_export.checked);
{/literal}
//-->
</script>
{/if}
{include file='grn/footer.tpl'}
