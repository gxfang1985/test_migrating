{include file="grn/personal_head.tpl"}
{include file="grn/personal_header.tpl"}
{grn_title title=$filter.title class=$page_info.parts[0]}
<!--file delete-->
{grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
 <!--menubar-->
<div id="main_menu_part">
<span class="menu_item">{capture name='grn_message_personal_GRN_MSG_PE_47'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-47' replace='true'}{/capture}{grn_link image='modify20.gif' caption=$smarty.capture.grn_message_personal_GRN_MSG_PE_47 page='message/personal/filter_modify' mfid=$filter.mfid}</span>
<span class="menu_item">{capture name='grn_message_personal_GRN_MSG_PE_48'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-48' replace='true'}{/capture}{grn_link image='delete20.gif' caption=$smarty.capture.grn_message_personal_GRN_MSG_PE_48 id='lnk_delete' script='javascript:void(0)'}</span>
</div>

<p>
<table style="border-collapse:collapse" border="1" cellspacing="0" cellpadding="2" bordercolor="#666666" bgcolor="#ffffff">
 <tr>
  <td bgcolor="#cccccc" nowrap>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-49' replace='true'}</td>
  <td>{$filter.order}</td>
 </tr>
 <tr>
  <td bgcolor="#cccccc" nowrap>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-50' replace='true'}</td>
  <td>
{if $filter.cid}
  {grn_message_show_folder_position folder_id=$filter.cid show_icon=1}
{else}
  {cb_msg module='grn.message.personal' key='GRN_MSG_PE-51' replace='true'}
{/if}
  </td>
 </tr>
 <tr valign="top">
  <td bgcolor="#cccccc" nowrap>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-52' replace='true'}</td>
  <td>
        {if $filter.type eq "1"}
         {cb_msg module='grn.message.personal' key='GRN_MSG_PE-53' replace='true'}
        {else}
         {cb_msg module='grn.message.personal' key='GRN_MSG_PE-54' replace='true'}
        {/if}
       <hr>
       <table class="admin_list_table" width="100%">
        <tr>
         <th>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-55' replace='true'}</th>
         <th>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-56' replace='true'}</th>
         <th width="70%">{cb_msg module='grn.message.personal' key='GRN_MSG_PE-57' replace='true'}</th>
        </tr>
{foreach from=$filter.condition item=condition}
        <tr valign="top">
 {if $condition.object == 1}
         <td nowrap>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-58' replace='true'}</td>
 {elseif $condition.object == 2}
         <td nowrap>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-59' replace='true'}</td>
 {elseif $condition.object == 3}
         <td nowrap>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-60' replace='true'}</td>
 {/if}
 {if $condition.type == 1}
         <td nowrap>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-61' replace='true'}</td>
 {elseif $condition.type == 2}
         <td nowrap>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-62' replace='true'}</td>
 {elseif $condition.type == 3}
         <td nowrap>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-63' replace='true'}</td>
 {elseif $condition.type == 4}
         <td nowrap>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-64' replace='true'}</td>
 {elseif $condition.type == 5}
         <td nowrap>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-65' replace='true'}</td>
 {/if}
         <td>{$condition.value|escape}</td>
        </tr>
{/foreach}
       </table>
  </td>
 </tr>
</table>

{include file="grn/personal_footer.tpl"}
