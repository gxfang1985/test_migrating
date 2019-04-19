{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<!-- 見通しよくナビゲーション -->

<center>
<table border=0>
 <tr align="center">
  <td class="step_grn" valign="middle">{cb_msg module='grn.workflow' key='select_mandator' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_current_grn" valign="middle">{cb_msg module='grn.workflow' key='select_application_form' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_grn" valign="middle">{cb_msg module='grn.workflow' key='enter_contents' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_grn" valign="middle">{cb_msg module='grn.workflow' key='set_path' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_grn" valign="middle">{cb_msg module='grn.workflow' key='confirm_contents' replace='true'}</td>
 </tr>
</table>
</center>

<!-- ここまで　見通しよくナビゲーション -->

<p class="explanation">{cb_msg module='grn.workflow' key='message_select_application_form' replace='true'}</p>

<!--folder_path-->
{include file="workflow/_category_path.tpl" no_search=1 mid=$mandator_id}
<!--folder_path_end-->

<table width="100%">
<tr valign="top">
<td id="tree_part" width="30%">
{include file="workflow/_category_structure.tpl" no_extra=1 mid=$mandator_id}
</td>

<td id="view_part" width="70%">
<div class="margin_bottom">
 <div>
  <span class="bold">{$category.name|escape}</span>
 </div>
</div>
<!-- ##_ここにメインエリア　一覧を入れる_##　-->
<div class="margin_bottom">
</div>
{literal}
<style type="text/css">
<!-- 
.workflow_category_memo{
  width:98%;
  padding:0.8em 0.3em 0.5em 0.8em;
  background-color:#ffffff;
  border:3px double #ccccdd;
  font-size:90%;
  letter-spacing:0.1em;
  line-height:120%;
}
-->
</style>
{/literal}
{if $category.memo}
<div class="workflow_category_memo">
 {grn_format body=$category.memo}
</div>
{/if}

<div style="height:1.0em;"></div>       
</div>
{literal}
<style type="text/css">
<!-- 
.category_hr
{
  font-weight:bold;
  padding:5px,10px,5px,10px;
  border-bottom:2px dotted #999999;
}
-->
</style>
{/literal}
{foreach from=$form_list item=form}
 {if $form.type == 0}
<nobr>
 {grn_workflow_link page='workflow/send_form_proxy' caption=$form.name truncated_caption=$config.subject_width icon_type=$form.icon_type icon_id=$form.icon_id icon_url=$form.icon_url cid=$category_id fid=$form.fid mid=$mandator_id}
</nobr>
<blockquote style="margin-top:0px">
 <tt>
  <font size=+0>
   {grn_format body=$form.memo}
  </font>
 </tt>
</blockquote>
 {else}
<p class="category_hr"></p><!-- 設定機能「区切り線の追加」で指定した区切り線 -->
 {/if}
{/foreach}
 </td>
<tr>
</table>

{include file="grn/footer.tpl"}
