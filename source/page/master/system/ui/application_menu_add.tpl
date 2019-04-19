{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/ui/command_application_menu_add'}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p><div class="explanation">{cb_msg module='grn.system.ui' key='GRN_SY_UI-157' replace='true'}<br>
{cb_msg module='grn.system.ui' key='GRN_SY_UI-158' replace='true'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-159' replace='true'}</div></p>

<p>
{include file='grn/show_validation_errors.tpl'}
<table class="std_form">
 <tr>
  <td colspan="2">
{if $menu_type eq 'app'}
  {capture name='grn_system_ui_GRN_SY_UI_160'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-160' replace='true'}{/capture}{grn_radio name='menu_type' id='app' value='app' caption=$smarty.capture.grn_system_ui_GRN_SY_UI_160 checked=1}
{else}
  {capture name='grn_system_ui_GRN_SY_UI_161'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-161' replace='true'}{/capture}{grn_radio name='menu_type' id='app' value='app' caption=$smarty.capture.grn_system_ui_GRN_SY_UI_161}
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_ui_GRN_SY_UI_162'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-162' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_ui_GRN_SY_UI_162 necessary=0}
  </th>
  <td>
      {grn_text_multilanguage element_name=$multiLanguageInfoArrayWithLink.element_name form_name=$form_name values=$multiLanguageInfoArrayWithLink.values}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_ui_GRN_SY_UI_163'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-163' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_ui_GRN_SY_UI_163}
  </th>
  <td>
   <select name="link">
{foreach from=$menu key=key item=item}
   <optgroup label="{$item.name|escape}">
 {foreach from=$item.items key=child_key item=child_item}
  {if $child_item.value == $link}
   <option value="{$child_item.value|escape}" selected>{$child_item.label|escape}</option>
  {else}
   <option value="{$child_item.value|escape}">{$child_item.label|escape}</option>
  {/if}
 {/foreach}
   </optgroup>
{/foreach}
   </select>
  </td>
 </tr>
 <tr>
  <td colspan="2"><br>
{if $menu_type eq 'url'}
  {capture name='grn_system_ui_GRN_SY_UI_164'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-164' replace='true'}{/capture}{grn_radio name='menu_type' id='url' value='url' caption=$smarty.capture.grn_system_ui_GRN_SY_UI_164 checked=1}
{else}
  {capture name='grn_system_ui_GRN_SY_UI_166'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-166' replace='true'}{/capture}{grn_radio name='menu_type' id='url' value='url' caption=$smarty.capture.grn_system_ui_GRN_SY_UI_166}
{/if}<br>
  <div class="br">&nbsp;</div>
  {include file='grn/indispensable.tpl'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_ui_GRN_SY_UI_168'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-168' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_ui_GRN_SY_UI_168}
  </th>
  <td>
      {capture name='grn_system_ui_GRN_SY_UI_169'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-169' replace='true'}{/capture}
      {grn_text_multilanguage element_name=$multiLanguageInfoArrayWithUrl.element_name form_name=$form_name error_message=$smarty.capture.grn_system_ui_GRN_SY_UI_169 values=$multiLanguageInfoArrayWithUrl.values}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {grn_show_input_title title="URL" necessary=TRUE}
  </th>
  <td>
      {capture name='grn_system_ui_GRN_SY_UI_170'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-170' replace='true'}{/capture}{validate form=$form_name field="url" criteria="notEmpty" message=$smarty.capture.grn_system_ui_GRN_SY_UI_170 transform="cb_trim" append="validation_errors"}{grn_text necessary=true name="url" size="50" maxlength="255" value=$url}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-171' replace='true'}</th>
  <td>{grn_text name="icon_url" size="50" maxlength="255" value=$icon_url}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-172' replace='true'}</th>
  <td>{grn_file name="icon_file"}</td>
 </tr>
 <tr>
  <td colspan="2">
   <div class="sub_explanation">
    {cb_msg module='grn.system.ui' key='GRN_SY_UI-173' replace='true'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-174' replace='true'}<span class="bold">URL</span>{cb_msg module='grn.system.ui' key='GRN_SY_UI-175' replace='true'}<span class="bold">{cb_msg module='grn.system.ui' key='GRN_SY_UI-176' replace='true'}</span>{cb_msg module='grn.system.ui' key='GRN_SY_UI-177' replace='true'}<br>
    {cb_msg module='grn.system.ui' key='GRN_SY_UI-178' replace='true'}<span class="bold">{cb_msg module='grn.system.ui' key='GRN_SY_UI-179' replace='true'}</span>{cb_msg module='grn.system.ui' key='GRN_SY_UI-180' replace='true'}
  </div>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_ui_GRN_SY_UI_181'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-181' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_ui_GRN_SY_UI_181}
       {grn_button_cancel page='system/ui/application_menu_list'}
  </td>
 </tr>
</table>

</form>

{include file="grn/system_footer.tpl"}
