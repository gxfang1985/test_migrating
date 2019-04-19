{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_mail_system_GRN_MAIL_SY_48'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-48' replace='true'}{/capture}{grn_link image='modify20.gif' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_48 page='mail/system/mailserver_modify' msid=$set.msid}</span>
<span class="menu_item">{capture name='grn_mail_system_GRN_MAIL_SY_49'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-49' replace='true'}{/capture}{grn_link image='delete20.gif' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_49 page='mail/system/mailserver_delete' msid=$set.msid}</span>
</div>

<p>
<table class="view_table" width="50%">
 <colgroup>
  <col width="20%">
  <col width="80%">
 </colgroup>
 <tr>
  <th>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-50' replace='true'}</th>
  <td>{$set.foreign_key|escape}</td>
 </tr>
 <tr>
  <th>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-51' replace='true'}</th>
  <td>{$set.title|escape}</td>
 </tr>
</table>

<p>
<div class="sub_title">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-52' replace='true'}</div>
<table class="view_table" width="50%">
 <colgroup>
  <col width="20%">
  <col width="80%">
 </colgroup>
 <tr>
  <th>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-53' replace='true'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-54' replace='true'}</th>
  <td>{$set.smtp_server|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-55' replace='true'}<br>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-56' replace='true'}</th>
  <td>{$set.smtp_port|escape}</td>
 </tr>
 
 <tr>
  <th>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-503' replace='true'}</th>
  <td>{$type_encrypted_connection|escape}</td>
  </tr>
 <tr>
 
  <th>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-57' replace='true'}</th>
{if $set.smtp_auth eq 'NONE'}
  <td>{capture name='grn_mail_system_GRN_MAIL_SY_58'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-58' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_58 image='spacer20.gif'}</td>
{else}
  <td>{$set.smtp_auth|escape}</td>
{/if}
 </tr>
{if $set.smtp_auth eq 'NONE'}
    {if $smarty.const.ON_FOREST != 1}
        <tr valign="top">
            <th>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-59' replace='true'}<br>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-60' replace='true'}</th>
            <td>{if $set.is_pop_before_smtp == '1'}{capture name='grn_mail_system_GRN_MAIL_SY_62'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-62' replace='true'}{/capture}{grn_sentence image='check20.gif' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_62}{else}{capture name='grn_mail_system_GRN_MAIL_SY_63'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-63' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_63 image='spacer20.gif'}{/if}</td>
        </tr>
        {if $set.is_pop_before_smtp == '1'}
            <tr>
                <th>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-64' replace='true'}</th>
                <td>{$set.pop_before_smtp_wait|escape}&nbsp;{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-65' replace='true'}</td>
            </tr>
        {/if}
    {/if}
{else}
 <tr>
  <th>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-66' replace='true'}</th>
  <td>{if $set.smtp_account_set == '1'}{capture name='grn_mail_system_GRN_MAIL_SY_67'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-67' replace='true'}{/capture}{grn_sentence image='check20.gif' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_67}{else}{capture name='grn_mail_system_GRN_MAIL_SY_68'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-68' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_68 image='spacer20.gif'}{/if}</td>
 </tr>
{/if}
 <tr>
  <th>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-69' replace='true'}</th>
  <td>{$set.smtp_timeout|escape}&nbsp;{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-70' replace='true'}</td>
 </tr>
</table>

<p>
<div class="sub_title">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-71' replace='true'}</div>
<table class="view_table" width="50%">
 <colgroup>
  <col width="20%">
  <col width="80%">
 </colgroup>
 <tr>
  <th>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-72' replace='true'}</th>
  <td>{$set.received_protocol|escape}</td>
 </tr>
 <tr>
  <th>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-73' replace='true'}</th>
  <td>{$set.received_server|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-74' replace='true'}<br>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-75' replace='true'}</th>
  <td>{$set.received_port|escape}</td>
 </tr>
 
 <tr>
  <th>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-490' replace='true'}</th>
  <td>{if $set.received_ssl == '1'}{capture name='grn_mail_system_GRN_MAIL_SY_491'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-491' replace='true'}{/capture}{grn_sentence image='check20.gif' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_491}{else}{capture name='grn_mail_system_GRN_MAIL_SY_493'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-493' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_493 image='spacer20.gif'}{/if}</td>
  </tr>
 <tr>
 
 
{if $set.received_protocol eq 'POP3'}
 <tr>
  <th>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-76' replace='true'}</th>
  <td>{if $set.apop == '1'}{capture name='grn_mail_system_GRN_MAIL_SY_77'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-77' replace='true'}{/capture}{grn_sentence image='check20.gif' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_77}{else}{capture name='grn_mail_system_GRN_MAIL_SY_78'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-78' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_78 image='spacer20.gif'}{/if}</td>
{/if}
 </tr>
 <tr>
  <th>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-79' replace='true'}</th>
  <td>{$set.retrieve_timeout|escape}&nbsp;{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-80' replace='true'}</td>
 </tr>
</table>

{include file='grn/system_footer.tpl'}
