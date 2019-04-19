{include file="grn/personal_head.tpl"}
{include file="grn/personal_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='personal/ui/command_application_menu_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="two_parts">
 <!--menubar-->
 <div id="menubar_top">
  <ul id="menu">
   <li>{capture name='grn_personal_ui_GRN_PRS_UI_13'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-13' replace='true'}{/capture}{grn_link page='personal/ui/application_menu_add' caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_13 class='write20'}
   <li>{capture name='grn_personal_ui_GRN_PRS_UI_14'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-14' replace='true'}{/capture}{grn_link page='personal/ui/icon_list' caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_14 class='write20'}
   <li>{capture name='grn_personal_ui_GRN_PRS_UI_15'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-15' replace='true'}{/capture}{grn_link page='personal/ui/application_menu_refresh' caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_15 class='delete20'}
  </ul>
 </div>
 <!--menubar_end-->
 <!--view-->
 <div id="view">
  <!----->
   <div class="sub_title">{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-16' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}</div>
   <table class="list_column">
    <colgroup>
     <col width="5%">
     <col width="30%">
     <col width="30%">
     <col width="35%">
    </colgroup>
    <tr>
     <th nowrap>{include file="grn/checkall.tpl" elem_name='eid[]'}</th>
     <th nowrap>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-19' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-20' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-21' replace='true'}</th>
    </tr>
{foreach from=$menu key=id item=item}
    <tr valign="top">
     <td><input type="checkbox" name="eid[]" value="{$id}"></td>
     <td>{$item.name|escape}</td>
     <td>{$item.location|escape}</td>
     <td>{if $item.path}<img src="{$item.path}">{elseif $item.image}{grn_image image=$item.image}{/if}</td>
    </tr>
{/foreach}
   </table>
   <div class="list">
    <p class="item">
     <div class="contents_navi">
      {include file="grn/word_navi.tpl" navi=$view_set.navi }
     </div>
    </p>
    <p class="item">
     <div class="check_delete">
      <div class="word">
       {cb_msg module='grn.personal.ui' key='GRN_PRS_UI-22' replace='true'}{capture name='grn_personal_ui_GRN_PRS_UI_23'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-23' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_23 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false;"}
      </div>
     </div>
    </p>
   </div>
  <!----->
 </div>
 <!--view_end--->
</div>
</form>
{include file="grn/personal_footer.tpl"}
