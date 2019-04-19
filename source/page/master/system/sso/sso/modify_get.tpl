{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/sso/sso/command_modify_get'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="smid" value="{$sso_method.smid}">
<input type="hidden" name="said" value="{$sso_method.said}">
<input type="hidden" name="driver_type" value="{$sso_method.driver_type}">
<input type="hidden" name="display" value="{$display}">
{include file='system/sso/sso/_sso_js.tpl'}

<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_system_sso_sso_GRN_SY_SS_SS_95'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-95' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_95 necessary=true}
  </th>
  <td>
       {capture name='grn_system_sso_sso_GRN_SY_SS_SS_96'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-96' replace='true'}{/capture}{validate form=$form_name field="display_name" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_96 append="validation_errors"}
       {grn_text name="display_name" class="display_name" necessary=true value=$sso_method.display_name size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_sso_sso_GRN_SY_SS_SS_97'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-97' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_97 necessary=true}
  </th>
  <td>
       {capture name='grn_system_sso_sso_GRN_SY_SS_SS_98'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-98' replace='true'}{/capture}{validate form=$form_name field="target_url" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_98 append="validation_errors"}
       {grn_text name="target_url" class="target_url" necessary=true value=$sso_method.driver_settings.target_url size="50" disable_return_key=true maxlength="255"}<br>
       <div class="sub_explanation">{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-100' replace='true'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-101' replace='true'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-102' replace='true'}</div>
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_sso_sso_GRN_SY_SS_SS_103'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-103' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_103}
  </th>
  <td>
       {if $sso_method.available_window== 1}
        {capture name='grn_system_sso_sso_GRN_SY_SS_SS_104'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-104' replace='true'}{/capture}{grn_checkbox name="available_window" id="available_window" value="1" caption=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_104 checked=TRUE}
       {else}
        {capture name='grn_system_sso_sso_GRN_SY_SS_SS_105'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-105' replace='true'}{/capture}{grn_checkbox name="available_window" id="available_window" value="1" caption=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_105}
       {/if}
       {if $sso_method.available_personal == 1}
        {capture name='grn_system_sso_sso_GRN_SY_SS_SS_106'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-106' replace='true'}{/capture}{grn_checkbox name="available_personal" id="available_personal" value="1" caption=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_106 checked=TRUE}
       {else}
        {capture name='grn_system_sso_sso_GRN_SY_SS_SS_107'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-107' replace='true'}{/capture}{grn_checkbox name="available_personal" id="available_personal" value="1" caption=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_107}
       {/if}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {assign var="personal_param_names" value=$sso_method.driver_settings.personal_param_names}
      {assign var="personal_param_values" value=$sso_method.driver_settings.personal_param_values}
      {capture name='grn_system_sso_sso_GRN_SY_SS_SS_108'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-108' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_108}
  </th>
  <td style="padding:0px">
      <table>
       <tr>
        <td>{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-109' replace='true'}</td>
        <td>{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-110' replace='true'}</td>
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
      {capture name='grn_system_sso_sso_GRN_SY_SS_SS_111'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-111' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_111}
  </th>
  <td style="padding:0px">
      <table>
       <tr>
        <td>{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-112' replace='true'}</td>
        <td>{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-113' replace='true'}</td>
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
       {capture name='grn_system_sso_sso_GRN_SY_SS_SS_114'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-114' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_114}
       {capture name='grn_system_sso_sso_GRN_SY_SS_SS_115'}{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-115' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_sso_sso_GRN_SY_SS_SS_115 page='system/sso/sso_method_view' smid=$sso_method.smid}
  </td>
 </tr>
</table>

</form>
