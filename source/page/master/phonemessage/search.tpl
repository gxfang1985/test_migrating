{include file='grn/head.tpl'}
{include file='grn/header.tpl'}

{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='phonemessage/search'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="cid" value="{$category_id}">
<input type="hidden" name="gid" value="{$group_id}">
<input type="hidden" name="uid" value="{$user_id}">
 <p>
 <table class="std_form">
  <tr valign="top">
   <th>{cb_msg module='grn.phonemessage' key='GRN_PHM-41' replace='true'}</th>
   <td>
    {grn_text necessary=true name="search_text" value=$search_text size="50"}
    <input type="submit" name="Search" value="{cb_msg module='grn.phonemessage' key='GRN_PHM-42' replace='true'}"><br>
    {capture name='grn_phonemessage_GRN_PHM_43'}{cb_msg module='grn.phonemessage' key='GRN_PHM-43' replace='true'}{/capture}{grn_checkbox name="sensitive" id="sensitive" value="1" checked=$sensitive caption=$smarty.capture.grn_phonemessage_GRN_PHM_43}
   </td>
  </tr>
  <tr>
   <td></td>
   <td>
       <div class="mTop10">
           {capture name='grn_phonemessage_GRN_PHM_44'}{cb_msg module='grn.phonemessage' key='GRN_PHM-44' replace='true'}{/capture}
           {grn_button id='phone_messages_button_search' ui='main' action='submit' caption=$smarty.capture.grn_phonemessage_GRN_PHM_44}
       </div>
   </td>
  </tr>
 </table>

 <p>
 <div class="sub_title">{cb_msg module='grn.phonemessage' key='GRN_PHM-45' replace='true'}</div>
  {capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}{/capture}
  {include file="grn/smart_word_navi_310.tpl" navi=$view_set.navi navi_right=$smarty.capture.navi_right}
  <table class="list_column" width="100%">
   <colgroup>
    {if $schedule_available}
    <col width="20%">
    <col width="25%">
    <col width="20%">
    <col width="35%">
    {else}
    <col width="25%">
    <col width="55%">
    <col width="20%">
    {/if}
   </colgroup>
   <tr>
    <th nowrap>{cb_msg module='grn.phonemessage' key='GRN_PHM-48' replace='true'}</th>
    <th nowrap>&nbsp;</th>
    <th nowrap class="tAlignCenter-grn">{cb_msg module='grn.phonemessage' key='GRN_PHM-86' replace='true'}</th>
    {if $schedule_available}
    <th nowrap>{cb_msg module='grn.phonemessage' key='GRN_PHM-88' replace='true'}</th>
    {/if}
   </tr>
{foreach from=$accesses key=user_id item=access name="access_loop"}
{if $smarty.foreach.access_loop.iteration % 2 == 0}
   <tr class="phonemessage_list_bg">
{else}
   <tr>
{/if}
    <td nowrap>{if $sso == GRN_PHONEMESSAGE_SSO_DEFAULT}{grn_user_name uid=$user_id users_info=$users_info}{else}{grn_sso_link uid=$user_id caption=$users.$user_id.col_display_name sso_id=$sso app_id="phonemessage" id_list=$users.$user_id.sso}{/if}</td>
    <td nowrap>
    {if $access.add}{assign var='disabled' value=true}{else}{assign var='disabled' value=false}{/if}
     {capture name='grn_phonemessage_GRN_PHM_50'}{cb_msg module='grn.phonemessage' key='GRN_PHM-50' replace='true'}{/capture}{grn_link page='phonemessage/add' caption=$smarty.capture.grn_phonemessage_GRN_PHM_50 gid=$group_id uid=$user_id image='telmemo20_w.gif' disabled=$disabled}&nbsp;
    {if $access.browse}{assign var='disabled' value=true}{else}{assign var='disabled' value=false}{/if}
    {if 0 < $users.$user_id.newmessage_count}{assign var='class_name' value='telmemo20_u'}{else}{assign var='class_name' value='telmemo20'}{/if}
     {capture name='grn_phonemessage_GRN_PHM_51'}{cb_msg module='grn.phonemessage' key='GRN_PHM-51' replace='true'}{/capture}{grn_link page='phonemessage/history' gid=$group_id uid=$user_id caption=$smarty.capture.grn_phonemessage_GRN_PHM_51 image=$class_name|cat:'.gif' disabled=$disabled}
    </td>
    <td nowrap class="tAlignCenter-grn">
    {if 0 < $access.email_flags}{grn_image image='image-common/mark_check16.png'}{else}{/if}
    </td>
    {if $schedule_available}
    <td nowrap>
    {foreach from=$users_event.$user_id.schedule_event.event item=event}
            {if ! $event.private}{if $event.type == "share_temporary" || $event.type == "temporary"}<span class="{$event.type}">{/if}<a href="{grn_pageurl page='schedule/view' event=$event.id bdate=$schedule_event.date uid=$user_id gid=$group_id}">{/if}<span class="">{$event.data|grn_noescape}{if $event.is_private}{grn_image image="image-common/privateMark_sub16.png"}{/if}</span>{if ! $event.private}</a>{if $event.type == "share_temporary" || $event.type == "temporary"}</span>{/if}{/if}<br>
    {/foreach}
    </td>
    {/if}
   </tr>
{/foreach}
  </table>
  {capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}{/capture}
 <input type="hidden" name="second_search" value="1">
</form>

{include file="grn/footer.tpl"}
