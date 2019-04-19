{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}

<div id="main_menu_part">
    <span class="float_left nowrap-grn">
        <span class="menu_item">{capture name='grn_system_user_GRN_SY_US_215'}{cb_msg module='grn.system.user' key='GRN_SY_US-215' replace='true'}{/capture}{grn_link page='system/user/role_modify' caption=$smarty.capture.grn_system_user_GRN_SY_US_215 image='modify20.gif' role_id=$role.rid alt=''}</span>
        <span class="menu_item">{capture name='grn_system_user_GRN_SY_US_216'}{cb_msg module='grn.system.user' key='GRN_SY_US-216' replace='true'}{/capture}{grn_link page='system/user/role_user_vest' caption=$smarty.capture.grn_system_user_GRN_SY_US_216 image='user20.gif' role_id=$role.rid reset=1 alt=''}</span>
        {if $role.rid == 1}
            <span class="menu_item">{capture name='grn_system_user_GRN_SY_US_217'}{cb_msg module='grn.system.user' key='GRN_SY_US-217' replace='true'}{/capture}{grn_link page='system/user/role_delete' caption=$smarty.capture.grn_system_user_GRN_SY_US_217 image='delete20.gif' role_id=$role.rid disabled=yes element_id="system-role-delete" alt=''}</span>
        {else}
            <span class="menu_item">{capture name='grn_system_user_GRN_SY_US_218'}{cb_msg module='grn.system.user' key='GRN_SY_US-218' replace='true'}{/capture}{grn_link page='system/user/role_delete' caption=$smarty.capture.grn_system_user_GRN_SY_US_218 image='delete20.gif' role_id=$role.rid element_id="system-role-delete" alt=''}</span>
        {/if}
    </span>
    <span class="float_right nowrap-grn mBottom2">
        <div class="moveButtonBlock-grn">
            {grn_previous_next_navi previous=$navi_params.previous next=$navi_params.next}
        </div>
    </span>
    <div class="clear_both_0px"></div>
</div>

{grn_title title=$page_title class=$page_info.parts[0]|cat:' inline_block_grn mBottom10' no_style=1}

<table class="view_table">
<tr>
<th>{cb_msg module='grn.system.user' key='GRN_SY_US-219' replace='true'}</th>
<td>{$role.title|escape}</td>
</tr>
<tr valign="top">
<th>{cb_msg module='grn.system.user' key='GRN_SY_US-220' replace='true'}</th>
<td>{grn_format body=$role.memo}</td>
</tr>
<tr>
<th>{cb_msg module='grn.system.user' key='GRN_SY_US-221' replace='true'}</th>
<td>{$role.number_of_users}</td>
</tr>
<tr>
<th>{cb_msg module='grn.system.user' key='GRN_SY_US-222' replace='true'}</th>
<td>
{grn_user_name uid=$role.creator_uid name=$role.creator_name deleted_off=TRUE}
{grn_date_format date=$role.ctime format="DateTimeMiddle_YMDW_HM"}
</td>
</tr>
<tr>
<th>{cb_msg module='grn.system.user' key='GRN_SY_US-223' replace='true'}</th>
<td>
{grn_user_name uid=$role.modifier_uid name=$role.modifier_name deleted_off=TRUE}
{grn_date_format date=$role.mtime format="DateTimeMiddle_YMDW_HM"}
</td>
</tt>
</table>

{include file="grn/system_footer.tpl"}
