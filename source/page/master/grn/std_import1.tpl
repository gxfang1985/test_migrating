{**
 *  @param  string  config_id   (option)    'system' or 'prsonal'
 *  @param  string  app_id      (option)    application id
 *  @param  string  form_name   (option)    name attribute of form tag
 *  @param  string  post_page               page to POST
 *  @param  string  cancel_page (option)    page to cancel
 *  @param  string  explanation (option)    explanation for delete operation
 *  @param  array   form                    form data structure
 *  @param  string  id (option)             id param
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
 {grn_title title=$page_title|cat:' - Step 1/2' class=$page_info.parts[0]}
{/if}

<!--main-->
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
<form name="{$form_name}" method="post" action="{grn_pageurl page=$post_page}" enctype='multipart/form-data'><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{if $explanation}
  <div class="explanation">{$explanation}</div>
  <p>
{/if}

<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_grn_GRN_GRN_930'}{cb_msg module='grn.grn' key='GRN_GRN-930' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_grn_GRN_GRN_930 necessary=1}</th>
  <td>{capture name='grn_grn_GRN_GRN_931'}{cb_msg module='grn.grn' key='GRN_GRN-931' replace='true'}{/capture}{validate form=$form_name field='file:file' criteria='grn_notFileEmpty' message=$smarty.capture.grn_grn_GRN_GRN_931 append='validation_errors'}{grn_file name='file' size='50' necessary=1 disable_return_key=true}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-932' replace='true'}</th>
  <td>{grn_charset name='charset' default=$charset}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-933' replace='true'}</th>
  <td>
     {if $skip}
      {capture name='grn_grn_GRN_GRN_934'}{cb_msg module='grn.grn' key='GRN_GRN-934' replace='true'}{/capture}{grn_radio name="skip" id="yes" value="1" caption=$smarty.capture.grn_grn_GRN_GRN_934 checked=1}&nbsp;{capture name='grn_grn_GRN_GRN_935'}{cb_msg module='grn.grn' key='GRN_GRN-935' replace='true'}{/capture}{grn_radio name="skip" id="no" value="0" caption=$smarty.capture.grn_grn_GRN_GRN_935 checked=0}
     {else}
      {capture name='grn_grn_GRN_GRN_936'}{cb_msg module='grn.grn' key='GRN_GRN-936' replace='true'}{/capture}{grn_radio name="skip" id="yes" value="1" caption=$smarty.capture.grn_grn_GRN_GRN_936 checked=0}&nbsp;{capture name='grn_grn_GRN_GRN_937'}{cb_msg module='grn.grn' key='GRN_GRN-937' replace='true'}{/capture}{grn_radio name="skip" id="no" value="0" caption=$smarty.capture.grn_grn_GRN_GRN_937 checked=1}
     {/if}
  </td>
 </tr>
 {if $enable_old_format}
 <tr>
   <th nowrap>{cb_msg module='grn.grn' key='GRN_GRN-1519' replace='true'}</th>
   <td>
     {capture name='grn_grn_GRN_GRN_1520'}{cb_msg module='grn.grn' key='GRN_GRN-1520' replace='true'}{/capture}
     {grn_checkbox name="old" id="old" value="1" caption=$smarty.capture.grn_grn_GRN_GRN_1520 checked=$old}<br />
     {cb_msg module='grn.grn' key='GRN_GRN-1521' replace='true'}
     <script>{literal}
         jQuery(function () {
             jQuery("#old").on("click", function () {
                 if (jQuery("#old").prop("checked")) {
                     jQuery(".new-column").each(function () {
                         jQuery(this).hide();
                     });
                 }
                 else {
                     jQuery(".new-column").each(function () {
                         jQuery(this).show();
                     });
                 }

                 jQuery(".column-number").each(function (index, columnNumberElement) {
                     function _filter(a, f) {
                         var ret = [];
                         for (var i = 0; i < a.length; i++) {
                             if (f(a[i]))
                                 ret[ret.length] = a[i];
                         }
                         return ret;
                     }

                     var import_notes_data = _filter(jQuery(columnNumberElement.parentNode).prevAll(), function (e) {
                         return jQuery(e).is(":visible");
                     });
                     columnNumberElement.innerHTML = (jQuery(import_notes_data).length + 1).toString() + ".";
                 });
             });
         });
     </script>{/literal}
   </td>
 {/if}
 <tr>
  <td></td>
  <td>
     {* SP2 IE対策 *}
     <input class="margin" type="submit" name="send" value="{cb_msg module='grn.grn' key='GRN_GRN-938' replace='true'} >>">
     {* {grn_button_submit class='margin' caption="次へ >>"} *}
{if $cancel_button}
    {$cancel_button|grn_noescape}
{elseif $cancel_page}
    {if $id}
        {grn_button_cancel class='margin' page=$cancel_page id=$id}
    {else}
        {grn_button_cancel class='margin' page=$cancel_page}
    {/if}
{elseif $config_id && $app_id}
     {grn_button_cancel class='margin' page="`$config_id`/application_list" app_id=$app_id}
{else}
     {grn_button_cancel class='margin'}
{/if}
  </td>
 </tr>
</table>

{if $items || $column_explanation}
<hr>
<p>
{include file='grn/csv_columns.tpl' columns=$items column_explanation=$column_explanation type='import'}
{/if}

{foreach from=$form.hiddens key=key item=item}
<input type='hidden' name='{$key}' value='{$item}'>
{/foreach}

</form>

<!--footer-->
{if $config_id}
 {include file="grn/`$config_id`_footer.tpl"}
{else}
 {include file='grn/footer.tpl'}
{/if}
