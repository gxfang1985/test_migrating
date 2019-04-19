{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}

<!--menubar-->
<div id="main_menu_part">
    <span class="float_left nowrap-grn">
        {if $user.privileged}
            <span class="menu_item">{capture name='grn_system_user_GRN_SY_US_225'}{cb_msg module='grn.system.user' key='GRN_SY_US-225' replace='true'}{/capture}{grn_link class='menu_item' image='modify20.gif' page="$dir_name/org_user_modify" caption=$smarty.capture.grn_system_user_GRN_SY_US_225 oid=$org_id uid=$user_id alt=''}</span>
            {if !$is_sandbox_page}
                <span class="menu_item">{capture name='grn_system_user_GRN_SY_US_226'}{cb_msg module='grn.system.user' key='GRN_SY_US-226' replace='true'}{/capture}{grn_link class='menu_item' image='delete20.gif' page="$dir_name/org_user_delete" caption=$smarty.capture.grn_system_user_GRN_SY_US_226 oid=$org_id uid=$user_id disabled=$is_super alt=''}</span>
            {/if}
            {if !$license_deny}
                <span class="menu_item">{capture name='grn_system_user_GRN_SY_US_227'}{cb_msg module='grn.system.user' key='GRN_SY_US-227' replace='true'}{/capture}{grn_link class='menu_item' image='organize20.gif' page="$dir_name/org_user_belong" caption=$smarty.capture.grn_system_user_GRN_SY_US_227 oid=$org_id uid=$user_id reset=1 alt=''}</span>
                {if $is_admin}
                    <span class="menu_item">{capture name='grn_system_user_GRN_SY_US_228'}{cb_msg module='grn.system.user' key='GRN_SY_US-228' replace='true'}{/capture}{grn_link class='menu_item' image='role20.gif' page="$dir_name/org_user_role_modify" caption=$smarty.capture.grn_system_user_GRN_SY_US_228 oid=$org_id uid=$user_id reset=1 alt=''}</span>
                {/if}
            {/if}
        {else}
            &nbsp;
        {/if}
    </span>
    <span class="float_right nowrap-grn mBottom2">
        <div class="moveButtonBlock-grn">
            {grn_previous_next_navi previous=$navi_params.previous next=$navi_params.next}
        </div>
    </span>
    <div class="clear_both_0px"></div>
</div>
<!--menubar_end-->

{grn_title title=$user.display_name class=$page_info.parts[0]|cat:' inline_block_grn mBottom10' no_style=1}
{if $is_sandbox_page}{include file="system/user/sandbox/_sandbox_title_label.tpl"}{/if}

<table class="view_table">
   <!--builtin_items-->
{foreach from=$builtin_items key=item_id item=item}
    {if $item.use && (
        $item_id == 'display_name' ||
        $item_id == 'foreign_key' ||
        $item_id == 'locale' ||
        $item_id == 'base' ||
        $item_id == 'usergroups' ||
        $item_id == 'primary_group'
        )}
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

<tr valign="top">{* ROLE *}
<th>{cb_msg module='grn.system.user' key='GRN_SY_US-231' replace='true'}</th>
<td>
{foreach from=$user.roles key=key item=item}
{$item.foreign_key|escape}<br>
{/foreach}
</td>
</tr>
<tr valign="top"> {* POSITION *}
<th>{cb_msg module='grn.system.user' key='GRN_SY_US-232' replace='true'}</th>
<td>{if $user.position == GRN_UUM_USER_MAX_POSITION}{cb_msg module='grn.system.user' key='GRN_SY_US-233' replace='true'}{else}{$user.position|escape}{/if}</td>
</tr>
<tr valign="top">{* VALID *}
<th>{cb_msg module='grn.system.user' key='GRN_SY_US-234' replace='true'}</th>
<td>{if $user.valid}<span class="font_green">{cb_msg module='grn.system.user' key='GRN_SY_US-235' replace='true'}</span>{else}<span class="font_red">{cb_msg module='grn.system.user' key='GRN_SY_US-236' replace='true'}</span>{/if}</td>
</tr>
   <!--builtin_items-->
{foreach from=$builtin_items key=item_id item=item}
    {if $item.use && (
        $item_id != 'display_name' &&
        $item_id != 'foreign_key' &&
        $item_id != 'usergroups' &&
        $item_id != 'primary_group' &&
        $item_id != 'attendee' &&
        $item_id != 'locale' &&
        $item_id != 'base' &&
        $item_id != 'display_name_language' &&
        $item_id != 'nickname'
        )}
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
{if !$is_sandbox_page}
    <tr>
        <th>{cb_msg module='grn.system.user' key='GRN_SY_US-237' replace='true'}</th>
        <td>
            {grn_user_name uid=$user.creator_uid name=$user.creator_name deleted_off=TRUE}
            {grn_date_format date=$user.ctime format="DateTimeMiddle_YMDW_HM"}
        </td>
    </tr>
    <tr>
        <th>{cb_msg module='grn.system.user' key='GRN_SY_US-238' replace='true'}</th>
        <td>
            {grn_user_name uid=$user.modifier_uid name=$user.modifier_name deleted_off=TRUE}
            {grn_date_format date=$user.mtime format="DateTimeMiddle_YMDW_HM"}
        </td>
    </tr>
{/if}
</table>

{include file='grn/system_footer.tpl'}
