{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=""}
{assign var='form_name' value=$smarty.template|basename}

{grn_delete title=$delete_info_multi.title page=$delete_info_multi.page no_confirm=$delete_info_multi.no_confirm data=$delete_info_multi.data handler=$delete_info_multi.handler multi_target=$delete_info_multi.multi_target form_target=$delete_info_multi.form_target}

<form name="{$form_name}" method="post" action="{grn_pageurl page=$page_prefix|cat:$form_name}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div class="explanation">{cb_msg module='grn.system.logging' key='GRN_SY_LO-140' replace='true'}</div>

<p>
{include file="grn/show_validation_errors.tpl"}
<p>

<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_system_logging_GRN_SY_LO_141'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-141' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_logging_GRN_SY_LO_141}</th>
  <td>{grn_text necessary=true name="search_text" value=$search_text size="10"}&nbsp;{capture name='grn_system_logging_GRN_SY_LO_142'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-142' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_system_logging_GRN_SY_LO_142}&nbsp;{capture name='grn_system_logging_GRN_SY_LO_143'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-143' replace='true'}{/capture}{grn_button_cancel page=$site_position[0].page caption=$smarty.capture.grn_system_logging_GRN_SY_LO_143}</td>
 </tr>
</table>

<p>
<div class="explanation">{cb_msg module='grn.system.logging' key='GRN_SY_LO-144' replace='true'}</div>

<table class="list_column" style="width:100%;" id="files_list">
<colgroup>
 <col width="1%">
 <col width="60%">
 <col>
</colgroup>
<tr valign="top">
<th nowrap><span class="list_menu_item">{include file="grn/checkall.tpl" form_name=$form_name elem_name="eid[]"}</span></th>
 <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-138' replace='true'}</th>
 <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-139' replace='true'}</th>
</tr>
{foreach from=$files item=file}
<tr class="{cycle values='linetwo,lineone'}" valign="top">
 <td nowrap><input type="checkbox" name="eid[]" value="{$file.id}"></td>

 <td nowrap>
    {*grn_link page=$folder_page caption=$file.title*}
    <a class="with_lang" href="{grn_pageurl page=$page_prefix|cat:"system/logging/download" fid=$file.id postfix=$file.title}">{$file.title}</a>
 </td>

 <td nowrap>
    {grn_date_format date=$file.date format="DateTimeCompact"}
 </td>
</tr>
{/foreach}
</table>

<div class="list_menu"><nobr>
 <span class="list_menu_item">{include file="grn/checkall.tpl" form_name=$form_name elem_name="eid[]"}</span>
{capture name='grn_system_logging_GRN_SY_LO_145'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-145' replace='true'}{/capture}{grn_button_submit id= 'btn_delete_multi' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_145 onclick="return false;"}
</div>
</form>
{include file='grn/system_footer.tpl'}
