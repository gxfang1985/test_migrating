{include file="grn/personal_head.tpl"}
{include file="grn/personal_header.tpl"}
{grn_title title=$filter.title class=$page_info.parts[0]}
<div id="main_menu_part">
<span class="menu_item">{capture name='grn_mail_personal_GRN_MAIL_PE_61'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-61' replace='true'}{/capture}{grn_link image='modify20.gif' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_61 page='mail/personal/filter_modify' aid=$set.aid mfid=$filter.mfid}</span>
{grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
<span class="menu_item">{capture name='grn_mail_personal_GRN_MAIL_PE_62'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-62' replace='true'}{/capture}{grn_link image='delete20.gif' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_62 page='mail/personal/filter_delete' script='javascript:void(0);' id="lnk_delete"}</span>
</div>

<p>
<table style="border-collapse:collapse" border="1" cellspacing="0" cellpadding="2" bordercolor="#666666" bgcolor="#ffffff">
 <tr>
  <td bgcolor="#cccccc" nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-63' replace='true'}</td>
  <td>{grn_sentence caption=$set.account image='mailaccount20.gif'}
{if $set.stop}
       <br><span class="attention">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-20' replace='true'}</span>
{/if}
  </td>
 </tr>
 <tr>
 </tr>
 <tr>
  <td bgcolor="#cccccc" nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-65' replace='true'}</td>
  <td>{$filter.order|escape}</td>
 </tr>
{if $use_status}
 <tr>
  <td bgcolor="#cccccc" nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-66' replace='true'}</td>
  <td><div style="color: {$set.status_color};">{$set.status_name}</div></td>
 </tr>
{/if}
 <tr>
  <td bgcolor="#cccccc" nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-67' replace='true'}</td>
  <td>
{if $filter.available}
       {grn_mail_show_folder_position folder_id=$filter.cid show_icon=1}
{else}
       {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-68' replace='true'}
{/if}
  </td>
 </tr>
 <tr valign="top">
  <td bgcolor="#cccccc" nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-69' replace='true'}</td>
  <td>
{if $filter.kind eq "1"}
        {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-70' replace='true'}
{else}
        {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-71' replace='true'}
{/if}
       <hr>
       <table class="admin_list_table" width="100%">
        <tr>
         <th>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-72' replace='true'}</th>
         <th>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-73' replace='true'}</th>
         <th width="70%">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-74' replace='true'}</th>
        </tr>
{foreach from=$filter.condition item=condition}
        <tr valign="top">
 {if $condition.object == 'SB'}
         <td nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-75' replace='true'}</td>
 {elseif $condition.object == 'FR'}
         <td nowrap>{cb_msg module='grn.grn' key='GRN_GRN-1484' replace='true'}</td>
 {elseif $condition.object == 'TO'}
         <td nowrap>{cb_msg module='grn.grn' key='GRN_GRN-1485' replace='true'}</td>
 {elseif $condition.object == 'CC'}
         <td nowrap>{cb_msg module='grn.grn' key='GRN_GRN-1486' replace='true'}</td>
 {elseif $condition.object == 'HD'}
         <td nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-76' replace='true'}</td>
 {elseif $condition.object == 'SZ'}
         <td nowrap>{cb_msg module='grn.grn' key='GRN_GRN-1488' replace='true'}</td>
 {/if}
 {if $condition.object == 'SZ'}
  {if $condition.type == 'GE'}
         <td nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-78' replace='true'}</td>
  {elseif $condition.type == 'LE'}
         <td nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-80' replace='true'}</td>
  {/if}
 {else}
  {if $condition.type == 'CO'}
         <td nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-255' replace='true'}</td>
  {elseif $condition.type == 'NCO'}
         <td nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-256' replace='true'}</td>
  {elseif $condition.type == 'SA'}
         <td nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-84' replace='true'}</td>
  {elseif $condition.type == 'NSA'}
         <td nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-85' replace='true'}</td>
  {elseif $condition.type == 'BE'}
         <td nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-86' replace='true'}</td>
  {/if}
 {/if}
         <td>{$condition.value|escape}</td>
        </tr>
{/foreach}
       </table>
  </td>
 </tr>
</table>

{include file="grn/personal_footer.tpl"}
