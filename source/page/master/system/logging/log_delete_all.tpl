{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/logging/log_delete_all2'}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="priority" value="{$priority|escape}">
<p>
 <div class="explanation">{cb_msg module='grn.system.logging' key='GRN_SY_LO-10' replace='true'}</div>
 <div class="attention">{cb_msg module='grn.system.logging' key='GRN_SY_LO-11' replace='true'}</div>
</p>

<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-12' replace='true'}</th>
  <td>
   <select name='category'>
   <option value="">{cb_msg module='grn.system.logging' key='GRN_SY_LO-13' replace='true'}</option>
   {assign var='category_key' value=''}
   {foreach from=$categories item=item}
    {foreach from=$item.child item=child}
     {if $child.selected}
   <option value="{$child.value|escape}" selected>{$child.label|escape}</option>
      {assign var='category_key' value=$child.value}
     {else}
   <option value="{$child.value|escape}">{$child.label|escape}</option>
     {/if}
    {/foreach}
   {/foreach}
   </select>
   {* grn_select_hierarchy name='category' hierarchy=$categories padding='　' mark='┗' *}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-14' replace='true'}</th>
  <td>
       {grn_select_date prefix='term_' date=$start_date form_name=$form_name}&nbsp;{cb_msg module='grn.system.logging' key='GRN_SY_LO-15' replace='true'}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_logging_GRN_SY_LO_16'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-16' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_16}
       {grn_button_cancel class='margin' page='system/logging/admin' priority=$priority category=$category_key}
  </td>
 </tr>
</table>

</form>

{include file='grn/system_footer.tpl'}
