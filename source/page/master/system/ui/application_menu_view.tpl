{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_system_ui_GRN_SY_UI_101'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-101' replace='true'}{/capture}{grn_link page='system/ui/application_menu_modify' id=$id caption=$smarty.capture.grn_system_ui_GRN_SY_UI_101 image='modify20.gif'}</span>
<span class="menu_item">{capture name='grn_system_ui_GRN_SY_UI_102'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-102' replace='true'}{/capture}{grn_link page='system/ui/application_menu_delete' id=$id caption=$smarty.capture.grn_system_ui_GRN_SY_UI_102 image='delete20.gif'}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-103' replace='true'}</th>
  <td>{$item.name|escape}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-104' replace='true'}</th>
{if $item.app_id}
  <td>{grn_link page="`$item.location`" caption=$item.caption}</td>
{else}
  <td>{grn_link_raw page=$item.url caption=$item.url no_script="true"}</td>
{/if}
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-105' replace='true'}</th>
  <td>
{if $item.app_id}
  {grn_image image="`$item.icon_class`.png"}
{elseif $item.icon_url}
  {grn_image_raw image=$item.icon_url}
{elseif $item.icon_file_info}
  {grn_filename dpage='grn/icon_download' name=$item.icon_file_info.name mdefault=0 mid=$id inline=true}
{/if}
  </td>
 </tr>
</table>

{include file='grn/system_footer.tpl'}
