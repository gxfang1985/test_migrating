{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/ui/mailer_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div id="main_menu_part">
    <span class="menu_item">{capture name='grn_system_ui_GRN_SY_UI_201'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-201' replace='true'}{/capture}{grn_link page='system/ui/mailer_add' caption=$smarty.capture.grn_system_ui_GRN_SY_UI_201 image='write20.gif'}</span>
    <span class="menu_item">{capture name='grn_system_ui_GRN_SY_UI_202'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-202' replace='true'}{/capture}{grn_link page='system/ui/mailer_delete_all' caption=$smarty.capture.grn_system_ui_GRN_SY_UI_202 image='delete20.gif'}</span>
</div>
<p>
  <table class="list_column">
    <colgroup>
     <col width="1%">
     <col width="20%">
     <col width="79%">
    </colgroup>
    <tr>
     <th nowrap>{include file="grn/checkall.tpl" elem_name='eid[]'}</th>
     <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-203' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-204' replace='true'}</th>
    </tr>
    {foreach from=$mailer_list key=key item=item}
        <tr valign="top">
         <td><input type="checkbox" name="eid[]" value="{$key}"></td>
         <td>{grn_link page='system/ui/mailer_view' id=$key caption=$item.name}</td>
         <td>{$item.url}</td>
        </tr>
    {/foreach}
  </table>
</p>
<p>
{cb_msg module='grn.system.ui' key='GRN_SY_UI-141' replace='true'}{capture name='grn_system_ui_GRN_SY_UI_142'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-142' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_system_ui_GRN_SY_UI_142 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false;"}
</p>
</form>
{include file='grn/system_footer.tpl'}