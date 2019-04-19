{include file="grn/personal_head.tpl"}
{include file="grn/personal_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
{include file="grn/show_validation_errors.tpl"}
<form name="{$form_name}" method="post" enctype="multipart/form-data" action="{grn_pageurl page='personal/ui/command_icon_add'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <div id="action">
  <!----->
{include file='grn/indispensable.tpl'}
   <div class="list">
    <p class="item">
     <div class="title">
      <div class="word">{capture name='grn_personal_ui_GRN_PRS_UI_126'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-126' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_personal_ui_GRN_PRS_UI_126}</div>
     </div>
     <div class="contents">
      <div class="word">{grn_text name="icon_name" size="50"}</div>
     </div>
    </p>
    <p class="item">
     <div class="title">
      <div class="word">{grn_show_input_title title="URL"}</div>
     </div>
     <div class="contents">
      <div class="word">{grn_text name="icon_url" size="50"}</div>
     </div>
    </p>
    <p class="item">
     <div class="title">
      <div class="word">{capture name='grn_personal_ui_GRN_PRS_UI_127'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-127' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_personal_ui_GRN_PRS_UI_127 necessary=true}</div>
     </div>
     <div class="contents">
      <div class="word">{grn_file name="icon_file"}</div>
     </div>
    </p>
    <p class="item">
     <div class="contents_button">
      <div class="word">
       {capture name='grn_personal_ui_GRN_PRS_UI_128'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-128' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_128}
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
