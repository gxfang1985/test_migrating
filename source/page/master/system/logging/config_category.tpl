{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title|cat:' - Step 1/2' class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="get" action="{grn_pageurl page='system/logging/config'}">
<input type="hidden" name="priority" value="{$priority|escape}">
<div class="explanation">{cb_msg module='grn.system.logging' key='GRN_SY_LO-84' replace='true'}</div>

<p>
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_system_logging_GRN_SY_LO_85'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-85' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_logging_GRN_SY_LO_85}</th>
  <td>
   <select name='category'>
   <option value="">{cb_msg module='grn.system.logging' key='GRN_SY_LO-86' replace='true'}</option>
   {foreach from=$categories item=item}
    {foreach from=$item.child item=child}
     {if $child.selected}
   <option value="{$child.value|escape}" selected>{$child.label|escape}</option>
     {else}
   <option value="{$child.value|escape}">{$child.label|escape}</option>
     {/if}
    {/foreach}
   {/foreach}
   </select>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_logging_GRN_SY_LO_87'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-87' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_logging_GRN_SY_LO_87}
       {grn_button_cancel page='system/logging/admin'}
  </td>
 </tr>
</table>

</form>

{include file='grn/system_footer.tpl'}
