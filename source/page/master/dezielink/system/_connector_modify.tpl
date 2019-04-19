<table class="std_form">
<tr valign="top">
<th nowrap>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-2' replace='true'}</th>
<td>
  {if !$is_office_module}
    {if $connector_available}
      {capture name='grn_dezielink_system_GRN_DZL_SY_3'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-3' replace='true'}{/capture}{grn_radio name='connector_available' id='connector_available_on' value='on' caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_3 checked=1 onclick="setDisableById(this.form, 'url:sync_user_on:sync_user_off:day:week:month:hour:minute:portlet_available_on:portlet_available_off:wdays:days:portlet_cache_expire', 'off');G.connector_available(this.form);"}&nbsp;&nbsp;{capture name='grn_dezielink_system_GRN_DZL_SY_4'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-4' replace='true'}{/capture}{grn_radio name='connector_available' id='connector_available_off' value='off' caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_4 checked=0 onclick="setDisableById(this.form, 'url:sync_user_on:sync_user_off:day:week:month:hour:minute:portlet_available_on:portlet_available_off:wdays:days:portlet_cache_expire', 'on');"}
    {else}
      {capture name='grn_dezielink_system_GRN_DZL_SY_5'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-5' replace='true'}{/capture}{grn_radio name='connector_available' id='connector_available_on' value='on' caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_5 onclick="setDisableById(this.form, 'url:sync_user_on:sync_user_off:day:week:month:hour:minute:portlet_available_on:portlet_available_off:wdays:days:portlet_cache_expire', 'off');G.connector_available(this.form);"}&nbsp;&nbsp;{capture name='grn_dezielink_system_GRN_DZL_SY_6'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-6' replace='true'}{/capture}{grn_radio name='connector_available' id='connector_available_off' value='off' caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_6 checked=1 onclick="setDisableById(this.form, 'url:sync_user_on:sync_user_off:day:week:month:hour:minute:portlet_available_on:portlet_available_off:wdays:days:portlet_cache_expire', 'on');"}
    {/if}
  {else}
    {if $connector_available}
        {capture name='grn_dezielink_system_GRN_DZL_SY_3'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-3' replace='true'}{/capture}{grn_radio name='connector_available' id='connector_available_on' value='on' caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_3 checked=1 onclick="setDisableById(this.form, 'url:sync_user_on:sync_user_off:day:week:month:hour:minute:wdays:days', 'off');G.connector_available(this.form);"}&nbsp;&nbsp;{capture name='grn_dezielink_system_GRN_DZL_SY_4'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-4' replace='true'}{/capture}{grn_radio name='connector_available' id='connector_available_off' value='off' caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_4 checked=0 onclick="setDisableById(this.form, 'url:sync_user_on:sync_user_off:day:week:month:hour:minute:wdays:days', 'on');"}
    {else}
        {capture name='grn_dezielink_system_GRN_DZL_SY_5'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-5' replace='true'}{/capture}{grn_radio name='connector_available' id='connector_available_on' value='on' caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_5 onclick="setDisableById(this.form, 'url:sync_user_on:sync_user_off:day:week:month:hour:minute:wdays:days', 'off');G.connector_available(this.form);"}&nbsp;&nbsp;{capture name='grn_dezielink_system_GRN_DZL_SY_6'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-6' replace='true'}{/capture}{grn_radio name='connector_available' id='connector_available_off' value='off' caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_6 checked=1 onclick="setDisableById(this.form, 'url:sync_user_on:sync_user_off:day:week:month:hour:minute:wdays:days', 'on');"}
    {/if}
  {/if}
