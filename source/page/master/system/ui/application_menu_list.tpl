{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/ui/application_menu_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_system_ui_GRN_SY_UI_134'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-134' replace='true'}{/capture}{grn_link page='system/ui/application_menu_add' caption=$smarty.capture.grn_system_ui_GRN_SY_UI_134 image='write20.gif'}</span>
<span class="menu_item">{capture name='grn_system_ui_GRN_SY_UI_135'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-135' replace='true'}{/capture}{grn_link page='system/ui/application_menu_order' caption=$smarty.capture.grn_system_ui_GRN_SY_UI_135 image='order20.gif'}</span>
<span class="menu_item">{capture name='grn_system_ui_GRN_SY_UI_136'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-136' replace='true'}{/capture}{grn_link page='system/ui/application_menu_refresh' caption=$smarty.capture.grn_system_ui_GRN_SY_UI_136 image='delete20.gif'}</span>
<!--
<span class="menu_item">{capture name='grn_system_ui_GRN_SY_UI_137'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-137' replace='true'}{/capture}{grn_link page='system/ui/application_menu_delete_all' caption=$smarty.capture.grn_system_ui_GRN_SY_UI_137 image='delete20.gif'}</span>
-->
</div>

   <p>
   <table class="list_column">
    <colgroup>
     <col width="1%">
     <col width="99%">
    </colgroup>
    <tr>
     <th nowrap>{include file="grn/checkall.tpl" elem_name='eid[]'}</th>
     <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-138' replace='true'}</th>
    </tr>
{foreach from=$menu_list key=key item=item}
    <tr valign="top">
     <td><input type="checkbox" name="eid[]" value="{$key}"></td>
     <td>
      {grn_link page='system/ui/application_menu_view' id=$key caption=$item.name}
      {cb_msg module='grn.system.ui' key='GRN_SY_UI-139' replace='true'}{$item.url|escape}{cb_msg module='grn.system.ui' key='GRN_SY_UI-140' replace='true'}
     </td>
    </tr>
{/foreach}
   </table>
   <p>
   {cb_msg module='grn.system.ui' key='GRN_SY_UI-141' replace='true'}{capture name='grn_system_ui_GRN_SY_UI_142'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-142' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_system_ui_GRN_SY_UI_142 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false;"}
   </p>

</form>

{include file='grn/system_footer.tpl'}
