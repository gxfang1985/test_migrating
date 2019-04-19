{**
 *  @param  string  config_id   (option)    'system' or 'prsonal'
 *  @param  string  form_name   (option)    name attribute of form tag
 *  @param  string  post_page               page to POST
 *  @param  string  explanation (option)    explanation for delete operation
 *  @param  array   target                  target object to delete
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
{elseif $target.instance.display_name}
 <p>{$target.class.display_name|escape}{cb_msg module='grn.grn' key='GRN_GRN-274' replace='true'}<span class="bold">{if $image}{grn_image image=$image}{/if}{$target.instance.display_name|escape}</span>{cb_msg module='grn.grn' key='GRN_GRN-275' replace='true'}</p>
{/if}
 <p>
  {capture name='grn_grn_GRN_GRN_276'}{cb_msg module='grn.grn' key='GRN_GRN-276' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_grn_GRN_GRN_276}
  {capture name='grn_grn_GRN_GRN_277'}{cb_msg module='grn.grn' key='GRN_GRN-277' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_grn_GRN_GRN_277}
 </p>
 <input type="hidden" name="id" value="{$target.instance.id}">
</form>

<!--footer-->
{if $config_id}
 {include file="grn/`$config_id`_footer.tpl"}
{else}
 {include file='grn/footer.tpl'}
{/if}