</td>
</tr>
<tr valign="top">
<th nowrap>{capture name='grn_dezielink_system_GRN_DZL_SY_7'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-7' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_7 necessary=true}</th>
<td>{capture name='grn_dezielink_system_GRN_DZL_SY_8'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-8' replace='true'}{/capture}{validate form=$form_name field="url" criteria="notEmpty" message=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_8 transform="cb_trim" append="validation_errors"}{grn_text name="url" id="url" value=$url size="80" disable_return_key=true maxlength="255"}
    <div class="sub_explanation">{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-10' replace='true'}<b>{$sample_url}</b></div>
</td>
</tr>
<tr>
<td><br /></td>
<td><br /></td>
</tr>
<tr valign="top">
<th nowrap>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-11' replace='true'}</th>
<td>
    {if $sync_user}
      {capture name='grn_dezielink_system_GRN_DZL_SY_12'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-12' replace='true'}{/capture}{grn_radio name='sync_user' id='sync_user_on' value='on' caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_12 checked=1 onclick="javascript:display_on('link_box');G.sync_user_on()"}&nbsp;&nbsp;{capture name='grn_dezielink_system_GRN_DZL_SY_13'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-13' replace='true'}{/capture}{grn_radio name='sync_user' id='sync_user_off' value='off ' caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_13 checked=0 onclick="javascript:display_off('link_box')"}
    {else}
      {capture name='grn_dezielink_system_GRN_DZL_SY_14'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-14' replace='true'}{/capture}{grn_radio name='sync_user' id='sync_user_on' value='on' caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_14 checked=0 onclick="javascript:display_on('link_box');G.sync_user_on()"}&nbsp;&nbsp;{capture name='grn_dezielink_system_GRN_DZL_SY_15'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-15' replace='true'}{/capture}{grn_radio name='sync_user' id='sync_user_off' value='off' caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_15 checked=1 onclick="javascript:display_off('link_box')"}
    {/if}
    <div class="sub_explanation">{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-16' replace='true'}</div>
    <div class="sub_explanation margin_top">
    <span class="attention">{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-17' replace='true'}</span><br>
    {cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-18' replace='true'}<br>
    {cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-19' replace='true'}
    </div>
    <div id="link_box" class="margin_top" style="margin-left: 1em;{if !$user_available}display:none{/if}">
      <div class="sub_title margin_top">{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-20' replace='true'}</div>
      {if !$sync_period || $sync_period.type == 1}
        {capture name='grn_dezielink_system_GRN_DZL_SY_21'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-21' replace='true'}{/capture}{grn_radio name='period_type' id='day' value='1' caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_21 checked=1 onclick="setDisableById(this.form, 'wdays', 'on');setDisableById(this.form, 'days', 'on')"}<br />
      {else}
        {capture name='grn_dezielink_system_GRN_DZL_SY_22'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-22' replace='true'}{/capture}{grn_radio name='period_type' id='day' value='1' caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_22 onclick="setDisableById(this.form, 'wdays', 'on');setDisableById(this.form, 'days', 'on')"}<br />
      {/if}
      {if $sync_period.type == 2}
        {capture name='grn_dezielink_system_GRN_DZL_SY_23'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-23' replace='true'}{/capture}{grn_radio name='period_type' id='week' value='2' caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_23 checked=1 onclick="setDisableById(this.form, 'wdays', 'off');setDisableById(this.form, 'days', 'on');"}
        {assign var="wdays" value=$sync_period.value}
      {else}
        {capture name='grn_dezielink_system_GRN_DZL_SY_24'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-24' replace='true'}{/capture}{grn_radio name='period_type' id='week' value='2' caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_24 onclick="setDisableById(this.form, 'wdays', 'off');setDisableById(this.form, 'days', 'on')"}
        {assign var="wdays" value=0}
      {/if}
       <select id="wdays" name="wdays">
       <option value="0" {if $wdays == 0}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-25' replace='true'}</option>
       <option value="1" {if $wdays == 1}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-26' replace='true'}</option>
       <option value="2" {if $wdays == 2}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-27' replace='true'}</option>
       <option value="3" {if $wdays == 3}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-28' replace='true'}</option>
       <option value="4" {if $wdays == 4}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-29' replace='true'}</option>
       <option value="5" {if $wdays == 5}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-30' replace='true'}</option>
       <option value="6" {if $wdays == 6}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-31' replace='true'}</option>
       </select><br/>
      {if $sync_period.type == 3}
        {capture name='grn_dezielink_system_GRN_DZL_SY_32'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-32' replace='true'}{/capture}{grn_radio name='period_type' id='month' value='3' caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_32 checked=1  onclick="setDisableById(this.form, 'wdays', 'on');setDisableById(this.form, 'days', 'off')"}
        {assign var="days" value=$sync_period.value}
      {else}
        {capture name='grn_dezielink_system_GRN_DZL_SY_33'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-33' replace='true'}{/capture}{grn_radio name='period_type' id='month' value='3' caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_33 onclick="setDisableById(this.form, 'wdays', 'on');setDisableById(this.form, 'days', 'off')"}
        {assign var="days" value=1}
      {/if}
       <select id="days" name="days">
       <option value="1" {if $days == 1}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-34' replace='true'}</option>
       <option value="2" {if $days == 2}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-35' replace='true'}</option>
       <option value="3" {if $days == 3}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-36' replace='true'}</option>
       <option value="4" {if $days == 4}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-37' replace='true'}</option>
       <option value="5" {if $days == 5}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-38' replace='true'}</option>
       <option value="6" {if $days == 6}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-39' replace='true'}</option>
       <option value="7" {if $days == 7}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-40' replace='true'}</option>
       <option value="8" {if $days == 8}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-41' replace='true'}</option>
       <option value="9" {if $days == 9}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-42' replace='true'}</option>
       <option value="10" {if $days == 10}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-43' replace='true'}</option>
       <option value="11" {if $days == 11}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-44' replace='true'}</option>
       <option value="12" {if $days == 12}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-45' replace='true'}</option>
       <option value="13" {if $days == 13}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-46' replace='true'}</option>
       <option value="14" {if $days == 14}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-47' replace='true'}</option>
       <option value="15" {if $days == 15}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-48' replace='true'}</option>
       <option value="16" {if $days == 16}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-49' replace='true'}</option>
       <option value="17" {if $days == 17}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-50' replace='true'}</option>
       <option value="18" {if $days == 18}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-51' replace='true'}</option>
       <option value="19" {if $days == 19}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-52' replace='true'}</option>
       <option value="20" {if $days == 20}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-53' replace='true'}</option>
       <option value="21" {if $days == 21}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-54' replace='true'}</option>
       <option value="22" {if $days == 22}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-55' replace='true'}</option>
       <option value="23" {if $days == 23}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-56' replace='true'}</option>
       <option value="24" {if $days == 24}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-57' replace='true'}</option>
       <option value="25" {if $days == 25}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-58' replace='true'}</option>
       <option value="26" {if $days == 26}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-59' replace='true'}</option>
       <option value="27" {if $days == 27}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-60' replace='true'}</option>
       <option value="28" {if $days == 28}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-61' replace='true'}</option>
       <option value="29" {if $days == 29}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-62' replace='true'}</option>
       <option value="30" {if $days == 30}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-63' replace='true'}</option>
       <option value="31" {if $days == 31}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-64' replace='true'}</option>
       <option value="0" {if $days == 0}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-65' replace='true'}</option>
      </select>  
      <div class="sub_title margin_top">{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-66' replace='true'}</div>
      <select id="hour" name="hour">
       <option value="0" {if $sync_time->hour == 1}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-67' replace='true'}</option>
       <option value="1" {if $sync_time->hour == 1}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-68' replace='true'}</option>
       <option value="2" {if $sync_time->hour == 2}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-69' replace='true'}</option>
       <option value="3" {if $sync_time->hour == 3}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-70' replace='true'}</option>
       <option value="4" {if $sync_time->hour == 4}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-71' replace='true'}</option>
       <option value="5" {if $sync_time->hour == 5}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-72' replace='true'}</option>
       <option value="6" {if $sync_time->hour == 6}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-73' replace='true'}</option>
       <option value="7" {if $sync_time->hour == 7}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-74' replace='true'}</option>
       <option value="8" {if $sync_time->hour == 8}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-75' replace='true'}</option>
       <option value="9" {if $sync_time->hour == 9}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-76' replace='true'}</option>
       <option value="10" {if $sync_time->hour == 10}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-77' replace='true'}</option>
       <option value="11" {if $sync_time->hour == 11}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-78' replace='true'}</option>
       <option value="12" {if $sync_time->hour == 12}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-79' replace='true'}</option>
       <option value="13" {if $sync_time->hour == 13}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-80' replace='true'}</option>
       <option value="14" {if $sync_time->hour == 14}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-81' replace='true'}</option>
       <option value="15" {if $sync_time->hour == 15}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-82' replace='true'}</option>
       <option value="16" {if $sync_time->hour == 16}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-83' replace='true'}</option>
       <option value="17" {if $sync_time->hour == 17}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-84' replace='true'}</option>
       <option value="18" {if $sync_time->hour == 18}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-85' replace='true'}</option>
       <option value="19" {if $sync_time->hour == 19}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-86' replace='true'}</option>
       <option value="20" {if $sync_time->hour == 20}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-87' replace='true'}</option>
       <option value="21" {if $sync_time->hour == 21}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-88' replace='true'}</option>
       <option value="22" {if $sync_time->hour == 22}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-89' replace='true'}</option>
       <option value="23" {if $sync_time->hour == 23}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-90' replace='true'}</option>
      </select>
      <select id="minute" name="minute">
       <option value="0" {if $sync_time->minute == 0}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-91' replace='true'}</option>
       <option value="10" {if $sync_time->minute == 10}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-92' replace='true'}</option>
       <option value="20" {if $sync_time->minute == 20}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-93' replace='true'}</option>
       <option value="30" {if $sync_time->minute == 30}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-94' replace='true'}</option>
       <option value="40" {if $sync_time->minute == 40}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-95' replace='true'}</option>
       <option value="50" {if $sync_time->minute == 50}selected{/if}>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-96' replace='true'}</option>
      </select>
      <br /><span class="sub_explanation attention">{cb_msg module='grn' key='GRN_SCHED_RESTRICTION_TIME_IN_UTC' replace='true'}</span>
     </div>
</td>
</tr>
{if !$is_office_module}
<tr valign="top">
<th nowrap>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-97' replace='true'}</th>
<td>
  {if $portlet_available}
    {capture name='grn_dezielink_system_GRN_DZL_SY_98'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-98' replace='true'}{/capture}{grn_radio name='portlet_available' id='portlet_available_on' value='on' caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_98 checked=1 onclick="javascript:display_on('portlet_box');"}&nbsp;&nbsp;{capture name='grn_dezielink_system_GRN_DZL_SY_99'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-99' replace='true'}{/capture}{grn_radio name='portlet_available' id='portlet_available_off' value='off' caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_99 onclick="javascript:display_off('portlet_box');"}
  {else}
    {capture name='grn_dezielink_system_GRN_DZL_SY_100'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-100' replace='true'}{/capture}{grn_radio name='portlet_available' id='portlet_available_on' value='on' caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_100 onclick="javascript:display_on('portlet_box');"}&nbsp;&nbsp;{capture name='grn_dezielink_system_GRN_DZL_SY_101'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-101' replace='true'}{/capture}{grn_radio name='portlet_available' id='portlet_available_off' value='off' caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_101 checked=1 onclick="javascript:display_off('portlet_box');"}
  {/if}
    <div id="portlet_box" class="margin_top" style="margin-left: 1em;{if !$portlet_available}display:none{/if}">
      <div class="margin_top">{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-102' replace='true'}&nbsp;
      <select id="portlet_cache_expire" name="portlet_cache_expire">
       <option value="0" {if $portlet_cache_expire == 0}selected{/if}>&nbsp;0</option>
       <option value="1" {if $portlet_cache_expire == 1}selected{/if}>&nbsp;1</option>
       <option value="5" {if $portlet_cache_expire == 5}selected{/if}>&nbsp;5</option>
       <option value="10" {if $portlet_cache_expire == 10}selected{/if}>10</option>
       <option value="15" {if $portlet_cache_expire == 15}selected{/if}>15</option>
       <option value="30" {if $portlet_cache_expire == 30}selected{/if}>30</option>
      </select>&nbsp;{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-103' replace='true'}
      <div class="sub_explanation">
        {cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-104' replace='true'}<br/>
        {cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-105' replace='true'}
      </div>
      </div>
    </div>
</td>
</tr>
{/if}
<tr>
<td></td>
<td>
   {capture name='grn_dezielink_system_GRN_DZL_SY_106'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-106' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_106}
   {grn_button_cancel page=$cancel_page}
</td>
</tr>
</table>
<input type="hidden" name="fn" value="{$form_name}" />
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}" />
