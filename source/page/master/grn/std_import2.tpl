{**
 *  @param  string  config_id   (option)    'system' or 'prsonal'
 *  @param  string  app_id      (option)    application id
 *  @param  string  form_name   (option)    name attribute of form tag
 *  @param  string  post_page               page to POST
 *  @param  string  explanation (option)    explanation for delete operation
 *  @param  array   form                    form data structure
 *  @option string  prev_button             previous button form html
 *  @option string  cancel_button           cancel button form html
**}
{* header *}
{if $config_id}
 {include file="grn/`$config_id`_head.tpl"}
 {include file="grn/`$config_id`_header.tpl"}
{elseif $page_info.parts[0] == 'system'}
 {assign var='config_id' value='system'}
 {include file='grn/system_head.tpl'}
 {include file='grn/system_header.tpl'}
{elseif $page_info.parts[1] == 'system'}
 {assign var='config_id' value='system'}
 {include file='grn/system_head.tpl'}
 {include file='grn/system_header.tpl'}
{elseif $page_info.parts[0] == 'personal'}
 {assign var='config_id' value='personal'}
 {include file='grn/personal_head.tpl'}
 {include file='grn/personal_header.tpl'}
{elseif $page_info.parts[1] == 'personal'}
 {assign var='config_id' value='personal'}
 {include file='grn/personal_head.tpl'}
 {include file='grn/personal_header.tpl'}
{else}
 {include file='grn/head.tpl'}
 {include file='grn/header.tpl'}
{/if}

<!--page_title-->
{if $page_title}
 {grn_title title=$page_title|cat:' - Step 2/2' class=$page_info.parts[0]}
{/if}

<!--main-->
{** ポストページの指定がない場合は規約に従ってページ名を自動生成 **}
{if ! $post_page}
 {assign var='command_page' value=''}
 {foreach name='command_page' from=$page_info.parts item=part}
  {if $command_page}
   {assign var='command_page' value=$command_page|cat:'/'}
  {/if}
  {if $smarty.foreach.command_page.last}
   {assign var='command_page' value=$command_page|cat:'command_'}
  {/if}
  {assign var='command_page' value=$command_page|cat:$part}
 {/foreach}
 {assign var='post_page' value=$command_page}
{/if}

{if ! $form_name}{assign var='form_name' value=$page_info.all}{/if}
<form name="{$form_name}" method="post" action="{grn_pageurl page=$post_page}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{** 注意書き **}
{if $explanation}
  <div class="explanatin">{$explanation}</div>
{/if}

{** プレビューテーブルの表示 **}
{include file='grn/csv_preview.tpl' datas=$csv_datas columns=$items}

{** 操作ボタン **}
{if $prev_button}
      {$prev_button|grn_noescape}
{elseif $prev_page}
      {capture name='grn_grn_GRN_GRN_351'}{cb_msg module='grn.grn' key='GRN_GRN-351' replace='true'}{/capture}{grn_button_cancel class="margin" page=$prev_page charset=$charset skip=$skip caption="<< "|cat:$smarty.capture.grn_grn_GRN_GRN_351}
{else}
      {capture name='grn_grn_GRN_GRN_352'}{cb_msg module='grn.grn' key='GRN_GRN-352' replace='true'}{/capture}{grn_button_cancel class="margin" caption="<< "|cat:$smarty.capture.grn_grn_GRN_GRN_352}
{/if}
      {capture name='grn_grn_GRN_GRN_353'}{cb_msg module='grn.grn' key='GRN_GRN-353' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_grn_GRN_GRN_353}
{if $cancel_button}
      {$cancel_button|grn_noescape}
{elseif $config_id && $app_id}
      {grn_button_cancel class="margin" page="`$config_id`/application_list" app_id=$app_id}
{else}
      {grn_button_cancel class="margin"}
{/if}

</p>

{if $items || $column_explanation}
<hr>
<p>
{** 読み込むカラムの説明 **}
{include file='grn/csv_columns.tpl' columns=$items column_explanation=$column_explanation type='import'}
{/if}


<input type="hidden" name="charset" value="{$charset}">
<input type="hidden" name="skip" value="{$skip}">
<input type="hidden" name="file_id" value="{$file_id}">
<input type="hidden" name="old" value="{$old}">
{foreach from=$form.hiddens key=key item=item}
<input type='hidden' name='{$key}' value='{$item}'>
{/foreach}
</form>

<!--footer-->
{if $config_id}
 {include file="grn/`$config_id`_footer.tpl"}
{else}
 {include file="grn/footer.tpl"}
{/if}
