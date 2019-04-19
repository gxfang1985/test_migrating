{if $is_system}
  {assign var='base_dir' value='report/system'}
{elseif $is_manage}
  {assign var='base_dir' value='report/operation'}
{else}
  {assign var='base_dir' value='report'}
{/if}

{* メニュー、通知メッセージ *}
{if $is_operatable || $is_system || $is_manage || $accessible_category}
    <div id="main_menu_part">
        {if $is_operatable || $is_system || $is_manage}
            <span class="menu_item">{capture name='grn_report_GRN_RPRT_76'}{cb_msg module='grn.report' key='GRN_RPRT-76' replace='true'}{/capture}{grn_link element_id='report_modify' page=$base_dir|cat:'/modify' caption=$smarty.capture.grn_report_GRN_RPRT_76 image='modify20.gif' rid=$rid alt=''}</span>
            <span class="menu_item">{capture name='grn_report_GRN_RPRT_77'}{cb_msg module='grn.report' key='GRN_RPRT-77' replace='true'}{/capture}{grn_link element_id='report_notification_modify' page=$base_dir|cat:'/notification_modify' caption=$smarty.capture.grn_report_GRN_RPRT_77 image='user20.gif' rid=$rid alt=''}</span>
        {/if}
        {if $accessible_category && ! $is_system && ! $is_manage}
            <span class="menu_item">{capture name='grn_report_GRN_RPRT_79'}{cb_msg module='grn.report' key='GRN_RPRT-79' replace='true'}{/capture}{grn_link element_id='report_reuse' caption=$smarty.capture.grn_report_GRN_RPRT_79 page=$base_dir|cat:'/reuse' image='reuse20.gif' rid=$rid mode='reuse' disabled=$disable_form alt=''}</span>
        {/if}
    </div>
{/if}

{grn_title title=$report_title class=$page_info.parts[0]|cat:' inline_block_grn mBottom10' no_style=1}

<div id="one_parts">
 <!--view--->
 <div id="view">
  <!---->
   <table width="100%"><tbody>
    <tr>
{if count($members) > 0}
     <td id='report_member' width="45%" valign="top">
      <div class="sub_title">{cb_msg module='grn.report' key='GRN_RPRT-26' replace='true'}</div>
 {if ! $is_system}
      <div class="scroll_list_header">
 {/if}
       <table class="list_column">
        <colgroup>
         <col width="50%">
         <col width="30%">
         <col width="20%">
        </colgroup>
        <tr>
         <th nowrap>{capture name='grn_report_user_name'}{cb_msg module='grn.report' key='user_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_report_user_name page=$page_info.all params=$sort_params.member_user_params reverse=$sort_params.member_user_reverse disable=$sort_params.member_user_disabled}</th>
         <th nowrap>{capture name='grn_report_allow_operator'}{cb_msg module='grn.report' key='allow_operator' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_report_allow_operator page=$page_info.all params=$sort_params.member_operator_params reverse=$sort_params.member_operator_reverse disable=$sort_params.member_operator_disabled}</th>
         <th nowrap>{capture name='grn_report_unsubscribe_notification'}{cb_msg module='grn.report' key='unsubscribe_notification' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_report_unsubscribe_notification page=$page_info.all params=$sort_params.member_unsubscribe_params reverse=$sort_params.member_unsubscribe_reverse disable=$sort_params.member_unsubscribe_disabled}</th>
        </tr>
 {if ! $is_system}
       </table>
      </div>
      <div class="scroll_list" style="height:500px;">
       <table class="list_column">
        <colgroup>
         <col width="54%">
         <col width="28%">
         <col width="18%">
        </colgroup>
 {/if}
        {foreach from=$members item=info name="addressee"}
         {if $smarty.foreach.addressee.iteration % 2 == 0}
        <tr class="lineone">
         {else}
        <tr class="linetwo">
         {/if}
         <td nowrap>{grn_user_name uid=$info.id name=$info.name users_info=$users_info}{if $report.creator == $info.id}{cb_msg module='grn.report' key='creator' replace='true'}{/if}</td>
         <td>{if $info.is_operator || $report.creator == $info.id }{grn_image image="check20.gif"}{/if}</td>
         <td>{if $info.unsubscribe}{grn_image image="check20.gif"}{/if}</td>
        </tr>
        {/foreach}
       </table>
      </div>
     </td>
     <td width="5%"></td>
{/if}
     <td id='report_notification' width="45%" valign="top">
      <div class="sub_title">{cb_msg module='grn.report' key='GRN_RPRT-27' replace='true'}</div>
{if ! $is_system}
      <div class="scroll_list_header">
{/if}
       <table class="list_column">
        <colgroup>
         <col width="50%">
         <col width="30%">
         <col width="20%">
        </colgroup>
        <tr>
         <th nowrap>{capture name='grn_report_user_name'}{cb_msg module='grn.report' key='user_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_report_user_name page=$page_info.all params=$sort_params.notification_user_params reverse=$sort_params.notification_user_reverse disable=$sort_params.notification_user_disabled}</th>
         <th nowrap>{capture name='grn_report_allow_operator'}{cb_msg module='grn.report' key='allow_operator' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_report_allow_operator page=$page_info.all params=$sort_params.notification_operator_params reverse=$sort_params.notification_operator_reverse disable=$sort_params.notification_operator_disabled}</th>
         <th nowrap>{capture name='grn_report_unsubscribe_notification'}{cb_msg module='grn.report' key='unsubscribe_notification' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_report_unsubscribe_notification page=$page_info.all params=$sort_params.notification_unsubscribe_params reverse=$sort_params.notification_unsubscribe_reverse disable=$sort_params.notification_unsubscribe_disabled}</th>
        </tr>
{if ! $is_system}
       </table>
      </div>
      <div class="scroll_list" style="height:500px;">
       <table class="list_column">
        <colgroup>
         <col width="54%">
         <col width="28%">
         <col width="18%">
        </colgroup>
{/if}
        {foreach from=$notification_users item=notification_info name="notification"}
         {if $smarty.foreach.notification.iteration % 2 == 0}
        <tr class="lineone">
         {else}
        <tr class="linetwo">
         {/if}
         <td nowrap>{grn_user_name uid=$notification_info.id name=$notification_info.name users_info=$users_info}{if $report.creator == $notification_info.id}{cb_msg module='grn.message' key='GRN_MSG-221' replace='true'}{/if}</td>
         <td nowrap>{if $notification_info.is_operator || $report.creator == $notification_info.id }{grn_image image="check20.gif"}{/if}</td>
         <td>{if $notification_info.unsubscribe}{grn_image image="check20.gif"}{/if}</td>
        </tr>
        {/foreach}
       </table>
      </div>
     </td>
     <td width="5%"></td>
{if count($members) == 0}
     <td width="50%"></td>
{/if}
    </tr>
   </tbody></table>
  <!----->
 </div>
 <!--view_end--->
</div>
