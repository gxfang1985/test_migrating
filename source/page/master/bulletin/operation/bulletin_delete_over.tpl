{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{if ! $articles.delete_numbers}
 <p>
{cb_msg module='grn.bulletin.operation' key='GRN_BLLT_OP-24' replace='true'}
</p>
 <p>
  <input type="button" value="{cb_msg module='grn.bulletin.operation' key='GRN_BLLT_OP-25' replace='true'}" onclick="history.back()">
 </p>
{else}
 {if $delete_continue}
<p>
{cb_msg module='grn.bulletin.operation' key='GRN_BLLT_OP-26' replace='true'}<br>
{cb_msg module='grn.bulletin.operation' key='GRN_BLLT_OP-27' replace='true'}
</p> 
 {/if}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/operation/command_bulletin_delete_over'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
 {cb_msg module='grn.bulletin.operation' key='GRN_BLLT_OP-28' replace='true'}{grn_sentence caption=$category_name image='category20.gif' class='bold'}{cb_msg module='grn.bulletin.operation' key='GRN_BLLT_OP-29' replace='true'}<span class="bold">{$articles.delete_numbers}</span>{cb_msg module='grn.bulletin.operation' key='GRN_BLLT_OP-30' replace='true'}
<div class="attention">{cb_msg module='grn.bulletin.operation' key='GRN_BLLT_OP-31' replace='true'}</div>
</p>
 <p>
  {capture name='grn_bulletin_operation_GRN_BLLT_OP_32'}{cb_msg module='grn.bulletin.operation' key='GRN_BLLT_OP-32' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_bulletin_operation_GRN_BLLT_OP_32}
  {capture name='grn_bulletin_operation_GRN_BLLT_OP_33'}{cb_msg module='grn.bulletin.operation' key='GRN_BLLT_OP-33' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_bulletin_operation_GRN_BLLT_OP_33}
 </p>
<input type="hidden" name="cid" value="{$category_id}">
</form>
{/if}
{include file="grn/footer.tpl"}

