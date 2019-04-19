{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=""}

{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='memo/system/command_common_set'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

 <p>
 <table class="std_form">
  <!--category_items-->
  <tr>
   <th>{capture name='grn_memo_system_GRN_MEM_SY_1'}{cb_msg module='grn.memo.system' key='GRN_MEM_SY-1' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_memo_system_GRN_MEM_SY_1}</th>
   <td><select name="filesize_limit">
{foreach from=$filesize_menu item=size}
 {if $size == -1}
  <option value="{$size}"{if $size == $filesize_limit} selected{/if}>{cb_msg module='grn.memo.system' key='GRN_MEM_SY-2' replace='true'}</option>
 {elseif $size == 0}
  <option value="{$size}"{if $size == $filesize_limit} selected{/if}>{cb_msg module='grn.memo.system' key='GRN_MEM_SY-3' replace='true'}</option>
 {else}
  {math assign='mb' equation='x / y' x=$size y=$mega_byte}
  <option value="{$size}"{if $size == $filesize_limit} selected{/if}>{$mb} MB</option>
 {/if}
{/foreach}
   </select></td>
  </tr>
  <tr>
   <th>{capture name='grn_memo_system_GRN_MEM_SY_4'}{cb_msg module='grn.memo.system' key='GRN_MEM_SY-4' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_memo_system_GRN_MEM_SY_4}</th>
   <td>{capture name='grn_memo_system_GRN_MEM_SY_5'}{cb_msg module='grn.memo.system' key='GRN_MEM_SY-5' replace='true'}{/capture}{grn_checkbox name='enable_htmleditor' id='enable_htmleditor' value=1 checked=$enable_htmleditor caption=$smarty.capture.grn_memo_system_GRN_MEM_SY_5}</td>
  </tr>
  <tr>
   <td><br></td>
   <td>
       {capture name='grn_memo_system_GRN_MEM_SY_6'}{cb_msg module='grn.memo.system' key='GRN_MEM_SY-6' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_memo_system_GRN_MEM_SY_6}
       {grn_button_cancel}
   </td>
  </tr>
 </table>

</form>
{include file="grn/system_footer.tpl"}
