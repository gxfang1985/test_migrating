{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/application/command_app_changename'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="app_id" value="{$app_id|escape}">

<p class="explanation">{cb_msg module='grn.system.application' key='GRN_SY_AP-19' replace='true'}<br>{cb_msg module='grn.system.application' key='GRN_SY_AP-20' replace='true'}</p>
{include file="grn/show_validation_errors.tpl"}
{include file='grn/indispensable.tpl'}

<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_system_application_GRN_SY_AP_26'}{cb_msg module='grn.system.application' key='GRN_SY_AP-26' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_application_GRN_SY_AP_26 necessary=true}</th>
  <td>
    <table>
      <tbody>
        {capture name='grn_system_application_GRN_SY_AP_23'}{cb_msg module='grn.system.application' key='GRN_SY_AP-23' replace='true'}{/capture}
        {foreach from=$multiLanguageInfoArray.values key=lang_of_val item=val}
        {if $lang_of_val != "def"}
        <tr>
         <td>{cb_language_name code=$lang_of_val}:</td>
         <td><input type="text" name="{$multiLanguageInfoArray.element_name}-{$lang_of_val}" value="{$val}" size="50" maxlength="100"></td>
         {validate form=$form_name field=$multiLanguageInfoArray.element_name|cat:"-"|cat:$lang_of_val criteria='notEmpty' transform='cb_trim' append='validation_errors' message=$smarty.capture.grn_system_application_GRN_SY_AP_23}
        </tr>
        {/if}
        {/foreach}
      </tbody>
    </table>
  </td>
 </tr>
</table>


   {capture name='grn_system_application_GRN_SY_AP_25'}{cb_msg module='grn.system.application' key='GRN_SY_AP-25' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_system_application_GRN_SY_AP_25}
   {grn_button_cancel page='system/application/index'}


</form>

{include file="grn/system_footer.tpl"}
