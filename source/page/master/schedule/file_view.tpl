{* GTM-1136 *}
{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

<div id="main_menu_part">

{if $auth_modify}
    <span class="aButtonStandard-grn"><button type="button" tabindex="0" title="{cb_msg module='grn.schedule' key='GRN_SCH-944' replace='true'}" aria-label="{cb_msg module='grn.schedule' key='GRN_SCH-944' replace='true'}" class="mRight10" onclick="javascript:location.href='{grn_pageurl page=schedule/file_upload event=$event_id fid=$file.id}';">{cb_msg module='grn.schedule' key='GRN_SCH-944' replace='true'}</button></span>

    <span class="menu_item">{capture name='grn_schedule_GRN_SCH_945'}{cb_msg module='grn.schedule' key='GRN_SCH-945' replace='true'}{/capture}{grn_link page='schedule/file_modify' caption=$smarty.capture.grn_schedule_GRN_SCH_945 image='modify20.gif' event=$event_id fid=$file.id alt=''}</span>

    {grn_delete title=$delete_file.title page=$delete_file.page data=$delete_file.data handler=$delete_file.handler}
    <span class="menu_item">{capture name='grn_schedule_GRN_SCH_946'}{cb_msg module='grn.schedule' key='GRN_SCH-946' replace='true'}{/capture}{grn_link page='schedule/file_delete' caption=$smarty.capture.grn_schedule_GRN_SCH_946 image='delete20.gif' event=$event_id fid=$file.id id='lnk_delete' script='javascript:void(0)' alt=''}</span>
{else}
    <span class="aButtonStandard-grn button_disable_filter_grn"><button type="button" tabindex="0" title="{cb_msg module='grn.schedule' key='GRN_SCH-944' replace='true'}" aria-label="{cb_msg module='grn.schedule' key='GRN_SCH-944' replace='true'}" aria-disabled="true" class="mRight10">{cb_msg module='grn.schedule' key='GRN_SCH-944' replace='true'}</button></span>

    <span class="menu_item">{capture name='grn_schedule_GRN_SCH_945'}{cb_msg module='grn.schedule' key='GRN_SCH-945' replace='true'}{/capture}{grn_link page='schedule/file_modify' caption=$smarty.capture.grn_schedule_GRN_SCH_945 image='modify20.gif' event=$event_id fid=$file.id disabled='true' alt=''}</span>

    {grn_delete title=$delete_file.title page=$delete_file.page data=$delete_file.data handler=$delete_file.handler}
    <span class="menu_item">{capture name='grn_schedule_GRN_SCH_946'}{cb_msg module='grn.schedule' key='GRN_SCH-946' replace='true'}{/capture}{grn_link page='schedule/file_delete' caption=$smarty.capture.grn_schedule_GRN_SCH_946 image='delete20.gif' event=$event_id fid=$file.id id='lnk_delete' script='javascript:void(0)' disabled='true' alt=''}</span>
{/if}

{grn_image image='spacer20.gif'}
</div>
<!--menubar_end-->
{grn_title title=$page_title class=$page_info.parts[0]|cat:" inline_block_grn mBottom10" no_style=1}

{include file="grn/file_view.tpl" download_page="schedule/file_download" restore_page="schedule/file_restore" linkparams=$linkparams name_width=$config.name_width}

{include file="grn/footer.tpl"}