{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='timecard/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-1' replace='true'}</th>
  <td>{capture name='grn_timecard_system_GRN_TIM_SY_2'}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-2' replace='true'}{/capture}{grn_checkbox name="auto_puchout" id="auto_puchout" value="1" checked=$config.enable_auto_punchout caption=$smarty.capture.grn_timecard_system_GRN_TIM_SY_2}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-3' replace='true'}</th>
  <td>
       <select name="offset_day">
{foreach from=$config.offset_day_list key=day item=current}
        <option value="{$day}"{if $config.offset_day == $day} selected{/if}>{$day}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-4' replace='true'}
{/foreach}
       </select>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-5' replace='true'}</th>
  <td>
       <select name="offset_month">
        <option value="0"{if $config.offset_month == 0} selected{/if}>0
        <option value="1"{if $config.offset_month == 1} selected{/if}>1
        <option value="2"{if $config.offset_month == 2} selected{/if}>2
        <option value="3"{if $config.offset_month == 3} selected{/if}>3
       </select>
       <div class="margin_top">{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-6' replace='true'}</div>
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-7' replace='true'}</th>
  <td>
       <select name="absence_max">
{foreach from=$config.absence_limit_list key=num item=value}
        <option value="{$num}"{if $value} selected{/if}>{if $num}{$num}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-8' replace='true'}{else}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-9' replace='true'}{/if}
{/foreach}
       </select>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-10' replace='true'}</th>
  <td>
       <select name="change_of_day">
        <option value="0"{if $config.change_of_day.hour == 0} selected{/if}>0:00
        <option value="1"{if $config.change_of_day.hour == 1} selected{/if}>1:00
        <option value="2"{if $config.change_of_day.hour == 2} selected{/if}>2:00
        <option value="3"{if $config.change_of_day.hour == 3} selected{/if}>3:00
        <option value="4"{if $config.change_of_day.hour == 4} selected{/if}>4:00
        <option value="5"{if $config.change_of_day.hour == 5} selected{/if}>5:00
        <option value="6"{if $config.change_of_day.hour == 6} selected{/if}>6:00
        <option value="7"{if $config.change_of_day.hour == 7} selected{/if}>7:00
        <option value="8"{if $config.change_of_day.hour == 8} selected{/if}>8:00
       </select>
       <div class="margin_top">{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-11' replace='true'}<br>{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-12' replace='true'}</div>
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-13' replace='true'}</th>
  <td>{capture name='grn_timecard_system_GRN_TIM_SY_14'}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-14' replace='true'}{/capture}{grn_checkbox name="user_modify" id="user_modify" value="1" checked=$config.enable_modify_record caption=$smarty.capture.grn_timecard_system_GRN_TIM_SY_14}
       <div class="margin_top">{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-15' replace='true'}/off {cb_msg module='grn.timecard.system' key='GRN_TIM_SY-16' replace='true'}</div>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_timecard_system_GRN_TIM_SY_17'}{cb_msg module='grn.timecard.system' key='GRN_TIM_SY-17' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_timecard_system_GRN_TIM_SY_17}
       {grn_button_cancel}
  </td>
 </tr>
</table>

</form>

{include file='grn/system_footer.tpl'}
