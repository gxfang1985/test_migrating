{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_system_ui_GRN_SY_UI_212'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-212' replace='true'}{/capture}{grn_link page='system/ui/mailer_modify' id=$id caption=$smarty.capture.grn_system_ui_GRN_SY_UI_212 image='modify20.gif'}</span>
<span class="menu_item">{capture name='grn_system_ui_GRN_SY_UI_213'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-213' replace='true'}{/capture}{grn_link page='system/ui/mailer_delete' id=$id caption=$smarty.capture.grn_system_ui_GRN_SY_UI_213 image='delete20.gif'}</span>
</div>

<p></p>
<table class="view_table">
 <tr>
  <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-208' replace='true'}</th>
  <td>{$item.name|escape}</td>
 </tr>
 <tr>
  <th nowrap>URL</th>
  <td>{$item.url|escape}</td>
 </tr>
</table>

{include file='grn/system_footer.tpl'}