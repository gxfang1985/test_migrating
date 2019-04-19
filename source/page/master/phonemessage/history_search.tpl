{include file='grn/head.tpl'}
{include file='grn/header.tpl'}

{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='phonemessage/history_search'}">
<input type="hidden" name="cid" value="{$category_id}">
<input type="hidden" name="gid" value="{$group_id}">
<input type="hidden" name="uid" value="{$user_id}">
<div id="one_parts">
 <p>
 <table class="std_form">
  <tr valign="top">
   <th>{cb_msg module='grn.phonemessage' key='GRN_PHM-70' replace='true'}</th>
   <td>
    {grn_text necessary=true name="search_text" value=$search_text size="50"}
    <input type="submit" name="Search" value="{cb_msg module='grn.phonemessage' key='GRN_PHM-71' replace='true'}"><br>
    {capture name='grn_phonemessage_GRN_PHM_72'}{cb_msg module='grn.phonemessage' key='GRN_PHM-72' replace='true'}{/capture}{grn_checkbox name="sensitive" id="sensitive" value="1" checked=$sensitive caption=$smarty.capture.grn_phonemessage_GRN_PHM_72}
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.phonemessage' key='GRN_PHM-73' replace='true'}</th>
   <td>{grn_select name='cid' options=$category_options}</td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.phonemessage' key='GRN_PHM-74' replace='true'}</th>
   <td>
    {capture name='grn_phonemessage_GRN_PHM_75'}{cb_msg module='grn.phonemessage' key='GRN_PHM-75' replace='true'}{/capture}{grn_checkbox name="search_keys[message]" id="message" value="message" checked=$search_keys.message caption=$smarty.capture.grn_phonemessage_GRN_PHM_75}
    {capture name='grn_phonemessage_GRN_PHM_76'}{cb_msg module='grn.phonemessage' key='GRN_PHM-76' replace='true'}{/capture}{grn_checkbox name="search_keys[receiver_name]" id="receiver_name" value="receiver_name" checked=$search_keys.receiver_name caption=$smarty.capture.grn_phonemessage_GRN_PHM_76}
    {capture name='grn_phonemessage_GRN_PHM_77'}{cb_msg module='grn.phonemessage' key='GRN_PHM-77' replace='true'}{/capture}{grn_checkbox name="search_keys[sender_name]" id="sender_name" value="sender_name" checked=$search_keys.sender_name caption=$smarty.capture.grn_phonemessage_GRN_PHM_77}
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.phonemessage' key='GRN_PHM-78' replace='true'}</th>
   <td>{grn_select name='status' options=$status_options}</td>
  </tr>
  <tr>
   <td></td>
   <td>
    <div class="mTop10">
     {capture name='grn_phonemessage_GRN_PHM_79'}{cb_msg module='grn.phonemessage' key='GRN_PHM-79' replace='true'}{/capture}
     {grn_button id='phone_messages_button_search' action='submit' ui='main' caption=$smarty.capture.grn_phonemessage_GRN_PHM_79}
    </div>
   </td>
  </tr>
 </table>

 <p>
 <div class="sub_title">{cb_msg module='grn.phonemessage' key='GRN_PHM-80' replace='true'}</div>
 {assign var='search_page' value=true}
 {include file='phonemessage/_list.tpl'}
 <input type="hidden" name="second_search" value="1">
 </div>
</form>

{include file="grn/footer.tpl"}
