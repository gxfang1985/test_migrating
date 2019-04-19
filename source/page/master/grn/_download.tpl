{literal}
    <script type="text/javascript">
    <!--
        var __bundleDownLoad = grn.html.download;
        __bundleDownLoad.filename = "{/literal}{$filename|escape:javascript}{literal}";
        __bundleDownLoad.filename = __bundleDownLoad.filename.replace(/[\?\*\/\\"':|<>]/g,'_');
        __bundleDownLoad.filename = encodeURIComponent(__bundleDownLoad.filename);
        __bundleDownLoad.max_download_size = {/literal}{$max_download_size}{literal};

        window.onload = function()
        {
            jQuery("#bundleMaxSize").html( __bundleDownLoad.getSizeString(__bundleDownLoad.max_download_size) );

            grn.component.button("#bundleDownloadButton").on("click", function() {
                __bundleDownLoad.pre_submit();
                document.forms['bundle_download_form'].submit();
            });
        };
    //-->
    </script>
    <style type="text/css">
    <!--
        #bundleDownloadWindow
        {
            position:absolute;
            background-color:white;
            top:20%;
            left:15%;
            border:1px solid #B0B0B0;
        }

        #bundleFiles
        {
            top:10%;
            height:100%;
            border:1px solid #B0B0B0;
            overflow: scroll;
        }
        
        #bundleFiles table.list_column thead img {
            vertical-align: 1px;
        }
        
        div.cover
        {
            position:absolute;
            top:0px;
            left:0px;
            background-color:black;
            -moz-opacity:0.50; /*FF*/
            opacity:0.50;
            zIndex : 1001;
        }
    //-->
    </style>
{/literal}

<div id="background" class=""></div>
<div id="bundleDownloadWindow" class="msgbox" style="display:none;">
    <div class="title" id="bundleDownloadTitle">
        {cb_msg module='grn.grn' key='grn.download.file_select' replace='true'}
        <a style="position: absolute; right: 5px;top:5px;text-decoration:none;" onclick="__bundleDownLoad.closeBundleDownloadWindow();" href="javascript:;">{grn_image image="close20.gif"}</a>
    </div>
    <form id="bundle_download_form" name="bundle_download_form" action="{cb_pageurl page='grn/command_zip_file_download'}" method="POST" style="height:100%;">
        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        <input type="hidden" name="app" value="{$app}">
        <input type="hidden" name="filename" value="{$filename}">
        <input type="hidden" name="folder_id" value="{$folder_id}">
        <div style="padding:1em;height:80%;">
            <div id="bundleFiles">
                <table class="list_column" width="100%">
                    <colgroup>
                        <col width="1%">
                        <col width="25%"> <!-- タイトル -->
                        <col width="25%"> <!-- ファイル名 -->
                        <col width="25%"> <!-- 更新者 -->
                        <col width="12%"> <!-- サイズ -->
                        <col width="12%"> <!-- 更新日時 -->
                    </colgroup>
                    <thead>
                        <tr>
                            <td align="center"><button style="width:20px; height:20px; padding-left: 3px;" onClick="__bundleDownLoad.check_download_files();return false">{capture name='grn_grn_GRN_GRN_431'}{cb_msg module='grn.grn' key='GRN_GRN-431' replace='true'}{/capture}{grn_image image='check10.gif' alt=$smarty.capture.grn_grn_GRN_GRN_431}</button></td>
                            <td>{cb_msg module='grn.grn' key='grn.download.table.subject' replace='true'}</td>
                            <td>{cb_msg module='grn.grn' key='grn.download.table.content' replace='true'}</td>
                            <td>{cb_msg module='grn.grn' key='grn.download.table.modifier' replace='true'}</td>
                            <td>{cb_msg module='grn.grn' key='grn.download.table.size' replace='true'}</td>
                            <td>{cb_msg module='grn.grn' key='grn.download.table.mtime' replace='true'}</td>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$files item=file}
                            <tr id="tr_{$file.id}"
                                class="{cycle values='lineone,linetwo'}"
                                onmouseover="__bundleDownLoad.setSelectableView({$file.id});"
                                onmouseout="__bundleDownLoad.setUnselectableView({$file.id});" >
                                <td style="padding-left:10px;">
                                    <input type="checkbox"
                                           id="download_{$file.id}"
                                           name="fid[]"
                                           onclick="__bundleDownLoad.calcTotalFileSize(this);"
                                           size="{$file.size}"
                                           value="{$file.id}" >
                                </td>
                                <td>{$file.title}</td>
                                <td>{$file.filename}</td>
                                <td>{grn_user_name uid=$file.modifier_uid name=$file.modifier_name truncated=$config.name_width users_info=$users_info}</td>
                                <td>{grn_format_filesize size=$file.size unit="KB" round='ceil'}</td>
                                <td>{grn_date_format date=$file.mtime format="DateTimeCompact"}</td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
        <div style="height:20%;background-color:white; padding-bottom: 15px;">
            <table border="0" width="100%" class="bundleDownloadWindow_info" {if !$max_download_size}style="display:none;"{/if} >
                <tr>
                    <td width="1%">
                        <span id="bundleSizePercentage" {if !$max_download_size}style="display:none;"{/if} >0%</span>
                    </td>
                    <td>
                        <div style="border: 1px solid rgb(176, 176, 176); padding: 0px; width: 99.5%; height: 10px;{if !$max_download_size}display:none;{/if}">
                            <div id="inner_progress" style="width:0%;background-color:lightgreen;height:100%;float:left;"></div>
                            <div id="assumed_progress" style="width:0%;background-color:yellow;height:10px;float:left;"></div>
                        </div>
                    </td>
                    <td width="10px"></td>
                    <td width="25%">
                        {if $max_download_size}
                            {cb_msg module='grn.grn' key='grn.download.filesize' replace='true'}<span id="bundleDownloadSize">0B</span>
                        {/if}
                    </td>
                    <td width="20%">
                        {cb_msg module='grn.grn' key='grn.download.filesize.limit' replace='true'}<span id="bundleMaxSize"></span>
                    </td>
                </tr>
            </table>
            <div style="text-align:center;background-color:white;">
                {strip}
                    {cb_msg module='grn.grn' key='grn.download.encode' replace='true'}
                    <select name="encode" class="mRight15">
                        {foreach from=$encodings key=key item=item}
                            <option value="{$key}" {if $item.selected}selected="selected"{/if}>
                                {$item.encode|escape}
                            </option>
                        {/foreach}
                    </select>
                    {capture name="grn_grn_download_bundle_download2"}{cb_msg module='grn.grn' key='grn.download.bundle.download2' replace='true'}{/capture}
                    {grn_button id="bundleDownloadButton" ui='main' spacing='normal' caption=$smarty.capture.grn_grn_download_bundle_download2}
                    {grn_button id="bundleCancelButton" action='cancel' onclick="__bundleDownLoad.closeBundleDownloadWindow();"}
                    {if !$max_download_size}
                        {cb_msg module='grn.grn' key='grn.download.filesize' replace='true'}
                        <span id="bundleDownloadSize" style="width:70px;display:inline-block;">0B</span>
                    {/if}
                {/strip}
            </div>
        </div>
       </form>
</div>
