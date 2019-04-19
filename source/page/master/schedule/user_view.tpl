{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{assign var='form_name' value=$smarty.template|basename}
<!--menubar-->
<div id="main_menu_part">
 <span class="menu_item">{capture name='grn_schedule_GRN_SCH_528'}{cb_msg module='grn.schedule' key='GRN_SCH-528' replace='true'}{/capture}{grn_link page='schedule/personal_day' caption=$smarty.capture.grn_schedule_GRN_SCH_528 image='cal_pday20.gif' uid=$user_id alt=''}</span>
 <span class="menu_item">{capture name='grn_schedule_GRN_SCH_529'}{cb_msg module='grn.schedule' key='GRN_SCH-529' replace='true'}{/capture}{grn_link page='schedule/personal_week' caption=$smarty.capture.grn_schedule_GRN_SCH_529 image='cal_pweek20.gif' uid=$user_id alt=''}</span>
 <span class="menu_item">{capture name='grn_schedule_GRN_SCH_530'}{cb_msg module='grn.schedule' key='GRN_SCH-530' replace='true'}{/capture}{grn_link page='schedule/group_day' caption=$smarty.capture.grn_schedule_GRN_SCH_530 image='cal_gday20.gif' uid=$user_id gid=$primary_group_id alt=''}</span>
 <span class="menu_item">{capture name='grn_schedule_GRN_SCH_531'}{cb_msg module='grn.schedule' key='GRN_SCH-531' replace='true'}{/capture}{grn_link page='schedule/index' caption=$smarty.capture.grn_schedule_GRN_SCH_531 image='cal_gweek20.gif' uid=$user_id gid=$primary_group_id alt=''}</span>
 <span class="menu_item">{capture name='grn_schedule_GRN_SCH_532'}{cb_msg module='grn.schedule' key='GRN_SCH-532' replace='true'}{/capture}{grn_link page='schedule/add' caption=$smarty.capture.grn_schedule_GRN_SCH_532 image='write20.gif' uid=$user_id referer_key=$referer_key alt=''}</span>
</div>
<!--menubar_end-->
{grn_title title=$builtin_items.display_name.value class=$page_info.parts[0]|cat:" inline_block_grn mBottom10" no_style=1}
<table class="view_table">
   <!--builtin_items-->
{foreach from=$builtin_items key=item_id item=item}
    {if $item.use && $item.show && $item_id!="display_name_language" && $item_id!="nickname"}
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
    {if $item.use && $item.show}
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

{include file='grn/footer.tpl'}
