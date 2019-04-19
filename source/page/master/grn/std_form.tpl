{**
 *  @param  string  config_id   (option)    'system' or 'prsonal'
 *  @param  string  form_name   (option)    name attribute of form tag
 *  @param  string  post_page               page to POST
 *  @param  string  explanation (option)    explanation for form operation
 *  @param  array   form                    form data structure
**}

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
<div class="explanation">{$explanation}</div>
{/if}

<p>
{include file='grn/show_validation_errors.tpl'}
{if $attention}
{include file='grn/indispensable.tpl'}
{/if}
<table class="std_form">
{foreach from=$form.items key=key item=item}
 {if $item.type == 'multiple_string'}
 <tr valign="top">
 {else}
 <tr>
 {/if}
  <th nowrap>{grn_show_input_title title=$item.display_name necessary=$item.necessary}</th>
  <td>
 {if $item.necessary}
  {capture name='grn_grn_GRN_GRN_1336'}{cb_msg module='grn.grn' key='GRN_GRN-1336' replace='true'}{/capture}{validate form=$form_name field=$key criteria="notEmpty" message=$item.display_name|cat:$smarty.capture.grn_grn_GRN_GRN_1336 transform="cb_trim" append="validation_errors"}
 {/if}
 {if $item.type == 'string'}
  {if $item.maxlength}{assign var='maxlength' value=$item.maxlength}{else}{assign var='maxlength' value='100'}{/if}
  {grn_text name=$key size='50' disable_return_key=TRUE value=$item.value maxlength=$maxlength}
 {elseif $item.type == 'url'}
  {if $item.maxlength}{assign var='maxlength' value=$item.maxlength}{else}{assign var='maxlength' value='100'}{/if}
   {grn_text name=$key size='50' disable_return_key=TRUE value=$item.value maxlength=$maxlength}
 {elseif $item.type == 'multiple_string'}
   {grn_textarea name=$key cols=$item.cols rows=$item.rows value=$item.value}
 {elseif $item.type == 'checkbox'}
   {grn_checkbox name=$key id="`$key`_`$item.value`" value=$item.value caption=$item.caption checked=$item.checked}
 {elseif $item.type == 'radio'}
  {foreach from=$item.options item=radio_item}
   {grn_radio name=$key id="`$key`_`$radio_item.value`" value=$radio_item.value caption=$radio_item.label checked=$radio_item.checked}
   {if $item.option_br}<br>{/if}
  {/foreach}
 {elseif $item.type == 'select'}
  {grn_select name=$key options=$item.options}
 {/if}
  </td>
 </tr>
{/foreach}
 <tr>
  <td></td>
  <td>
{foreach from=$form.buttons key=key item=item}
 {if $item.type == 'submit'}
  {grn_button_submit class='margin' caption=$item.display_name}
 {elseif $item.type == 'cancel'}
  {if ! $item.page}
   {grn_button_cancel class='margin'}
  {elseif $item.app_id}
   {grn_button_cancel class='margin' page=$item.page app_id=$item.app_id}
  {else}
   {grn_button_cancel class='margin' page=$item.page}
  {/if}
 {/if}
{/foreach}
  </td>
 </tr>
</table>

<!--hidden-->
{foreach from=$form.hiddens key=key item=item}
<input type='hidden' name='{$key}' value='{$item}'>
{/foreach}
<!--hidden_end-->

</form>






{if $config_id}
 {include file="grn/`$config_id`_footer.tpl"}
{else}
 {include file='grn/footer.tpl'}
{/if}
