{if ! $input_size}{assign var=input_size value="40"}{/if}
{if ! $file_image}{assign var=file_image value="file20.gif"}{/if}
{if ! $delete_image}{assign var=delete_image value="delete20.gif"}{/if}
{if ! $delete_image_align}{assign var=delete_image_align value="absmiddle"}{/if}
{if ! $attached_name}{assign var="attached_name" value="fids[]"}{/if}
{if ! $box}{assign var="box" value="fbox"}{/if}
{if ! $box_prefix}{assign var="box_prefix" value="fdiv"}{/if}
{if ! $input_name}{assign var="input_name" value="file"}{/if}
{if !$load_attach_file}
{grn_load_javascript file="grn/html/rpaf.js"}
  {assign var="load_attach_file" value=TRUE}
{/if}
{grn_assign_file_upload_information}

<script language="Javascript" type="text/javascript">
<!--
var __rpaf_{$input_name}_count     = 0;
var __rpaf_max_{$input_name}_count = {$max_file_count};

var init_{$input_name}_values = '';
init_{$input_name}_values = init_{$input_name}_values + '__rpaf_link_name = "{$link_name}";';
init_{$input_name}_values = init_{$input_name}_values + '__rpaf_file_count_name = "__rpaf_{$input_name}_count";';
init_{$input_name}_values = init_{$input_name}_values + '__rpaf_max_file_count_name = "__rpaf_max_{$input_name}_count";';

__upload_max_file_count_{$input_name} = {$max_file_count};
__upload_{$input_name}_require = "{$required}";
__upload_msg_{$input_name}_error = "{$item.display_name}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-1' replace='true'}";

__upload_ticket = "{$upload_ticket}";
__upload_files_url = '{grn_pageurl page="report/ajax/uploaded_files"}';
__upload_msg_error = "{cb_msg module='grn.grn' key='grn.upload.error' replace='true'}";
__upload_msg_error_suffix   = "{cb_msg module='grn.grn' key='grn.upload.error.suffix' replace='true'}";
__upload_msg_filesizeover_1 = "{cb_msg module='grn.grn' key='grn.upload.filesizeover.1' replace='true'}";
__upload_msg_filesizeover_2 = "{cb_msg module='grn.grn' key='grn.upload.filesizeover.2' replace='true'}";
__upload_msg_zerobyte_file  = "{cb_msg module='grn.grn' key='grn.upload.zerobyte.file' replace='true'}";
__upload_msg_cancel = "{cb_msg module='grn.grn' key='grn.upload.cancel' replace='true'}";
__upload_msg_confirm1 = "{cb_msg module='grn.grn' key='grn.upload.confirm1' replace='true'}";
__upload_msg_confirm2 = "{cb_msg module='grn.grn' key='grn.upload.confirm2' replace='true'}";

//-->
</script>
<script language="Javascript" type="text/javascript" >
<!--
    __upload_url = "{$url}";
    os_type = "{$browser.os_type}";
    browser_type = "{$browser.type}";
    browser_ver_major = "{$browser.ver_major}";
    _input_name = "{$input_name}";
//-->
</script>

<div id="attention_{$input_name}" style="font-weight:bold;color:red;"></div>

<div id="html5_content_{$input_name}" class="html5_content" style="display:none;">
    {if $attached_file_list}
        {if ! $file_image}{assign var=file_image value="file20.gif"}{/if}
        {if ! $attached_name}{assign var="attached_name" value="fids[]"}{/if}

        <div id="flash_afbox_{$input_name}" class="afbox">
            <table style="margin-top: 10px;">
                {foreach from=$attached_file_list key=fid item=file}
                   <tr id="row_{$input_name}-{$fid}">
                       <td>
                            <input class="flash_infile upload_checkbox_{$input_name}" onclick="onChangeCheckBox('{$input_name}-{$fid}')" id="{$input_name}-{$fid}_checkbox" type="checkbox" name="{$attached_name}" value="{$fid}" checked>
                       </td>
                        <td>
                            <span style="margin:0,0,0,0;">{grn_image image=$file_image}
                                <span id="{$input_name}-{$fid}_filename">
                                    {$file.name|escape:"html"}
                                </span>
                            </span>
                        </td>
                    </tr>
                {/foreach}
            </table>
        </div>
    {/if}
    <div id="drop_{$input_name}" class="drop {$page_info.parts[0]}_drop">
        {cb_msg module='grn.grn' key='GRN_GRN-1534' replace='true'}
    </div> 
    <div class="file_input_div">
        {cb_msg module='grn.grn' key='GRN_GRN-1535' replace='true'}
        <input id="file_upload_{$input_name}" multiple type="file" size="{$input_size}" name="{$input_name}" class="file_html5 file_input_hidden"></input>
    </div>

    <input type="hidden" name="html5" value="true" size="100">

    <div id="upload_message_{$input_name}" style="font-size:small;">
    </div>
    <table id="upload_table_{$input_name}" class="attachment_list_base_grn" >
      <tbody>
        <tr>
          <td></td>
        </tr>
      </tbody>
    </table>
    <input type="hidden" name="upload_ticket" value="{$upload_ticket}" />
