      {assign var='work_hours_list_count' value=$base.work_hours_list|@count}
      <tr>
        <th>{cb_msg module='grn.system.i18n.base' key='workday' replace='true'}</th>
        <td>
          {capture name='tmp'}{cb_msg module='grn.system.i18n.base' key='sunday' replace='true'}{/capture}{grn_checkbox name='sunday' id='sunday' value='1' caption=$smarty.capture.tmp checked=$base.workday_sunday}
          {capture name='tmp'}{cb_msg module='grn.system.i18n.base' key='monday' replace='true'}{/capture}{grn_checkbox name='monday' id='monday' value='1' caption=$smarty.capture.tmp checked=$base.workday_monday}
          {capture name='tmp'}{cb_msg module='grn.system.i18n.base' key='tuesday' replace='true'}{/capture}{grn_checkbox name='tuesday' id='tuesday' value='1' caption=$smarty.capture.tmp checked=$base.workday_tuesday}
          {capture name='tmp'}{cb_msg module='grn.system.i18n.base' key='wednesday' replace='true'}{/capture}{grn_checkbox name='wednesday' id='wednesday' value='1' caption=$smarty.capture.tmp checked=$base.workday_wednesday}
          {capture name='tmp'}{cb_msg module='grn.system.i18n.base' key='thursday' replace='true'}{/capture}{grn_checkbox name='thursday' id='thursday' value='1' caption=$smarty.capture.tmp checked=$base.workday_thursday}
          {capture name='tmp'}{cb_msg module='grn.system.i18n.base' key='friday' replace='true'}{/capture}{grn_checkbox name='friday' id='friday' value='1' caption=$smarty.capture.tmp checked=$base.workday_friday}
          {capture name='tmp'}{cb_msg module='grn.system.i18n.base' key='saturday' replace='true'}{/capture}{grn_checkbox name='saturday' id='saturday' value='1' caption=$smarty.capture.tmp checked=$base.workday_saturday}
        </td>
      </tr>
      <tr>
        <th>{cb_msg module='grn.system.i18n.base' key='work_hours' replace='true'}</th>
        <td id='work_hours'>
          {if $work_hours_list_count > 0}
          {assign var='work_hours_num' value=1}
          {foreach from=$base.work_hours_list item=work_hours}
          <div id='work_hours_{$work_hours_num}' class="work_hours">
            {grn_select_time prefix='start_work_hours_'|cat:$work_hours_num|cat:'_' time=$work_hours.start necessary=true minute_interval=$minute_interval}{cb_msg module='grn.system.i18n.base' key='from_to' replace='true'}{grn_select_time prefix='end_work_hours_'|cat:$work_hours_num|cat:'_' time=$work_hours.end necessary=true minute_interval=$minute_interval}{if $work_hours_num > 1}<input id='remove_work_hours_{$work_hours_num}' type='button' value='{cb_msg module='grn.system.i18n.base' key='remove' replace='true'}' onclick='GRN_BaseWorkHours.remove({$work_hours_num});' />{/if}
          </div>
          {assign var='work_hours_num' value=$work_hours_num+1}
          {/foreach}
          {else}
          <div id='work_hours_1' class="work_hours">{grn_select_time prefix='start_work_hours_1_' necessary=true minute_interval=$minute_interval}{cb_msg module='grn.system.i18n.base' key='from_to' replace='true'}{grn_select_time prefix='end_work_hours_1_' necessary=true minute_interval=$minute_interval}</div>
          {/if}
          {if $work_hours_list_count < 10}
          <div id='add_work_hours'><input id='add_work_hours_button' type='button' onclick='GRN_BaseWorkHours.copy();' value='{cb_msg module='grn.system.i18n.base' key='add_work_hours' replace='true'}' /></div>
          {else}
          <div id='add_work_hours'></div>
          {/if}
        </td>
      </tr>
      <tr>
        <th>{cb_msg module='grn.system.i18n.base' key='calendar' replace='true'}</th>
        <td>
          <table>
            <tr>
              <td><select name="calendar" id="calendar">
                  {foreach from=$calendars key=calendar_id item=calendar_name}
	              <option value="{$calendar_id}" {if $calendar_id == $base.calendar.id}selected{/if}>{$calendar_name}</option>
	              {/foreach}
              </select></td>
            </tr>
            <tr>
              <td>{capture name='tmp'}{cb_msg module='grn.system.i18n.base' key='apply_calendar' replace='true'}{/capture}{grn_checkbox name='apply_calendar' id='apply_calendar' value='1' caption=$smarty.capture.tmp checked=$base.apply_calendar}</td>
            </tr>
          </table>
        </td>
      </tr>
