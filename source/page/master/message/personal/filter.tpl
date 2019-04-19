{include file="grn/personal_head.tpl"}
{include file="grn/personal_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_message_personal_GRN_MSG_PE_1'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-1' replace='true'}{/capture}{grn_link image='write20.gif' caption=$smarty.capture.grn_message_personal_GRN_MSG_PE_1 page='message/personal/filter_add' element_id="personal_filter_add"}</span>
<span class="menu_item">{capture name='grn_message_personal_GRN_MSG_PE_2'}{cb_msg module='grn.message.personal' key='GRN_MSG_PE-2' replace='true'}{/capture}{grn_link image='order20.gif' caption=$smarty.capture.grn_message_personal_GRN_MSG_PE_2 page='message/personal/filter_order' disabled=$disabled_change_order element_id="personal_filter_order"}</span>
</div>

<p>
<div class="explanation">{cb_msg module='grn.message.personal' key='GRN_MSG_PE-3' replace='true'}</div>
</p>

   <table class="admin_list_table" width="100%">
    <colgroup>
     <col width="1%">
     <col width="69%">
     <col width="30%">
    </colgroup>
    <tr>
     <th>No.</th>
     <th>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-4' replace='true'}</th>
     <th>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-5' replace='true'}</th>
    </tr>
{foreach name=filters from=$filters key=mfid item=filter}
    <tr valign="top">
 {if $filter.available eq "1"}
     <td>{$smarty.foreach.filters.iteration}</td>
     <td>
      {grn_link caption=$filter.title page='message/personal/filter_view' image='msgfilter20.gif' mfid=$mfid}
     </td>
     <td>{grn_message_show_folder_position folder_id=$filter.folder_id show_icon=1}</td>
 {else}
     <td class="gray">{$smarty.foreach.filters.iteration}<span class="required">{cb_msg module='grn.message.personal' key='GRN_MSG_PE-6' replace='true'}</span></td>
     <td class="gray">
      {grn_link caption=$filter.title page='message/personal/filter_view' image='msgfilter20.gif' mfid=$mfid}
     </td>
     <td class="gray">&nbsp;</td>
 {/if}
    </tr>
{/foreach}
   </table>

<p class="small_notes">{cb_msg module='grn.message.personal' key='GRN_MSG_PE-7' replace='true'}</p>

{include file="grn/personal_footer.tpl"}
