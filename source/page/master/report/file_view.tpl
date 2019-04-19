{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

<!--menubar-->
{if $file.modifiable || $file.deletable}
    <div id="main_menu_part">
        {if $file.modifiable}
            {if $file.locked == 'other'}
                <input type="button" value="{cb_msg module='grn.report' key='GRN_RPRT-151' replace='true'}" disabled="true">
                <span class="aButtonStandard-grn button_disable_filter_grn"><button type="button" tabindex="0" title="{cb_msg module='grn.report' key='GRN_RPRT-151' replace='true'}" aria-label="{cb_msg module='grn.report' key='GRN_RPRT-151' replace='true'}" class="mRight10" aria-disabled="true">{cb_msg module='grn.report' key='GRN_RPRT-151' replace='true'}</button></span>
            {else}
                {if $lockable && $file.locked != 'login'}
                    {include file="report/_file_update.tpl" page='report/file_update' fid=$fid cid=$cid rid=$rid follow_id=$follow_id iid=$iid csrf_ticket=$csrf_ticket}
                    <span class="aButtonStandard-grn"><button type="button" tabindex="0" title="{cb_msg module='grn.report' key='GRN_RPRT-152' replace='true'}" aria-label="{cb_msg module='grn.report' key='GRN_RPRT-152' replace='true'}" class="mRight10" onclick="javascript:document.forms.form_file_update.submit();">{cb_msg module='grn.report' key='GRN_RPRT-152' replace='true'}</button></span>
                {else}
                    <span class="aButtonStandard-grn"><button type="button" tabindex="0" title="{cb_msg module='grn.report' key='GRN_RPRT-153' replace='true'}" aria-label="{cb_msg module='grn.report' key='GRN_RPRT-153' replace='true'}" class="mRight10" onclick="javascript:location.href='{grn_pageurl page=report/file_upload fid=$fid cid=$cid rid=$rid follow_id=$follow_id iid=$iid}';">{cb_msg module='grn.report' key='GRN_RPRT-153' replace='true'}</button></span>
                {/if}
            {/if}
            <span class="menu_item">{capture name='grn_report_GRN_RPRT_154'}{cb_msg module='grn.report' key='GRN_RPRT-154' replace='true'}{/capture}{grn_link page='report/file_modify' caption=$smarty.capture.grn_report_GRN_RPRT_154 image='modify20.gif' fid=$fid cid=$cid rid=$rid follow_id=$follow_id iid=$iid alt=''}</span>
        {/if}
        {if $file.deletable}
            <span class="menu_item">
                {grn_delete title=$file_delete_info.title page=$file_delete_info.page data=$file_delete_info.data handler=$file_delete_info.handler}
                {if $file.locked}
                    {capture name='grn_report_GRN_RPRT_155'}{cb_msg module='grn.report' key='GRN_RPRT-155' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_GRN_RPRT_155 image='delete20.gif' disabled=true alt=''}
                {else}
                    {capture name='grn_report_GRN_RPRT_156'}{cb_msg module='grn.report' key='GRN_RPRT-156' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_GRN_RPRT_156 image='delete20.gif' script='javascript:void(0)' id='lnk_follow_delete' alt=''}
                {/if}
            </span>
        {/if}
        {grn_image image='spacer20.gif'}
    </div>
{/if}
<!--menubar_end-->
{grn_title title=$page_title class=$page_info.parts[0]|cat:' inline_block_grn mBottom10' no_style=1}

{if $file.locked == 'other'}
    <div>{cb_msg module='grn.report' key='GRN_RPRT-157' replace='true'}&nbsp;{grn_user_name uid=$file.locked_owner_uid name=$file.locked_owner_name}&nbsp;{cb_msg module='grn.report' key='GRN_RPRT-158' replace='true'}</div>
    <p></p>
{elseif $file.locked == 'login'}
    <form name="unlock" method="post" action='{grn_pageurl page="report/command_file_unlock"}'>
        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        <input type="hidden" name="fid" value="{$fid}">
        <input type="hidden" name="cid" value="{$cid}">
        <input type="hidden" name="rid" value="{$rid}">
        <input type="hidden" name="follow_id" value="{$follow_id}">
        <input type="hidden" name="iid" value="{$iid}">
        <font color="green">{cb_msg module='grn.report' key='GRN_RPRT-159' replace='true'}</font><input type="submit" value="{cb_msg module='grn.report' key='GRN_RPRT-160' replace='true'}">
    </form>
    <p></p>
{/if}

{if ! $file.modifiable or ! $file.deletable}
    {assign var="no_restore" value=true}
{/if}
{include file="grn/file_view.tpl" download_page="report/file_download" restore_page="report/file_restore" linkparams=$linkparams}
{include file="grn/footer.tpl"}
