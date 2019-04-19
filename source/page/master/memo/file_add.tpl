{include file="grn/head.tpl"} {include file="grn/header.tpl"} {grn_title
title=$page_title class=''} {assign var="form_name"
value=$smarty.template|basename}
<form name="{$form_name}" method="post" enctype="multipart/form-data"
    action="{grn_pageurl page='memo/command_'|cat:$page_info.last}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <div class="explanation">
        {cb_msg module='grn.memo' key='GRN_MEM-139' replace='true'}
    </div>
    {if $err_no_file}
        <div style="color:red;font-weight:bold;">
            {cb_msg module='grn.cabinet' key='GRN_CAB-23' replace='true'}
        </div>
    {/if}

    {grn_assign_file_upload_information}

    <script language="Javascript" type="text/javascript">
      <!--
        __upload_msg_error          = "{cb_msg module='grn.grn' key='grn.upload.error' replace='true'}";
        __upload_msg_error_suffix   = "{cb_msg module='grn.grn' key='grn.upload.error.suffix'   replace='true'}";
        __upload_msg_filesizeover_1 = "{cb_msg module='grn.grn' key='grn.upload.filesizeover.1' replace='true'}";
        __upload_msg_filesizeover_2 = "{cb_msg module='grn.grn' key='grn.upload.filesizeover.2' replace='true'}";
        __upload_msg_zerobyte_file  = "{cb_msg module='grn.grn' key='grn.upload.zerobyte.file' replace='true'}";
        __upload_msg_version_suffix = "{cb_msg module='grn.memo' key='GRN_MEM-149' replace='true'}";
        __upload_msg_cancel         = "{cb_msg module='grn.grn' key='grn.upload.cancel' replace='true'}";
        __upload_msg_confirm1       = "{cb_msg module='grn.grn' key='grn.upload.confirm1' replace='true'}";
        __upload_msg_confirm2       = "{cb_msg module='grn.grn' key='grn.upload.confirm2' replace='true'}";
        __upload_ticket ="{$upload_ticket}";
        __upload_url = "{$url}";
        os_type = "{$browser.os_type}";
        browser_type = "{$browser.type}";
        browser_ver_major = "{$browser.ver_major}";
      //-->
    </script>
    <input type="hidden" name="did" value="{$folder_id}">
    <input type="hidden" name="pdid" value="{$folder_id}">
    <input type="hidden" name="upload_ticket" value="{$upload_ticket}">

    <div>
            {literal}
                <style type="text/css">
                <!--
                .list_column td {
                    border-top: 1px solid #000;
                }
                -->
                </style>
            {/literal}
            {include file='grn/indispensable.tpl'}

            <table class="std_form">
                <tr>
                    <th>{cb_msg module='grn.cabinet' key='GRN_CAB-21' replace='true'}</th>
                    <td>{grn_user_name name=$login.name uid=$login.id}</td>
                </tr>
                <tr>
                    <th>{cb_msg module='grn.cabinet' key='GRN_CAB-27' replace='true'}</th>
                    <td>{$folder_name|escape:"html"}</td>
                </tr>
                <tr>
                    <th>
                        {capture name='grn_memo_GRN_MEM_140'}{cb_msg module='grn.memo' key='GRN_MEM-140' replace='true'}{/capture}
                        {grn_show_input_title title=$smarty.capture.grn_memo_GRN_MEM_140 necessary=TRUE}
                    </th>
                    <td>
                        <div id="html5_content" style="display:none;">
                            <div id="drop_" class="drop">
                                {cb_msg module='grn.grn' key='GRN_GRN-1534' replace='true'}
                            </div>
                            <div class="file_input_div">
                                {cb_msg module='grn.grn' key='GRN_GRN-1535' replace='true'}
                                {grn_file class="file_html5 file_input_hidden" name="file" necessary=TRUE multiple=true id="file_upload_"}
                            </div>
                            <input type="hidden" name="html5" value="true" size="100">
                        </div>

                        <div id="not_support_html5_content" style="display:none;">
                            {capture name='grn_GRN_GRN_1581'}{cb_msg module='grn.grn' key='GRN_GRN-1581' replace='true'}{/capture}
                            <span class="icon_information_sub_grn messageSub-grn">{$smarty.capture.grn_GRN_GRN_1581}</span>
                        </div>
                    </td>
                </tr>
            </table>

            <div style="display: none;">
                <select id="version_select" name="max_version_fileid">
                    {foreach from=$version.options item=value}
                        {if $max_version == $value }
                            {assign var="selected" value="selected"}
                        {else}
                            {assign var="selected" value=""}
                        {/if}
                        {if $value == 0}
                            <option value="0" {$selected} >{cb_msg module='grn.memo' key='GRN_MEM-147' replace='true'}</option>
                        {elseif $value == -1}
                            <option value="-1"{$selected}>{cb_msg module='grn.memo' key='GRN_MEM-148' replace='true'}</option>
                        {else}
                            <option value="{$value}"{$selected}>{$value}</option>
                        {/if}
                    {/foreach}
                </select>
            </div>
            <div id="upload_message" style="margin-bottom: 10px;"></div>
            <div>
                <table id="fileTable" class="fileup_info">
                    <colgroup>
                        <col width="1%" nowrap><!-- チェックボックス -->
                        <col nowrap><!-- ファイル名 -->
                        <col nowrap><!-- サイズ -->
                        <col width="1%" nowrap><!-- プログレスバー用 -->
                        <col width="1%" nowrap><!-- キャンセルボタン -->
                        <col width="200px" nowrap><!-- タイトル -->
                        <col nowrap><!-- バージョン管理 -->
                        <col width="300px" nowrap><!-- 説明 -->
                    </colgroup>
                    <tr>
                        <th nowrap>&nbsp;</th>
                        <th nowrap>{cb_msg module='grn.memo' key='GRN_MEM-140' replace='true'}</th>
                        <th nowrap>{cb_msg module='grn.memo' key='GRN_MEM-105' replace='true'}</th>
                        <th nowrap></th>
                        <th nowrap></th>
                        <th nowrap>{cb_msg module='grn.memo' key='GRN_MEM-126' replace='true'}</th>
                        <th nowrap>{cb_msg module='grn.memo' key='GRN_MEM-35' replace='true'}</th>
                        <th nowrap>{cb_msg module='grn.memo' key='GRN_MEM-183' replace='true'}</th>
                    </tr>
                </table>
            </div>
            {strip}
                <div class="mTop15 mBottom15">
                    {capture name='grn_memo_GRN_NEM_152'}{cb_msg module='grn.memo' key='GRN_MEM-152' replace='true'}{/capture}
                    {capture name='memo_button_save_onclick'}
                        if (grn.component.button(this).isDisabled()) return false; if (!confirmIfExistFailedFile()) return false; else grn.component.button.util.submit(this); grn.component.button(this).showSpinner();
                    {/capture}

                    {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_memo_GRN_NEM_152 onclick=$smarty.capture.memo_button_save_onclick id="memo_button_save" auto_disable=false}
                    {grn_button action="cancel" page="memo/index" page_param_did=$folder_id id="memo_button_cancel"}
                </div>
            {/strip}
    </div>
    <div class="clear_both_0px"></div>

    {grn_load_javascript file="grn/html/upload_cabinet.js"}
</form>

{include file="grn/footer.tpl"}
