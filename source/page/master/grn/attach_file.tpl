{if ! $input_size}{assign var=input_size value="40"}{/if}
{if ! $file_image}{assign var=file_image value="file20.gif"}{/if}
{if ! $delete_image}{assign var=delete_image value="delete20.gif"}{/if}
{if ! $attached_name}
 {assign var="attached_name" value="fids[]"}
{/if}
{grn_assign_file_upload_information}

<script language="Javascript" type="text/javascript"><!--
__upload_ticket = "{$upload_ticket}";
__upload_files_url = '{grn_pageurl page="grn/uploaded_files"}';

__upload_msg_error          = "{cb_msg module='grn.grn' key='grn.upload.error' replace='true' replace='true'}";
__upload_msg_error_suffix   = "{cb_msg module='grn.grn' key='grn.upload.error.suffix' replace='true'}";
__upload_msg_filesizeover_1 = "{cb_msg module='grn.grn' key='grn.upload.filesizeover.1' replace='true'}";
__upload_msg_filesizeover_2 = "{cb_msg module='grn.grn' key='grn.upload.filesizeover.2' replace='true'}";
__upload_msg_zerobyte_file  = "{cb_msg module='grn.grn' key='grn.upload.zerobyte.file' replace='true'}";
__upload_msg_cancel         = "{cb_msg module='grn.grn' key='grn.upload.cancel' replace='true'}";
__upload_msg_confirm1       = "{cb_msg module='grn.grn' key='grn.upload.confirm1' replace='true'}";
__upload_msg_confirm2       = "{cb_msg module='grn.grn' key='grn.upload.confirm2' replace='true'}";

//--></script>
<script language="Javascript" type="text/javascript" >
<!--
    __upload_url = "{$url}";
    os_type = "{$browser.os_type}";
    browser_type = "{$browser.type}";
    browser_ver_major = "{$browser.ver_major}";
//-->
</script>
{grn_load_javascript file="grn/html/upload.js"}
{grn_load_javascript file="grn/html/af.js"}

    <div id="html5_content" style="display:none;">
            {if $attached_files}
                {if ! $file_image}{assign var=file_image value="file20.gif"}{/if}
                {if ! $attached_name}{assign var="attached_name" value="fids[]"}{/if}
    
                <div id="flash_afbox" class="afbox">
                    {foreach from=$attached_files key=fid item=file}
                        <div id="flash_afdiv{$fid|escape}">
                            <input class="flash_infile" type="checkbox" onclick="onChangeCheckBox('{$fid}')" id="{$fid}_checkbox" name="{$attached_name}" value="{$fid}" checked>
                            <span style="margin:0,0,0,0;">{grn_image image=$file_image}
                                <span id="{$fid}_filename">
                                    {$file.name|escape:"html"}
                                </span>
                            </span>
                        </div>
                    {/foreach}
                </div>
            {/if}
            <div style="margin-top:3px;">
                <div id="drop_" class="drop">
                    {cb_msg module='grn.grn' key='GRN_GRN-1534' replace='true'}
                </div>
                <div class="file_input_div">
                    {cb_msg module='grn.grn' key='GRN_GRN-1535' replace='true'}
                    {grn_file class="file_html5 file_input_hidden" name="file" multiple=true id="file_upload_"}
                </div>
                <input type="hidden" name="html5" value="true" size="100">
            </div>
            <div class="clear_both_0px"></div>
            <div id="upload_message" {if $isFollow}style="font-size:small;margin-left:20px;"{/if}>
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
            {if $attached_files}
                <div id="afbox" class="afbox">
                    {foreach from=$attached_files key=fid item=file}
                        <div id="afdiv{$fid|escape}"><input class="infile" type="hidden" name="{$attached_name}" value="{$fid}"><span style="margin:0,0,0,0;">{grn_image image=$file_image}<span>{$file.name|escape:"html"}</span></span>&nbsp;<a href="javascript:grn_delete_fileselect('afdiv{$fid|escape}')">{grn_image image=$delete_image align='absmiddle'}{cb_msg module='grn.grn' key='GRN_GRN-926' replace='true'}</a></div>
                    {/foreach}
                </div>
            {/if}
            {capture name='grn_GRN_GRN_1581'}{cb_msg module='grn.grn' key='GRN_GRN-1581' replace='true'}{/capture}
            <span class="icon_information_sub_grn messageSub-grn">{$smarty.capture.grn_GRN_GRN_1581}</span>
        </div>
    </div>

    <div class="clear_both_0px"></div>
    <input type="hidden" name="upload_ticket" value="{$upload_ticket}" />

{** STM-379 **}
<script language="Javascript" type="text/javascript">
    {literal}
    if(browser_type == 'msie' && browser_ver_major >= 10)
    {
        jQuery('#file_upload_').keypress(function(e)
        {
            if(e.which == 13)
            {
                e.preventDefault();
                jQuery('#file_upload_').click();
            }
        });
    }
    {/literal}
</script>
