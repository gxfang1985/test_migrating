{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$message.subject class=$page_info.parts[0]}
<div id="one_parts">
 <!--view--->
 <div id="view">
  <!---->
<table width="100%"><tbody>
 <tr><td width="45%" valign="top">
  <div class="sub_title">{cb_msg module='grn.message.system' key='GRN_MSG_SY-64' replace='true'}</div>
  <table class="list_column">
   <colgroup>
    <col width="50%">
    <col width="25%">
    <col width="25%">
   </colgroup>
   <tr>
    <th nowrap>{capture name='grn_message_GRN_MSG_SY_110'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-110' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_SY_110 page=$page_info.all params=$addressee_user_sort_params reverse=$addressee_user_reverse disable=$addressee_user_disabled}</th>
    <th nowrap>{capture name='grn_message_GRN_MSG_SY_111'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-111' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_SY_111 page=$page_info.all params=$addressee_manager_sort_params reverse=$addressee_manager_reverse disable=$addressee_manager_disabled}</th>
    <th nowrap>{capture name='grn_message_GRN_MSG_SY_112'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-112' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_SY_112 page=$page_info.all params=$addressee_unsubscribe_sort_params reverse=$addressee_unsubscribe_reverse disable=$addressee_unsubscribe_disabled}</th>
   </tr>
{foreach from=$user_info item=info name="addressee"}
{if $smarty.foreach.addressee.iteration % 2 == 0}
   <tr class="phonemessage_list_bg">
{else}
   <tr>
{/if}
    <td nowrap>{if $info.is_sender}{grn_user_name uid=$info.id name=$info.name users_info=$users_info}{cb_msg module='grn.message.system' key='GRN_MSG_SY-115' replace='true'}{else}{grn_user_name uid=$info.id name=$info.name users_info=$users_info}{/if}</td>
    <td>{if $info.is_operator}{grn_image image="check20.gif"}{/if}</td>
    <td>{if $info.unsubscribe}{grn_image image="check20.gif"}{/if}</td>
   </tr>
{/foreach}
  </table>
 </td>
 <td width="5%"></td>
 <td width="45%" valign="top">
{if $delete_user_info }
  <div class="sub_title">{cb_msg module='grn.message.system' key='GRN_MSG_SY-114' replace='true'}</div>
  <table class="list_column">
   <colgroup>
    <col width="50%">
    <col width="50%">
   </colgroup>
   <tr>
    <th nowrap>{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_SY_110 page=$page_info.all params=$delete_user_sort_params reverse=$delete_user_reverse disable=$delete_user_disabled}</th>
    <th nowrap>{capture name=grn_message_GRN_MSG_SY_113}{cb_msg module='grn.message.system' key='GRN_MSG_SY-113' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_SY_113 page=$page_info.all params=$delete_dtime_sort_params reverse=$delete_dtime_reverse disable=$delete_dtime_disabled}</th>
   </tr>
 {foreach from=$delete_user_info key=uid item=delete_info name="delete"}
{if $smarty.foreach.delete.iteration % 2 == 0}
   <tr class="phonemessage_list_bg">
{else}
   <tr>
{/if}
    <td nowrap>{if $delete_info.is_sender}{grn_user_name uid=$delete_info.id name=$delete_info.name users_info=$users_info}{cb_msg module='grn.message.system' key='GRN_MSG_SY-115' replace='true'}{else}{grn_user_name uid=$delete_info.id name=$delete_info.name users_info=$users_info}{/if}</td>
    <td nowrap>{if $delete_info.dtime}{grn_date_format date=$delete_info.dtime format='DateTimeMiddle_YMDW_HM'}{/if}</td>
   </tr>
 {/foreach}
   </table>
  <p></p>
{/if}
{if $deleted_user_info}
<div class="sub_title">{cb_msg module='grn.message.system' key='GRN_MSG_SY-106' replace='true'}</div>
  <table class="list_column">
   <colgroup>
    <col width="50%"/>
   </colgroup>
   <tbody><tr>
    <th nowrap="">{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_SY_110 page=$page_info.all params=$deleted_user_sort_params reverse=$deleted_user_reverse disable=$deleted_user_disabled}</th>
   </tr>
 {foreach from=$deleted_user_info key=uid item=deleted_info name="deleted"}
{if $smarty.foreach.deleted.iteration % 2 == 0}
   <tr class="phonemessage_list_bg">
{else}
   <tr>
{/if}
    <td nowrap>{if $deleted_info.is_sender}{grn_user_name uid=$deleted_info.id name=$deleted_info.name users_info=$users_info}{cb_msg module='grn.message.system' key='GRN_MSG_SY-115' replace='true'}{else}{grn_user_name uid=$deleted_info.id name=$deleted_info.name users_info=$users_info}{/if}</td>
   </tr>
 {/foreach}
    </tbody></table>
{/if}
 </td>
 <td width="5%"></td>
 </tr>
</tbody></table>
  <!----->
 </div>
 <!--view_end--->
</div>
{include file="grn/system_footer.tpl"}
