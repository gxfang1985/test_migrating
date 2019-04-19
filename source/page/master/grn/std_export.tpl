{**
 *  @param  string  config_id   (option)    'system' or 'prsonal'
 *  @param  string  app_id      (option)    application id
 *  @param  string  form_name   (option)    name attribute of form tag
 *  @param  string  post_page               page to POST
 *  @param  string  explanation (option)    explanation for delete operation
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
<form name="{$form_name}" method="post" action="{grn_pageurl page=$post_page postfix=$postfix}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{if $explanation}
  <div class="explanation">{$explanation}</div>
{/if}

<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-1400' replace='true'}</th>
  <td>{grn_charset name='charset' bom='TRUE'}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-1401' replace='true'}</th>
  <td>
      {capture name='grn_grn_GRN_GRN_1402'}{cb_msg module='grn.grn' key='GRN_GRN-1402' replace='true'}{/capture}{grn_radio name='item_name' id='yes' value='1' caption=$smarty.capture.grn_grn_GRN_GRN_1402 checked=0}&nbsp;{capture name='grn_grn_GRN_GRN_1403'}{cb_msg module='grn.grn' key='GRN_GRN-1403' replace='true'}{/capture}{grn_radio name='item_name' id='no' value='0' caption=$smarty.capture.grn_grn_GRN_GRN_1403 checked=1}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_grn_GRN_GRN_1404'}{cb_msg module='grn.grn' key='GRN_GRN-1404' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_grn_GRN_GRN_1404}
{if $config_id && $app_id}
       {grn_button_cancel class='margin' page="`$config_id`/application_list" app_id=$app_id}
{else}
       {grn_button_cancel class='margin'}
{/if}
  </td>
 </tr>
</table>

{foreach from=$form.hiddens key=key item=item}
<input type='hidden' name='{$key}' value='{$item}'>
{/foreach}

</form>

{if $columns || $column_explanation}
<hr>
<p>
{include file='grn/csv_columns.tpl' columns=$columns column_explanation=$column_explanation type='export'}
{/if}


<!--footer-->
{if $config_id}
 {include file="grn/`$config_id`_footer.tpl"}
{else}
 {include file="grn/footer.tpl"}
{/if}
