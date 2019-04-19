{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

{grn_title title=$message.subject class=$page_info.parts[0]}
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
  <div class="sub_title">{$page_title|escape}</div>
  <table class="list_column">
   <colgroup>
    <col width="25%">
    <col width="25%">
    <col width="50%">
   </colgroup>
   <tr>
    <th nowrap>{cb_msg module='grn.message' key='GRN_MSG-207' replace='true'}</th>
    <th nowrap>{capture name='grn_message_GRN_MSG_208'}{cb_msg module='grn.message' key='GRN_MSG-208' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_208 page=$page_info.all params=$voice_sort_params reverse=$voice_sort_params.voice_rev disable=$voice_disable}</th>
    <th nowrap>{cb_msg module='grn.message' key='GRN_MSG-209' replace='true'}</th>
   </tr>
{foreach from=$user_info item=info}
   <tr>
 {if $info.delete}
    <td class="darkgray" nowrap>{if $info.creator_uid}{grn_user_name uid=$info.creator_uid name=$info.creator_name users_info=$users_info}{cb_msg module='grn.message' key='GRN_MSG-210' replace='true'}{elseif $info.editor_uid}{grn_user_name uid=$info.editor_uid name=$info.editor_name users_info=$users_info}{cb_msg module='grn.message' key='GRN_MSG-211' replace='true'}{else}{grn_user_name uid=$info.uid name=$info.name users_info=$users_info}{/if}</td>
    <td class="darkgray" nowrap>{if $info.mtime}{grn_date_format date=$info.mtime format='DateTimeMiddle_YMDW_HM'}{/if}</td>
    <td class="darkgray" nowrap>{if $info.data}{$info.data|escape}{else}&nbsp;{/if}</td>
 {else}
    <td nowrap>{if $info.creator_uid}{grn_user_name uid=$info.creator_uid name=$info.creator_name users_info=$users_info}{cb_msg module='grn.message' key='GRN_MSG-212' replace='true'}{elseif $info.editor_uid}{grn_user_name uid=$info.editor_uid name=$info.editor_name users_info=$users_info}{cb_msg module='grn.message' key='GRN_MSG-213' replace='true'}{else}{grn_user_name uid=$info.uid name=$info.name users_info=$users_info}{/if}</td>
    <td>{if $info.mtime}{grn_date_format date=$info.mtime format='DateTimeMiddle_YMDW_HM'}{/if}</td>
    <td>{if $info.data}{$info.data|escape}{else}&nbsp;{/if}</td>
 {/if}
   </tr>
{/foreach}
  </table>
  <p>
{if $delete_user_info }
  <div class="sub_title">{cb_msg module='grn.message' key='GRN_MSG-214' replace='true'}{$page_title|escape}</div>
  <table class="list_column">
   <colgroup>
     <col width="25%">
     <col width="25%">
     <col width="30%">
     <col width="20%">
    </colgroup>
    <tr>
     <th nowrap>{cb_msg module='grn.message' key='GRN_MSG-215' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.message' key='GRN_MSG-216' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.message' key='GRN_MSG-217' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.message' key='GRN_MSG-218' replace='true'}</th>
    </tr>
 {foreach from=$delete_user_info key=uid item=delete_info}
    <tr class="{cycle values='linetwo,lineone'}">
  {if $delete_info.delete}
    <td class="darkgray" nowrap>{if $delete_info.creator_uid}{grn_user_name uid=$delete_info.creator_uid name=$delete_info.creator_name users_info=$users_info}{cb_msg module='grn.message' key='GRN_MSG-219' replace='true'}{elseif $delete_info.editor_uid}{grn_user_name uid=$delete_info.editor_uid name=$delete_info.editor_name users_info=$users_info}{cb_msg module='grn.message' key='GRN_MSG-220' replace='true'}{else}{grn_user_name uid=$delete_info.uid name=$delete_info.name users_info=$users_info}{/if}</td>
    <td class="darkgray" nowrap>{if $delete_info.mtime}{grn_date_format date=$delete_info.mtime format='DateTimeMiddle_YMDW_HM'}{/if}</td>
    <td class="darkgray" nowrap>{if $delete_info.data}{$delete_info.data|escape}{else}&nbsp;{/if}</td>
    <td class="darkgray" nowrap>{if $delete_info.dtime}{grn_date_format date=$delete_info.dtime format='DateTimeMiddle_YMDW_HM'}{/if}</td>
  {else}
    <td nowrap>{if $delete_info.creator_uid}{grn_user_name uid=$delete_info.creator_uid name=$delete_info.creator_name users_info=$users_info}{cb_msg module='grn.message' key='GRN_MSG-221' replace='true'}{elseif $delete_info.editor_uid}{grn_user_name uid=$delete_info.editor_uid name=$delete_info.editor_name users_info=$users_info}{cb_msg module='grn.message' key='GRN_MSG-222' replace='true'}{else}{grn_user_name uid=$delete_info.uid name=$delete_info.name users_info=$users_info}{/if}</td>
    <td nowrap>{if $delete_info.mtime}{grn_date_format date=$delete_info.mtime format='DateTimeMiddle_YMDW_HM'}{/if}</td>
    <td nowrap>{if $delete_info.data}{$delete_info.data|escape}{else}&nbsp;{/if}</td>
    <td nowrap>{if $delete_info.dtime}{grn_date_format date=$delete_info.dtime format='DateTimeMiddle_YMDW_HM'}{/if}</td>
  {/if}
    </tr>
 {/foreach}
   </table>
{/if}
   <div class="list_br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.message' key='GRN_MSG-223' replace='true'}{$app_name}{cb_msg module='grn.message' key='GRN_MSG-224' replace='true'}</div>
  <!----->
 </div>
 <!--view_end--->
</div>

{include file="grn/footer.tpl"}
