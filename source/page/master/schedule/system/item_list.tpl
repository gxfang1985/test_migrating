{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_schedule_system_GRN_SCH_SY_105'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-105' replace='true'}{/capture}{grn_link page='schedule/system/item_add' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_105 image='write20.gif'}</span>
<span class="menu_item">{capture name='grn_schedule_system_GRN_SCH_SY_106'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-106' replace='true'}{/capture}{grn_link page='schedule/system/item_order' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_106 image='order20.gif'}</span>
</div>

<p>
<div class="explanation">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-107' replace='true'}</div>
<p>

<div>
 <span class="sub_title">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-108' replace='true'}</span>
</div>
<table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
 <colgroup>
  <col width="25%">
  <col width="40%">
  <col width="10%">
  <col width="10%">
  <col width="15%">
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-109' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-110' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-111' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-112' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-113' replace='true'}</th>
 </tr>
 <tr valign="top">
  <td>{capture name='grn_schedule_system_GRN_SCH_SY_114'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-114' replace='true'}{/capture}{grn_link page='schedule/system/item_view' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_114 image='detail20.gif' biid='title_purpose'}</td>
  <td>{$facility_title_code.title_purpose}</td>
  <td>{grn_image image='check20.gif'}</td>
  <td>
  {if $title_purpose}{grn_checkbox name="title_purpose" id="title_purpose" value="1" checked=TURE}{else}{grn_checkbox name="title_purpose" id="title_purpose" value="1"}{/if}
  </td>
  <td></td>
 </tr>
 <tr valign="top">
  <td>{capture name='grn_schedule_system_GRN_SCH_SY_115'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-115' replace='true'}{/capture}{grn_link page='schedule/system/item_view' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_115 image='detail20.gif' biid='title_name'}</td>
  <td>{$facility_title_code.title_name}</td>
  <td>{grn_image image='check20.gif'}</td>
  <td>
   {if $title_name}{grn_checkbox name="title_name" id="title_name" value="1" checked=TURE}{else}{grn_checkbox name="title_name" id="title_name" value="1"}{/if}
  </td>
  <td></td>
 </tr>
</table>
<br>

<div>
 <span class="sub_title">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-116' replace='true'}</span>
</div>
<table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
 <colgroup>
  <col width="25%">
  <col width="40%">
  <col width="10%">
  <col width="10%">
  <col width="15%">
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-117' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-118' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-119' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-120' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-121' replace='true'}</th>
 </tr>
{foreach from=$items key=item_id item=item}
 <tr valign="top">
  <td>{grn_link caption=$item.display_name page='schedule/system/item_view' eiid=$item_id image='detail20.gif'}</td>
  <td>{$item.id|escape}</td>
  <td>{grn_checkbox name="extended_items[$item_id][use]" id="use_$item_id" value=1 checked=$item.use}</td>
  <td>{grn_checkbox name="extended_items[$item_id][display]" id="display_$item_id" value=1 checked=$item.display}</td>
  <td>{grn_checkbox name="extended_items[$item_id][display_item_name]" id="display_item_name_$item_id" value=1 checked=$item.display_item_name}</td>
 </tr>
{/foreach}
</table>



<table class="std_form">
 <tr>
  <td></td>
  <td>
       {capture name='grn_schedule_system_GRN_SCH_SY_122'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-122' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_122}
       {grn_button_cancel page="system/application_list" app_id="schedule"}
  </td>
 </tr>
</table>

</form>

{include file='grn/system_footer.tpl'}
