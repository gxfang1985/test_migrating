{**
 *  @param  string  config_id   (option)    'system' or 'prsonal'
 *  @param  string  form_name   (option)    name attribute of form tag
 *  @param  string  post_page               page name to POST
 *  @param  string  explanation (option)    explanation for delete operation
 *  @param  array   target                  target class to delete
**}
{* header *}
{if $config_id}
 {include file="grn/`$config_id`_head.tpl"}
 {include file="grn/`$config_id`_header.tpl"}
{else}
 {include file='grn/head.tpl'}
 {include file='grn/header.tpl'}
{/if}

<!--page_title-->
{if $page_title}
 {grn_title title=$page_title class=$page_info.parts[0]}
{/if}

<!--main-->
{if ! $form_name}{assign var='form_name' value=$page_info.all}{/if}
<form name="{$form_name}" method="post" action="{grn_pageurl page=$post_page}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{if $explanation}
 <p>{$explanation}</p>
{elseif $target.class.display_name}
 <p>{cb_msg module='grn.grn' key='GRN_GRN-1248' replace='true'}<span class="bold">{$target.item_count}</span>{cb_msg module='grn.grn' key='GRN_GRN-1249' replace='true'}{$target.class.display_name}{cb_msg module='grn.grn' key='GRN_GRN-1250' replace='true'}</p>
{/if}
 <p>
  {capture name='grn_grn_GRN_GRN_1251'}{cb_msg module='grn.grn' key='GRN_GRN-1251' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_grn_GRN_GRN_1251}
  {capture name='grn_grn_GRN_GRN_1252'}{cb_msg module='grn.grn' key='GRN_GRN-1252' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_grn_GRN_GRN_1252}
 </p>
{if ! $elem_name}{assign var='elem_name' value='eid[]'}{/if}
{foreach from=$target.items item=item}
<input type="hidden" name="{$elem_name}" value="{$item}">
{/foreach}
</form>

<!--footer-->
{if $config_id}
 {include file="grn/`$config_id`_footer.tpl"}
{else}
 {include file='grn/footer.tpl'}
{/if}
