{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
{if ! $file_dpage}{assign var='file_dpage' value='space/file_download'}{/if}
{grn_load_javascript file="grn/html/component/validator.js"}

{literal}
<script language="JavaScript" text="text/javascript">
jQuery(function(){
    {/literal}
    var form = document.forms['{$form_name}'];
    {literal}
    var buttonSend = grn.component.button("#btnUpdateAttachment").on("click", function() {
        if(validate(form)) {
            buttonSend.showSpinner();
            form.submit();
        }
    });
});
function validate(form)
{
    var validators = new grn.component.validator(form, document.getElementById("FieldToShowErrorMessage"));
    if(jQuery("#html5_content").length && jQuery("#html5_content").css("display") != "none")
    {
        validators.addValidator(new grn.component.validator.UploadedFile("html5_content", "upload_fileids[]", "newfile", '{/literal}{cb_msg module='grn.space.file' key='GRN_SP_FILE-10' replace='true'}{literal}', 0) );
    }

    validators.clearErrorMessage();

    if(validators.validateAll()){
        grn_onsubmit_common(form);
        return true;
    }
    else
    {
        return false;
    }
}
</script>
{/literal}
{grn_assign_file_upload_information}

<form name="{$form_name}" method="post" enctype="multipart/form-data" action="{grn_pageurl page='space/command_file_upload'}">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="upload_ticket" value="{$upload_ticket}" />
<input type="hidden" name="fid" value="{$file.id}">
<input type="hidden" name="spid" value="{$space_id}">
<input type="hidden" name="tid" value="{$thread_id}">
{if $todo_id}
<input type="hidden" name="tdid" value="{$todo_id}">
{/if}
<input type="hidden" name="from" value="{$from}">
<input type="hidden" name="index_return" value="{$index_return}">
<p>
 <div class="explanation">{cb_msg module='grn.grn' key='GRN_GRN-245' replace='true'}</div>
 {if $err_no_file}
     <div style="color:red;font-weight:bold;">
         {cb_msg module='grn.cabinet' key='GRN_CAB-23' replace='true'}
     </div>
 {/if}
</p>
<div id="FieldToShowErrorMessage"></div>
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <td colspan="2"><div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-246' replace='true'}</div></td>
 </tr>
 <tr>
  <th nowrap>
     {cb_msg module='grn.space.file' key='GRN_SP_FILE-12' replace='true'}
  </th>
  <td>
     <a class="with_lang" href="{grn_pageurl page=$file_dpage params=$linkparams fid=$file.id postfix=$file.filename ticket=$download_ticket}">{$file.filename|escape:"html"}</a>&nbsp;&nbsp;({$file.mime})
  </td>
 </tr>
 <tr>
  <th nowrap>
     {cb_msg module='grn.grn' key='GRN_GRN-248' replace='true'}
  </th>
  <td>
     {grn_format_filesize size=$file.size unit="byte"}
  </td>
 </tr>
 <tr>
  <td colspan="2"><br><div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-249' replace='true'}</div></td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_space_GRN_SP_FILE_13'}{cb_msg module='grn.space.file' key='GRN_SP_FILE-13' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_space_GRN_SP_FILE_13 necessary=TRUE}
  </th>
  <td>
      <script language="Javascript" type="text/javascript"><!--
        __upload_ticket = "{$upload_ticket}";
        __upload_files_url = '{grn_pageurl page="grn/uploaded_files"}';
        
        __upload_msg_error = "{cb_msg module='grn.grn' key='grn.upload.error' replace='true'}";
        __upload_msg_error_suffix   = "{cb_msg module='grn.grn' key='grn.upload.error.suffix' replace='true'}";
        __upload_msg_filesizeover_1 = "{cb_msg module='grn.grn' key='grn.upload.filesizeover.1' replace='true'}";
        __upload_msg_filesizeover_2 = "{cb_msg module='grn.grn' key='grn.upload.filesizeover.2' replace='true'}";
        __upload_msg_zerobyte_file  = "{cb_msg module='grn.grn' key='grn.upload.zerobyte.file' replace='true'}";
        __upload_msg_cancel = "{cb_msg module='grn.grn' key='grn.upload.cancel' replace='true'}";
        __upload_url = "{$url}";
        os_type = "{$browser.os_type}";
        browser_type = "{$browser.type}";
        browser_ver_major = "{$browser.ver_major}";
        //-->
      </script>
        {grn_load_javascript file="grn/html/upload.js"}
        {grn_load_javascript file="grn/html/upload_single.js"}

      <div id="html5_content" style="display:none;">
            <div id="drop_" class="drop">
                {cb_msg module='grn.grn' key='GRN_GRN-1534' replace='true'}
            </div> 
            <div class="file_input_div">
                {cb_msg module='grn.grn' key='GRN_GRN-1535' replace='true'}
                {grn_file name='newfile' necessary=TRUE class="file_html5 file_input_hidden" id="file_upload_"}
            </div>
            <input type="hidden" name="html5" value="true" size="100">

            <div id="upload_message" style="font-size:small;">
            </div>
            <table id="upload_table" class="attachment_list_base_grn">
              <tbody>
                <tr>
                  <td></td>
                </tr>
              </tbody>
            </table>
      </div>

      <div class="attachment_legacy_base_grn">
          <div id="not_support_html5_content" style="display:none;">
              {capture name='grn_GRN_GRN_1581'}{cb_msg module='grn.grn' key='GRN_GRN-1581' replace='true'}{/capture}
              <span class="icon_information_sub_grn messageSub-grn">{$smarty.capture.grn_GRN_GRN_1581}</span>
          </div>
      </div>
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.space.file' key='GRN_SP_FILE-14' replace='true'}
  </th>
  <td>
      {grn_user_name name=$login.name uid=$login.id}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.grn' key='GRN_GRN-254' replace='true'}
  </th>
  <td>
      {capture name='grn_grn_GRN_GRN_255'}{cb_msg module='grn.grn' key='GRN_GRN-255' replace='true'}{/capture}{grn_textarea name="comment" value=$comment rows="5" title=$smarty.capture.grn_grn_GRN_GRN_255}<br><div class="sub_explanation">{cb_msg module='grn.grn' key='GRN_GRN-256' replace='true'}</div>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      <div class="mTop10">
          {strip}
              {capture name='grn_grn_GRN_GRN_257'}{cb_msg module='grn.grn' key='GRN_GRN-257' replace='true'}{/capture}
              {grn_button id='btnUpdateAttachment' ui='main' caption=$smarty.capture.grn_grn_GRN_GRN_257 spacing='normal'}
               {if $appType == 1}
                   {if $index_return == TRUE}
                       {grn_button action='cancel' page='space/application/discussion/index' page_param_spid=$space_id}
                   {else}
                       {grn_button action='cancel' page='space/application/discussion/file_view'
                       page_param_spid=$space_id page_param_tid=$thread_id page_param_fid=$file.id}
                   {/if}
               {else}
                   {if $index_return == TRUE}
                       {grn_button action='cancel' page='space/application/todo/view'
                       page_param_spid=$space_id page_param_tdid=$todo_id page_param_from=$from}
                   {else}
                       {grn_button action='cancel' page='space/application/todo/file_view'
                       page_param_spid=$space_id page_param_tid=$thread_id page_param_fid=$file.id page_param_from=$from}
                   {/if}
               {/if}
          {/strip}
      </div>
  </td>
 </tr>
</table>
</form>
