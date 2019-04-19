{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='personal/sso/sso/command_set_post'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="smid" value="{$sso_method.smid}">
<input type="hidden" name="said" value="{$sso_method.said}">
<input type="hidden" name="driver_type" value="{$sso_method.driver_type}">
<input type="hidden" name="display" value="{$display}">
{include file='personal/sso/sso/_sso_js.tpl'}

<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_personal_sso_sso_GRN_PRS_SO_S_18'}{cb_msg module='grn.personal.sso.sso' key='GRN_PRS_SO_S-18' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_personal_sso_sso_GRN_PRS_SO_S_18}
  </th>
  <td>
       {$sso_method.display_name|escape}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {assign var="personal_param_names" value=$sso_method.driver_settings.personal_param_names}
      {assign var="personal_param_values" value=$sso_method.driver_settings.personal_param_values}
      {capture name='grn_personal_sso_sso_GRN_PRS_SO_S_19'}{cb_msg module='grn.personal.sso.sso' key='GRN_PRS_SO_S-19' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_personal_sso_sso_GRN_PRS_SO_S_19}
  </th>
  <td style="padding:0px">
      <table>
       <tr>
        <td>{cb_msg module='grn.personal.sso.sso' key='GRN_PRS_SO_S-20' replace='true'}</td>
        <td>{cb_msg module='grn.personal.sso.sso' key='GRN_PRS_SO_S-21' replace='true'}</td>
       </tr>
{if count($sso_method.driver_settings.personal_params) > 0}
       <tr>
        <td width="100">{$personal_param_names.0|escape}<input type="hidden" name="personal_names[]" value="{$personal_param_names.0}"></td>
        <td nowrap>
{if ! $personal_param_values.0.application}
   {assign var='values_class' value=''}
{elseif $personal_param_values.0.application == '0'}
   {assign var='values_class' value=''}
{else}
   {assign var='values_class' value='none'}
{/if}
         {include file='personal/sso/sso/_sso_input.tpl' selectid='sso_input_personal0' textid='personal_values0' sso_form='this.form' value=$personal_param_values.0}{grn_text id='personal_values0' name="personal_values[]" class=$values_class necessary=true value=$personal_param_values.0.value size="50" disable_return_key=true}
        </td>
       </tr>
{if count($sso_method.driver_settings.personal_params) > 1}
       <tr>
        <td width="100">{$personal_param_names.1|escape}<input type="hidden" name="personal_names[]" value="{$personal_param_names.1}"></td>
        <td nowrap>
{if ! $personal_param_values.1.application}
   {assign var='values_class' value=''}
{elseif $personal_param_values.1.application == '0'}
   {assign var='values_class' value=''}
{else}
   {assign var='values_class' value='none'}
{/if}
         {include file='personal/sso/sso/_sso_input.tpl' selectid='sso_input_personal1' textid='personal_values1' sso_form='this.form' value=$personal_param_values.1}{grn_text id='personal_values1' name="personal_values[]" class=$values_class necessary=true value=$personal_param_values.1.value size="50" disable_return_key=true}
        </td>
       </tr>
{/if}{** if count($sso_method.driver_settings.personal_params) > 1 **}
{/if}{** if count($sso_method.driver_settings.personal_params) > 0 **}
      </table>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
{if count($sso_method.driver_settings.personal_params) > 0}
       {capture name='grn_personal_sso_sso_GRN_PRS_SO_S_22'}{cb_msg module='grn.personal.sso.sso' key='GRN_PRS_SO_S-22' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_personal_sso_sso_GRN_PRS_SO_S_22}
{else}
       {capture name='grn_personal_sso_sso_GRN_PRS_SO_S_23'}{cb_msg module='grn.personal.sso.sso' key='GRN_PRS_SO_S-23' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_personal_sso_sso_GRN_PRS_SO_S_23 disabled=1}
{/if}
       {capture name='grn_personal_sso_sso_GRN_PRS_SO_S_24'}{cb_msg module='grn.personal.sso.sso' key='GRN_PRS_SO_S-24' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_personal_sso_sso_GRN_PRS_SO_S_24 page='personal/sso/sso_method_view' smid=$sso_method.smid}
  </td>
 </tr>
</table>

</form>
