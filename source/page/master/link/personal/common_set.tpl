{include file="grn/personal_head.tpl"}
{include file="grn/personal_header.tpl"}
{grn_title title=$page_title class='bulletin'}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.link.personal' key='GRN_LNK_PE-1' replace='true'}</th>
  <td>
{if $popup_set}
      {capture name='grn_link_personal_GRN_LNK_PE_2'}{cb_msg module='grn.link.personal' key='GRN_LNK_PE-2' replace='true'}{/capture}{grn_radio name='popup' id='popup1' value='1' caption=$smarty.capture.grn_link_personal_GRN_LNK_PE_2 checked=1}&nbsp;&nbsp;{capture name='grn_link_personal_GRN_LNK_PE_3'}{cb_msg module='grn.link.personal' key='GRN_LNK_PE-3' replace='true'}{/capture}{grn_radio name='popup' id='popup0' value='0' caption=$smarty.capture.grn_link_personal_GRN_LNK_PE_3 checked=0}
{else}
      {capture name='grn_link_personal_GRN_LNK_PE_4'}{cb_msg module='grn.link.personal' key='GRN_LNK_PE-4' replace='true'}{/capture}{grn_radio name='popup' id='popup1' value='1' caption=$smarty.capture.grn_link_personal_GRN_LNK_PE_4 checked=0}&nbsp;&nbsp;{capture name='grn_link_personal_GRN_LNK_PE_5'}{cb_msg module='grn.link.personal' key='GRN_LNK_PE-5' replace='true'}{/capture}{grn_radio name='popup' id='popup0' value='0' caption=$smarty.capture.grn_link_personal_GRN_LNK_PE_5 checked=1}
{/if}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_link_personal_GRN_LNK_PE_6'}{cb_msg module='grn.link.personal' key='GRN_LNK_PE-6' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_link_personal_GRN_LNK_PE_6}
       {grn_button_cancel}
  </td>
 </tr>
</table>

</form>

{include file="grn/personal_footer.tpl"}
