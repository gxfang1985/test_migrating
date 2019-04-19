{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='node_image' value='category20.gif'}
{capture name='grn_workflow_system_category_csv_name'}{cb_msg module='grn.workflow.system' key='category_csv_name' replace='true'}{/capture}{assign var='prop_name' value=$smarty.capture.grn_workflow_system_category_csv_name}
{capture name='grn_workflow_system_category_csv_code'}{cb_msg module='grn.workflow.system' key='category_csv_code' replace='true'}{/capture}{assign var='prop_code' value=$smarty.capture.grn_workflow_system_category_csv_code}
{assign var='page_prefix' value='workflow/operation/'}
{assign var='no_virtual_root' value='1'}

<p>
<div class="explanation">
{cb_msg module='grn.workflow.system' key='w_select_category_publilc_y' replace='true'}
</div>

</p>

<div id="path_part">
{if $no_virtual_root}

 {foreach name='path' from=$node.ancestors item=item}
  {if $smarty.foreach.path.iteration == 1}{grn_image image=$node_image}{/if}{grn_link page=$page_info.all nid=$item.nid caption=$item.name} &gt; 
 {/foreach}
 {if $smarty.foreach.path.total < 1}{grn_image image=$node_image}{/if}{$node.name|escape}

{else}

 {if $is_root}
  {grn_image image=$node_image}{cb_msg module='grn.workflow.system' key='w_root' replace='true'}
 {else}
  {capture name='grn_workflow_system_w_root'}{cb_msg module='grn.workflow.system' key='w_root' replace='true'}{/capture}{grn_link image=$node_image page=$page_info.all caption=$smarty.capture.grn_workflow_system_w_root} &gt; 
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

  <div class="tree_item"><div class="sub_title">{if $is_root}{cb_msg module='grn.workflow.operation' key='key_49_1' replace='true'}{else}{cb_msg module='grn.workflow.operation' key='key_49_2' replace='true'}{/if}</div></div>
{foreach from=$node.children item=item}
  <div class="tree_item">
  {grn_link image=$node_image page=$page_info.all nid=$item.nid caption=$item.name}
  {if $item.child_count}({$item.child_count}){/if}
  </div>
{foreachelse}
  <div><nobr>{cb_msg module='grn.workflow.operation' key='key_50_1' replace='true'}{if $node_id}{cb_msg module='grn.workflow.operation' key='key_50_2' replace='true'}{else}{cb_msg module='grn.workflow.operation' key='key_50_3' replace='true'}{/if}</nobr></div>
{/foreach}

  </td>
  <td id="view_part" width="70%">

{if $node_id}
  <div id="main_menu_part">
  {if $is_manage}
  <span class="menu_item">{capture name='grn_workflow_operation_view_public_list'}{cb_msg module='grn.workflow.operation' key='view_public_list' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix`public_list" nid=$node_id reset=1 caption=$smarty.capture.grn_workflow_operation_view_public_list}</span>
  {else}
  <span class="menu_item">{capture name='grn_workflow_operation_view_public_list'}{cb_msg module='grn.workflow.operation' key='view_public_list' replace='true'}{/capture}{grn_link image='modify20.gif' page="`$page_prefix`public_list" nid=$node_id reset=1 caption=$smarty.capture.grn_workflow_operation_view_public_list disabled=true}</span>
  {/if}
  </div>

  <p>
  <div>
  <span class="sub_title">{cb_msg module='grn.workflow.operation' key='c_public_setting_status' replace='true'}</span>
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
    <th nowrap>{cb_msg module='grn.workflow.system' key='w_security_mode' replace='true'}</th>
    <td nowrap>{grn_image image='access20.gif'}{if $public.security_model == 'revoke'}{cb_msg module='grn.workflow.operation' key='c_limit' replace='true'}{else}{cb_msg module='grn.workflow.operation' key='c_accept' replace='true'}{/if}</td>
   </tr>
   <tr>
    <th nowrap>{cb_msg module='grn.workflow.operation' key='c_number_public_setting' replace='true'}</th>
    <td align="right">{$public.count}</td>
   </tr>
  </table>
{/if}

  </td>
 </tr>
</table>

{include file="grn/footer.tpl"}
