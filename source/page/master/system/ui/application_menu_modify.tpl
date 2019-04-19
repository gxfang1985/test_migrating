{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/ui/command_application_menu_modify'}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="id" value="{$id|escape}">

<div class="explanation">{cb_msg module='grn.system.ui' key='GRN_SY_UI-107' replace='true'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-108' replace='true'}</div>

<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <td colspan="2">
{if $menu_type eq 'app'}
  {capture name='grn_system_ui_GRN_SY_UI_109'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-109' replace='true'}{/capture}{grn_radio name='menu_type' id='app' value='app' caption=$smarty.capture.grn_system_ui_GRN_SY_UI_109 checked=1}
{else}
  {capture name='grn_system_ui_GRN_SY_UI_110'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-110' replace='true'}{/capture}{grn_radio name='menu_type' id='app' value='app' caption=$smarty.capture.grn_system_ui_GRN_SY_UI_110}
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_ui_GRN_SY_UI_111'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-111' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_ui_GRN_SY_UI_111 necessary=0}
  </th>
  <td>
      {grn_text_multilanguage element_name=$multiLanguageInfoArrayWithLink.element_name form_name=$form_name values=$multiLanguageInfoArrayWithLink.values}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_ui_GRN_SY_UI_112'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-112' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_ui_GRN_SY_UI_112}
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
  {capture name='grn_system_ui_GRN_SY_UI_113'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-113' replace='true'}{/capture}{grn_radio name='menu_type' id='url' value='url' caption=$smarty.capture.grn_system_ui_GRN_SY_UI_113 checked=1}
{else}
  {capture name='grn_system_ui_GRN_SY_UI_115'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-115' replace='true'}{/capture}{grn_radio name='menu_type' id='url' value='url' caption=$smarty.capture.grn_system_ui_GRN_SY_UI_115}
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_system_ui_GRN_SY_UI_117'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-117' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_ui_GRN_SY_UI_117}
  </th>
  <td>
      {capture name='grn_system_ui_GRN_SY_UI_118'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-118' replace='true'}{/capture}
      {grn_text_multilanguage element_name=$multiLanguageInfoArrayWithUrl.element_name form_name=$form_name error_message=$smarty.capture.grn_system_ui_GRN_SY_UI_118 values=$multiLanguageInfoArrayWithUrl.values}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {grn_show_input_title title="URL" necessary=TRUE}
  </th>
  <td>
      {capture name='grn_system_ui_GRN_SY_UI_119'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-119' replace='true'}{/capture}{validate form=$form_name field="url" criteria="notEmpty" message=$smarty.capture.grn_system_ui_GRN_SY_UI_119 transform="cb_trim" append="validation_errors"}{grn_text necessary=true name="url" size="50" maxlength="255" value=$url}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-120' replace='true'}</th>
  <td>{grn_text name="icon_url" size="50" maxlength="255" value=$icon_url}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-121' replace='true'}</th>
  <td>{grn_file name="icon_file"}<br>
      {if $icon_file_info}{grn_filename dpage='grn/icon_download' name=$icon_file_info.name mid=$id mdefault=0}{capture name='grn_system_ui_GRN_SY_UI_122'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-122' replace='true'}{/capture}{grn_checkbox name="delete_icon" id="delete_icon" value="1" caption=$smarty.capture.grn_system_ui_GRN_SY_UI_122}{/if}
  </td>
 </tr>
<!--
 {if $item.icon_file}
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-123' replace='true'}</th>
  <td>
  <img src="{grn_pageurl page='grn/icon_download' id=$id}"><br>
  {capture name='grn_system_ui_GRN_SY_UI_124'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-124' replace='true'}{/capture}{grn_checkbox name='icon_delete' id='icon_delete' value='1' caption=$smarty.capture.grn_system_ui_GRN_SY_UI_124}
  </td>
 </tr>
 {/if}
-->
 <tr>
  <td colspan="2">
   <div class="sub_explanation">
    {cb_msg module='grn.system.ui' key='GRN_SY_UI-125' replace='true'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-126' replace='true'}<span class="bold">URL</span>{cb_msg module='grn.system.ui' key='GRN_SY_UI-127' replace='true'}<span class="bold">{cb_msg module='grn.system.ui' key='GRN_SY_UI-128' replace='true'}</span>{cb_msg module='grn.system.ui' key='GRN_SY_UI-129' replace='true'}<br>
    {cb_msg module='grn.system.ui' key='GRN_SY_UI-130' replace='true'}<span class="bold">{cb_msg module='grn.system.ui' key='GRN_SY_UI-131' replace='true'}</span>{cb_msg module='grn.system.ui' key='GRN_SY_UI-132' replace='true'}
  </div>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_ui_GRN_SY_UI_133'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-133' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_ui_GRN_SY_UI_133}
       {grn_button_cancel page='system/ui/application_menu_view' id=$id}
  </td>
 </tr>
</table>

</form>

{include file="grn/system_footer.tpl"}
