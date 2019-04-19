{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>
     {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-58' replace='true'}
  </th>
  <td>
      {grn_select_numbers select_name=$select1.name options=$select1.options padding=$select1.padding selected=$select1.selected}&nbsp;{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-59' replace='true'}
      {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-60' replace='true'}
      {grn_select_numbers select_name=$select2.name options=$select2.options padding=$select2.padding selected=$select2.selected}&nbsp;{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-61' replace='true'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-62' replace='true'}
  </th>
  <td>
      {capture name='grn_schedule_personal_GRN_SCH_PE_63'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-63' replace='true'}{/capture}
{if $sundayalign}
      {grn_checkbox name='startwday' id='checkbox_id1' value='1' caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_63 checked=true}
{else}
      {grn_checkbox name='startwday' id='checkbox_id1' value='1' caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_63}
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-65' replace='true'}
  </th>
  <td>
{if $showendtime}
      {capture name='grn_schedule_personal_GRN_SCH_PE_66'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-66' replace='true'}{/capture}{grn_checkbox name='showendhour' id='checkbox_id2' value='1' caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_66 checked=true}
{else}
      {capture name='grn_schedule_personal_GRN_SCH_PE_67'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-67' replace='true'}{/capture}{grn_checkbox name='showendhour' id='checkbox_id2' value='1' caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_67}
{/if}
  </td>
 </tr>
 {if $activateDragDrop}
 <tr>
    <th>{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-75' replace='true'}</th>
    <td>
    {capture name='grn_schedule_personal_GRN_SCH_PE_76'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-76' replace='true'}{/capture}
    {grn_checkbox name="usingDragDrop" id="usingDragDrop" value="1" checked=$usingDragDrop caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_76}
    </td>
 </tr>
 {/if}
 <tr>
  <td></td>
  <td>
      {capture name='grn_schedule_personal_GRN_SCH_PE_68'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-68' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_68}
      {grn_button_cancel}
  </td>
 </tr>
</table>

</form>
{include file='grn/personal_footer.tpl'}
