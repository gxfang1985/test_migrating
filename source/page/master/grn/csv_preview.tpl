{**
 *  @param  array   datas                   プレビューデータ
 *  @param  array   columns                 読み込み項目配列
 *  @param  array   request_columns         読み込み項目数（columnsの指定がある場合は無視）
 *  @param  array   continue_column         項目数未定で「...」を表示する場合の列番号
**}
{* header *}


{** プレビューデータの最大カラム数を求める **}
{assign var='max_column_index' value=''}
{assign var='max_columns' value=''}
{foreach name='header' from=$datas key=key item=row}
 {if $import_max_columns < count($row)}
  {assign var='import_max_column_index' value=$key}
  {foreach name='cnt' from=$row item=i}{/foreach}
  {assign var='import_max_columns' value=$smarty.foreach.cnt.total}
 {/if}
{/foreach}

{if $columns}
 {foreach name='count_columns' from=$columns item=col}{/foreach}
 {assign var='request_columns' value=$smarty.foreach.count_columns.total}
{/if}


  <p>
  <div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-1076' replace='true'}</div>
  <table class="admin_list_table" width="100%">
   <tr>
{** 最大カラム数にあわせてヘッダを表示 **}
{foreach name='header' from=$datas[$import_max_column_index] key=key item=row}
 {if ! $continue_column || $smarty.foreach.header.iteration < $continue_column}
    <th nowrap>{$smarty.foreach.header.iteration}{cb_msg module='grn.grn' key='GRN_GRN-1078' replace='true'}
  {if $request_columns > 0}
   {if $smarty.foreach.header.iteration > $request_columns}
    <span class="sub_explanation">{cb_msg module='grn.grn' key='GRN_GRN-1079' replace='true'}</span>
   {/if}
  {/if}
    </th>
 {elseif $smarty.foreach.header.iteration == $continue_column}
    <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-1080' replace='true'}</th>
 {/if}
{/foreach}
   </tr>
{** プレビューデータ表示 **}
{foreach name='preview_data' from=$datas item=row}
 {if $smarty.foreach.preview_data.iteration <= 5} {** 5行でストップ **}
   <tr valign="top">
  {** 行データを表示 **}
  {foreach name='data' from=$row item=column}
   {if ! $continue_column || $smarty.foreach.data.iteration < $continue_column}
    <td>{if strlen($column)}{$column|escape}{else}<br>{/if}</td>
   {elseif $smarty.foreach.data.iteration == $continue_column}
    <td>{cb_msg module='grn.grn' key='GRN_GRN-1081' replace='true'}</td>
   {/if}
  {/foreach}
  {** 最大カラム数に足りない分を空で表示 **}
  {if $continue_column && $continue_column < $import_max_columns}
   {math equation="x - y" x=$continue_column y=$smarty.foreach.data.total assign="empty_columns"}
  {else}
   {math equation="x - y" x=$import_max_columns y=$smarty.foreach.data.total assign="empty_columns"}
  {/if}
  {if $empty_columns > 0}
    <td colspan="{$empty_columns}" class="gray"><br></td>
  {/if}
 {/if}
{/foreach}
   </tr>
  </table>
  </p>
