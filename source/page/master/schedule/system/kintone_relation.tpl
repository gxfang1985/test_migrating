{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{include file="grn/error_handler.tpl"}
{grn_load_javascript file="grn/html/page/schedule/system/kintone_relation.js"}
{assign var="delete_form_name" value="item_delete"}
<div id="overlay" class="overlay" style="display:none"></div>
<div id="item_delete_dialog" class="msgbox" style="display:none;">
    <form name="{$delete_form_name}" id="{$delete_form_name}" method="post" enctype="multipart/form-data" action="{grn_pageurl page='schedule/system/ajax/ajax_delete_kintone_relation'}">
        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        <input type="hidden" name="krid" id="krid">
        <div class="title">
            <span>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-589' replace='true'}</span>
        </div>
        <p>
        <div style="padding-left:20px;">
            <span>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-590' replace='true'}</span>
        </div>
        <p>
        <div style="padding-left:20px;" class="break_word_grn">
            <span>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-448' replace='true'}:</span>
            <span id="krname">aaaaa</span>
        </div>
        <p>
        <p>
        <p>
        <div class="command">
            <input type="button" id="Delete_OK" class="btn btn_yes" value="{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-19' replace='true'}"/>
            {grn_image id="dialog_spinner" image='spinner.gif' class='none'}
            <input type="button" id="Delete_Cancel" class="btn btn_no" value="{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-20' replace='true'}"/>
        </div>
    </form>
</div>
<script language="JavaScript" text="text/javascript">
    var __thisPage = grn.page.schedule.system.kintone_relation;
    var __dialog = new __thisPage.Dialog("overlay", "item_delete_dialog", "Delete_OK", "Delete_Cancel", "dialog_spinner", "{$delete_form_name}");

    (function(){literal}{
        YAHOO.util.Event.onDOMReady(function(){
            var dialog = $('item_delete_dialog');
            var body = document.getElementsByTagName('body')[0];
            dialog.parentNode.removeChild(dialog);
            body.appendChild(dialog);

            var overlay = $('overlay');
            overlay.parentNode.removeChild(overlay);
            body.appendChild(overlay);
        });
    }{/literal})();
</script>
{grn_title title=$page_title class=$page_info.parts[0]}

<div id="main_menu_part">
  {if $relation_info|@count < 50}
  <span class="menu_item">{capture name='grn_schedule_system_GRN_SCH_SY_585'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-585' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_585 page='schedule/system/kintone_relation_add' image='write20.gif'}</span>
  {/if}
  {if $relation_info|@count > 1}
  <span class="menu_item">{capture name='grn_schedule_system_GRN_SCH_SY_586'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-586' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_586 page='schedule/system/kintone_relation_order' image='order20.gif'}</span>
  {/if}
</div>

<p>
<table class="list_column" width="100%">
  <colgroup>
    <col width="20%">
    <col width="20%">
    <col width="10%">
    <col width="40%">
    <col width="10%">
  </colgroup>
  <tr>
    <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-448' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-576' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-587' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-588' replace='true'}</th>
    <th nowrap></th>
  </tr>
  {foreach from=$relation_info key=key item=item}
  <tr valign="top">
    <td nowrap rowspan="{$item.kintone_app|@count}">
      {grn_link page='schedule/system/kintone_relation_modify' caption=$item.itemName image='detail20.gif' krid=$key}
    </td>
    <td nowrap rowspan="{$item.kintone_app|@count}">{$item.menus|escape}</td>
    {foreach from=$item.kintone_app name=n key=k item=value}
      {if $smarty.foreach.n.first}
    <td nowrap>{$value.app_id|escape}</td>
    <td nowrap>{$value.field_code|escape}</td>
      {/if}
    {/foreach}
    <td rowspan="{$item.kintone_app|@count}">
      <input type="hidden" value="{$item.itemName|escape}" id="relation_name{$key}"/>
      <a href="javascript:void(0)" class="icon-delete-grn" onclick="__dialog.setHiddenInputValue('krid',{$key});__dialog.setElementHtml('krname',{$key});__dialog.show();" title="{cb_msg module='grn.system.ui' key='GRN_SY_UI-29' replace='true'}"></a>
    </td>
  </tr>
    {foreach from=$item.kintone_app item=value name=n}
      {if !$smarty.foreach.n.first}
  <tr valign="top">
    <td nowrap>{$value.app_id|escape}</td>
    <td nowrap>{$value.field_code|escape}</td>
  </tr>
      {/if}
    {/foreach}
  {/foreach}
</table>

{include file='grn/system_footer.tpl'}