{**
 *  @param  string  config_id   (option)    'system' or 'prsonal'
 *  @param  string  form_name   (option)    name attribute of form tag
 *  @param  string  post_page               page to POST
 *  @param  string  explanation (option)    explanation for form operation
 *  @param  array   order_options           options data structure for select tag
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
<div id="one_parts">

 <!--action-->
 <div id="action">
  <p class="item">
  {grn_change_order form_name=$form_name select_name='id[]' options=$order_options}
  </p>
  <p class="item">
   <div class="contents_button">
    <div classs="word">
    <input class="margin" type="submit" value="{cb_msg module='grn.grn' key='GRN_GRN-321' replace='true'}" onclick="grn_onsubmit_common(this.form);">
    {grn_button_cancel}
    </div>
   </div>
  </p>
 </div>
</div>
</form>

<!--footer-->
{if $config_id}
 {include file="grn/`$config_id`_footer.tpl"}
{else}
 {include file='grn/footer.tpl'}
{/if}
