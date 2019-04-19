{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{include file='grn/show_validation_errors.tpl'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/menupage_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div id="main_menu_part">
<span class="menu_item">{if ! $menu.menuadd }{assign var='is_menu_add_disable' value='true'}{/if}{capture name='grn_schedule_system_GRN_SCH_SY_440'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-440' replace='true'}{/capture}{grn_link page='schedule/system/menupage_add' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_440 image='write20.gif' disabled=$is_menu_add_disable}</span>
<span class="menu_item">{if $menu.count < 2 }{assign var='is_menu_order_disable' value='true'}{/if}{capture name='grn_schedule_system_GRN_SCH_SY_441'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-441' replace='true'}{/capture}{grn_link page='schedule/system/menupage_order' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_441 image='order20.gif' disabled=$is_menu_order_disable}</span>
<span class="menu_item">{if ! $menu.count }{assign var='is_menu_delete_disable' value='true'}{/if}{capture name='grn_schedule_system_GRN_SCH_SY_442'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-442' replace='true'}{/capture}{grn_link page='schedule/system/menupage_delete_all' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_442 image='delete20.gif' disabled=$is_menu_delete_disable}</span>
</div>

   <p>
   <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
    <colgroup>
     <col width="5%">
     <col width="93%">
    </colgroup>
    <tr>
     <th nowrap>{include file="grn/checkall.tpl"  elem_name='eid[]'}</th>
     <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-443' replace='true'}</th>
    </tr>
{foreach from=$menu.menupage item=menupage}
    <tr valign="top">
     <td><input type="checkbox" name="eid[]" value="{$menupage.id}"></td>
     <td>{grn_link page='schedule/system/menupage_view' caption=$menupage.title image='detail20.gif' menupageid=$menupage.id}</td>
    </tr>
{/foreach}
   </table>
     <div class="contents_navi">
      {include file="grn/word_navi.tpl" navi=$menu.navi }
     </div>
       {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-444' replace='true'}{capture name='grn_schedule_system_GRN_SCH_SY_445'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-445' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_445 onclick='if( ! grn_is_checked( this.form, \'eid[]\' ) ) return false;'}

</form>

{include file='grn/system_footer.tpl'}
