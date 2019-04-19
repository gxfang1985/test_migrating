{include file="grn/personal_head.tpl"}
{include file="grn/personal_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='personal/ui/command_icon_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="two_parts">
 <!--menubar-->
 <div id="menubar_top">
  <ul id="menu">
   <li>{capture name='grn_personal_ui_GRN_PRS_UI_129'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-129' replace='true'}{/capture}{grn_link page='personal/ui/icon_add' caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_129 class='write20'}
   <li>{capture name='grn_personal_ui_GRN_PRS_UI_130'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-130' replace='true'}{/capture}{grn_link page='personal/ui/application_menu_list' caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_130 class='write20'}
  </ul>
 </div>
 <!--menubar_end-->
 <!--view-->
 <div id="view">
  <!----->
   <div class="sub_title">{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-131' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}</div>
   <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
    <colgroup>
     <col width="5%">
     <col width="40%">
     <col width="40%">
    </colgroup>
    <tr>
     <th nowrap>{include file="grn/checkall.tpl" elem_name='eid[]'}</th>
     <th nowrap>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-134' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-135' replace='true'}</th>
    </tr>
{foreach from=$icons key=id item=icon}
    <tr valign="top">
{assign var='iconid' value=$icon.id}
     <td>{if $icon.path}<input type="checkbox" name="eid[]" value="{$iconid}">{/if}</td>
     <td>{$icon.name|escape}</td>
     <td>{if $icon.path}<img src="{$icon.path}">{elseif $icon.image}{grn_image image=$icon.image}{/if}</td>
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
       {cb_msg module='grn.personal.ui' key='GRN_PRS_UI-136' replace='true'}{capture name='grn_personal_ui_GRN_PRS_UI_137'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-137' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_137 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false;"}
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
