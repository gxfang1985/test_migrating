{include file='grn/head.tpl'}
{include file='grn/header.tpl'}

{grn_title title=$message.subject class=$page_info.parts[0]}
{if $message.is_snapshot eq '1'}
<div class="explanation">
{cb_msg module='grn.message' key='GRN_MSG-326' replace='true'}{$app_name}{cb_msg module='grn.message' key='GRN_MSG-327' replace='true'}{if $editor_uid}{cb_msg module='grn.message' key='GRN_MSG-328' replace='true'}{else}{cb_msg module='grn.message' key='GRN_MSG-329' replace='true'}{/if}{cb_msg module='grn.message' key='GRN_MSG-330' replace='true'}<br>
{cb_msg module='grn.message' key='GRN_MSG-331' replace='true'}<br>
{cb_msg module='grn.message' key='GRN_MSG-332' replace='true'}&nbsp;{grn_date_format date=$message.delete_time}
</div>
{/if}
<div class="sub_title">{$page_title|escape}</div>
<table class="list_column">
 <colgroup>
  <col width="25%">
  <col width="25%">
  <col width="50%">
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.message' key='GRN_MSG-333' replace='true'}</th>
  <th nowrap>{capture name='grn_message_GRN_MSG_334'}{cb_msg module='grn.message' key='GRN_MSG-334' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_334 page=$page_info.all params=$confirmed_sort_params reverse=$confirmed_sort_params.confirmed_rev disable=$confirmed_disable}</th>
  <th nowrap>{cb_msg module='grn.message' key='GRN_MSG-335' replace='true'}</th>
 </tr>
{foreach from=$user_info item=info}
 <tr>
 {if $info.delete}
  <td class="darkgray" nowrap>{if $info.creator_uid}{grn_user_name uid=$info.creator_uid name=$info.creator_name users_info=$users_info}{cb_msg module='grn.message' key='GRN_MSG-336' replace='true'}{elseif $info.editor_uid}{grn_user_name uid=$info.editor_uid name=$info.editor_name users_info=$users_info}{cb_msg module='grn.message' key='GRN_MSG-337' replace='true'}{else}{grn_user_name uid=$info.uid name=$info.name users_info=$users_info}{/if}</td>
  <td class="darkgray" nowrap>{if $info.vtime->unix_ts}{grn_date_format date=$info.vtime format='DateTimeMiddle_YMDW_HM'}{elseif $info.no_receive}-{/if}</td>
  <td class="darkgray" nowrap>{if $info.data}{$info.data|escape}{else}&nbsp;{/if}</td>
 {else}
  <td nowrap>{if $info.creator_uid}{grn_user_name uid=$info.creator_uid name=$info.creator_name users_info=$users_info}{cb_msg module='grn.message' key='GRN_MSG-338' replace='true'}{elseif $info.editor_uid}{grn_user_name uid=$info.editor_uid name=$info.editor_name users_info=$users_info}{cb_msg module='grn.message' key='GRN_MSG-339' replace='true'}{else}{grn_user_name uid=$info.uid name=$info.name users_info=$users_info}{/if}</td>
  <td nowrap>{if $info.vtime->unix_ts}{grn_date_format date=$info.vtime format='DateTimeMiddle_YMDW_HM'}{elseif $info.no_receive}-{/if}</td>
  <td nowrap>{if $info.data}{$info.data|escape}{else}&nbsp;{/if}</td>
 {/if}
 </tr>
{/foreach}
</table>
<p>
{if $delete_user_info}
<div class="sub_title">{$page_title|escape}({cb_msg module='grn.message' key='GRN_MSG-340' replace='true'})</div>
<table class="list_column">
 <colgroup>
  <col width="25%">
  <col width="25%">
  <col width="30%">
  <col width="20%">
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.message' key='GRN_MSG-341' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.message' key='GRN_MSG-342' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.message' key='GRN_MSG-343' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.message' key='GRN_MSG-344' replace='true'}</th>
 </tr>
 {foreach from=$delete_user_info key=uid item=delete_info}
 <tr>
  {if $delete_info.delete}
  <td class="darkgray" nowrap>{if $delete_info.creator_uid}{grn_user_name uid=$delete_info.creator_uid name=$delete_info.creator_name users_info=$users_info}{cb_msg module='grn.message' key='GRN_MSG-345' replace='true'}{elseif $delete_info.editor_uid}{grn_user_name uid=$delete_info.editor_uid name=$delete_info.editor_name users_info=$users_info}{cb_msg module='grn.message' key='GRN_MSG-346' replace='true'}{else}{grn_user_name uid=$delete_info.uid name=$delete_info.name users_info=$users_info}{/if}</td>
  <td class="darkgray" nowrap>{if $delete_info.vtime->unix_ts}{grn_date_format date=$delete_info.vtime format='DateTimeMiddle_YMDW_HM'}{/if}</td>
  <td class="darkgray" nowrap>{if $delete_info.data}{$delete_info.data|escape}{else}&nbsp;{/if}</td>
  <td class="darkgray" nowrap>{if $delete_info.dtime}{grn_date_format date=$delete_info.dtime format='DateTimeMiddle_YMDW_HM'}{/if}</td>
  {else}
  <td nowrap>{if $delete_info.creator_uid}{grn_user_name uid=$delete_info.creator_uid name=$delete_info.creator_name users_info=$users_info}{cb_msg module='grn.message' key='GRN_MSG-347' replace='true'}{elseif $delete_info.editor_uid}{grn_user_name uid=$delete_info.editor_uid name=$delete_info.editor_name users_info=$users_info}{cb_msg module='grn.message' key='GRN_MSG-348' replace='true'}{else}{grn_user_name uid=$delete_info.uid name=$delete_info.name users_info=$users_info}{/if}</td>
  <td nowrap>{if $delete_info.vtime->unix_ts}{grn_date_format date=$delete_info.vtime format='DateTimeMiddle_YMDW_HM'}{/if}</td>
  <td nowrap>{if $delete_info.data}{$delete_info.data|escape}{else}&nbsp;{/if}</td>
  <td nowrap>{if $delete_info.dtime}{grn_date_format date=$delete_info.dtime format='DateTimeMiddle_YMDW_HM'}{/if}</td>
  {/if}
 </tr>
 {/foreach}
</table>
{/if}
<div class="sub_explanation">{cb_msg module='grn.message' key='GRN_MSG-349' replace='true'}{$app_name}{cb_msg module='grn.message' key='GRN_MSG-350' replace='true'}</div>

{include file='grn/footer.tpl'}
