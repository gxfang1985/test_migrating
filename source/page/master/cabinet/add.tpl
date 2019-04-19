{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class='cabinet'}
{assign var="form_name" value=$smarty.template|basename}
{grn_assign_file_upload_information}

<form name="{$form_name}" method="post" enctype="multipart/form-data" action="{grn_pageurl page='cabinet/command_add'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <div class="explanation">
        {cb_msg module='grn.cabinet' key='GRN_CAB-20' replace='true'}
    </div>
    {if $err_no_file}
        <div style="color:red;font-weight:bold;">
            {cb_msg module='grn.cabinet' key='GRN_CAB-23' replace='true'}
        </div>
    {/if}
    <script language="Javascript" type="text/javascript">
    <!--
        __upload_msg_error          = "{cb_msg module='grn.grn' key='grn.upload.error' replace='true'}";
        __upload_msg_error_suffix   = "{cb_msg module='grn.grn' key='grn.upload.error.suffix' replace='true'}";
        __upload_msg_filesizeover_1 = "{cb_msg module='grn.grn' key='grn.upload.filesizeover.1' replace='true'}";
        __upload_msg_filesizeover_2 = "{cb_msg module='grn.grn' key='grn.upload.filesizeover.2' replace='true'}";
        __upload_msg_zerobyte_file  = "{cb_msg module='grn.grn' key='grn.upload.zerobyte.file' replace='true'}";
        __upload_msg_version_suffix = "{cb_msg module='grn.cabinet' key='GRN_CAB-31' replace='true'}";
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
    {grn_load_javascript file="grn/html/textarea.js"}
    
    <input type="hidden" name="uid" value="{$login.id}">
    <input type="hidden" name="hid" value="{$folder_id}">
    <input type="hidden" name="s_hid" value="{$set_folder_id}">
    <input type="hidden" name="upload_ticket" value="{$upload_ticket}">

    <div>
            {include file='grn/indispensable.tpl'}
            {literal}
                <style type="text/css">
                <!--
                .list_column td
                {
                    border-top:1px solid #000;
                }
                -->
                </style>
            {/literal}

            <table class="std_form">
                <tr>
                    <th>{cb_msg module='grn.cabinet' key='GRN_CAB-21' replace='true'}</th>
                    <td>{grn_user_name name=$login.name uid=$login.id}</td>
                </tr>
                <tr>
                    <th>{cb_msg module='grn.cabinet' key='GRN_CAB-27' replace='true'}</th>
                    <td>{$folder.title|escape:"html"}</td>
                </tr>
                <tr>
                <th>{capture name='grn_cabinet_GRN_CAB_22'}{cb_msg module='grn.cabinet' key='GRN_CAB-22' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_cabinet_GRN_CAB_22 necessary=TRUE}</th>
                <td>
                    <div id="html5_content" style="display:none;">
                        <div id="drop_" class="drop">
                            {cb_msg module='grn.grn' key='GRN_GRN-1534' replace='true'}
                        </div>
                        <div class="file_input_div">
                            {cb_msg module='grn.grn' key='GRN_GRN-1535' replace='true'}
                            {capture name='grn_cabinet_GRN_CAB_23'}{cb_msg module='grn.cabinet' key='GRN_CAB-23' replace='true'}{/capture}{capture name='grn_cabinet_GRN_CAB_24'}{cb_msg module='grn.cabinet' key='GRN_CAB-24' replace='true'}{/capture}{grn_file name="file" necessary=TRUE title=$smarty.capture.grn_cabinet_GRN_CAB_24 class="file_input_hidden" multiple=true id="file_upload_"}
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

            <div style="display:none;">
                <select id="version_select" name="max_version_fileid">
                    {foreach from=$version.options item=value}
                        {if $max_version == $value }
                            {assign var="selected" value="selected"}
                        {else}
                            {assign var="selected" value=""}
                        {/if}
                        {if $value == 0}
                            <option value="0" {$selected}>{cb_msg module='grn.cabinet' key='GRN_CAB-29' replace='true'}</option>
                        {elseif $value == -1}
                            <option value="-1" {$selected}>{cb_msg module='grn.cabinet' key='GRN_CAB-30' replace='true'}</option>
                        {else}
                            <option value="{$value}" {$selected}>{$value}</option>
                        {/if}
                    {/foreach}
                </select>
            </div>
            <div id="upload_message" style="margin-bottom:10px;"></div>
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
                {capture name='grn_cabinet_GRN_CAB_34'}{cb_msg module='grn.cabinet' key='GRN_CAB-34' replace='true'}{/capture}
                {capture name='cabinet_addfile_submit'}
                    if(grn.component.button("#cabinet_button_add").isDisabled())
                        return false;

                    grn.component.button("#cabinet_button_add").showSpinner();
                    if(confirmIfExistFailedFile())
                        document.forms['{$form_name}'].submit();
                    else grn.component.button("#cabinet_button_add").hideSpinner();
                {/capture}

                {grn_button id='cabinet_button_add' ui='main' spacing='normal' caption=$smarty.capture.grn_cabinet_GRN_CAB_34 onclick=$smarty.capture.cabinet_addfile_submit}
                {grn_button id='cabinet_button_cancel' action='cancel' page="cabinet/index" page_param_hid=$folder_id}
            </div>
        {/strip}
    </div>

    <div class="clear_both_0px"></div>
    {grn_load_javascript file="grn/html/upload_cabinet.js"}
</form>
{include file="grn/footer.tpl"}
