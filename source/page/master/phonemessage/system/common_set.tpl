{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='phonemessage/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">


<table class="std_form">
 <tr valign="top">
  <th nowrap>{capture name='grn_phonemessage_system_GRN_PHM_SY_11'}{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-11' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_phonemessage_system_GRN_PHM_SY_11 necessary=false}</th>
  <td>
   {grn_select name='sso' options=$sso_options}
   <div class="margin_top">{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-12' replace='true'}</div>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      {capture name='grn_phonemessage_system_GRN_PHM_SY_13'}{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-13' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_phonemessage_system_GRN_PHM_SY_13}
      {grn_button_cancel}
  </td>
 </tr>
</table>

</form>

{include file='grn/system_footer.tpl'}
