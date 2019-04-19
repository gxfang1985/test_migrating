{**
 *  ツリー構造におけるアクセス権の設定画面のテンプレート
 *
 *  @param  string  prop_name       ノードの名前のプロパティ名（例：カテゴリ名、フォルダ名）
 *  @param  string  prop_code       ノードお識別子のプロパティ名（例：カテゴリコード、組織コード）
 *  @param  string  page_prefix     一連の画面名のプレフィックス
 *  @param  string  node_id         現在のノードID
 *  @param  array   node            ノード情報（連想配列）
 *  @param  array   access          アクセス権の設定状況（連想配列）
 *}

<table width="100%">
 <tr valign="top">
  <td id="tree_part">
    {include file='grn/org_tree_26.tpl'}
  </td>
  <td id="view_part" width="90%">

{if $node_id}
  <div id="main_menu_part">
  <span class="menu_item">{capture name='grn_grn_GRN_GRN_873'}{cb_msg module='grn.grn' key='GRN_GRN-873' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix`access_list" nid=$node_id reset=1 caption=$smarty.capture.grn_grn_GRN_GRN_873}</span>
  </div>

  <p>
  <div>
  <span class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-874' replace='true'}</span>
  </div>
  <table class="view_table">
   <tr>
    <th nowrap>{$prop_name|escape}</th>
    <td>{$node.name|escape}</td>
   </tr>
   <tr>
    <th nowrap>{$prop_code|escape}</th>
    <td>{$node.foreign_key|escape}</td>
   </tr>
   <tr>
    <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-875' replace='true'}</th>
    <td nowrap>{grn_image image='access20.gif'}{$access.security_model|upper}{cb_msg module='grn.grn' key='GRN_GRN-876' replace='true'}{if $access.security_model == 'revoke'}{cb_msg module='grn.grn' key='GRN_GRN-877' replace='true'}{else}{cb_msg module='grn.grn' key='GRN_GRN-878' replace='true'}{/if}{cb_msg module='grn.grn' key='GRN_GRN-879' replace='true'}</td>
   </tr>
   <tr>
    <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-880' replace='true'}</th>
    <td align="right">{$access.count}</td>
   </tr>
  </table>
{/if}

  </td>
 </tr>
</table>
