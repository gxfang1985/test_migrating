{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=""}

{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cabinet/system/command_common_set'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

 <p>
 <table class="std_form">
  <!--category_items-->
  <tr>
   <th>{capture name='grn_cabinet_system_GRN_CAB_SY_1'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-1' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_1}</th>
    <td><select name="trash_period">
    {foreach from=$trash_period_list item=period}
        {if $period == $trash_period}
            <option value="{$period}" selected>{$period}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-2' replace='true'}</option>
        {else}
            <option value="{$period}">{$period}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-3' replace='true'}</option>
        {/if}
    {/foreach}
   </select></td>
  </tr>
  <tr>
   <th nowrap>{cb_msg module='grn.system.filemanager' key='bundle.download.max.filesize' replace='true'}</th>
   <td>
    {grn_select name=$bundle_download.name options=$bundle_download.options selected=$bundle_download.selected}
   </td>
  </tr>
  <tr>
   <td><br></td>
   <td>
       {capture name='grn_cabinet_system_GRN_CAB_SY_4'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-4' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_4}
       {grn_button_cancel}
   </td>
  </tr>
 </table>

</form>
{include file="grn/system_footer.tpl"}
