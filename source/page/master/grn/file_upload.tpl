<input type="hidden" name="fid" value="{$file.id}">
{if ! $form_name}
    {assign var='form_name' value=$page_info.all}
{/if}
{grn_assign_file_upload_information}

<p>
    {if $file.locked == 'login'}
        <div class="explanation">
            {cb_msg module='grn.grn' key='GRN_GRN-1514' replace='true'}<b>{$login.name}</b>{cb_msg module='grn.grn' key='GRN_GRN-1515' replace='true'}<br>
            <div style="color:red;font-weight:bold;">
                {cb_msg module='grn.grn' key='GRN_GRN-1516' replace='true'}
            </div>
            <div style="font-weight:bold;">
                {cb_msg module='grn.grn' key='GRN_GRN-1517' replace='true'}
            </div>
            <br>
        </div>
    {/if}

    <div class="explanation">{cb_msg module='grn.grn' key='GRN_GRN-245' replace='true'}</div>
    {if $err_no_file}
        <div style="color:red;font-weight:bold;">
            {cb_msg module='grn.cabinet' key='GRN_CAB-23' replace='true'}
        </div>
    {/if}
</p>

<p>
{include file="grn/show_validation_errors.tpl"}
{include file='grn/indispensable.tpl'}
<input type="hidden" name="upload_ticket" value="{$upload_ticket}" />
<table class="std_form">
    <tr>
        <td colspan="2"><div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-246' replace='true'}</div></td>
    </tr>
    <tr>
        <th nowrap>
            {cb_msg module='grn.grn' key='GRN_GRN-247' replace='true'}
        </th>
        <td>
            <a class="with_lang" href="{grn_pageurl page=$download_page params=$linkparams fid=$file.id postfix=$file.filename ticket=$download_ticket}"><nobr></nobr>{$file.filename|escape:"html"}</a>&nbsp;&nbsp;({$file.mime})
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
            {capture name='grn_grn_GRN_GRN_250'}{cb_msg module='grn.grn' key='GRN_GRN-250' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_grn_GRN_GRN_250 necessary=TRUE}
        </th>
        <td>
            <script language="Javascript" type="text/javascript">
            <!--
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
                        {capture name='grn_grn_GRN_GRN_251'}{cb_msg module='grn.grn' key='GRN_GRN-251' replace='true'}{/capture}{capture name='grn_grn_GRN_GRN_252'}{cb_msg module='grn.grn' key='GRN_GRN-252' replace='true'}{/capture}{grn_file name='newfile' necessary=TRUE title=$smarty.capture.grn_grn_GRN_GRN_252 size='40' class="file_html5 file_input_hidden" id="file_upload_"}
                    </div>
                    <input type="hidden" name="html5" value="true" size="100">
                    
                    <div id="upload_message" style="font-size:small;">
                    </div>
                    <table id="upload_table" class="attachment_list_base_grn" >
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
            {cb_msg module='grn.grn' key='GRN_GRN-253' replace='true'}
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
                    {capture name='fileupload_button_upload_onclick'}
                        jQuery("#button_command").attr({ldelim}name: 'upload', value: '{$smarty.capture.grn_grn_GRN_GRN_257}'{rdelim}); grn.component.button.util.submit(this);
                    {/capture}
                    {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_grn_GRN_GRN_257 onclick=$smarty.capture.fileupload_button_upload_onclick id="fileupload_button_upload"}

                    {capture name='grn_grn_GRN_GRN_258'}{cb_msg module='grn.grn' key='GRN_GRN-258' replace='true'}{/capture}
                    {capture name='fileupload_button_cancel_onclick'}
                        jQuery("#button_command").attr({ldelim}name: 'cancel', value: '{$smarty.capture.grn_grn_GRN_GRN_258}'{rdelim}); grn.component.button.util.submit(this);
                    {/capture}
                    {grn_button caption=$smarty.capture.grn_grn_GRN_GRN_258 onclick=$smarty.capture.fileupload_button_cancel_onclick id="fileupload_button_cancel" class="button_submit_grn"}
                {/strip}
                <input type="hidden" name="" value="" id="button_command">
            </div>
        </td>
    </tr>
</table>
