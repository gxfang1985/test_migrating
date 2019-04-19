{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{assign var='form_name' value=$smarty.template|basename}
<!--menubar-->
<div id="main_menu_part">
 <span class="menu_item">{capture name='grn_schedule_GRN_SCH_799'}{cb_msg module='grn.schedule' key='GRN_SCH-799' replace='true'}{/capture}{grn_link page='schedule/personal_day' caption=$smarty.capture.grn_schedule_GRN_SCH_799 image='cal_pday20.gif' uid='f'|cat:$facility.faid alt=''}</span>
 <span class="menu_item">{capture name='grn_schedule_GRN_SCH_800'}{cb_msg module='grn.schedule' key='GRN_SCH-800' replace='true'}{/capture}{grn_link page='schedule/personal_week' caption=$smarty.capture.grn_schedule_GRN_SCH_800 image='cal_pweek20.gif' uid='f'|cat:$facility.faid alt=''}</span>
 <span class="menu_item">{capture name='grn_schedule_GRN_SCH_801'}{cb_msg module='grn.schedule' key='GRN_SCH-801' replace='true'}{/capture}{grn_link page='schedule/group_day' caption=$smarty.capture.grn_schedule_GRN_SCH_801 image='cal_gday20.gif' uid='f'|cat:$facility.faid gid='f'|cat:$facility.group alt=''}</span>
 <span class="menu_item">{capture name='grn_schedule_GRN_SCH_802'}{cb_msg module='grn.schedule' key='GRN_SCH-802' replace='true'}{/capture}{grn_link page='schedule/index' caption=$smarty.capture.grn_schedule_GRN_SCH_802 image='cal_gweek20.gif' uid='f'|cat:$facility.faid gid='f'|cat:$facility.group alt=''}</span>
 {if $user_can_add_schedule}
 <span class="menu_item">{capture name='grn_schedule_GRN_SCH_803'}{cb_msg module='grn.schedule' key='GRN_SCH-803' replace='true'}{/capture}{grn_link page='schedule/add' caption=$smarty.capture.grn_schedule_GRN_SCH_803 image='write20.gif' uid='f'|cat:$facility.faid gid='f'|cat:$facility.group referer_key=$referer_key alt=''}</span>
 {/if}
</div>
<!--menubar_end-->
{grn_title title=$facility.title class=$page_info.parts[0]|cat:" inline_block_grn mBottom10" no_style=1}
<table class="view_table">
 <tr>
  <th>{cb_msg module='grn.schedule' key='GRN_SCH-804' replace='true'}</th>
  <td>{$facility.title|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.schedule' key='GRN_SCH-805' replace='true'}</th>
  <td>{$facility.memo|grn_noescape}</td>
 </tr>
 <tr>
  <th>{cb_msg module='grn.schedule' key='GRN_SCH-806' replace='true'}</th>
  <td>{$facility.group_name|escape}</td>
 </tr>
</table>

{include file='grn/footer.tpl'}
