{**

  このテンプレートは以下の変数を期待しています

  $download_page          ダウンロードページ
  $linkparams             リンクへの引数

  $restore.file                   ファイル情報本体
  $restore.file.id                ファイルID
  $restore.file.filename          ファイル名
  $restore.file.title             タイトル
  $restore.file.version           最新バージョン
  $restore.file.max_version       バージョン管理数

  $restore.log                    巻き戻し対象のログ
  $restore.log.id                 ログID
  $restore.log.version            ログのバージョン
  $restore.log.filename           ファイル名
  $restore.log.creator_uid        更新者ID
  $restore.log.creator_name       更新者名
  $restore.log.ctime              更新タイムスタンプ

**}
<input type="hidden" name="fid" value="{$restore.file.id}">
<input type="hidden" name="ver" value="{$restore.log.version}">

<table class="std_form">
    <tr>
        <td colspan="2"><div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-28' replace='true'}</div></td>
    </tr>
    <tr>
        <th nowrap>
            {cb_msg module='grn.grn' key='GRN_GRN-29' replace='true'}
        </th>
        <td>
            <a class="with_lang" href="{grn_pageurl page=$download_page params=$linkparams fid=$restore.file.id postfix=$restore.file.filename ticket=$download_ticket}"><nobr></nobr>{$restore.file.filename|escape:"html"}</a>
        </td>
    </tr>
    <tr>
        <td colspan="2"><br>
            <div class="explanation">{cb_msg module='grn.grn' key='GRN_GRN-30' replace='true'}</div>
        </td>
    </tr>
    <tr>
        <th nowrap>
            {cb_msg module='grn.grn' key='GRN_GRN-31' replace='true'}
        </th>
        <td>
            {grn_date_format date=$restore.log.ctime format="DateTimeFull_YMDW_HM"}
        </td>
    </tr>
    <tr>
        <th nowrap>
            {cb_msg module='grn.grn' key='GRN_GRN-32' replace='true'}
        </th>
        <td>
            <a class="with_lang" href="{grn_pageurl page=$download_page params=$linkparams fid=$restore.file.id ver=$restore.log.version postfix=$restore.log.filename ticket=$download_ticket}"><nobr></nobr>{$restore.log.filename|escape:"html"}</a>
        </td>
    </tr>
    <tr valign="top">
        <th nowrap>
            {cb_msg module='grn.grn' key='GRN_GRN-33' replace='true'}
        </th>
        <td>
            {capture name='grn_grn_GRN_GRN_34'}{cb_msg module='grn.grn' key='GRN_GRN-34' replace='true'}{/capture}{grn_textarea name="comment" value="" rows="5" title=$smarty.capture.grn_grn_GRN_GRN_34}<br><div class="sub_explanation">{cb_msg module='grn.grn' key='GRN_GRN-35' replace='true'}</div>
        </td>
    </tr>
    <tr>
        <td></td>
        <td>
            <div class="mTop10">
                {strip}
                    {capture name='grn_grn_GRN_GRN_36'}{cb_msg module='grn.grn' key='GRN_GRN-36' replace='true'}{/capture}
                    {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_grn_GRN_GRN_36 id="filerestore_button_save"}

                    {capture name='grn_grn_GRN_GRN_37'}{cb_msg module='grn.grn' key='GRN_GRN-37' replace='true'}{/capture}
                    {grn_button action="cancel" caption=$smarty.capture.grn_grn_GRN_GRN_37 id="filerestore_button_cancel"}
                {/strip}
            </div>
        </td>
    </tr>
</table>
