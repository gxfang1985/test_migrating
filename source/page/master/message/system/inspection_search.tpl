{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{literal}
<script>
<!--
function display_on_off(s)
{
    var d = document.getElementById('select_user');
    if(s)
    {
        d.style.display = '';
    }
    else
    {
        d.style.display = 'none';
    }
}

function grn_onsubmit_common()
{
    grn.component.member_add.prepareSubmit(["sUID"]);
}
//-->
</script>
{/literal}
<form name="{$form_name}" method="post" action="{grn_pageurl page=$page_info.all}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.message.system' key='GRN_MSG_SY-1' replace='true'}
  </th>
  <td>
      {grn_text necessary=true name='search_text' value=$search_text size='50'}&nbsp;<input class="" type="submit" value="{cb_msg module='grn.message.system' key='GRN_MSG_SY-2' replace='true'}" onClick="grn_onsubmit_common();">
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.message.system' key='GRN_MSG_SY-3' replace='true'}
  </th>
  <td>
       {capture name='grn_message_system_GRN_MSG_SY_4'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-4' replace='true'}{/capture}{grn_radio name='user' id='0' value='0' caption=$smarty.capture.grn_message_system_GRN_MSG_SY_4 onclick='display_on_off(0)' checked=$user.all}
       {capture name='grn_message_system_GRN_MSG_SY_5'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-5' replace='true'}{/capture}{grn_radio name='user' id='1' value='1' caption=$smarty.capture.grn_message_system_GRN_MSG_SY_5 onclick='display_on_off(1)' checked=$user.selected}
       <div id='select_user' {if $user.all}style='display:none;'{/if}>
       {grn_member_add name='sUID' app_id='message' form_name=$form_name selected_users=$initialize_users include_org=false popup_include_org=false org_direct=false}
       </div>
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.message.system' key='GRN_MSG_SY-19' replace='true'}
  </th>
  <td>
      
       {grn_select_date form_name=$form_name prefix='start' timestamp=$start}{cb_msg module='grn.message.system' key='GRN_MSG_SY-20' replace='true'}{grn_select_date form_name=$form_name prefix='end' timestamp=$end}
      
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.message.system' key='GRN_MSG_SY-21' replace='true'}
  </th>
  <td>
{capture name='grn_message_system_GRN_MSG_SY_22'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-22' replace='true'}{/capture}{grn_checkbox name='search_keys[]' id='subject' value='subject' checked=$search_keys.subject caption=$smarty.capture.grn_message_system_GRN_MSG_SY_22}
{capture name='grn_message_system_GRN_MSG_SY_23'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-23' replace='true'}{/capture}{grn_checkbox name='search_keys[]' id='data' value='data' checked=$search_keys.data caption=$smarty.capture.grn_message_system_GRN_MSG_SY_23}
{capture name='grn_message_system_GRN_MSG_SY_24'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-24' replace='true'}{/capture}{grn_checkbox name='search_keys[]' id='sender' value='sender' checked=$search_keys.sender caption=$smarty.capture.grn_message_system_GRN_MSG_SY_24}
{capture name='grn_message_system_GRN_MSG_SY_25'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-25' replace='true'}{/capture}{grn_checkbox name='search_keys[]' id='addressee' value='addressee' checked=$search_keys.addressee caption=$smarty.capture.grn_message_system_GRN_MSG_SY_25}
{capture name='grn_message_system_GRN_MSG_SY_26'}{cb_msg module='grn' key='grn.comment' replace='true'}{/capture}{grn_checkbox name='search_keys[]' id='follow' value='follow' checked=$search_keys.follow caption=$smarty.capture.grn_message_system_GRN_MSG_SY_26}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       <input class="margin" type="submit" value="{cb_msg module='grn.message.system' key='GRN_MSG_SY-27' replace='true'}" onClick="grn_onsubmit_common();">
  </td>
 </tr>
</table>

   <hr>
   <div class="sub_title">{cb_msg module='grn.message.system' key='GRN_MSG_SY-28' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}</div>
   {include file='grn/word_navi.tpl' navi=$navi.navi}
   <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
    <colgroup>
     <col width="30%">
     <col width="30%">
     <col width="25%">
     <col width="15%">
    </colgroup>
    <tr>
     <th nowrap>{cb_msg module='grn.message.system' key='GRN_MSG_SY-31' replace='true'}</th>
     <th nowrap>{cb_msg module='grn' key='grn.comment.body.and.comment' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.message.system' key='GRN_MSG_SY-33' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.message.system' key='GRN_MSG_SY-34' replace='true'}</th>
    </tr>
{foreach from=$search_item item=item}
    <tr valign="top">
     <td>
{if $item.attached}
 {assign var='class_clip' value='_clip8'}
{else}
 {assign var='class_clip' value=''}
{/if}
      {grn_link page='message/system/inspection_view' caption=$item.subject truncated_caption=$truncate_cols image="msg20`$class_clip`.gif" mid=$item.mid}
     </td>
     <td>
      {$item.data|escape:"html"|cb_mb_truncate:$truncate_cols}
     </td>
     <td>{grn_user_name uid=$item.creator_id name=$item.creator_name truncated=$name_width users_info=$users_info}</td>
     <td>{grn_date_format date=$item.mtime}</td>
    </tr>
{/foreach}
   </table>
     <div class="contents_navi">
      {include file='grn/word_navi.tpl' navi=$navi.navi}
     </div>

</form>

<script>
<!--
    var d = document.forms["{$form_name}"];
    window.onload = function(){literal}{{/literal}if(d.elements['user'][1].checked) display_on_off(1);{literal}}{/literal}
//-->
</script>

{include file='grn/system_footer.tpl'}
