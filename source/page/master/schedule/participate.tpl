{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{include file='grn/show_validation_errors.tpl'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.schedule' key='GRN_SCH-175' replace='true'}<br>
 {cb_msg module='grn.schedule' key='GRN_SCH-176' replace='true'}<span class="bold">{grn_sentence caption=$schedule_event.data class='schedule20'}</span>
 </p>
{** -------------- VCBSCH0010 START ----------------- **}
{if $netmeeting}
 <p>
   {cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-41' replace='true'}
 </p>
{/if}
{** -------------- VCBSCH0010 END   ----------------- **}
 {if ($schedule_event.type == "share_repeat") or ($schedule_event.type == "repeat")}
 <p>
 <table class="std_form">
  <tr>
   <th>{capture name='grn_schedule_GRN_SCH_177'}{cb_msg module='grn.schedule' key='GRN_SCH-177' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_GRN_SCH_177 necessary=TRUE}</th>
   <td>{capture name='grn_schedule_GRN_SCH_178'}{cb_msg module='grn.schedule' key='GRN_SCH-178' replace='true'}{/capture}{validate form=$form_name field="apply" criteria="notEmpty" message=$smarty.capture.grn_schedule_GRN_SCH_178 append="validation_errors"}{capture name='grn_schedule_GRN_SCH_990'}{cb_msg module='grn.schedule' key='GRN_SCH-990' replace='true'}{/capture}{capture name='grn_schedule_GRN_SCH_991'}{cb_msg module='grn.schedule' key='GRN_SCH-991' replace='true'}{/capture}{grn_radio name="apply" id="3" value="this" caption=$smarty.capture.grn_schedule_GRN_SCH_990|cat:$schedule_event.str_date|cat:$smarty.capture.grn_schedule_GRN_SCH_991 checked=$schedule_event.apply_this div_cover="mBottom3" span_cover="1"}{capture name='grn_schedule_GRN_SCH_850'}{cb_msg module='grn.schedule' key='GRN_SCH-850' replace='true'}{$schedule_event.str_date}{cb_msg module='grn.schedule' key='GRN_SCH-851' replace='true'}{/capture}{grn_radio name="apply" id="4" value="after" caption=$smarty.capture.grn_schedule_GRN_SCH_850 checked=$schedule_event.apply_after div_cover="mBottom3" span_cover="1"}{capture name='grn_schedule_GRN_SCH_182'}{cb_msg module='grn.schedule' key='GRN_SCH-182' replace='true'}{/capture}{grn_radio name="apply" id="5" value="all" caption=$smarty.capture.grn_schedule_GRN_SCH_182 checked=$schedule_event.apply_all div_cover="mBottom3" label_class="attentionMessage-grn bold_grn" span_cover="1"}</td>
  </tr>
  <tr>
   <td></td>
   <td>
    {capture name='grn_schedule_GRN_SCH_183'}{cb_msg module='grn.schedule' key='GRN_SCH-183' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_GRN_SCH_183}
    {capture name='grn_schedule_GRN_SCH_184'}{cb_msg module='grn.schedule' key='GRN_SCH-184' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_schedule_GRN_SCH_184 page='schedule/view' event=$schedule_event.event_id bdate=$schedule_event.date uid=$user_id gid=$group_id referer_key=$referer_key}
   </td>
  </tr>
 </table>
 {else}
  {validate form=$form_name field="dummy" criteria="notEmpty" append="validation_errors"}
  <input type="hidden" name="dummy" value="0">
 <p class="mTop10">
  {strip}
   {capture name='grn_schedule_GRN_SCH_185'}{cb_msg module='grn.schedule' key='GRN_SCH-185' replace='true'}{/capture}
   {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_schedule_GRN_SCH_185 id="schedule_button_save"}

   {capture name='grn_schedule_GRN_SCH_186'}{cb_msg module='grn.schedule' key='GRN_SCH-186' replace='true'}{/capture}
   {grn_button action="cancel" caption=$smarty.capture.grn_schedule_GRN_SCH_186 id="schedule_button_cancel" page='schedule/view' page_param_event=$schedule_event.event_id page_param_bdate=$schedule_event.date page_param_uid=$user_id page_param_gid=$group_id page_param_referer_key=$referer_key}
  {/strip}
 </p>
 {/if}
<input type="hidden" name="event" value="{$schedule_event.event_id|escape}">
<input type="hidden" name="uid" value="{$user_id|escape}">
<input type="hidden" name="gid" value="{$group_id|escape}">
<input type="hidden" name="bdate" value="{$schedule_event.date|escape}">
<input type="hidden" name="referer_key" value="{$referer_key|escape}">
</form>
{include file='grn/footer.tpl'}
