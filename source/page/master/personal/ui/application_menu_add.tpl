{include file="grn/personal_head.tpl"}
{include file="grn/personal_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
{include file="grn/show_validation_errors.tpl"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='personal/ui/command_application_menu_add'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <div id="action">
  <!----->
{include file='grn/indispensable.tpl'}
   <div class="list">
    <p class="item">
     <div class="title">
      <div class="word">{capture name='grn_personal_ui_GRN_PRS_UI_75'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-75' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_personal_ui_GRN_PRS_UI_75 necessary=TRUE}</div>
     </div>
     <div class="contents">
      <div class="word">{capture name='grn_personal_ui_GRN_PRS_UI_76'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-76' replace='true'}{/capture}{validate form=$form_name field="name" criteria="notEmpty" message=$smarty.capture.grn_personal_ui_GRN_PRS_UI_76 transform="cb_trim" append="validation_errors"}{grn_text name="name" size="50"}</div>
     </div>
    </p>
    <p class="item">
     <div class="title">
      <div class="word">{grn_show_input_title title="URL"}</div>
     </div>
     <div class="contents">
      <div class="word">{grn_text name="location" size="50"}</div>
     </div>
    </p>
    <p class="item">
     <div class="title">
      <div class="word">{capture name='grn_personal_ui_GRN_PRS_UI_77'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-77' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_personal_ui_GRN_PRS_UI_77}</div>
     </div>
     <div class="contents">
      <div class="word">{grn_select name='link' options=$link_options}</div>
     </div>
    </p>
    <p class="item">
     <div class="contents_button">
      <div class="word">
       {capture name='grn_personal_ui_GRN_PRS_UI_78'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-78' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_78}
       {grn_button_cancel}
      </div>
     </div>
    </div>
   </div>
  <!----->
 </div>
 <!--action_end--->
</div>
</form>
{include file="grn/personal_footer.tpl"}
