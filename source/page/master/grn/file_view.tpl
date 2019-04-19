{**

  このテンプレートは以下の変数を期待しています

  $download_page          ダウンロードページ
  $restore_page           巻き戻しページ
  $linkparams             リンクへの引数

  $file                   ファイル情報本体
  $file.id                ファイルID
  $file.filename          ファイル名
  $file.size              ファイルサイズ
  $file.mime              ファイルMIMEタイプ
  $file.title             タイトル
  $file.memo              メモ
  $file.version           最新バージョン
  $file.max_version       バージョン管理数
  $file.creator_uid       登録者ID
  $file.creator_name      登録者名
  $file.ctime             登録タイムスタンプ
  $file.modifier_uid      更新者ID
  $file.modifier_name     更新者名
  $file.mtime             更新タイムスタンプ
  $file.locked            ロック状態（空：非ロック、other：他人がロック、login：ログインユーザーがロック
  $file.lock_owner_uid    ロックしているユーザーのID
  $file.lock_owner_name   ロックしているユーザーの名前

  $file.logs                   ログ（ログIDをキーにした配列）
  $file.logs[id].version       ログのバージョン
  $file.logs[id].filename      ファイル名
  $file.logs[id].creator_uid   更新者ID
  $file.logs[id].creator_name  更新者名
  $file.logs[id].ctime         更新タイムスタンプ
  $file.logs[id].operation     操作（create,update,restore）
  $file.logs[id].comment       コメント
  $file.logs[id].file_exists   実ファイルが存在するかどうか

  $file.navi              履歴一覧ナビゲーション

  参考
bulletin/file_view.tpl

**}
<div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-393' replace='true'}</div>
<table class="view_table" width="80%">
    <colgroup>
        <col width="20%">
        <col width="80%">
    </colgroup>
    <tr>
        <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-394' replace='true'}</th>
        <td><a class="with_lang" href="{grn_pageurl page=$download_page params=$linkparams fid=$file.id postfix=$file.filename ticket=$download_ticket}"><nobr></nobr>{$file.filename|escape:"html"}</a>&nbsp;&nbsp;({$file.mime})</td>
    </tr>
    <tr>
        <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-395' replace='true'}</th>
        <td>{grn_format_filesize size=$file.size unit="byte"}</td>
    </tr>
</table>

<p>
<div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-396' replace='true'}</div>
<table class="view_table" width="80%">
    <colgroup>
        <col width="20%">
        <col width="80%">
    </colgroup>
    <tr>
        <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-397' replace='true'}</th>
        <td>
            <a name="title">{$file.title|escape:"html"}</a>&nbsp;
        </td>
    </tr>
    <tr>
        <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-398' replace='true'}</th>
        <td>
            {if $file.max_version == -1}
                {cb_msg module='grn.grn' key='GRN_GRN-399' replace='true'}
            {elseif $file.max_version > 0}
                {$file.max_version}&nbsp;{cb_msg module='grn.grn' key='GRN_GRN-400' replace='true'}
            {else}
                {cb_msg module='grn.grn' key='GRN_GRN-401' replace='true'}
            {/if}
        </td>
    </tr>
    <tr>
        <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-402' replace='true'}</th>
        <td nowrap>{grn_user_name uid=$file.creator_uid name=$file.creator_name users_info=$users_info}&nbsp;{grn_date_format date=$file.ctime format='DateTimeMiddle_YMDW_HM'}</td>
    </tr>
    <tr>
        <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-403' replace='true'}</th>
        <td nowrap>{grn_user_name uid=$file.modifier_uid name=$file.modifier_name users_info=$users_info}&nbsp;{grn_date_format date=$file.mtime format='DateTimeMiddle_YMDW_HM'}</td>
    </tr>
    <tr valign="top">
        <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-404' replace='true'}</th>
        <td>
            {if 1 > $file.memo|count_characters:true}
                <br>
            {else}
                {grn_format body=$file.memo}
            {/if}
        </td>
    </tr>
</table>

<p>

