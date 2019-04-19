{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{grn_load_javascript file="grn/html/component/validator_mobile.js"}
{grn_load_javascript file="grn/html/page/space/mobile/discussion/_send.js"}
{literal}
<script language="JavaScript" text="text/javascript">
(function()
{
    var G = grn.page.space.mobile.discussion._send;
    G.ERRMSG_TITLE_IS_REQUIRED = '{/literal}{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-2' replace='true'}{literal}';
})();
</script>
{/literal}
<div id="FieldToShowErrorMessage" class="mobile-error-area-grn"></div>
<div class="mobile-div-title-grn">
  <span class="mobile-label-grn">{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-1' replace='true'}<span class="mobile-required-grn">*</span></span>
  {grn_text necessary=true name="title" id="title" value=$title disable_return_key=true}
</div>
{if $is_display_folder}
    <div class="mobile-div-title-grn">
        <span class="mobile-label-grn">{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-58' replace='true'}</span>
        {capture name='grn_folder_mobile_menu'}{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-58' replace='true'}{/capture}
        <span class="mobile-label-grn">{$smarty.capture.grn_schedule_mobile_menu}</span>
        <a id="menu_folder" href="#popup_menu_folder" data-rel="popup" data-transition="pop" data-shadow="true" data-wrapperels="span" class="mobile_select_view_grn">
            <span class="mobile_event_menu_content_grn">----------</span>
            <span class="mobile_select_icon_grn"></span>
        </a>
        <input type="hidden" value="" name="did" id="menu_folder_value">
        {include file="grn/mobile_select_menu.tpl"
        selectMenuTitle=$smarty.capture.grn_folder_mobile_menu
        select_items=$folder_list
        selectMenuUI='menu_folder'
        selectMenuValue='menu_folder_value'
        popupMenu='popup_menu_folder'
        default_title='---------'
        }
    </div>
{/if}
<div class="mobile-div-title-grn">
  <span for="textarea" class="mobile-label-grn">{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-3' replace='true'}</span>
  {grn_textarea name="thread_data" id="thread_data" class="mobile-textarea-grn" value=$data disable_return_key=true}
</div>
{include file="grn/mobile_attach_file.tpl" attached_files=$attach_files}
<div class="mobile-buttonArea-grn">
   <div class="mobile-buttonMain-grn mobile-button-left-grn mobile_show_overlay_js">
     {if ! $modify_form}
     <input type="submit" name="send" value="{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-46' replace='true'}" 
       onclick="return grn.page.space.mobile.discussion._send.validate(event, document.forms['{$form_name}']);" data-inline="true" data-theme="{$data_theme}" /></div>
     <div class="mobile-buttonNormal-grn mobile-button-right-grn mobile_show_overlay_js">
       <input type="button" value="{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-41' replace='true'}"
         onclick='location.href="{grn_pageurl page='space/mobile/application/discussion/index' spid=$space_id}";' data-inline="true" data-theme="{$data_theme}" /></div>
     {else}
     <input type="submit" name="send" value="{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-47' replace='true'}" 
       onclick="return grn.page.space.mobile.discussion._send.validate(event, document.forms['{$form_name}']);" data-inline="true" data-theme="{$data_theme}" /></div>
     <div class="mobile-buttonNormal-grn mobile-button-right-grn mobile_show_overlay_js">
       <input type="button" value="{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-41' replace='true'}"
         onclick='location.href="{grn_pageurl page='space/mobile/application/discussion/detail' spid=$space_id tid=$thread_id}";' data-inline="true" data-theme="{$data_theme}" /></div>
     {/if}
</div>
<input type="hidden" name="spid" value="{$space_id}" class="data-none">
<input type="hidden" name="tid" value="{$thread_id}" class="data-none">
<input type="hidden" name="tmp_key" value="{$tmp_key}" class="data-none">
 