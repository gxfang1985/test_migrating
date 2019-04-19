{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/sso/sso/command_modify_post'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="smid" value="{$sso_method.smid}">
<input type="hidden" name="said" value="{$sso_method.said}">
<input type="hidden" name="driver_type" value="{$sso_method.driver_type}">
<input type="hidden" name="display" value="{$display}">
{include file='system/sso/sso/_sso_js.tpl'}

<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_system_sso_sso_GRN_SY_SS_SS_37'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-37' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_37 necessary=true}
  </th>
  <td>
       {capture name='grn_system_sso_sso_GRN_SY_SS_SS_38'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-38' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_38 append="validation_errors"}
       {grn_text name="display_name" class="display_name" necessary=true value=$sso_method.display_name size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_sso_sso_GRN_SY_SS_SS_39'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-39' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_39 necessary=true}
  </th>
  <td>
       {capture name='grn_system_sso_sso_GRN_SY_SS_SS_40'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-40' replace='true'}{/capture}{validate form=$form_name field="target_url" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_40 append="validation_errors"}
       {grn_text name="target_url" class="target_url" necessary=true value=$sso_method.driver_settings.target_url size="50" disable_return_key=true maxlength="255"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_sso_sso_GRN_SY_SS_SS_42'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-42' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_42}
  </th>
  <td>
       {if $sso_method.available_window== 1}
        {capture name='grn_system_sso_sso_GRN_SY_SS_SS_43'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-43' replace='true'}{/capture}{grn_checkbox name="available_window" id="available_window" value="1" caption=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_43 checked=TRUE}
       {else}
        {capture name='grn_system_sso_sso_GRN_SY_SS_SS_44'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-44' replace='true'}{/capture}{grn_checkbox name="available_window" id="available_window" value="1" caption=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_44}
       {/if}
       {if $sso_method.available_personal == 1}
        {capture name='grn_system_sso_sso_GRN_SY_SS_SS_45'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-45' replace='true'}{/capture}{grn_checkbox name="available_personal" id="available_personal" value="1" caption=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_45 checked=TRUE}
       {else}
        {capture name='grn_system_sso_sso_GRN_SY_SS_SS_46'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-46' replace='true'}{/capture}{grn_checkbox name="available_personal" id="available_personal" value="1" caption=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_46}
       {/if}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {assign var="personal_param_names" value=$sso_method.driver_settings.personal_param_names}
      {assign var="personal_param_values" value=$sso_method.driver_settings.personal_param_values}
      {capture name='grn_system_sso_sso_GRN_SY_SS_SS_47'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-47' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_47}
  </th>
  <td style="padding:0px">
      <table>
       <tr>
        <td>{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-48' replace='true'}</td>
        <td>{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-49' replace='true'}</td>
       </tr>
       <tr>
        <td>{grn_text name="personal_names[]" class="personal_names[]" necessary=true value=$personal_param_names.0 size="20" disable_return_key=true}</td>
        <td nowrap>
{if $personal_param_values.0.application == ''}
   {assign var='values_class' value=''}
{else}
   {assign var='values_class' value='none'}
{/if}
         {include file='system/sso/sso/_sso_input.tpl' selectid='sso_input_personal0' textid='personal_values0' sso_form='this.form' value=$personal_param_values.0}{grn_text id='personal_values0' name="personal_values[]" class=$values_class necessary=true value=$personal_param_values.0.value size="50" disable_return_key=true}
        </td>
       </tr>
       <tr>
        <td>{grn_text name="personal_names[]" class="personal_names[]" necessary=true value=$personal_param_names.1 size="20" disable_return_key=true}</td>
        <td nowrap>
{if $personal_param_values.1.application == ''}
   {assign var='values_class' value=''}
{else}
   {assign var='values_class' value='none'}
{/if}
         {include file='system/sso/sso/_sso_input.tpl' selectid='sso_input_personal1' textid='personal_values1' sso_form='this.form' value=$personal_param_values.1}{grn_text id='personal_values1' name="personal_values[]" class=$values_class necessary=true value=$personal_param_values.1.value size="50" disable_return_key=true}
        </td>
       </tr>
      </table>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {assign var="system_param_names" value=$sso_method.driver_settings.system_param_names}
      {assign var="system_param_values" value=$sso_method.driver_settings.system_param_values}
      {capture name='grn_system_sso_sso_GRN_SY_SS_SS_50'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-50' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_50}
  </th>
  <td style="padding:0px">
      <table>
       <tr>
        <td>{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-51' replace='true'}</td>
        <td>{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-52' replace='true'}</td>
       </tr>
       <tr>
        <td>{grn_text name="system_names[]" class="system_names[]" value=$system_param_names.0 size="20" disable_return_key=true}</td>
        <td nowrap>
{if $system_param_values.0.application == ''}
   {assign var='values_class' value=''}
{else}
   {assign var='values_class' value='none'}
{/if}
        {include file='system/sso/sso/_sso_input.tpl' selectid='sso_input_system0' textid='system_values0' sso_form='this.form' value=$system_param_values.0}{grn_text id='system_values0' name="system_values[]" class=$values_class necessary=true value=$system_param_values.0.value size="50" disable_return_key=true}
        </td>
       </tr>
       <tr>
        <td>{grn_text name="system_names[]" class="system_names[]" value=$system_param_names.1 size="20" disable_return_key=true}</td>
        <td nowrap>
{if $system_param_values.1.application == ''}
   {assign var='values_class' value=''}
{else}
   {assign var='values_class' value='none'}
{/if}
        {include file='system/sso/sso/_sso_input.tpl' selectid='sso_input_system1' textid='system_values1' sso_form='this.form' value=$system_param_values.1}{grn_text id='system_values1' name="system_values[]" class=$values_class necessary=true value=$system_param_values.1.value size="50" disable_return_key=true}
        </td>
       </tr>
       <tr>
        <td>{grn_text name="system_names[]" class="system_names[]" value=$system_param_names.2 size="20" disable_return_key=true}</td>
        <td nowrap>
{if $system_param_values.2.application == ''}
   {assign var='values_class' value=''}
{else}
   {assign var='values_class' value='none'}
{/if}
        {include file='system/sso/sso/_sso_input.tpl' selectid='sso_input_system2' textid='system_values2' sso_form='this.form' value=$system_param_values.2}{grn_text id='system_values2' name="system_values[]" class=$values_class necessary=true value=$system_param_values.2.value size="50" disable_return_key=true}
        </td>
       </tr>
       <tr>
        <td>{grn_text name="system_names[]" class="system_names[]" value=$system_param_names.3 size="20" disable_return_key=true}</td>
        <td nowrap>
{if $system_param_values.3.application == ''}
   {assign var='values_class' value=''}
{else}
   {assign var='values_class' value='none'}
{/if}
        {include file='system/sso/sso/_sso_input.tpl' selectid='sso_input_system3' textid='system_values3' sso_form='this.form' value=$system_param_values.3}{grn_text id='system_values3' name="system_values[]" class=$values_class necessary=true value=$system_param_values.3.value size="50" disable_return_key=true}
        </td>
       </tr>
       <tr>
        <td>{grn_text name="system_names[]" class="system_names[]" value=$system_param_names.4 size="20" disable_return_key=true}</td>
        <td nowrap>
{if $system_param_values.4.application == ''}
   {assign var='values_class' value=''}
{else}
   {assign var='values_class' value='none'}
{/if}
        {include file='system/sso/sso/_sso_input.tpl' selectid='sso_input_system4' textid='system_values4' sso_form='this.form' value=$system_param_values.4}{grn_text id='system_values4' name="system_values[]" class=$values_class necessary=true value=$system_param_values.4.value size="50" disable_return_key=true}
        </td>
       </tr>
      </table>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_sso_sso_GRN_SY_SS_SS_53'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-53' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_53}
       {capture name='grn_system_sso_sso_GRN_SY_SS_SS_54'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-54' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_54 page='system/sso/sso_method_view' smid=$sso_method.smid}
  </td>
 </tr>
</table>

</form>
