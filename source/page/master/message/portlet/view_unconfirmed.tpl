{if $portlet.settings.font_size == "large"}
 {assign var="font_size" value='font-size:140%;'}
 {assign var="fontsize" value='font-size:110%;'}
{elseif $portlet.settings.font_size == "normal"}
 {assign var="font_size" value=''}
 {assign var="fontsize" value='font-size:80%;'}
{elseif $portlet.settings.font_size == "small"}
 {assign var="font_size" value='font-size:70%;'}
 {assign var="fontsize" value='font-size:60%;'}
{else}
 {assign var="fontsize" value='font-size:80%;'}
{/if}
<table class="top_title">{strip}
    <tbody>
    <tr>
        <td>
            <span class="portlet_title_grn">
                <a href="{grn_pageurl page='message/unconfirmed_list'}">{$page_title}</a>
            </span>
        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_unacknowledged_message_grn">
{if $has_messages}
<table class="list_column" style="{$font_size}">
 <colgroup>
  <col width="40%">
  <col width="20%">
  <col width="20%">
  <col width="20%">
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-16' replace='true'}</th>
{if $settings.sender}
  <th nowrap>{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-17' replace='true'}</th>
{/if}
{if $settings.time}
  <th nowrap>{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-18' replace='true'}</th>
{/if}
{if $settings.folder}
  <th nowrap>{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-19' replace='true'}</th>
{/if}
 </tr>
{foreach from=$messages item=message}
 <tr valign="top">
{if $message.has_files}
 {assign var="class_clip" value="_clip8"}
{else}
 {assign var="class_clip" value=''}
{/if}
{if $message.status eq 0}               {* unread *}
 {assign var="unread" value="1"}
 {assign var="class_update" value=''}
{else}                                  {* update/read *}
 {assign var="unread" value="0"}
 {if $message.status eq 1}              {* update *}
  {assign var="class_update" value="_u"}
 {else}                                 {* read *}
  {assign var="class_update" value=''}
 {/if}
{/if}
  <td>
   {grn_link page='message/view' caption=$message.subject image="msg20`$class_update``$class_clip`.gif" unread=$unread cid=$message.cid rid=$message.rid mid=$message.mid truncated_caption=$subject_width}
  </td>
{if $settings.sender}
  <td nowrap style="{$fontsize}">{grn_user_name uid=$message.creator_id name=$message.creator_name users_info=$users_info truncated=$name_width}</td>
{/if}
{if $settings.time}
  <td nowrap sytle="{$fontsize}">{grn_date_format date=$message.time}</td>
{/if}
{if $settings.folder}
  <td nowrap style="{$fontsize}">{$message.folder_name|escape}</td>
{/if}
 </tr>
{/foreach}
</table>
{/if}
</div> <!--end of portal_frame -->
