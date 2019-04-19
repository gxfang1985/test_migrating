{**
 *  @param  string  type                読み込みの場合は「import」書き出しの場合は「export」
 *  @param  string  column_explanation  カラムの説明（columnsより優先される）
 *  @param  array   columns             カラム内容を格納した配列
 *  @param  string  sub_explanation     注意書き（読み込みの場合はデフォルト値あり）
 *  @param  string  disable_sub_explanation 注意書きを使用しない
**}

{if $type eq 'import'} 
 {capture name='grn_grn_GRN_GRN_1327'}{cb_msg module='grn.grn' key='GRN_GRN-1327' replace='true'}{/capture}{assign var='config_title' value=$smarty.capture.grn_grn_GRN_GRN_1327} 
 {capture name='grn_grn_GRN_GRN_1328'}{cb_msg module='grn.grn' key='GRN_GRN-1328' replace='true'}{/capture}{assign var='execution_type' value=$smarty.capture.grn_grn_GRN_GRN_1328} 
 {if ! $sub_explanation && ! $disable_sub_explanation}
  {capture name='grn_grn_GRN_GRN_1329'}{cb_msg module='grn.grn' key='GRN_GRN-1329' replace='true'}{/capture}{assign var='sub_explanation' value=$smarty.capture.grn_grn_GRN_GRN_1329} 
 {/if}
{elseif $type eq 'export'} 
 {capture name='grn_grn_GRN_GRN_1330'}{cb_msg module='grn.grn' key='GRN_GRN-1330' replace='true'}{/capture}{assign var='config_title' value=$smarty.capture.grn_grn_GRN_GRN_1330} 
 {capture name='grn_grn_GRN_GRN_1331'}{cb_msg module='grn.grn' key='GRN_GRN-1331' replace='true'}{/capture}{assign var='execution_type' value=$smarty.capture.grn_grn_GRN_GRN_1331} 
{/if} 
<div class="sub_title">{$config_title}{cb_msg module='grn.grn' key='GRN_GRN-1332' replace='true'}</div> 
<table width="100%">
<tr><td class="notes"> 
 {cb_msg module='grn.grn' key='GRN_GRN-1333' replace='true'}{$execution_type}{cb_msg module='grn.grn' key='GRN_GRN-1334' replace='true'} 
 <div class="horizontal"> 
{if $column_explanation}
{$column_explanation|grn_noescape}
{else}
{foreach name='correspondence' from=$columns item=title} 
  <div><span class="bold">{$smarty.foreach.correspondence.iteration}.</span>&nbsp;{$title|escape}</div> 
{/foreach} 
{/if}
 </div> 

{if $sub_explanation && ! $disable_sub_explanation}
 <div class="clear_both"> 
  <span class="sub_explanation">{$sub_explanation|grn_noescape}</span> 
 </div> 
{if $delete_user_message eq TRUE}
<p class="attention">
{cb_msg module='grn.grn' key='GRN_GRN-1335' replace='true'}
</p>
{/if}
{if $limit_number_ip eq TRUE}
<p class="attention">
{cb_msg module='grn.grn' key='GRN_GRN-1560' replace='true'}
</p>
{/if}
{/if}
</td></tr>
</table>