</div>

{grn_load_javascript file="grn/html/upload.js"}
{grn_load_javascript file="grn/html/upload_report.js"}

<div class="attachment_legacy_base_grn">
    <div id="no_flash_plugin_content_{$input_name}" class="not_support_html5_content" style="display:none;">
        {if $attached_file_list}
            <div id="a{$box}" class="a{$box}">
                {foreach from=$attached_file_list key=fid item=attached_file}
                    <div id="a{$box_prefix}{$fid|escape}">
                        <nobr>
                            <input id="attached_file_{$input_name}" class="infile attached_file_{$input_name}"
                                   type="hidden" name="{$attached_name}" value="{$fid}">
                            <span style="margin:0,0,0,0;">
                                {if $attached_file.table == GRN_REPORT_TABLE_FILERELATION}
                                    {assign var=image value="disk20.gif"}
                                    {if $display == 'view'}
                                        {if $settings.inline == 1}
                                            {grn_attach_file_link name=$attached_file.name dpage="report/file_download" vpage="report/file_view" size=$attached_file.size mime=$attached_file.mime rid=$report_id ifid=$attached_file.ifid inline=$settings.inline thumbnail=$settings.thumbnail thumbnail_xsize=$settings.thumbnail_xsize thumbnail_ysize=$settings.thumbnail_ysize image=$image disabled=$disabled hash=$attached_file.hash}
                                        {else}
                                            {grn_attach_file_link name=$attached_file.name dpage="report/file_download" vpage="report/file_view" size=$attached_file.size mime=$attached_file.mime rid=$report_id ifid=$attached_file.ifid image=$image disabled=$disabled}
                                        {/if}
                                    {elseif $display == 'view-system'}
                                        {if $settings.inline == 1}
                                            {grn_attach_file_link name=$attached_file.name dpage="report/system/file_download" vpage="report/system/file_view" size=$attached_file.size mime=$attached_file.mime cid=$category_id fid=$form_id rid=$report_id params=$params ifid=$attached_file.ifid inline=$settings.inline thumbnail=$settings.thumbnail thumbnail_xsize=$settings.thumbnail_xsize thumbnail_ysize=$settings.thumbnail_ysize image=$image disabled=$disabled hash=$attached_file.hash}
                                        {else}
                                            {grn_attach_file_link name=$attached_file.name dpage="report/system/file_download" vpage="report/system/file_view" size=$attached_file.size mime=$attached_file.mime cid=$category_id fid=$form_id rid=$report_id params=$params ifid=$attached_file.ifid image=$image disabled=$disabled}
                                        {/if}
                                    {elseif $display == 'view-operation'}
                                        {if $settings.inline == 1}
                                            {grn_attach_file_link name=$attached_file.name dpage="report/operation/file_download" vpage="report/operation/file_view" size=$attached_file.size mime=$attached_file.mime cid=$category_id fid=$form_id rid=$report_id params=$params ifid=$attached_file.ifid inline=$settings.inline thumbnail=$settings.thumbnail thumbnail_xsize=$settings.thumbnail_xsize thumbnail_ysize=$settings.thumbnail_ysize image=$image disabled=$disabled hash=$attached_file.hash}
                                        {else}
                                            {grn_attach_file_link name=$attached_file.name dpage="report/operation/file_download" vpage="report/operation/file_view" size=$attached_file.size mime=$attached_file.mime cid=$category_id fid=$form_id rid=$report_id params=$params ifid=$attached_file.ifid image=$image disabled=$disabled}
                                        {/if}
                                    {/if}
                                {else}
                                    {grn_image image=$file_image}{$attached_file.name|escape:"html"}
                                {/if}
                            </span>
                            <a href="javascript:grn_report_delete_fileselect('a{$box_prefix}{$fid|escape}', init_{$input_name}_values)">{grn_image image=$delete_image align=$delete_image_align}{cb_msg module='grn.report' key='GRN_RPRT-203' replace='true'}</a>
                        </nobr>
                    </div>
                {/foreach}
            </div>
        {/if}
        {capture name='grn_GRN_GRN_1581'}{cb_msg module='grn.grn' key='GRN_GRN-1581' replace='true'}{/capture}
        <span class="icon_information_sub_grn messageSub-grn">{$smarty.capture.grn_GRN_GRN_1581}</span>
    </div>
</div>

{** STM-379 **}
<script language="Javascript" type="text/javascript">
    {literal}
    if(browser_type == 'msie' && browser_ver_major >= 10)
    {
        {/literal}
        jQuery('#file_upload_{$input_name}').keypress(function(e)
        {literal}
        {
            if(e.which == 13)
            {
                e.preventDefault();
                {/literal}
                jQuery('#file_upload_{$input_name}').click();
                {literal}
            }
        });
    }
    {/literal}
</script>
