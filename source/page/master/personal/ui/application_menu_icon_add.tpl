{include file="grn/personal_head.tpl"}
{include file="grn/personal_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='personal/ui/command_application_menu_icon_add'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="icon_id" value="0">
<div id="one_parts">
 <!--view-->
 <div id="view">
  <!----->
   <div class="sub_title">{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-88' replace='true'}{include file="grn/smart_data_count.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}</div>
   <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
    <colgroup>
     <col width="2%">
     <col width="49%">
     <col width="49%">
    </colgroup>
    <tr>
     <th nowrap></th>
     <th nowrap>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-91' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-92' replace='true'}</th>
    </tr>
{foreach from=$icons key=id item=icon}
    <tr>
{assign var='iconid' value=$icon.id}
     <td>{capture name='grn_personal_ui_GRN_PRS_UI_93'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-93' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_93 onclick="form.icon_id.value='$iconid';"}</td>
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
   </div>
   <p>
    {capture name='grn_personal_ui_GRN_PRS_UI_94'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-94' replace='true'}{/capture}{grn_button_submit class="line" caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_94}
   </p>
  <!----->
 </div>
 <!--view_end--->
</div>
</form>
{include file="grn/personal_footer.tpl"}
