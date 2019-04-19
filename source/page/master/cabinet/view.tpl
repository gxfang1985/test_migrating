{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
{grn_delete title=$lock_info.title page=$lock_info.page no_confirm=$lock_info.no_confirm data=$lock_info.data handler=$lock_info.handler}

<!--menubar-->
<div id="main_menu_part">
    <span class="float_left nowrap-grn">
        {if $file.auth.write}
            {if $file.locked != 'other'}
                {if $lockable}
                    {if $file.locked == 'login'}
                        <span class="aButtonStandard-grn"><button id="btn_lock" type="button" tabindex="0" title="{cb_msg module='grn.cabinet' key='GRN_CAB-155' replace='true'}" aria-label="{cb_msg module='grn.cabinet' key='GRN_CAB-155' replace='true'}" class="mRight10">{cb_msg module='grn.cabinet' key='GRN_CAB-155' replace='true'}</button></span>
                    {else}
                        <span class="aButtonStandard-grn"><button id="btn_lock" type="button" tabindex="0" title="{cb_msg module='grn.cabinet' key='GRN_CAB-156' replace='true'}" aria-label="{cb_msg module='grn.cabinet' key='GRN_CAB-156' replace='true'}" class="mRight10">{cb_msg module='grn.cabinet' key='GRN_CAB-156' replace='true'}</button></span>
                    {/if}
                {else}
                    <span class="aButtonStandard-grn"><button id="btn_lock" type="button" tabindex="0" title="{cb_msg module='grn.cabinet' key='GRN_CAB-157' replace='true'}" aria-label="{cb_msg module='grn.cabinet' key='GRN_CAB-157' replace='true'}" class="mRight10">{cb_msg module='grn.cabinet' key='GRN_CAB-157' replace='true'}</button></span>
                {/if}
                <span class="menu_item">{capture name='grn_cabinet_GRN_CAB_158'}{cb_msg module='grn.cabinet' key='GRN_CAB-158' replace='true'}{/capture}{grn_link page='cabinet/modify' caption=$smarty.capture.grn_cabinet_GRN_CAB_158 image='modify20.gif' hid=$folder_id fid=$file_id class='menu_item' alt=''}</span>
            {else}
                <span class="aButtonStandard-grn button_disable_filter_grn"><button type="button" tabindex="0" title="{cb_msg module='grn.cabinet' key='GRN_CAB-159' replace='true'}" aria-label="{cb_msg module='grn.cabinet' key='GRN_CAB-159' replace='true'}" class="mRight10" aria-disabled="true">{cb_msg module='grn.cabinet' key='GRN_CAB-159' replace='true'}</button></span>
                <span class="menu_item">{capture name='grn_cabinet_GRN_CAB_160'}{cb_msg module='grn.cabinet' key='GRN_CAB-160' replace='true'}{/capture}{grn_link page='cabinet/modify' caption=$smarty.capture.grn_cabinet_GRN_CAB_160 image='modify20.gif' hid=$folder_id fid=$file_id class='menu_item' disabled=1 alt=''}</span>
            {/if}
            {if $file.locked != 'other'}
                <span class="menu_item">{capture name='grn_cabinet_GRN_CAB_161'}{cb_msg module='grn.cabinet' key='GRN_CAB-161' replace='true'}{/capture}{grn_link page='cabinet/move'   caption=$smarty.capture.grn_cabinet_GRN_CAB_161 image='move20.gif'   hid=$folder_id fid=$file_id class='menu_item' alt=''}</span>
                <span class="menu_item">{capture name='grn_cabinet_GRN_CAB_162'}{cb_msg module='grn.cabinet' key='GRN_CAB-162' replace='true'}{/capture}{grn_link page='cabinet/delete' caption=$smarty.capture.grn_cabinet_GRN_CAB_162 image='delete20.gif' hid=$folder_id fid=$file_id class='menu_item' id='lnk_delete' script="javascript:void(0);" alt=''}</span>
            {else}
                <span class="menu_item">{capture name='grn_cabinet_GRN_CAB_163'}{cb_msg module='grn.cabinet' key='GRN_CAB-163' replace='true'}{/capture}{grn_link page='cabinet/move'   caption=$smarty.capture.grn_cabinet_GRN_CAB_163 image='move20.gif'   hid=$folder_id fid=$file_id class='menu_item' disabled=1 alt=''}</span>
                <span class="menu_item">{capture name='grn_cabinet_GRN_CAB_164'}{cb_msg module='grn.cabinet' key='GRN_CAB-164' replace='true'}{/capture}{grn_link page='cabinet/delete' caption=$smarty.capture.grn_cabinet_GRN_CAB_164 image='delete20.gif' hid=$folder_id fid=$file_id class='menu_item' disabled=1 id='lnk_delete' script="javascript:void(0);" alt=''}</span>
            {/if}
        {elseif $folder.privileges.operation}
            {if $file.locked != 'other'}
                <span class="menu_item">{capture name='grn_cabinet_GRN_CAB_165'}{cb_msg module='grn.cabinet' key='GRN_CAB-165' replace='true'}{/capture}{grn_link page='cabinet/move'   caption=$smarty.capture.grn_cabinet_GRN_CAB_165 image='move20.gif'   hid=$folder_id fid=$file_id class='menu_item' alt=''}</span>
                <span class="menu_item">{capture name='grn_cabinet_GRN_CAB_166'}{cb_msg module='grn.cabinet' key='GRN_CAB-166' replace='true'}{/capture}{grn_link page='cabinet/delete' caption=$smarty.capture.grn_cabinet_GRN_CAB_166 image='delete20.gif' hid=$folder_id fid=$file_id class='menu_item' id='lnk_delete' script="javascript:void(0);" alt=''}</span>
            {else}
                <span class="menu_item">{capture name='grn_cabinet_GRN_CAB_167'}{cb_msg module='grn.cabinet' key='GRN_CAB-167' replace='true'}{/capture}{grn_link page='cabinet/move'   caption=$smarty.capture.grn_cabinet_GRN_CAB_167 image='move20.gif'   hid=$folder_id fid=$file_id class='menu_item' disabled=1 alt=''}</span>
                <span class="menu_item">{capture name='grn_cabinet_GRN_CAB_168'}{cb_msg module='grn.cabinet' key='GRN_CAB-168' replace='true'}{/capture}{grn_link page='cabinet/delete' caption=$smarty.capture.grn_cabinet_GRN_CAB_168 image='delete20.gif' hid=$folder_id fid=$file_id class='menu_item' disabled=1 id='lnk_delete' script="javascript:void(0);" alt=''}</span>
            {/if}
        {else}
            {grn_image image='spacer20.gif'}
        {/if}
    </span>

    <span class="float_right nowrap-grn mBottom2">
        <div class="moveButtonBlock-grn">
            {grn_previous_next_navi previous=$navi.prev next=$navi.next}
        </div>
    </span>
    <div class="clear_both_0px"></div>
</div>

{include file="star/star_init.tpl" list_id="star_list" use_star=$use_star}
<div id="star_list">
    {if $use_star}
        {grn_star_icon module="grn.cabinet" star_infos=$star_infos unique_id=$file_id fid=$file_id hid=$folder_id no_style=1}
    {/if}
    {if strlen($file.title) < 1}
        {grn_title title=$file.filename class='cabinet inline_block_grn mBottom10' no_style=1}
    {else}
        {grn_title title=$file.title class='cabinet inline_block_grn mBottom10' no_style=1}
    {/if}
</div>

{if $file.locked == 'login'}
    {if $file.auth.write}
        <form name="unlock" method="post" action="{grn_pageurl page='cabinet/command_unlock'}">
            <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
            <input type="hidden" name="hid" value="{$folder_id}">
            <input type="hidden" name="fid" value="{$file_id}">
            <div>{cb_msg module='grn.cabinet' key='GRN_CAB-169' replace='true'}<input type="submit" value="{cb_msg module='grn.cabinet' key='GRN_CAB-170' replace='true'}"></div>
        </form>
    {/if}
    <p>
{elseif $file.locked == 'other'}
    {if $folder.privileges.operation}
        <form name="unlock" method="post" action="{grn_pageurl page='cabinet/command_unlock'}">
            <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
            <input type="hidden" name="hid" value="{$folder_id}">
            <input type="hidden" name="fid" value="{$file_id}">
            <div>{cb_msg module='grn.cabinet' key='GRN_CAB-171' replace='true'}&nbsp;{grn_user_name uid=$file.locked_owner_uid name=$file.locked_owner_name}&nbsp;{cb_msg module='grn.cabinet' key='GRN_CAB-172' replace='true'}<input type="submit" value="{cb_msg module='grn.cabinet' key='GRN_CAB-173' replace='true'}"></div>
        </form>
    {else}
        <div>{cb_msg module='grn.cabinet' key='GRN_CAB-174' replace='true'}&nbsp;{grn_user_name uid=$file.locked_owner_uid name=$file.locked_owner_name}&nbsp;{cb_msg module='grn.cabinet' key='GRN_CAB-175' replace='true'}</div>
    {/if}
    <p>
{/if}

{include file="cabinet/_view.tpl" folder_page='cabinet/index'}

{include file="grn/footer.tpl"}
