{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

{if $available_system_email}
<form name="{$form_name}" method="post" action="{grn_pageurl page='phonemessage/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

  <div class="explanation">
   {cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-30' replace='true'}<br>
   {cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-31' replace='true'}
  </div>

<p>
<table class="std_form">
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-32' replace='true'}</th>
  <td>
    {capture name='grn_phonemessage_system_GRN_PHM_SY_33'}{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-33' replace='true'}{/capture}{grn_checkbox name='use_system_email' id='use_system_email' value='1' caption=$smarty.capture.grn_phonemessage_system_GRN_PHM_SY_33 checked=$use_system_email}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
    {capture name='grn_phonemessage_system_GRN_PHM_SY_34'}{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-34' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_phonemessage_system_GRN_PHM_SY_34}
    {grn_button_cancel}
  </td>
 </tr>
</table>

{else}
<div id="view">
 <p>{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-35' replace='true'}</p>
 <ul>
  <li><span class="bold">{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-36' replace='true'}</span>
 </ul>
 <p>{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-37' replace='true'}</p>
 <ul>
  <li>{capture name='grn_phonemessage_system_GRN_PHM_SY_38'}{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-38' replace='true'}{/capture}{grn_link image='mailaccount20.gif' caption=$smarty.capture.grn_phonemessage_system_GRN_PHM_SY_38 page='system/external/mail'}<br>
 </ul>
</div>
{/if}

</form>

{include file='grn/system_footer.tpl'}
