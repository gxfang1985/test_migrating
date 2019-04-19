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
  <col width="30%">
  <col width="30%">
  <col width="30%">
  <col width="10%">
 </colgroup>
 <tr>
  <th nowrap>{$prop_name|escape}</th>
  <th nowrap>{$prop_code|escape}</th>
  <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-268' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-269' replace='true'}</th>
 </tr>
{foreach from=$node_list key=key item=item}
 <tr>
  <td>{grn_link image=$node_image page="`$page_prefix`access_list" caption=$item.name nid=$item.nid reset=1}</td>
  <td>{$item.foreign_key|escape}</td>
  <td nowrap>{grn_image image='access20.gif'}{$item.security_model|upper}{cb_msg module='grn.grn' key='GRN_GRN-270' replace='true'}{if $item.security_model == 'revoke'}{cb_msg module='grn.grn' key='GRN_GRN-271' replace='true'}{else}{cb_msg module='grn.grn' key='GRN_GRN-272' replace='true'}{/if}{cb_msg module='grn.grn' key='GRN_GRN-273' replace='true'}</td>
  <td align="right">{$item.access_count}</td>
 </tr>
{/foreach}
</table>
