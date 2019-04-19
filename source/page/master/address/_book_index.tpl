{**
 *  @param  string  config_id   (option)    'system' or 'prsonal'
 *  @param  string  explanation (option)    explanation for delete operation
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

<div id="one_parts">

 <div id="view">
{if $explanation}
  <div class="explanation">{$explanation}</div>
{else}
  <div class="explanation">{cb_msg module='grn.address' key='GRN_ADDR-131' replace='true'}</div>
{/if}

  <p>
  <table class="admin_list_table">
   <tr>
    <th nowrap>{cb_msg module='grn.address' key='GRN_ADDR-132' replace='true'}</th>
   </tr>
{if $userlist_page}
   <tr>
    <td nowrap>{capture name='grn_address_GRN_ADDR_133'}{cb_msg module='grn.address' key='GRN_ADDR-133' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_address_GRN_ADDR_133 page="address/`$sub_dir``$userlist_page`" image='user20.gif'}</td>
   </tr>
{/if}
{if $private_book_page && $access.private_address}
   <tr valign="top">
    <td nowrap>{capture name='grn_address_GRN_ADDR_134'}{cb_msg module='grn.address' key='GRN_ADDR-134' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_address_GRN_ADDR_134|cat:$application_name page="address/`$sub_dir``$private_book_page`" bid=$private_book_id image='person20.gif'}</td>
   </tr>
{/if}
{if $access.shared_address}
    {foreach from=$books key=key item=item}
   <tr valign="top">
    <td nowrap>{grn_link caption=$item.display_name page="address/`$sub_dir``$shared_book_page`" bid=$key image='person20.gif'}</td>
   </tr>
    {/foreach}
{/if}
  </table>
 </div>

</div>

{if $config_id}
 {include file="grn/`$config_id`_footer.tpl"}
{else}
 {include file='grn/footer.tpl'}
{/if}
