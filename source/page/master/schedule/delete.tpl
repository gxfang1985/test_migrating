{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_load_javascript file="grn/html/schedule.js"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.schedule' key='GRN_SCH-150' replace='true'}<br>
 {cb_msg module='grn.schedule' key='GRN_SCH-151' replace='true'}<span class="bold">{grn_sentence caption=$schedule_event.data class='schedule20'}</span>
 </p>
{** -------------- VCBSCH0010 START ----------------- **}
{if $schedule_event.netmeeting}
 <p>
   {cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-35' replace='true'}{if $schedule_event.netmeeting_msg}<br>{if ($schedule_event.type == "share") and ($schedule_event.user_id == $login.id)}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-36' replace='true'}{else}{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB-37' replace='true'}{/if}{/if}
 </p>
{/if}
{** -------------- VCBSCH0010 END   ----------------- **}
{include file='grn/show_validation_errors.tpl'}
{if $schedule_event.type == "normal" or $schedule_event.type == 'banner'}
  {validate form=$form_name field="dummy" criteria="notEmpty" append="validation_errors"}
  <input type="hidden" name="dummy" value="0">

    {strip}
    <div class="mTop10">
        {capture name='grn_schedule_GRN_SCH_152'}{cb_msg module='grn.schedule' key='GRN_SCH-152' replace='true'}{/capture}
        {grn_button spacing="normal" action="submit" caption=$smarty.capture.grn_schedule_GRN_SCH_152 id="schedule_button_save"}

        {capture name='grn_schedule_GRN_SCH_153'}{cb_msg module='grn.schedule' key='GRN_SCH-153' replace='true'}{/capture}
        {grn_button action="cancel" caption=$smarty.capture.grn_schedule_GRN_SCH_153 id="schedule_button_cancel" page='schedule/view' page_param_event=$schedule_event.event_id page_param_bdate=$schedule_event.date page_param_uid=$user_id page_param_gid=$group_id page_param_referer_key=$referer_key}
    </div>
    {/strip}
 </p>
{elseif (($schedule_event.type == "share") or ($schedule_event.type == "share_banner")) and ($schedule_event.user_id != $login.id) }
  {validate form=$form_name field="dummy" criteria="notEmpty" append="validation_errors"}
  <input type="hidden" name="dummy" value="0">

    {strip}
    <div class="mTop10">
        {capture name='grn_schedule_GRN_SCH_154'}{cb_msg module='grn.schedule' key='GRN_SCH-154' replace='true'}{/capture}
        {grn_button spacing="normal" action="submit" caption=$smarty.capture.grn_schedule_GRN_SCH_154 id="schedule_button_save"}

        {capture name='grn_schedule_GRN_SCH_155'}{cb_msg module='grn.schedule' key='GRN_SCH-155' replace='true'}{/capture}
        {grn_button action="cancel" caption=$smarty.capture.grn_schedule_GRN_SCH_155 id="schedule_button_cancel" page='schedule/view' page_param_event=$schedule_event.event_id page_param_bdate=$schedule_event.date page_param_uid=$user_id page_param_gid=$group_id page_param_referer_key=$referer_key}
    </div>
    {/strip}
 </p>
{else}
 <p>
{include file='grn/indispensable.tpl'}
 <table class="std_form">
 {if (($schedule_event.type == "share_repeat") or ($schedule_event.type == "share") or ($schedule_event.type == "share_banner")) and ($schedule_event.user_id == $login.id)}
  <tr>
   <th>{capture name='grn_schedule_GRN_SCH_156'}{cb_msg module='grn.schedule' key='GRN_SCH-156' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_GRN_SCH_156 necessary=true}</th>
   <td>{capture name='grn_schedule_GRN_SCH_157'}{cb_msg module='grn.schedule' key='GRN_SCH-157' replace='true'}{/capture}{validate form=$form_name field="member" criteria="notEmpty" message=$smarty.capture.grn_schedule_GRN_SCH_157 append="validation_errors"}{capture name='grn_schedule_GRN_SCH_159'}{cb_msg module='grn.schedule' key='GRN_SCH-159' replace='true'}{/capture}{grn_radio name="member" id="2" value="1" caption=$smarty.capture.grn_schedule_GRN_SCH_159 checked=$schedule_event.member_own div_cover="mBottom3" span_cover="1"}{capture name='grn_schedule_GRN_SCH_158'}{cb_msg module='grn.schedule' key='GRN_SCH-158' replace='true'}{/capture}{grn_radio name="member" id="1" value="0" caption=$smarty.capture.grn_schedule_GRN_SCH_158 checked=$schedule_event.member_all div_cover="mBottom3" label_class="attentionMessage-grn bold_grn" span_cover="1"}</td>
  </tr>
 {/if}
 {if ($schedule_event.type == "share_repeat") or ($schedule_event.type == "repeat")}
  <tr>
   <th>{capture name='grn_schedule_GRN_SCH_160'}{cb_msg module='grn.schedule' key='GRN_SCH-160' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_GRN_SCH_160 necessary=true}</th>
   <td>{capture name='grn_schedule_GRN_SCH_161'}{cb_msg module='grn.schedule' key='GRN_SCH-161' replace='true'}{/capture}{validate form=$form_name field="apply" criteria="notEmpty" message=$smarty.capture.grn_schedule_GRN_SCH_161 append="validation_errors"}{if $schedule_event.date}{capture name='grn_schedule_GRN_SCH_162'}{cb_msg module='grn.schedule' key='GRN_SCH-162' replace='true'}{/capture}{capture name='grn_schedule_GRN_SCH_163'}{cb_msg module='grn.schedule' key='GRN_SCH-163' replace='true'}{/capture}{grn_radio name="apply" id="3" value="this" caption=$smarty.capture.grn_schedule_GRN_SCH_162|cat:$schedule_event.str_date|cat:$smarty.capture.grn_schedule_GRN_SCH_163 checked=$schedule_event.apply_this div_cover="mBottom3" span_cover="1"}{capture name='grn_schedule_GRN_SCH_850'}{cb_msg module='grn.schedule' key='GRN_SCH-850' replace='true'}{$schedule_event.str_date}{cb_msg module='grn.schedule' key='GRN_SCH-851' replace='true'}{/capture}{grn_radio name="apply" id="4" value="after" caption=$smarty.capture.grn_schedule_GRN_SCH_850  checked=$schedule_event.apply_after div_cover="mBottom3" span_cover="1"}{/if}{capture name='grn_schedule_GRN_SCH_165'}{cb_msg module='grn.schedule' key='GRN_SCH-165' replace='true'}{/capture}{grn_radio name="apply" id="5" value="all" caption=$smarty.capture.grn_schedule_GRN_SCH_165 checked=$schedule_event.apply_all div_cover="mBottom3" label_class="attentionMessage-grn bold_grn" span_cover="1"}</td>
  </tr>
 {/if}
 {if ( $schedule_event.type == 'share_temporary' ) or ( $schedule_event.type == 'temporary' )}
  <tr>
   <th>{capture name='grn_schedule_GRN_SCH_166'}{cb_msg module='grn.schedule' key='GRN_SCH-166' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_GRN_SCH_166 necessary=true}</th>
   <td>{capture name='grn_schedule_GRN_SCH_167'}{cb_msg module='grn.schedule' key='GRN_SCH-167' replace='true'}{/capture}{validate form=$form_name field="did" criteria="notEmpty" message=$smarty.capture.grn_schedule_GRN_SCH_167 append="validation_errors"}
  {if $schedule_event.temporary_type == 'or'}
   {foreach from=$schedule_event.temporary item=facility_data}
       <strong>{$facility_data.facility_name|escape}</strong><br>
    {foreach from=$facility_data.dates item=temporary}
     {grn_radio name="did" id=$temporary.temporary_id value=$temporary.temporary_id caption=$temporary.str_date div_cover="mBottom3" span_cover="1"}
    {/foreach}
   {/foreach}
  {else}
   {foreach from=$schedule_event.temporary item=temporary}
    {grn_radio name="did" id=$temporary.temporary_id value=$temporary.temporary_id caption=$temporary.str_date div_cover="mBottom3" span_cover="1"}
   {/foreach}
  {/if}
   </td>
  </tr>
 {/if}
  <tr>
   <td></td>
   <td>
       <div class="mTop10">
           {strip}
               {capture name='grn_schedule_GRN_SCH_168'}{cb_msg module='grn.schedule' key='GRN_SCH-168' replace='true'}{/capture}
               {grn_button spacing="normal" action="submit" caption=$smarty.capture.grn_schedule_GRN_SCH_168 id="schedule_button_save"}

               {capture name='grn_schedule_GRN_SCH_169'}{cb_msg module='grn.schedule' key='GRN_SCH-169' replace='true'}{/capture}
               {grn_button action="cancel" caption=$smarty.capture.grn_schedule_GRN_SCH_169 id="schedule_button_cancel" page='schedule/view' page_param_event=$schedule_event.event_id page_param_bdate=$schedule_event.date page_param_uid=$user_id page_param_gid=$group_id page_param_referer_key=$referer_key}
           {/strip}
       </div>
   </td>
  </tr>
 </table>
{/if}
 <input type="hidden" name="event" value="{$schedule_event.event_id|escape}">
 <input type="hidden" name="uid" value="{$user_id|escape}">
 <input type="hidden" name="gid" value="{$group_id|escape}">
 <input type="hidden" name="bdate" value="{$schedule_event.date|escape}">
 <input type="hidden" name="referer_key" value="{$referer_key|escape}">
</form>

{include file='grn/footer.tpl'}
