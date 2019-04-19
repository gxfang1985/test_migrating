{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/search'}">
 <input type="hidden" name="optional_search" value="1">
 <input type="hidden" name="referer_key" value="{$referer_key}">
 <p>
 <table class="std_form">
  <tr>
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-480' replace='true'}</th>
   <td>
    {grn_text necessary=true name="search_text" value=$search_text size="50"}
    <input type="submit" name="Search" value="{cb_msg module='grn.schedule' key='GRN_SCH-481' replace='true'}"  onclick="grn.component.member_add.get_instance('member_select').prepareSubmit();">
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-482' replace='true'}</th>
   <td>
    {capture name='grn_schedule_GRN_SCH_483'}{cb_msg module='grn.schedule' key='GRN_SCH-483' replace='true'}{/capture}{grn_checkbox name='search_keys[]' id='title' value='title' checked=$search_keys.title caption=$smarty.capture.grn_schedule_GRN_SCH_483}
    {capture name='grn_schedule_GRN_SCH_484'}{cb_msg module='grn.schedule' key='GRN_SCH-484' replace='true'}{/capture}{grn_checkbox name='search_keys[]' id='companyinfo' value='companyinfo' checked=$search_keys.companyinfo caption=$smarty.capture.grn_schedule_GRN_SCH_484}
    {capture name='grn_schedule_GRN_SCH_485'}{cb_msg module='grn.schedule' key='GRN_SCH-485' replace='true'}{/capture}{grn_checkbox name='search_keys[]' id='memo' value='memo' checked=$search_keys.memo caption=$smarty.capture.grn_schedule_GRN_SCH_485}
    {capture name='grn_schedule_GRN_SCH_486'}{cb_msg module='grn' key='grn.comment' replace='true'}{/capture}{grn_checkbox name='search_keys[]' id='follow' value='follow' checked=$search_keys.follow caption=$smarty.capture.grn_schedule_GRN_SCH_486}
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-487' replace='true'}</th>
   <td>
    {grn_select_date prefix='start_' date=$stime form_name=$form_name}{cb_msg module='grn.schedule' key='GRN_SCH-488' replace='true'}{grn_select_date prefix='end_' date=$etime form_name=$form_name}
   </td>
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-489' replace='true'}</th>
   <td>
    {grn_member_add name='member_select' form_name=$form_name selected_users=$selected_users app_id='schedule' access_plugin=$view_plugin include_org=$show_organize popup_include_org=$show_organize org_direct=TRUE is_calendar=TRUE}
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-490' replace='true'}</th>
   <td>{capture name='grn_schedule_GRN_SCH_491'}{cb_msg module='grn.schedule' key='GRN_SCH-491' replace='true'}{/capture}{grn_checkbox name='all_repeat' id='allrepeat' value='1' checked=$expand_repeat_and_temporary caption=$smarty.capture.grn_schedule_GRN_SCH_491}</td>
  </tr>
  <tr>
   <td></td>
   <td>
    <div class="mTop10">
     {capture name='grn_schedule_GRN_SCH_492'}{cb_msg module='grn.schedule' key='GRN_SCH-492' replace='true'}{/capture}
     {capture name='schedule_button_search_onclick'}
      grn.component.member_add.get_instance('member_select').prepareSubmit();grn.component.button.util.submit(this);
     {/capture}
     {grn_button ui="main" action="submit" caption=$smarty.capture.grn_schedule_GRN_SCH_492 onclick=$smarty.capture.schedule_button_search_onclick id="schedule_button_search"}
     </div>
   </td>
  </tr>
 </table>

 <p>
 <div class="sub_title">{cb_msg module='grn.schedule' key='GRN_SCH-493' replace='true'} {include file="grn/smart_data_count_310.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}</div>
 <div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$view_set.navi}</nobr></div>
 <table class="list_column">
  <colgroup>
   <col width="15%">
   <col width="30%">
   <col width="20%">
   <col width="20%">
   <col width="15%">
  </colgroup>
  <tr>
   <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-496' replace='true'}</th>
   <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-497' replace='true'}</th>
   <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-498' replace='true'}</th>
   <th nowrap>{cb_msg module='grn' key='grn.comment' replace='true'}</th>
   <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-500' replace='true'}</th>
  </tr>
{foreach from=$search_item item=search_item}
  <tr>
   <td nowrap>{grn_date_format date=$search_item.date format='DateFull_YMD'}</td>
   <td nowrap><a href="{grn_pageurl page='schedule/view' event=$search_item.event_id bdate=$search_item.date_format uid=$search_item.user_id referer_key=$referer_key}">{grn_image image='event20.gif'}{if $search_item.event_menu_color neq '0' && $search_item.event_menu_color neq ''}<span class='event_color{$search_item.event_menu_color}_grn'>{$search_item.event_menu}</span>{$search_item.event_detail}{else}{$search_item.title|cb_mb_truncate:$subject_cols}{/if}</a></td>
   <td>{$search_item.memo|escape|cb_mb_truncate:$truncate_cols}</td>
   <td><a href="{grn_pageurl page='schedule/view' event=$search_item.event_id bdate=$search_item.date_format uid=$search_item.user_id follow_id=$search_item.follow_id fragment='follow' referer_key=$referer_key}">{$search_item.follow|escape|cb_mb_truncate:$truncate_cols}</a></td>
   <td nowrap>{grn_schedule_member_name id=$search_item.creator_id name=$search_item.creator_name referer_key=$referer_key}</td>
  </tr>
{/foreach}
 </table>
 <div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$view_set.navi}</nobr></div>
</form>
{include file="grn/footer.tpl"}
