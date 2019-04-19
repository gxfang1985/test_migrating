{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-30' replace='true'}</th>
  <td>
       <select name="unit">
        <option value="{$unit}">{$unit}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-31' replace='true'}
        <option value="{$unit}">--
        <option value="5">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-32' replace='true'}
        <option value="10">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-33' replace='true'}
        <option value="15">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-34' replace='true'}
        <option value="30">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-35' replace='true'}
       </select>
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-36' replace='true'}</th>
  <td>
       <select name="limitmonths">
        <option value="{$limitmonths}">{if $limitmonths == 12}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-37' replace='true'}{else}{$limitmonths}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-38' replace='true'}{/if}
        <option value="{$limitmonths}">--
        <option value="1">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-39' replace='true'}
        <option value="2">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-40' replace='true'}
        <option value="3">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-41' replace='true'}
        <option value="4">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-42' replace='true'}
        <option value="5">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-43' replace='true'}
        <option value="6">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-44' replace='true'}
        <option value="12">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-45' replace='true'}
       </select>
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-46' replace='true'}</th>
  <td>
     {capture name='grn_schedule_system_GRN_SCH_SY_47'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-47' replace='true'}{/capture}{grn_checkbox name="private" id="0" value="1" checked=$private caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_47 onclick="setPrivateCheck(this.checked);"}<br/>
     {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-631' replace='true'}
     {capture name='grn_schedule_system_GRN_SCH_SY_628'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-628' replace='true'}{/capture}{grn_radio name='default_private_set' id='default_public' value='0' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_628 checked=$default_public disabled=$private_initial_setting_disabled}
     {capture name='grn_schedule_system_GRN_SCH_SY_629'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-629' replace='true'}{/capture}{grn_radio name='default_private_set' id='default_private' value='1' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_629 checked=$default_private disabled=$private_initial_setting_disabled}
     {capture name='grn_schedule_system_GRN_SCH_SY_630'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-630' replace='true'}{/capture}{grn_radio name='default_private_set' id='default_setted' value='2' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_630 checked=$default_setted disabled=$private_initial_setting_disabled}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-49' replace='true'}</th>
  <td>
   {if $hideprivate}{capture name='grn_schedule_system_GRN_SCH_SY_50'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-50' replace='true'}{/capture}{grn_checkbox name="hideprivate" id="1" value="1" checked=TURE caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_50 }{else}{capture name='grn_schedule_system_GRN_SCH_SY_51'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-51' replace='true'}{/capture}{grn_checkbox name="hideprivate" id="1" value="1" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_51 }{/if}
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-52' replace='true'}</div>
  </td>
 </tr>
 <tr>
  <th>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-670' replace='true'}</th>
  <td>
    {capture name='grn_schedule_system_GRN_SCH_SY_671'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-671' replace='true'}{/capture}
    {grn_checkbox name="allow_setting_group_role_to_watchers" id="allow_setting_group_role_to_watchers" value="1" checked=$allow_setting_group_role_to_watchers caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_671}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-625' replace='true'}</th>
  <td>{if $managednotify}{capture name='grn_schedule_system_GRN_SCH_SY_626'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-626' replace='true'}{/capture}{grn_checkbox name="managednotify" id="managed_notify" value="1" checked=TURE caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_626}{else}{capture name='grn_schedule_system_GRN_SCH_SY_627'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-627' replace='true'}{/capture}{grn_checkbox name="managednotify" id="managed_notify" value="1" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_627}{/if}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-53' replace='true'}</th>
  <td>{if $showorganization}{capture name='grn_schedule_system_GRN_SCH_SY_54'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-54' replace='true'}{/capture}{grn_checkbox name="showorganization" id="2" value="1" checked=TURE caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_54}{else}{capture name='grn_schedule_system_GRN_SCH_SY_55'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-55' replace='true'}{/capture}{grn_checkbox name="showorganization" id="2" value="1" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_55}{/if}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-56' replace='true'}</th>
  <td>{if $publicholiday}{capture name='grn_schedule_system_GRN_SCH_SY_57'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-57' replace='true'}{/capture}{grn_checkbox name="publicholiday" id="3" value="1" checked=TURE caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_57}{else}{capture name='grn_schedule_system_GRN_SCH_SY_58'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-58' replace='true'}{/capture}{grn_checkbox name="publicholiday" id="3" value="1" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_58}{/if}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-59' replace='true'}</th>
  <td>{if $allowallfacilities}{capture name='grn_schedule_system_GRN_SCH_SY_60'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-60' replace='true'}{/capture}{grn_checkbox name="allowallfacilities" id="4" value="1" checked=TURE caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_60}{else}{capture name='grn_schedule_system_GRN_SCH_SY_61'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-61' replace='true'}{/capture}{grn_checkbox name="allowallfacilities" id="4" value="1" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_61}{/if}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-546' replace='true'}</th>
  <td>
    {capture name='grn_schedule_system_GRN_SCH_SY_547'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-547' replace='true'}{/capture}
    {capture name='grn_schedule_system_GRN_SCH_SY_548'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-548' replace='true'}{/capture}
    {capture name='grn_schedule_system_GRN_SCH_SY_549'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-549' replace='true'}{/capture}
    {assign var="leftrightEnable" value=false}
    {if !$allowfacilitiesname}
        {assign var="leftrightEnable" value=true}
    {/if}
    {grn_checkbox name="allowfacilitiename" id="5" value="1" checked=$allowfacilitiesname caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_549 onclick="setDisable(!this.checked);"}
    <br/>
    {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-550' replace='true'}
    <select name='facnamepos' id='facnamepos'>
    {if $nameonright}
    <option value="0">{$smarty.capture.grn_schedule_system_GRN_SCH_SY_547}</option>
    <option value="1" selected="selected">{$smarty.capture.grn_schedule_system_GRN_SCH_SY_548}</option>
    {else}
    <option value="0" selected="selected">{$smarty.capture.grn_schedule_system_GRN_SCH_SY_547}</option>
    <option value="1">{$smarty.capture.grn_schedule_system_GRN_SCH_SY_548}</option>
    {/if}
    </select>
  </td>
 </tr>
 <tr>
    <th>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-581' replace='true'}</th>
    <td>
    {capture name='grn_schedule_system_GRN_SCH_SY_582'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-582' replace='true'}{/capture}
    {grn_checkbox name="activateDragDrop" id="activateDragDrop" value="1" checked=$activateDragDrop caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_582}
    </td>
 </tr>
 {* GTM-1136 *}
 <tr>
    <th>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-583' replace='true'}</th>
    <td>
    {capture name='grn_schedule_system_GRN_SCH_SY_584'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-584' replace='true'}{/capture}
    {grn_checkbox name="allow_file_attachment" id="allow_file_attachment" value="1" checked=$allow_file_attachment caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_584}
    </td>
 </tr>
 {* End GTM-1136 *}
 {* GTM-1621 *}
 <tr>
    <th>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-610' replace='true'}</th>
    <td>
    {capture name='grn_schedule_system_GRN_SCH_SY_611'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-611' replace='true'}{/capture}
    {grn_checkbox name="allow_attendance_check" id="allow_attendance_check" value="1" checked=$allow_attendance_check caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_611 onclick="setAttendanceCheck(this.checked);"}
    <br/>
    {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-612' replace='true'}
    {capture name='grn_schedule_system_GRN_SCH_SY_613'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-613' replace='true'}{/capture}
    {if $allow_attendance_check}
        {grn_checkbox name="default_attendance_check" id="default_attendance_check" value="1" checked=$default_attendance_check caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_613}
    {else}
        {grn_checkbox name="default_attendance_check" id="default_attendance_check" value="1" checked=$default_attendance_check caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_613 disabled="1"}
    {/if}
    </td>
 </tr>
 {* End GTM-1621 *}
 <tr>
  <td></td>
  <td>
       {capture name='grn_schedule_system_GRN_SCH_SY_62'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-62' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_62}
       {grn_button_cancel}
  </td>
 </tr>
</table>

</form>

<script language="JavaScript">
{literal}
<!--
function setDisable(setValue)
{
  document.getElementById("facnamepos").disabled = setValue;
}
//-->
{/literal}
setDisable({$leftrightEnable});
{literal}
function setAttendanceCheck(setValue)
{
    if(setValue)
    {
        document.getElementById("default_attendance_check").disabled = false;
        document.getElementById("default_attendance_check_label").className = "";
        document.getElementById("default_attendance_check_label").onmouseover = function(){this.style.color="#ff0000"};
        document.getElementById("default_attendance_check_label").onmouseout = function(){this.style.color=""};
    }
    else
    {
        document.getElementById("default_attendance_check").disabled = true;
        document.getElementById("default_attendance_check_label").className = "form_disable";
        document.getElementById("default_attendance_check_label").onmouseover = function(){};
        document.getElementById("default_attendance_check_label").onmouseout = function(){};
    }
}

function setPrivateCheck(setValue)
{
    if(setValue)
    {
        document.getElementById("default_private").disabled = false;
        document.getElementById("default_public").disabled = false;
        document.getElementById("default_setted").disabled = false;
        jQuery("label[for = 'default_private']").removeClass("form_disable").attr("onmouseover", "this.style.color='#ff0000'").attr("onmouseout", "this.style.color = ''");
        jQuery("label[for = 'default_public']").removeClass("form_disable").attr("onmouseover", "this.style.color='#ff0000'").attr("onmouseout", "this.style.color = ''");
        jQuery("label[for = 'default_setted']").removeClass("form_disable").attr("onmouseover", "this.style.color='#ff0000'").attr("onmouseout", "this.style.color = ''");
    }
    else
    {
        document.getElementById("default_private").disabled = true;
        document.getElementById("default_public").disabled = true;
        document.getElementById("default_setted").disabled = true;
        jQuery("label[for = 'default_private']").addClass("form_disable").removeAttr("onmouseover onmouseout");
        jQuery("label[for = 'default_public']").addClass("form_disable").removeAttr("onmouseover onmouseout");
        jQuery("label[for = 'default_setted']").addClass("form_disable").removeAttr("onmouseover onmouseout");
    }
}

{/literal}
</script>
{include file='grn/system_footer.tpl'}
