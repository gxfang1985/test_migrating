{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}

<!--menubar-->
<div id="main_menu_part">
    <span class="float_left nowrap-grn">
        {if $file.locked != 'other'}
            <span class="menu_item">{capture name='grn_cabinet_system_GRN_CAB_SY_47'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-47' replace='true'}{/capture}{grn_link page='cabinet/system/move'   caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_47 image='move20.gif'   hid=$folder_id fid=$file_id class='menu_item' alt=''}</span>
            <span class="menu_item">{capture name='grn_cabinet_system_GRN_CAB_SY_48'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-48' replace='true'}{/capture}{grn_link page='cabinet/system/delete' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_48 image='delete20.gif' hid=$folder_id fid=$file_id class='menu_item' alt=''}</span>
        {else}
            <span class="menu_item">{capture name='grn_cabinet_system_GRN_CAB_SY_49'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-49' replace='true'}{/capture}{grn_link page='cabinet/system/move'   caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_49 image='move20.gif'   hid=$folder_id fid=$file_id class='menu_item' disabled=1 alt=''}</span>
            <span class="menu_item">{capture name='grn_cabinet_system_GRN_CAB_SY_50'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-50' replace='true'}{/capture}{grn_link page='cabinet/system/delete' caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_50 image='delete20.gif' hid=$folder_id fid=$file_id class='menu_item' disabled=1 alt=''}</span>
        {/if}
    </span>
    <span class="float_right nowrap-grn mBottom2">
        <div class="moveButtonBlock-grn">
            {grn_previous_next_navi previous=$navi.prev next=$navi.next}
        </div>
    </span>
    <div class="clear_both_0px"></div>
</div>

{if strlen($file.title) < 1}
    {grn_title title=$file.filename class='cabinet inline_block_grn mBottom10' no_style=1}
{else}
    {grn_title title=$file.title class='cabinet inline_block_grn mBottom10' no_style=1}
{/if}

{if $file.locked == 'login'}
    {if $file.auth.write}
        <form name="unlock" method="post" action="{grn_pageurl page='cabinet/system/command_unlock'}">
            <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
            <input type="hidden" name="hid" value="{$folder_id}">
            <input type="hidden" name="fid" value="{$file_id}">
            <div>{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-51' replace='true'}<input type="submit" value="{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-52' replace='true'}"></div>
        </form>
    {/if}
    <p>
{elseif $file.locked == 'other'}
    <form name="unlock" method="post" action="{grn_pageurl page='cabinet/system/command_unlock'}">
        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        <input type="hidden" name="hid" value="{$folder_id}">
        <input type="hidden" name="fid" value="{$file_id}">
        <div>{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-53' replace='true'}&nbsp;{grn_user_name uid=$file.locked_owner_uid name=$file.locked_owner_name}&nbsp;{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-54' replace='true'}<input type="submit" value="{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-55' replace='true'}"></div>
    </form>
    <p>
{/if}

{include file="cabinet/_view.tpl" page_prefix="cabinet/system" folder_page="cabinet/system/folder_list" no_restore=1}

{include file="grn/system_footer.tpl"}
