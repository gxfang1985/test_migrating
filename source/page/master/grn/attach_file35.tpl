{**
Options...
fbox_id     : ID of this file attachment box ( default "af" )
filename_width : The max width of the file name
progressbar_width : The width of the progress bar
upload_ticket: Upload ticket
attached_name : Attached file's parameter name
get_upload_temp: Retrieve uploaded files on load event (when back button clicked and so on)
**}
{if ! $id}{assign var=id value="af"}{/if}
{if ! $attached_name}
 {assign var="attached_name" value="fids[]"}
{/if}
{grn_assign_file_upload_information}

<script language="Javascript" type="text/javascript"><!--
    __upload_url = "{$url}";
    os_type = "{$browser.os_type}";
    browser_type = "{$browser.type}";
    browser_ver_major = "{$browser.ver_major}";
    _input_name = "{$fbox_id}";
{literal}
YAHOO.util.Event.onDOMReady(
        function() {
            upload_init("{/literal}{$fbox_id}{literal}");
{/literal}{if $get_upload_temp}{literal}
            getUploadedTempFiles("{/literal}{$fbox_id}{literal}");
{/literal}{/if}{literal}
            if(grn.browser.isSupportHTML5)
            {
                new DragDropFile("{/literal}{$fbox_id}{literal}");
                jQuery('.file_input_div').each(function(idx, f){
                    f.addEventListener ("mouseover",function()
                    {
                        jQuery(f).addClass("over");
                    },false);
                    f.addEventListener ("mouseout",function()
                    {
                        jQuery(f).removeClass("over");
                    },false);
                });
            }
            
         });
         
if (typeof __af == "undefined")
{
    __af = {};
}
if (typeof array_list == "undefined")
{
    array_list = new Array();
}
array_list.push("{/literal}{$fbox_id}{literal}");
{/literal}

__af.{$fbox_id} = {literal}{}{/literal};
__af.{$fbox_id}.filename_width = {if $filename_width}{$filename_width}{else}null{/if};
__af.{$fbox_id}.progressbar_width = {if $progressbar_width}{$progressbar_width}{else}300{/if};

__af.{$fbox_id}.upload_ticket = "{$upload_ticket}";
__af.{$fbox_id}.upload_files_url = '{grn_pageurl page="grn/uploaded_files"}';
__af.{$fbox_id}.upload_status = new Array();

__upload_msg_error          = "{cb_msg module='grn.grn' key='grn.upload.error' replace='true' replace='true'}";
__upload_msg_error_suffix   = "{cb_msg module='grn.grn' key='grn.upload.error.suffix' replace='true'}";
__upload_msg_filesizeover_1 = "{cb_msg module='grn.grn' key='grn.upload.filesizeover.1' replace='true'}";
__upload_msg_filesizeover_2 = "{cb_msg module='grn.grn' key='grn.upload.filesizeover.2' replace='true'}";
__upload_msg_zerobyte_file  = "{cb_msg module='grn.grn' key='grn.upload.zerobyte.file' replace='true'}";
__upload_msg_cancel         = "{cb_msg module='grn.grn' key='grn.upload.cancel' replace='true'}";
__upload_msg_confirm1       = "{cb_msg module='grn.grn' key='grn.upload.confirm1' replace='true'}";
__upload_msg_confirm2       = "{cb_msg module='grn.grn' key='grn.upload.confirm2' replace='true'}";

//--></script>

{grn_load_javascript file="grn/html/upload35.js"}
{grn_load_javascript file="grn/html/af35.js"}

    <div id="html5_content_{$fbox_id}" style="display:none;">
            {if $attached_files}
                {if ! $file_image}{assign var=file_image value="file20.gif"}{/if}
                {if ! $attached_name}{assign var="attached_name" value="fids[]"}{/if}
    
                <div id="flash_afbox_{$fbox_id}" class="afbox">
                    {foreach from=$attached_files key=fid item=file}
                        <div id="flash_afdiv_{$fbox_id}{$fid|escape}">
                            <input class="flash_infile" type="checkbox" onclick="onChangeCheckBox('{$fbox_id}', '{$fid}')" id="{$fbox_id}{$fid}_checkbox" name="{$attached_name}" value="{$fid}" checked>
                            <span style="margin:0,0,0,0;">{grn_image image=$file_image}
                                <span id="{$fbox_id}{$fid}_filename">
                                    {$file.name|escape:"html"}
                                </span>
                            </span>
                        </div>
                    {/foreach}
                </div>
            {/if}
            <div id="drop_{$fbox_id}" class="drop">
                {cb_msg module='grn.grn' key='GRN_GRN-1534' replace='true'}
            </div> 
            <div id="file_input_div_{$fbox_id}" class="file_input_div">
                {cb_msg module='grn.grn' key='GRN_GRN-1535' replace='true'}
                <input id="file_upload_{$fbox_id}" multiple type="file" size="{$input_size}" name="{$fbox_id}" class="file_html5 file_input_hidden"></input>
            </div>
            <input type="hidden" name="html5" value="true" size="100">

            <div id="upload_message_{$fbox_id}" {if $isFollow}style="font-size:small;margin-left:20px;"{/if}>
            </div>
            <table id="upload_table_{$fbox_id}" class="attachment_list_base_grn" style="{if $filename_width}width:100%; {/if}">
              <tbody>
                <tr>
                  <td></td>
                </tr>
              </tbody>
            </table>
    </div>

    <div id="not_support_html5_content_{$fbox_id}" style="display:none;" class="attachment_legacy_base_grn">
            {if $attached_files}
                <div id="afbox_{$fbox_id}" class="afbox">
                    {foreach from=$attached_files key=fid item=file}
                        <div id="afdiv_{$fbox_id}{$fid|escape}"><input class="infile" type="hidden" name="{$attached_name}" value="{$fid}"><span style="margin:0,0,0,0;">{grn_image image=$file_image}<span>{$file.name|escape:"html"}</span></span>&nbsp;<a href="javascript:grn_delete_fileselect('afdiv_{$fbox_id}{$fid|escape}')">{grn_image image=$delete_image align='absmiddle'}{cb_msg module='grn.grn' key='GRN_GRN-926' replace='true'}</a></div>
                    {/foreach}
                </div>
            {/if}
            {capture name='grn_GRN_GRN_1581'}{cb_msg module='grn.grn' key='GRN_GRN-1581' replace='true'}{/capture}
            <span class="icon_information_sub_grn messageSub-grn">{$smarty.capture.grn_GRN_GRN_1581}</span>
    </div>

    <div class="clear_both_0px"></div>
    <input type="hidden" name="upload_ticket" value="{$upload_ticket}" />

<script language="Javascript" type="text/javascript">
    {literal}
    if(browser_type == 'msie' && browser_ver_major >= 10)
    {
        {/literal}
        jQuery('#file_upload_{$fbox_id}').keypress(function(e)
                {literal}
        {
            if(e.which == 13)
            {
                e.preventDefault();
                {/literal}
                jQuery('#file_upload_{$fbox_id}').click();
                {literal}
            }
        });
    }
    {/literal}
</script>
