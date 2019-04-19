{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

{capture name='grn_address_GRN_ADDR_65'}{cb_msg module='grn.address' key='GRN_ADDR-65' replace='true'}{/capture}{grn_title title=$smarty.capture.grn_address_GRN_ADDR_65 class=$page_info.parts[0]}

{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='address/user_search'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
 <table class="std_form">
  <tr valign="top">
   <th>{cb_msg module='grn.address' key='GRN_ADDR-66' replace='true'}</th>
   <td>
      {grn_text necessary=true name="st" value=$search.text size='50'}
      <input type="submit" name="Search" value="{cb_msg module='grn.address' key='GRN_ADDR-67' replace='true'}"><br>
      {capture name='grn_address_GRN_ADDR_68'}{cb_msg module='grn.address' key='GRN_ADDR-68' replace='true'}{/capture}{grn_checkbox name="se" id="sensitive" value="1" checked=$search.sensitive caption=$smarty.capture.grn_address_GRN_ADDR_68}
   </td>
  </tr>
  <tr>

<!--
   <div class="item">
    <div class="title">
     <div class="word">{cb_msg module='grn.address' key='GRN_ADDR-69' replace='true'}</div>
    </div>
    <div class="contents">
     <div class="word">
 {foreach from=$builtin_items key=key item=item}
      <nobr>{grn_checkbox name='iid' id="iid_$key" value=$key caption=$item.display_name checked=true}&nbsp;</nobr>
 {/foreach}
     </div>
    </div>
   </div>
-->

  <tr>
   <td></td>
   <td>
    <div class="mTop10">
     {capture name='grn_address_GRN_ADDR_70'}{cb_msg module='grn.address' key='GRN_ADDR-70' replace='true'}{/capture}
     {grn_button id='address_book_button_search' ui='main' action='submit' caption=$smarty.capture.grn_address_GRN_ADDR_70}
    </div>
   </td>
  </tr>
 </table>
</form>
<p>
<div class="sub_title">{cb_msg module='grn.address' key='GRN_ADDR-71' replace='true'} {include file="grn/smart_data_count_310.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}</div>
{include file='address/_user_list.tpl'}

{include file="grn/footer.tpl"}
