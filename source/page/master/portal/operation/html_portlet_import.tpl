{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/operation/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.portal.operation' key='GRN_POT_OP-194' replace='true'}</div>
<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>
   {cb_msg module='grn.portal.operation' key='GRN_POT_OP-195' replace='true'}
  </th>
  <td>
       <select name="portlet_group">
        {foreach from=$portlet_group item=group}
         {if $group.plgid eq $portlet.plgid}
          <option value="{$group.plgid}" selected>{$group.title|escape}
         {else}
          <option value="{$group.plgid}">{$group.title|escape}
         {/if}
        {/foreach}
       </select>
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_portal_operation_GRN_POT_OP_196'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-196' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_portal_operation_GRN_POT_OP_196 necessary=TRUE}
  </th>
  <td>
      {capture name='grn_portal_operation_GRN_POT_OP_197'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-197' replace='true'}{/capture}{validate form=$form_name field="file:file" criteria="grn_notFileEmpty" message=$smarty.capture.grn_portal_operation_GRN_POT_OP_197 append="validation_errors"}{grn_file name="file" size="50" disable_return_key=true necessary=TRUE}</div>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_portal_operation_GRN_POT_OP_198'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-198' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_198 id='btn_file_upload'}
       {grn_button_cancel class="margin" page='portal/operation/html_portlet_list'}
  </td>
 </tr>
</table>

</form>

{include file='grn/footer.tpl'}
