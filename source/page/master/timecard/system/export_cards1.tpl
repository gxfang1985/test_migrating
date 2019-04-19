{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{include file='grn/org_tree.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<div class="explanation">
{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-90' replace='true'}{grn_appname app_id='timecard'}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-42' replace='true'}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-43' replace='true'}
</div>

{**
<div id="menubar_top">
 <ul id="menu">
  <li>{capture name='grn_timecard_system_GRN_TIM_SY_44'}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-44' replace='true'}{/capture}{grn_link page='timecard/system/export_cards2' caption=$smarty.capture.grn_timecard_system_GRN_TIM_SY_44 class='export20' oid=-1}
 </ul>
</div>
**}

<p>
{capture name='grn_timecard_system_GRN_TIM_SY_45'}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-45' replace='true'}{/capture}{include file='timecard/system/_org_user_select.tpl' form_name=$smarty.template|basename submit_caption=$smarty.capture.grn_timecard_system_GRN_TIM_SY_45|cat:'>>' post_page='timecard/system/command_export_cards1' cancel_page='system/application_list' cancel_params=$cancel_params}

{include file="grn/system_footer.tpl"}
