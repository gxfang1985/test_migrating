{assign var='form_name' value='news'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-54' replace='true'}
  </th>
  <td>
      {grn_select name='font_size' options=$font_options}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-55' replace='true'}
  </th>
  <td>
{if $display neq 'set-system' && $display neq 'set-operation'}
      {grn_mail_select_accounts select_name='user_account[]' selected_account_ids=$user_account hide_disable_account=1 need_checkbox=1 show_no_account_message=1}
{*アカウントが設定されていません。*}
{else}
      {capture name='grn_mail_portlet_GRN_MAIL_PO_56'}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-56' replace='true'}{/capture}{grn_radio name="user_account" id="account_default" value="default"  caption=$smarty.capture.grn_mail_portlet_GRN_MAIL_PO_56 checked=$user_account.default}
      {capture name='grn_mail_portlet_GRN_MAIL_PO_57'}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-57' replace='true'}{/capture}{grn_radio name="user_account" id="account_all" value="all" caption=$smarty.capture.grn_mail_portlet_GRN_MAIL_PO_57 checked=$user_account.all}
{/if}
  </td>
 </tr>

{if 0}
 <tr>
  <th nowrap>
      {cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-58' replace='true'}{$app_name|escape}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-59' replace='true'}
  </th>
  <td>
      {capture name='grn_mail_portlet_GRN_MAIL_PO_60'}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-60' replace='true'}{/capture}{grn_checkbox name="check_mails" id="check_mails"  value="1" checked=$check_mails caption=$smarty.capture.grn_mail_portlet_GRN_MAIL_PO_60}
  </td>
 </tr>
{/if}

{if ! $cannot_check_mails}
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-61' replace='true'}{$app_name|escape}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-62' replace='true'}
  </th>
  <td>
 {if $check_mails}
       {capture name='grn_mail_portlet_GRN_MAIL_PO_63'}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-63' replace='true'}{/capture}{grn_radio name='check_mails' id='check_mails1' value='1' caption=$smarty.capture.grn_mail_portlet_GRN_MAIL_PO_63 checked=TRUE}&nbsp;{capture name='grn_mail_portlet_GRN_MAIL_PO_64'}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-64' replace='true'}{/capture}{grn_radio name='check_mails' id='check_mails0' value='0' caption=$smarty.capture.grn_mail_portlet_GRN_MAIL_PO_64}
 {else}
       {capture name='grn_mail_portlet_GRN_MAIL_PO_65'}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-65' replace='true'}{/capture}{grn_radio name='check_mails' id='check_mails1' value='1' caption=$smarty.capture.grn_mail_portlet_GRN_MAIL_PO_65}&nbsp;{capture name='grn_mail_portlet_GRN_MAIL_PO_66'}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-66' replace='true'}{/capture}{grn_radio name='check_mails' id='check_mails0' value='0' caption=$smarty.capture.grn_mail_portlet_GRN_MAIL_PO_66 checked=TRUE}
 {/if}
       <br>&nbsp;{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-67' replace='true'}&nbsp;{$app_name|escape}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-68' replace='true'}{grn_select_numbers select_name='check_span' options=$check_span_options padding='&nbsp;' selected=$check_span}&nbsp;{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-69' replace='true'}
  </td>
 </tr>
{else}
<input type="hidden" name="check_mails" value="{$check_mails}">
<input type="hidden" name="check_span" value="{$check_span}">
{/if}

 <tr>
  <td></td>
  <td>
       {capture name='grn_mail_portlet_GRN_MAIL_PO_71'}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-71' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_mail_portlet_GRN_MAIL_PO_71}
{if $display == 'set-system'}
       {capture name='grn_mail_portlet_GRN_MAIL_PO_72'}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-72' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_mail_portlet_GRN_MAIL_PO_72 page='portal/system/view' pid=$portlet.pid}
{elseif $display == 'set-operation'}
       {capture name='grn_mail_portlet_GRN_MAIL_PO_73'}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-73' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_mail_portlet_GRN_MAIL_PO_73 page='portal/operation/view' pid=$portlet.pid}
{else}
       {capture name='grn_mail_portlet_GRN_MAIL_PO_74'}{cb_msg module='grn.mail.portlet' key='GRN_MAIL_PO-74' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_mail_portlet_GRN_MAIL_PO_74 page='portal/personal/view' pid=$portlet.pid}
{/if}
  </td>
 </tr>
</table>

<input type="hidden" name="pid" value="{$portlet.pid}">
<input type="hidden" name="plid" value="{$portlet.plid}">
<input type="hidden" name="ppid" value="{$portlet.ppid}">
<input type="hidden" name="display" value="{$display}">
</form>
