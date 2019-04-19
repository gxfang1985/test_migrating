{**
 *  ツリー構造における通知の設定画面のテンプレート
 *
 *  @param  string  prop_name       ノードの名前のプロパティ名（例：カテゴリ名、フォルダ名）
 *  @param  string  prop_code       ノードお識別子のプロパティ名（例：カテゴリコード、組織コード）
 *  @param  string  page_prefix     一連の画面名のプレフィックス
 *  @param  string  node_id         現在のノードID
 *  @param  array   node            ノード情報（連想配列）
 *  @param  array   notify          通知先の設定状況（連想配列）
 *  @param  array   enable_force    強制通知の有無
 *}

<table width="100%">
 <tr valign="top">
  <td id="tree_part">
    {include file='grn/org_tree_26.tpl'}
  </td>
  <td id="view_part" width="90%">

{if $node_id}
  <div id="main_menu_part">
  <span class="menu_item">{capture name='grn_grn_GRN_GRN_1174'}{cb_msg module='grn.grn' key='GRN_GRN-1174' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix`notify_list" nid=$node_id reset=1 caption=$smarty.capture.grn_grn_GRN_GRN_1174}</span>
  </div>

  <p>
  <div>
  <span class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-1175' replace='true'}</span>
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
   {if $enable_force}
   <tr>
    <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-1176' replace='true'}</th>
    <td nowrap>{if $notify.force}ON{else}OFF{/if}</td>
   </tr>
   <tr>
   {/if}
    <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-1177' replace='true'}</th>
    <td align="right">{$notify.count}</td>
   </tr>
  </table>
{/if}

  </td>
 </tr>
</table>
