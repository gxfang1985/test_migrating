{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/filemanager/mime_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p><div class="explanation">{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-15' replace='true'}</div></p>
<div id="main_menu_part">
<span class="menu_item">{capture name='grn_system_filemanager_GRN_SY_FI_16'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-16' replace='true'}{/capture}{grn_link page='system/filemanager/mime_add' caption=$smarty.capture.grn_system_filemanager_GRN_SY_FI_16 image='write20.gif'}</span>
<span class="menu_item">{capture name='grn_system_filemanager_GRN_SY_FI_17'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-17' replace='true'}{/capture}{grn_link page='system/filemanager/mime_delete_all' caption=$smarty.capture.grn_system_filemanager_GRN_SY_FI_17 image='delete20.gif' all=1 disabled=$not_exists}</span>
{capture name='grn_system_filemanager_GRN_SY_FI_19'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-19' replace='true'}{/capture}{* <span class="menu_item">{grn_link page='system/filemanager/mime_import1' caption=$smarty.capture.grn_system_filemanager_GRN_SY_FI_19 image='import20.gif'}</span>
<span class="menu_item">{capture name='grn_system_filemanager_GRN_SY_FI_20'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-20' replace='true'}{/capture}{grn_link page='system/filemanager/mime_export' caption=$smarty.capture.grn_system_filemanager_GRN_SY_FI_20 image='export20.gif' disabled=$not_exists}</span> *}
</div>

<p>
<div class="sub_title">{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-21' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}</div>
<table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
 <colgroup>
  <col width="5%">
  <col width="20%">
  <col width="75%">
 </colgroup>
 <tr>
  <th nowrap>{include file="grn/checkall.tpl" elem_name='eid[]'}</th>
{if $sort == 'eu'}
  <th nowrap>{capture name='grn_system_filemanager_GRN_SY_FI_24'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-24' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_system_filemanager_GRN_SY_FI_24 page=$page_info.all sort='ed' sp=0 sf=1 reverse=1}</th>
{else}
 {if $sort == 'ed'}
  <th nowrap>{capture name='grn_system_filemanager_GRN_SY_FI_25'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-25' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_system_filemanager_GRN_SY_FI_25 page=$page_info.all sort='eu' sp=0 sf=1}</th>
 {else}
  <th nowrap>{capture name='grn_system_filemanager_GRN_SY_FI_26'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-26' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_system_filemanager_GRN_SY_FI_26 page=$page_info.all sort='ed' sp=0 sf=1 disable=1}</th>
 {/if}
{/if}
  <th nowrap>{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-27' replace='true'}</th>
 </tr>
{foreach from=$list key=id item=item}
 <tr valign="top">
  <td><input type="checkbox" name="eid[]" value="{$id}"></td>
  <td>{grn_link page='system/filemanager/mime_view' caption=$item.extension image='detail20.gif' id=$id}</td>
  <td>{$item.mime|escape}</td>
 </tr>
{/foreach}
</table>

<div class="contents_navi">
{include file="grn/word_navi.tpl" navi=$view_set.navi }
</div>
{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-28' replace='true'}{capture name='grn_system_filemanager_GRN_SY_FI_29'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-29' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_system_filemanager_GRN_SY_FI_29 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false;"}

</form>

{include file='grn/system_footer.tpl'}
