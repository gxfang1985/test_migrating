{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class='bulletin'}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.link.system' key='GRN_LNK_SY-34' replace='true'}</th>
  <td>
{if $popup_set}
      {capture name='grn_link_system_GRN_LNK_SY_35'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-35' replace='true'}{/capture}{grn_radio name='popup' id='popup1' value='1' caption=$smarty.capture.grn_link_system_GRN_LNK_SY_35 checked=1}&nbsp;&nbsp;{capture name='grn_link_system_GRN_LNK_SY_36'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-36' replace='true'}{/capture}{grn_radio name='popup' id='popup0' value='0' caption=$smarty.capture.grn_link_system_GRN_LNK_SY_36 checked=0}
{else}
      {capture name='grn_link_system_GRN_LNK_SY_37'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-37' replace='true'}{/capture}{grn_radio name='popup' id='popup1' value='1' caption=$smarty.capture.grn_link_system_GRN_LNK_SY_37 checked=0}&nbsp;&nbsp;{capture name='grn_link_system_GRN_LNK_SY_38'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-38' replace='true'}{/capture}{grn_radio name='popup' id='popup0' value='0' caption=$smarty.capture.grn_link_system_GRN_LNK_SY_38 checked=1}
{/if}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_link_system_GRN_LNK_SY_39'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-39' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_link_system_GRN_LNK_SY_39}
       {grn_button_cancel}
  </td>
 </tr>
</table>

</form>

{include file="grn/system_footer.tpl"}
