{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

<!--menubar-->
<div id="main_menu_part">
    {if $message.creator_id == $user_id || $user_info.$user_id.is_operator }
        {if $folder_type neq '4'}
            <span class="menu_item">{capture name='grn_message_GRN_MSG_85'}{cb_msg module='grn.message' key='GRN_MSG-85' replace='true'}{/capture}{grn_link page='message/modify' caption=$smarty.capture.grn_message_GRN_MSG_85 image='modify20.gif' cid=$message.cid rid=$message.rid mid=$message.mid alt=''}</span>
            <span class="menu_item">{capture name='grn_message_GRN_MSG_86'}{cb_msg module='grn.message' key='GRN_MSG-86' replace='true'}{/capture}{grn_link page='message/address_modify' caption=$smarty.capture.grn_message_GRN_MSG_86 image='user20.gif' cid=$message.cid rid=$message.rid mid=$message.mid alt=''}</span>
        {else}
            <span class="menu_item">{capture name='grn_message_GRN_MSG_87'}{cb_msg module='grn.message' key='GRN_MSG-87' replace='true'}{/capture}{grn_link page='message/modify' caption=$smarty.capture.grn_message_GRN_MSG_87 image='modify20.gif' cid=$message.cid rid=$message.rid mid=$message.mid disabled=1 alt=''}</span>
            <span class="menu_item">{capture name='grn_message_GRN_MSG_88'}{cb_msg module='grn.message' key='GRN_MSG-88' replace='true'}{/capture}{grn_link page='message/address_modify' caption=$smarty.capture.grn_message_GRN_MSG_88 image='user20.gif' cid=$message.cid rid=$message.rid mid=$message.mid disabled=1 alt=''}</span>
        {/if}
    {/if}
    <span class="menu_item">{capture name='grn_message_GRN_MSG_90'}{cb_msg module='grn.message' key='GRN_MSG-90' replace='true'}{/capture}{grn_link page='message/reuse' caption=$smarty.capture.grn_message_GRN_MSG_90 image='reuse20.gif' cid=$message.cid rid=$message.rid mid=$message.mid alt=''}</span>
    <span class="menu_item">{capture name='grn_message_GRN_MSG_91'}{cb_msg module='grn.message' key='GRN_MSG-91' replace='true'}{/capture}{capture name='grn_message_GRN_MSG_92'}{cb_msg module='grn.message' key='GRN_MSG-92' replace='true'}{/capture}{grn_link page='message/send_other' caption=$smarty.capture.grn_message_GRN_MSG_91|cat:$app_name|cat:$smarty.capture.grn_message_GRN_MSG_92 image='msg20.gif' cid=$message.cid rid=$message.rid mid=$message.mid alt=''}</span>
</div>
<!--menubar-->
{grn_title title=$message.subject class=$page_info.parts[0]|cat:' inline_block_grn mBottom10' no_style=1}

<div id="one_parts">
 <!--view--->
 <div id="view">
  <!---->
{if $message.is_snapshot eq '1'}
  <div class="sub_title">
   {cb_msg module='grn.message' key='GRN_MSG-200' replace='true'}{$app_name}{cb_msg module='grn.message' key='GRN_MSG-201' replace='true'}{if $editor_uid}{cb_msg module='grn.message' key='GRN_MSG-202' replace='true'}{else}{cb_msg module='grn.message' key='GRN_MSG-203' replace='true'}{/if}{cb_msg module='grn.message' key='GRN_MSG-204' replace='true'}<br>
   {cb_msg module='grn.message' key='GRN_MSG-205' replace='true'}<br>
   {cb_msg module='grn.message' key='GRN_MSG-206' replace='true'}&nbsp;{grn_date_format date=$message.delete_time}
  </div>
{/if}
<table width="100%"><tbody>
 <tr><td width="45%" valign="top">
  <div class="sub_title">{cb_msg module='grn.message' key='GRN_MSG-341' replace='true'}</div>
  <div class="scroll_list_header">
  <table class="list_column">
   <colgroup>
    <col width="50%">
    <col width="25%">
    <col width="25%">
   </colgroup>
   <tr>
    <th nowrap>{capture name='grn_message_GRN_MSG_380'}{cb_msg module='grn.message' key='GRN_MSG-380' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_380 page=$page_info.all params=$addressee_user_sort_params reverse=$addressee_user_reverse disable=$addressee_user_disabled}</th>
    <th nowrap>{capture name='grn_message_GRN_MSG_381'}{cb_msg module='grn.message' key='GRN_MSG-381' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_381 page=$page_info.all params=$addressee_manager_sort_params reverse=$addressee_manager_reverse disable=$addressee_manager_disabled}</th>
    <th nowrap>{capture name='grn_message_GRN_MSG_382'}{cb_msg module='grn.message' key='GRN_MSG-382' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_382 page=$page_info.all params=$addressee_unsubscribe_sort_params reverse=$addressee_unsubscribe_reverse disable=$addressee_unsubscribe_disabled}</th>
   </tr>
  </table>
  </div>
  <div class="scroll_list" style="height:500px;">
  <table class="list_column">
   <colgroup>
    <col width="54%">
    <col width="23%">
    <col width="23%">
   </colgroup>
{foreach from=$user_info item=info name="addressee"}
{if $smarty.foreach.addressee.iteration % 2 == 0}
   <tr class="lineone">
{else}
   <tr class="linetwo">
{/if}
    <td nowrap>{if $message.creator_id == $info.id}{grn_user_name uid=$info.id name=$info.name users_info=$users_info}{cb_msg module='grn.message' key='GRN_MSG-212' replace='true'}{else}{grn_user_name uid=$info.id name=$info.name users_info=$users_info}{/if}</td>
    <td>{if $info.is_operator || $message.creator_id == $info.id }{grn_image image="check20.gif"}{/if}</td>
    <td>{if $info.unsubscribe}{grn_image image="check20.gif"}{/if}</td>
   </tr>
{/foreach}
  </table>
  </div>
 </td>
 <td width="5%"></td>
 <td width="45%" valign="top">
  <div class="sub_title">{cb_msg module='grn.message' key='GRN_MSG-384' replace='true'}</div>
  <div class="scroll_list_header">
  <table class="list_column">
   <colgroup>
    <col width="50%">
    <col width="50%">
   </colgroup>
   <tr>
    <th nowrap>{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_380 page=$page_info.all params=$delete_user_sort_params reverse=$delete_user_reverse disable=$delete_user_disabled}</th>
    <th nowrap>{capture name=grn_message_GRN_MSG_383}{cb_msg module='grn.message' key='GRN_MSG-383' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_383 page=$page_info.all params=$delete_dtime_sort_params reverse=$delete_dtime_reverse disable=$delete_dtime_disabled}</th>
   </tr>
  </table>
  </div>
  <div class="scroll_list" style="height:220px;">
{if $delete_user_info}
  <table class="list_column">
   <colgroup>
    <col width="50%">
    <col width="50%">
   </colgroup>
 {foreach from=$delete_user_info item=delete_info name="delete"}
{if $smarty.foreach.delete.iteration % 2 == 0}
   <tr class="phonemessage_list_bg">
{else}
   <tr>
{/if}
    <td nowrap>{if $delete_info.is_sender}{grn_user_name uid=$delete_info.id name=$delete_info.name users_info=$users_info}{cb_msg module='grn.message' key='GRN_MSG-221' replace='true'}{else}{grn_user_name uid=$delete_info.id name=$delete_info.name users_info=$users_info}{/if}</td>
    <td nowrap>{if $delete_info.dtime}{grn_date_format date=$delete_info.dtime format='DateTimeMiddle_YMDW_HM'}{/if}</td>
   </tr>
 {/foreach}
  </table>
{/if}
  </div>
  <p></p>
<div class="sub_title">{cb_msg module='grn.message' key='GMSG_MSG_2' app_name=$app_name}</div>
  <div class="scroll_list_header">
  <table class="list_column">
   <colgroup>
    <col width="50%"/>
   </colgroup>
   <tr>
    <th nowrap="">{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_380 page=$page_info.all params=$deleted_user_sort_params reverse=$deleted_user_reverse disable=$deleted_user_disabled}</th>
   </tr>
  </table>
  </div>
  <div class="scroll_list" style="height:220px;">
{if $deleted_user_info}
  <table class="list_column">
 {foreach from=$deleted_user_info item=deleted_info name="deleted"}
{if $smarty.foreach.deleted.iteration % 2 == 0}
   <tr class="phonemessage_list_bg">
{else}
   <tr>
{/if}
    <td nowrap>{if $deleted_info.is_sender}{grn_user_name uid=$deleted_info.id name=$deleted_info.name users_info=$users_info}{cb_msg module='grn.message' key='GRN_MSG-221' replace='true'}{else}{grn_user_name uid=$deleted_info.id name=$deleted_info.name users_info=$users_info}{/if}</td>
   </tr>
 {/foreach}
  </table>
{/if}
  </div>
 </td>
 <td width="5%"></td>
 </tr>
</tbody></table>
  <!----->
 </div>
 <!--view_end--->
</div>

{include file="grn/footer.tpl"}
