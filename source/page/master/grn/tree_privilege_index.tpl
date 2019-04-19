{**
 *  ツリー構造における運用管理権限の設定画面のテンプレート
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
 *  @param  array   privilege       運用管理権限の設定状況（連想配列）
 *  @param  bool    no_virtual_root 仮想ルートの有無
 *}
<div id="path_part">
{if $no_virtual_root}

 {foreach name='path' from=$node.ancestors item=item}
  {if $smarty.foreach.path.iteration == 1}{grn_image image=$node_image}{/if}{grn_link page=$page_info.all nid=$item.nid caption=$item.name} &gt; 
 {/foreach}
 {if $smarty.foreach.path.total < 1}{grn_image image=$node_image}{assign var='is_root' value=1}{/if}{$node.name|escape}

{else}

 {if $is_root}
  {grn_image image=$node_image}{cb_msg module='grn.grn' key='GRN_GRN-173' replace='true'}
 {else}
  {capture name='grn_grn_GRN_GRN_174'}{cb_msg module='grn.grn' key='GRN_GRN-174' replace='true'}{/capture}{grn_link image=$node_image page=$page_info.all caption=$smarty.capture.grn_grn_GRN_GRN_174} &gt; 
  {foreach from=$node.ancestors item=item}
   {grn_link page=$page_info.all nid=$item.nid caption=$item.name} &gt; 
  {/foreach}
  {$node.name|escape}
 {/if}

{/if}
</div>

<table width="100%">
 <tr valign="top">
  <td id="tree_part" width="30%">

  <div class="tree_item"><div class="sub_title">{if $is_root}{cb_msg module='grn.grn' key='GRN_GRN-175' replace='true'}{else}{cb_msg module='grn.grn' key='GRN_GRN-176' replace='true'}{/if}{$node_name|escape}</div></div>
{foreach from=$node.children item=item}
  <div class="tree_item">
  {grn_link image=$node_image page=$page_info.all nid=$item.nid caption=$item.name}
  {if $item.child_count}({$item.child_count}){/if}
  </div>
{foreachelse}
  <div><nobr>{cb_msg module='grn.grn' key='GRN_GRN-177' replace='true'}{if $node_id}{cb_msg module='grn.grn' key='GRN_GRN-178' replace='true'}{/if}{$node_name|escape}{cb_msg module='grn.grn' key='GRN_GRN-179' replace='true'}</nobr></div>
{/foreach}

  </td>
  <td id="view_part" width="70%">

{if $node_id}
  <div id="main_menu_part">
  <span class="menu_item">{capture name='grn_grn_GRN_GRN_180'}{cb_msg module='grn.grn' key='GRN_GRN-180' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix`privilege_list" nid=$node_id reset=1 caption=$smarty.capture.grn_grn_GRN_GRN_180 element_id="`$page_prefix`privilege_list"}</span>
  </div>

  <p>
  <div>
  <span class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-181' replace='true'}</span>
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
    <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-182' replace='true'}</th>
    <td align="right">{$privilege.count}</td>
   </tr>
  </table>
{/if}

  </td>
 </tr>
</table>
