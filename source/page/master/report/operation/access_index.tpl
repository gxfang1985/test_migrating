{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{capture name='grn_report_operation_GRN_RPRT_OP_61'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-61' replace='true'}{/capture}{assign var='node_name' value=$smarty.capture.grn_report_operation_GRN_RPRT_OP_61}
{assign var='node_image' value='category20.gif'}
{capture name='grn_report_operation_GRN_RPRT_OP_62'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-62' replace='true'}{/capture}{assign var='prop_name' value=$smarty.capture.grn_report_operation_GRN_RPRT_OP_62}
{capture name='grn_report_operation_GRN_RPRT_OP_63'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-63' replace='true'}{/capture}{assign var='prop_code' value=$smarty.capture.grn_report_operation_GRN_RPRT_OP_63}
{assign var='page_prefix' value='report/operation/'}
{assign var='no_virtual_root' value='1'}

<p>
<div class="explanation">
{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-64' replace='true'}
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
  {grn_image image=$node_image}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-65' replace='true'}
 {else}
  {capture name='grn_report_operation_GRN_RPRT_OP_66'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-66' replace='true'}{/capture}{grn_link image=$node_image page=$page_info.all caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_66} &gt; 
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

  <div class="tree_item"><div class="sub_title">{if $is_root}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-67' replace='true'}{else}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-68' replace='true'}{/if}{$node_name|escape}</div></div>
{foreach from=$node.children item=item}
  <div class="tree_item">
  {grn_link image=$node_image page=$page_info.all nid=$item.nid caption=$item.name}
  {if $item.child_count}({$item.child_count}){/if}
  </div>
{foreachelse}
  <div><nobr>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-69' replace='true'}{if $node_id}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-70' replace='true'}{/if}{$node_name|escape}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-71' replace='true'}</nobr></div>
{/foreach}

  </td>
  <td id="view_part" width="70%">

{if $node_id}
  <div id="main_menu_part">
   {strip}
    {capture name='grn_report_operation_GRN_RPRT_OP_72'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-72' replace='true'}{/capture}
     <span class="menu_item">
      {if $is_manage}
       {grn_link image='modify20.gif' page="`$page_prefix`access_list" nid=$node_id reset=1 caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_72}
      {else}
       {grn_link image='modify20.gif' page="`$page_prefix`access_list" nid=$node_id reset=1 caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_72 disabled=true}
      {/if}
     </span>
    {/strip}
  </div>

  <p>
  <div>
  <span class="sub_title">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-74' replace='true'}</span>
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
    <th nowrap>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-75' replace='true'}</th>
    <td nowrap>{grn_image image='access20.gif'}{$access.security_model|upper}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-76' replace='true'}{if $access.security_model == 'revoke'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-77' replace='true'}{else}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-78' replace='true'}{/if}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-79' replace='true'}</td>
   </tr>
   <tr>
    <th nowrap>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-80' replace='true'}</th>
    <td align="right">{$access.count}</td>
   </tr>
  </table>
{/if}

  </td>
 </tr>
</table>

{include file="grn/footer.tpl"}
