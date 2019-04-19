{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

{capture name='grn_address_GRN_ADDR_74'}{cb_msg module='grn.address' key='GRN_ADDR-74' replace='true'}{/capture}{grn_title title=$smarty.capture.grn_address_GRN_ADDR_74 class=$page_info.parts[0]}

{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='address/search'}">
 <p>
 <table class="std_form">
  <tr valign="top">
   <th>{cb_msg module='grn.address' key='GRN_ADDR-75' replace='true'}</th>
   <td>
      {grn_text necessary=true name="st" value=$search.text size='50'}
      <input type="submit" name="Search" value="{cb_msg module='grn.address' key='GRN_ADDR-76' replace='true'}"><br>
      {capture name='grn_address_GRN_ADDR_77'}{cb_msg module='grn.address' key='GRN_ADDR-77' replace='true'}{/capture}{grn_checkbox name="se" id="sensitive" value="1" checked=$search.sensitive caption=$smarty.capture.grn_address_GRN_ADDR_77}
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.address' key='GRN_ADDR-78' replace='true'}</th>
   <td>{grn_select name='bid' options=$book_options}</td>
  </tr>

<!--
   <div class="item">
    <div class="title">
     <div class="word">{cb_msg module='grn.address' key='GRN_ADDR-79' replace='true'}</div>
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
     {capture name='grn_address_GRN_ADDR_80'}{cb_msg module='grn.address' key='GRN_ADDR-80' replace='true'}{/capture}
     {grn_button id='address_book_button_search' ui='main' action='submit' caption=$smarty.capture.grn_address_GRN_ADDR_80}
    </div>
   </td>
  </tr>
 </table>
</form>

<p>
<div class="sub_title">{cb_msg module='grn.address' key='GRN_ADDR-81' replace='true'} {include file="grn/smart_data_count_310.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}</div>
{assign var='search' value=true}
{include file='address/_list.tpl'}

{include file="grn/footer.tpl"}