{* 更新情報配列表示 *}
<div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-405' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$file.navi.start_count end_num=$file.navi.end_count all_num=$file.navi.count}</div>
<table class="admin_list_table">
    <colgroup>
        <col width="1%">
        <col width="20%">
        <col width="20%">
        <col width="20%">
        <col width="5%">
        <col width="30%">
    </colgroup>
    <tr>
        <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-1470' replace='true'}</th>
        {if $sort == 'tu'}
            <th nowrap>{capture name='grn_grn_GRN_GRN_408'}{cb_msg module='grn.grn' key='GRN_GRN-408' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_grn_GRN_GRN_408       page=$page_info.all params=$linkparams fid=$file.id sort="td" sp=0 reverse=1}</th>
        {else}
            {if $sort == 'td'}
                <th nowrap>{capture name='grn_grn_GRN_GRN_409'}{cb_msg module='grn.grn' key='GRN_GRN-409' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_grn_GRN_GRN_409       page=$page_info.all params=$linkparams fid=$file.id sort="tu" sp=0}</th>
            {else}
                <th nowrap>{capture name='grn_grn_GRN_GRN_410'}{cb_msg module='grn.grn' key='GRN_GRN-410' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_grn_GRN_GRN_410       page=$page_info.all params=$linkparams fid=$file.id sort="td" sp=0 disable=1}</th>
            {/if}
        {/if}
        {if $sort == 'uu'}
            <th nowrap>{capture name='grn_grn_GRN_GRN_411'}{cb_msg module='grn.grn' key='GRN_GRN-411' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_grn_GRN_GRN_411     page=$page_info.all params=$linkparams fid=$file.id sort="ud" sp=0 reverse=1}</th>
        {else}
            {if $sort == 'ud'}
                <th nowrap>{capture name='grn_grn_GRN_GRN_412'}{cb_msg module='grn.grn' key='GRN_GRN-412' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_grn_GRN_GRN_412     page=$page_info.all params=$linkparams fid=$file.id sort="uu" sp=0}</th>
            {else}
                <th nowrap>{capture name='grn_grn_GRN_GRN_413'}{cb_msg module='grn.grn' key='GRN_GRN-413' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_grn_GRN_GRN_413     page=$page_info.all params=$linkparams fid=$file.id sort="ud" sp=0 disable=1}</th>
            {/if}
        {/if}
        {if $sort == 'nu'}
            <th nowrap>{capture name='grn_grn_GRN_GRN_414'}{cb_msg module='grn.grn' key='GRN_GRN-414' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_grn_GRN_GRN_414 page=$page_info.all params=$linkparams fid=$file.id sort="nd" sp=0 reverse=1}</th>
        {else}
            {if $sort == 'nd'}
                <th nowrap>{capture name='grn_grn_GRN_GRN_415'}{cb_msg module='grn.grn' key='GRN_GRN-415' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_grn_GRN_GRN_415 page=$page_info.all params=$linkparams fid=$file.id sort="nu" sp=0}</th>
            {else}
                <th nowrap>{capture name='grn_grn_GRN_GRN_416'}{cb_msg module='grn.grn' key='GRN_GRN-416' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_grn_GRN_GRN_416 page=$page_info.all params=$linkparams fid=$file.id sort="nd" sp=0 disable=1}</th>
            {/if}
        {/if}
        <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-417' replace='true'}</th>
        <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-418' replace='true'}</th>
    </tr>

    {foreach from=$file.logs item=log key=lid}
        <tr valign="top">
            <td nowrap>{$log.version}</td>
            <td nowrap>{grn_date_format date=$log.ctime format="DateTimeMiddle_YMDW_HM"}</td>
            <td nowrap>{grn_user_name uid=$log.creator_uid name=$log.creator_name truncated=$name_width users_info=$users_info}</td>
            {if $log.file_exists}
                {if $log.version != $file.version}
                    <td nowrap>
                        <a class="with_lang" href="{grn_pageurl page=$download_page params=$linkparams fid=$file.id ver=$log.version postfix=$log.filename ticket=$download_ticket}"><nobr></nobr>{$log.filename|escape:"html"}</a>
                        {if ! $no_restore}
                            {if ! $file.auth || $file.auth.write}
                                <input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-419' replace='true'}" onclick='location.href="{grn_pageurl page=$restore_page params=$linkparams fid=$file.id ver=$log.version}";'>
                            {else}
                                <input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-420' replace='true'}" onclick='location.href="{grn_pageurl page=$restore_page params=$linkparams fid=$file.id ver=$log.version}";' disabled>
                            {/if}
                        {/if}
                    </td>
                {else}
                    <td nowrap>{$log.filename|escape:"html"}</td>
                {/if}
            {else}
                <td>{$log.filename|escape:"html"}</td>
            {/if}
            {if $log.operation == 'restore'}
                <td nowrap>{cb_msg module='grn.common' key="file_operation_restore" ver=$log.restore_version}</td>
            {else}
                <td nowrap>{cb_msg module='grn.common' key=$log.operation|string_format:"file_operation_%s" }</td>
            {/if}
            <td>{grn_format body=$log.comment}</td>
        </tr>
    {/foreach}
</table>
<div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$file.navi.navi}</nobr></div>
{* 更新情報配列表示 *}
