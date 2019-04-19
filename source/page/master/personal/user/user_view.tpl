{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$builtin_items.display_name.value class=$page_info.parts[0]}

{if $access.modify}
<div id="main_menu_part">
<span class="menu_item">{capture name='grn_personal_user_GRN_PRS_US_16'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-16' replace='true'}{/capture}{grn_link page='personal/user/user_modify' caption=$smarty.capture.grn_personal_user_GRN_PRS_US_16 image='modify20.gif'}</span>
</div>
{/if}

<p>
<table class="view_table">
   <!--builtin_items-->
{foreach from=$builtin_items key=item_id item=item}
    {if $item.use && ($item_id != "display_name_language" && $item_id != "nickname")}
 <tr valign="top">
  <th nowrap>
        {$item.display_name|escape}
  </th>
  <td>
        {capture name='body'}{/capture}
        {include file='grn/_action_item_view_contents.tpl'}
        {if $smarty.capture.body}{if $item.sso == 0}{$smarty.capture.body|grn_noescape}{else}{grn_sso_link caption=$smarty.capture.body sso_id=$item.sso app_id="uum" id_list=$sso}{/if}{/if}
  </td>
 </tr>
    {/if}
{/foreach}
   <!--builtin_items_end-->

   <!--extended_items-->
{foreach from=$extended_items key=item_id item=item}
    {if $item.use}
 <tr valign="top">
  <th nowrap>
        {$item.display_name|escape}
  </th>
  <td>
        {capture name='body'}{/capture}
        {include file='grn/_action_item_view_contents.tpl'}
        {if $smarty.capture.body}{if $item.sso == 0}{$smarty.capture.body|grn_noescape}{else}{grn_sso_link caption=$smarty.capture.body sso_id=$item.sso app_id="uum" id_list=$sso}{/if}{/if}
  </td>
 </tr>
    {/if}
{/foreach}
   <!--extended_items_end-->
</table>

{include file='grn/personal_footer.tpl'}
