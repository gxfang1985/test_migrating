{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$page_info.all}
<form name="{$form_name}" method="post" action="{grn_pageurl page='message/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.message.system' key='GRN_MSG_SY-35' replace='true'}</th>
  <td>
   {capture name='grn_message_system_GRN_MSG_SY_36'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-36' replace='true'}{/capture}{grn_checkbox name="confirm" id="confirm" value="1" caption=$smarty.capture.grn_message_system_GRN_MSG_SY_36 checked=$confirm}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.message.system' key='GRN_MSG_SY-37' replace='true'}</th>
  <td>
   {capture name='grn_message_system_GRN_MSG_SY_38'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-38' replace='true'}{/capture}{grn_checkbox name="use_re" id="use_re" value="1" caption=$smarty.capture.grn_message_system_GRN_MSG_SY_38 checked=$use_re}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.message.system' key='GRN_MSG_SY-105' replace='true'}</th>
  <td>
   {if $confirm_mode == 0}
    {capture name='grn_message_system_GRN_MSG_SY_40'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-40' replace='true'}{/capture}{grn_radio name='confirm_mode' id='confirm_mode0' value='0' caption=$smarty.capture.grn_message_system_GRN_MSG_SY_40 checked=1}&nbsp;&nbsp;
    {capture name='grn_message_system_GRN_MSG_SY_41'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-41' replace='true'}{/capture}{grn_radio name='confirm_mode' id='confirm_mode1' value='1' caption=$smarty.capture.grn_message_system_GRN_MSG_SY_41 checked=0}
   {else}
    {capture name='grn_message_system_GRN_MSG_SY_42'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-42' replace='true'}{/capture}{grn_radio name='confirm_mode' id='confirm_mode0' value='0' caption=$smarty.capture.grn_message_system_GRN_MSG_SY_42 checked=0}&nbsp;&nbsp;
    {capture name='grn_message_system_GRN_MSG_SY_43'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-43' replace='true'}{/capture}{grn_radio name='confirm_mode' id='confirm_mode1' value='1' caption=$smarty.capture.grn_message_system_GRN_MSG_SY_43 checked=1}
   {/if}   
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn' key='grn.comment.permission.conf.anchor' replace='true'}</th>
  <td>  
        {capture name='grn_message_system_GRN_MSG_SY_45'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-45' replace='true'}{/capture}{grn_checkbox name="enable_follow_autolink" id="enable_follow_autolink" value="1" caption=$smarty.capture.grn_message_system_GRN_MSG_SY_45 checked=$enable_follow_autolink}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      {capture name='grn_message_system_GRN_MSG_SY_46'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-46' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_message_system_GRN_MSG_SY_46}
      {grn_button_cancel}
  </td>
 </tr>
</table>

</form>

{include file='grn/system_footer.tpl'}
