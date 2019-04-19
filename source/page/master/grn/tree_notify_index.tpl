{**
 *  ツリー構造における通知の設定画面のテンプレート
 *
 *  @param  array   page_info       画面情報
 *  @param  string  node_name       ノードの呼び名（例：カテゴリ、フォルダ）
 *  @param  string  node_image      ノードの画像（例：category20.gif, folder20.gif）
 *  @param  string  prop_name       ノードの名前のプロパティ名（例：カテゴリ名、フォルダ名）
 *  @param  string  prop_code       ノードお識別子のプロパティ名（例：カテゴリコード、組織コード）
 *  @param  string  page_prefix     一連の画面名のプレフィックス
 *  @param  string  node_id         現在のノードID
 *  @param  array   node            ノード情報（連想配列）
 *  @param  array   node.ancestors  先祖ノード一覧
 *  @param  array   node.children   子ノード一覧
 *  @param  array   notify          通知先の設定状況（連想配列）
 *  @param  array   enable_force    強制通知の有無
 *}
<div id="path_part">
 {foreach name="path" from=$node.ancestors item=item}
  {if $smarty.foreach.path.iteration == 1}
  {grn_link page=$page_info.all nid=$item.nid caption=$item.name image=$node_image} &gt; 
  {else}
  {grn_link page=$page_info.all nid=$item.nid caption=$item.name} &gt; 
  {/if}
 {/foreach}
 {if $smarty.foreach.path.total < 1}{grn_image image=$node_image}{assign var='is_root' value=1}{/if}{$node.name|escape}
</div>

<table width="100%">
 <tr valign="top">
  <td id="tree_part" width="30%">

  <div class="tree_item"><div class="sub_title">{if $is_root}{cb_msg module='grn.grn' key='GRN_GRN-1169' replace='true'}{else}{cb_msg module='grn.grn' key='GRN_GRN-1170' replace='true'}{/if}{$node_name|escape}</div></div>
{foreach from=$node.children item=item}
  <div class="tree_item">
  {grn_link image=$node_image page=$page_info.all nid=$item.nid caption=$item.name}
  {if $item.child_count}({$item.child_count}){/if}
  </div>
{foreachelse}
  <div><nobr>{cb_msg module='grn.grn' key='GRN_GRN-1171' replace='true'}{if $node_id}{cb_msg module='grn.grn' key='GRN_GRN-1172' replace='true'}{/if}{$node_name|escape}{cb_msg module='grn.grn' key='GRN_GRN-1173' replace='true'}</nobr></div>
{/foreach}

  </td>
  <td id="view_part" width="70%">

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
