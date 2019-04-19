{**
 *  @param  string  config_id   (option)    'system' or 'prsonal'
 *  @param  string  explanation (option)    explanation for delete operation
 *  @param  array   form                    form data structure
**}

{if $config_id}
 {include file="grn/`$config_id`_head.tpl"}
 {include file="grn/`$config_id`_header.tpl"}
 {assign var='sub_dir' value="`$config_id`/"}
{else}
 {include file='grn/head.tpl'}
 {include file='grn/header.tpl'}
 {assign var='sub_dir' value=''}
{/if}

{if $page_title}
 {grn_title title=$page_title class=$page_info.parts[0]}
{/if}

<div id="main_menu_part">
{if $modify_page}
<span class="menu_item">{capture name='grn_grn_GRN_GRN_8'}{cb_msg module='grn.grn' key='GRN_GRN-8' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_grn_GRN_GRN_8 page=$modify_page params=$menu_params image='modify20.gif'}</span>
{/if}
{if $delete_page}
  {if !$js_delete}
    <span class="menu_item">{capture name='grn_grn_GRN_GRN_9'}{cb_msg module='grn.grn' key='GRN_GRN-9' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_grn_GRN_GRN_9 page=$delete_page params=$menu_params image='delete20.gif'}</span>
  {else}
    {grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
    <span class="menu_item">{capture name='grn_grn_GRN_GRN_10'}{cb_msg module='grn.grn' key='GRN_GRN-10' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_grn_GRN_GRN_10 image='delete20.gif' id=$lnk_delete_id script='javascript:void(0);'}</span>
  {/if}
{/if}
</div>


<p>
<table class="view_table">
{foreach from=$form.items key=key item=item}
 <tr valign="top">
  <th>{$item.display_name|escape}</th>
  <td>
 {if $item.type == 'email_address'}
  {grn_sender_name name=$item.value}
 {elseif $item.type == 'url'}
  {$item.value|grn_autolink}
 {elseif $item.type == 'multiple_string'}
  {grn_format body=$item.value}
 {else}
  {$item.value|escape}
 {/if}
  </td>
 </tr>
{/foreach}
</table>

{if $config_id}
 {include file="grn/`$config_id`_footer.tpl"}
{else}
 {include file='grn/footer.tpl'}
{/if}
