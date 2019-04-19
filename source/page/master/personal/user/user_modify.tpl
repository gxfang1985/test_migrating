{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" enctype="multipart/form-data" action="{grn_pageurl page='personal/user/command_user_modify'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
{assign var='user_id' value=$login.id}

<table class="std_form">
   <!--builtin_items-->
{foreach from=$builtin_items key=item_id item=item}
    {if $item.use && $item_id != "display_name_language" && $item_id != "nickname"}
<tr valign="top">
  <th nowrap>
        {assign var='not_modify' value=$item.not_modify}
        {if $not_modify}
            {assign var='necessary' value=false}
        {else}
            {assign var='necessary' value=$item.necessary}
        {/if}
        {grn_show_input_title title=$item.display_name necessary=$necessary}
  </th>
  <td>
  {include file='grn/_action_item_modify_contents.tpl'}
  </td>
 </tr>
    {/if}
{/foreach}
   <!--builtin_items_end-->

   <!--exntended_items-->
{foreach from=$extended_items key=item_id item=item}
    {if $item.use}
 <tr valign="top">
  <th nowrap>
        {assign var='not_modify' value=$item.not_modify}
        {if $not_modify}
            {assign var='necessary' value=false}
        {else}
            {assign var='necessary' value=$item.necessary}
        {/if}
        {grn_show_input_title title=$item.display_name necessary=$necessary}
  </th>
  <td>
  {include file='grn/_action_item_modify_contents.tpl'}
  </td>
 </tr>
    {/if}
{/foreach}
   <!--exntended_items_end-->

 <tr>
  <td></td>
  <td>
      {capture name='grn_personal_user_GRN_PRS_US_57'}{cb_msg module='grn.personal.user' key='GRN_PRS_US-57' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_personal_user_GRN_PRS_US_57}
      {grn_button_cancel page='personal/user/user_view'}
  </td>
 </tr>
</table>

</form>

{include file="grn/footer.tpl"}
