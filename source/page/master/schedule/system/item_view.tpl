{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{if $item.id == 'subject'}
 {assign var='enable' value=false}
{else}
 {assign var='enable' value=true}
{/if}

{if $enable}
<div id="main_menu_part">
<span class="menu_item">{if $access.modify}{if $builtin_item_id}{capture name='grn_schedule_system_GRN_SCH_SY_123'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-123' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_123 page='schedule/system/item_modify' image='modify20.gif' biid=$builtin_item_id}{elseif $extended_item_id}{capture name='grn_schedule_system_GRN_SCH_SY_124'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-124' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_124 page='schedule/system/item_modify' image='modify20.gif' eiid=$extended_item_id}{/if}{/if}</span>
<span class="menu_item">{if $access.delete}{capture name='grn_schedule_system_GRN_SCH_SY_125'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-125' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_125 page='schedule/system/item_delete' image='delete20.gif' eiid=$extended_item_id}{/if}</span>
</div>
{/if}

<p>
<table class="view_table">
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-126' replace='true'}</th>
  <td>{$item.display_name|escape}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-127' replace='true'}</th>
  <td>{$item.id|escape}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-128' replace='true'}</th>
     {assign var='item_type' value=$item.type}
  <td>{$item_type_options.$item_type.label|escape}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-129' replace='true'}</th>
  <td>{if $item.use}{capture name='grn_schedule_system_GRN_SCH_SY_130'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-130' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_130 image='check20.gif'}{else}{capture name='grn_schedule_system_GRN_SCH_SY_131'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-131' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_131 image='spacer20.gif'}{/if}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-132' replace='true'}</th>
  <td>{if $item.display}{capture name='grn_schedule_system_GRN_SCH_SY_133'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-133' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_133 image='check20.gif'}{else}{capture name='grn_schedule_system_GRN_SCH_SY_134'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-134' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_134 image='spacer20.gif'}{/if}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-135' replace='true'}</th>
  <td>{if $item.display_item_name}{capture name='grn_schedule_system_GRN_SCH_SY_136'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-136' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_136 image='check20.gif'}{else}{capture name='grn_schedule_system_GRN_SCH_SY_137'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-137' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_137 image='spacer20.gif'}{/if}</td>
 </tr>
</table>

{include file='grn/system_footer.tpl'}
