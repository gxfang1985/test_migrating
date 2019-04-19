{**
 *  ツリー構造におけるアクセス権の設定画面のテンプレート
 *
 *  @param  array   page_info       画面情報
 *  @param  string  node_name       ノードの呼び名（例：ブック）
 *  @param  string  node_image      ノードの画像（例：person20.gif）
 *  @param  string  prop_name       ノードの名前のプロパティ名（例：ブック名）
 *  @param  string  prop_code       ノードの識別子のプロパティ名（例：識別子）
 *  @param  string  page_prefix     一連の画面名のプレフィックス
 *  @param  array   node_list       ノード一覧
 *}

<table class="list_column">
 <colgroup>
{if $prop_code}
  <col width="40%">
  <col width="30%">
  <col width="30%">
{else}
  <col width="70%">
  <col width="30%">
{/if}
 </colgroup>
 <tr>
  <th nowrap>{$prop_name|escape}</th>
{if $prop_code}
  <th nowrap>{$prop_code|escape}</th>
{/if}
  <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-924' replace='true'}</th>
 </tr>
{foreach from=$node_list key=key item=item}
 <tr>
  <td>{grn_link image=$node_image page="`$page_prefix`privilege_list" caption=$item.name nid=$item.nid}</td>
 {if $prop_code}
  <td>{$item.foreign_key|escape}</td>
 {/if}
  <td align="right">{$item.access_count}</td>
 </tr>
{/foreach}
</table>
