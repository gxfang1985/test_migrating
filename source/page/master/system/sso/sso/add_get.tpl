{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/sso/sso/command_add_get'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="smid" value="{$sso_method.smid}">
<input type="hidden" name="said" value="{$sso_method.said}">
<input type="hidden" name="driver_type" value="{$sso_method.driver_type}">
<input type="hidden" name="display" value="{$display}">
{include file='system/sso/sso/_sso_js.tpl'}

<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_system_sso_sso_GRN_SY_SS_SS_1'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-1' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_1 necessary=true}
  </th>
  <td>
       {capture name='grn_system_sso_sso_GRN_SY_SS_SS_2'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-2' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_2 append="validation_errors"}
       {grn_text name="display_name" class="display_name" necessary=true value="$display_name" size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_sso_sso_GRN_SY_SS_SS_3'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-3' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_3 necessary=true}
  </th>
  <td>
       {capture name='grn_system_sso_sso_GRN_SY_SS_SS_4'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-4' replace='true'}{/capture}{validate form=$form_name field="target_url" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_4 append="validation_errors"}
       {grn_text name="target_url" class="target_url" necessary=true value="$target_url" size="50" disable_return_key=true maxlength="255"}<br>
       <div class="sub_explanation">{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-6' replace='true'}</div>
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_sso_sso_GRN_SY_SS_SS_9'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-9' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_9}
  </th>
  <td>
       {if $available_window== 1}
        {capture name='grn_system_sso_sso_GRN_SY_SS_SS_10'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-10' replace='true'}{/capture}{grn_checkbox name="available_window" id="available_window" value="1" caption=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_10 checked=TRUE}
       {else}
        {capture name='grn_system_sso_sso_GRN_SY_SS_SS_11'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-11' replace='true'}{/capture}{grn_checkbox name="available_window" id="available_window" value="1" caption=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_11}
       {/if}
       {if $available_personal == 1}
        {capture name='grn_system_sso_sso_GRN_SY_SS_SS_12'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-12' replace='true'}{/capture}{grn_checkbox name="available_personal" id="available_personal" value="1" caption=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_12 checked=TRUE}
       {else}
        {capture name='grn_system_sso_sso_GRN_SY_SS_SS_13'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-13' replace='true'}{/capture}{grn_checkbox name="available_personal" id="available_personal" value="1" caption=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_13}
       {/if}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {assign var="personal_param_names" value=$sso_method.driver_settings.personal_param_names}
      {assign var="personal_param_values" value=$sso_method.driver_settings.personal_param_values}
      {capture name='grn_system_sso_sso_GRN_SY_SS_SS_14'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-14' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_14}
  </th>
  <td style="padding:0px">
      <table class="std_form">
       <tr>
        <td>{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-15' replace='true'}</td>
        <td>{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-16' replace='true'}</td>
       </tr>
       <tr>
        <td>{grn_text name="personal_names[]" class="personal_names[]" necessary=true value=$personal_param_names.0 size="20" disable_return_key=true}</td>
        <td nowrap>
{if $personal_param_values.0 == '' || ($personal_param_values.0 != '' && $personal_param_values.0.application == '' )}
   {assign var='values_class' value=''}
{else}
   {assign var='values_class' value='none'}
{/if}
         {include file='system/sso/sso/_sso_input.tpl' selectid='sso_input_personal0' textid='personal_values0' sso_form='this.form' value=$personal_param_values.0}
         {if $personal_param_values.0 != ''}{grn_text id='personal_values0' name="personal_values[]" class=$values_class necessary=true value=$personal_param_values.0.value size="50" disable_return_key=true}
         {else}{grn_text id='personal_values0' name="personal_values[]" class=$values_class necessary=true size="50" disable_return_key=true}{/if}
        </td>
       </tr>
       <tr>
        <td>{grn_text name="personal_names[]" class="personal_names[]" necessary=true value=$personal_param_names.1 size="20" disable_return_key=true}</td>
        <td nowrap>
{if $personal_param_values.1 == '' || ( $personal_param_values.1 != '' && $personal_param_values.1.application == '' )}
   {assign var='values_class' value=''}
{else}
   {assign var='values_class' value='none'}
{/if}
         {include file='system/sso/sso/_sso_input.tpl' selectid='sso_input_personal1' textid='personal_values1' sso_form='this.form' value=$personal_param_values.1}
         {if $personal_param_values.1 != ''}{grn_text id='personal_values1' name="personal_values[]" class=$values_class necessary=true value=$personal_param_values.1.value size="50" disable_return_key=true}
         {else}{grn_text id='personal_values1' name="personal_values[]" class=$values_class necessary=true size="50" disable_return_key=true}{/if}
        </td>
       </tr>
      </table>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {assign var="system_param_names" value=$sso_method.driver_settings.system_param_names}
      {assign var="system_param_values" value=$sso_method.driver_settings.system_param_values}
      {capture name='grn_system_sso_sso_GRN_SY_SS_SS_17'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-17' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_17}
  </th>
  <td style="padding:0px">
      <table>
       <tr>
        <td>{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-18' replace='true'}</td>
        <td>{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-19' replace='true'}</td>
       </tr>
       <tr>
        <td>{grn_text name="system_names[]" class="system_names[]" value=$system_param_names.0 size="20" disable_return_key=true}</td>
        <td nowrap>
{if $system_param_values.0 == '' || ($system_param_values.0 != '' && $system_param_values.0.application == '' )}
   {assign var='values_class' value=''}
{else}
   {assign var='values_class' value='none'}
{/if}
        {include file='system/sso/sso/_sso_input.tpl' selectid='sso_input_system0' textid='system_values0' sso_form='this.form' value=$system_param_values.0}
        {if $system_param_values.0 != ''}{grn_text id='system_values0' name="system_values[]" class=$values_class necessary=true value=$system_param_values.0.value size="50" disable_return_key=true}
        {else}{grn_text id='system_values0' name="system_values[]" class=$values_class necessary=true size="50" disable_return_key=true}{/if}
        </td>
       </tr>
       <tr>
        <td>{grn_text name="system_names[]" class="system_names[]" value=$system_param_names.1 size="20" disable_return_key=true}</td>
        <td nowrap>
{if $system_param_values.1 == '' || ($system_param_values.1 != '' && $system_param_values.1.application == '' )}
   {assign var='values_class' value=''}
{else}
   {assign var='values_class' value='none'}
{/if}
        {include file='system/sso/sso/_sso_input.tpl' selectid='sso_input_system1' textid='system_values1' sso_form='this.form' value=$system_param_values.1}
        {if $system_param_values.1 != ''}{grn_text id='system_values1' name="system_values[]" class=$values_class necessary=true value=$system_param_values.1.value size="50" disable_return_key=true}
        {else}{grn_text id='system_values1' name="system_values[]" class=$values_class necessary=true size="50" disable_return_key=true}{/if}
        </td>
       </tr>
       <tr>
        <td>{grn_text name="system_names[]" class="system_names[]" value=$system_param_names.2 size="20" disable_return_key=true}</td>
        <td nowrap>
{if $system_param_values.2 == '' || ($system_param_values.2 != '' && $system_param_values.2.application == '')}
   {assign var='values_class' value=''}
{else}
   {assign var='values_class' value='none'}
{/if}
        {include file='system/sso/sso/_sso_input.tpl' selectid='sso_input_system2' textid='system_values2' sso_form='this.form' value=$system_param_values.2}
        {if $system_param_values.2 != ''}{grn_text id='system_values2' name="system_values[]" class=$values_class necessary=true value=$system_param_values.2.value size="50" disable_return_key=true}
        {else}{grn_text id='system_values2' name="system_values[]" class=$values_class necessary=true size="50" disable_return_key=true}{/if}
        </td>
       </tr>
       <tr>
        <td>{grn_text name="system_names[]" class="system_names[]" value=$system_param_names.3 size="20" disable_return_key=true}</td>
        <td nowrap>
{if $system_param_values.3 == '' || ($system_param_values.3 != '' && $system_param_values.3.application == '')}
   {assign var='values_class' value=''}
{else}
   {assign var='values_class' value='none'}
{/if}
        {include file='system/sso/sso/_sso_input.tpl' selectid='sso_input_system3' textid='system_values3' sso_form='this.form' value=$system_param_values.3}
        {if $system_param_values.3 != ''}{grn_text id='system_values3' name="system_values[]" class=$values_class necessary=true value=$system_param_values.3.value size="50" disable_return_key=true}
        {else}{grn_text id='system_values3' name="system_values[]" class=$values_class necessary=true size="50" disable_return_key=true}{/if}
        </td>
       </tr>
       <tr>
        <td>{grn_text name="system_names[]" class="system_names[]" value=$system_param_names.4 size="20" disable_return_key=true}</td>
        <td nowrap>
{if $system_param_values.4 == '' || ($system_param_values.4 != '' && $system_param_values.4.application == '' )}
   {assign var='values_class' value=''}
{else}
   {assign var='values_class' value='none'}
{/if}
        {include file='system/sso/sso/_sso_input.tpl' selectid='sso_input_system4' textid='system_values4' sso_form='this.form' value=$system_param_values.4}
        {if $system_param_values.4 != ''}{grn_text id='system_values4' name="system_values[]" class=$values_class necessary=true value=$system_param_values.4.value size="50" disable_return_key=true}
        {else}{grn_text id='system_values4' name="system_values[]" class=$values_class necessary=true size="50" disable_return_key=true}{/if}
        </td>
       </tr>
      </table>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_sso_sso_GRN_SY_SS_SS_20'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-20' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_20}
       {capture name='grn_system_sso_sso_GRN_SY_SS_SS_21'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-21' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_21}
       {capture name='grn_system_sso_sso_GRN_SY_SS_SS_22'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-22' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_22 page='system/sso/sso_method_list' sf=1}
  </td>
 </tr>
</table> 
</form>
