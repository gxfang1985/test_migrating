{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

{grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
<!--menubar-->
{if $file.modifiable || $file.deletable}
    <div id="main_menu_part">
        {if $file.modifiable}
            {if $file.locked == 'other'}
                <span class="aButtonStandard-grn button_disable_filter_grn"><button type="button" tabindex="0" title="{cb_msg module='grn.message' key='GRN_MSG-36' replace='true'}" aria-label="{cb_msg module='grn.message' key='GRN_MSG-36' replace='true'}" class="mRight10" aria-disabled="true">{cb_msg module='grn.message' key='GRN_MSG-36' replace='true'}</button></span>
            {else}
                {if $enable_lock}
                    {include file="message/_file_update.tpl" page='message/file_update' cid=$cid rid=$rid mid=$mid rfid=$rfid frm=$frm csrf_ticket=$csrf_ticket}
                    <span class="aButtonStandard-grn"><button type="button" tabindex="0" title="{cb_msg module='grn.message' key='GRN_MSG-37' replace='true'}" aria-label="{cb_msg module='grn.message' key='GRN_MSG-37' replace='true'}" class="mRight10" onclick="javascript:document.forms.form_file_update.submit();">{cb_msg module='grn.message' key='GRN_MSG-37' replace='true'}</button></span>
                {else}
                    <span class="aButtonStandard-grn"><button type="button" tabindex="0" title="{cb_msg module='grn.message' key='GRN_MSG-38' replace='true'}" aria-label="{cb_msg module='grn.message' key='GRN_MSG-38' replace='true'}" class="mRight10" onclick="javascript:location.href='{grn_pageurl page=message/file_upload cid=$cid rid=$rid mid=$mid rfid=$rfid frm=$frm}';">{cb_msg module='grn.message' key='GRN_MSG-38' replace='true'}</button></span>
                {/if}
            {/if}
            <span class="menu_item">{capture name='grn_message_GRN_MSG_39'}{cb_msg module='grn.message' key='GRN_MSG-39' replace='true'}{/capture}{grn_link page='message/file_modify' caption=$smarty.capture.grn_message_GRN_MSG_39 image='modify20.gif' cid=$cid rid=$rid mid=$mid rfid=$rfid frm=$frm alt=''}</span>
        {/if}
        {if $file.deletable}
            {if $file.locked}
                <span class="menu_item">{capture name='grn_message_GRN_MSG_40'}{cb_msg module='grn.message' key='GRN_MSG-40' replace='true'}{/capture}{grn_link page='message/file_delete' caption=$smarty.capture.grn_message_GRN_MSG_40 image='delete20.gif' cid=$cid rid=$rid mid=$mid rfid=$rfid disabled=true frm=$frm alt=''}</span>
            {else}
                <span class="menu_item">{capture name='grn_message_GRN_MSG_41'}{cb_msg module='grn.message' key='GRN_MSG-41' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_message_GRN_MSG_41 image='delete20.gif' id='lnk_delete' script='javascript:void(0);' alt=''}</span>
            {/if}
        {/if}
        {grn_image image='spacer20.gif'}
    </div>
{/if}
<!--menubar_end-->
{grn_title title=$page_title class=$page_info.parts[0]|cat:' inline_block_grn mBottom10' no_style=1}

{if $enable_lock}
    {if $file.locked == 'other'}
        <div>{cb_msg module='grn.message' key='GRN_MSG-42' replace='true'}&nbsp;{grn_user_name uid=$file.locked_owner_uid name=$file.locked_owner_name}&nbsp;{cb_msg module='grn.message' key='GRN_MSG-43' replace='true'}</div>
    {elseif $file.locked == 'login'}
        <form name="unlock" method="post" action='{grn_pageurl page="message/command_file_unlock"}'>
            <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
            <input type="hidden" name="cid" value="{$cid}">
            <input type="hidden" name="rid" value="{$rid}">
            <input type="hidden" name="mid" value="{$mid}">
            <input type="hidden" name="rfid" value="{$rfid}">
            <input type="hidden" name="frm"  value="{$frm}">
            <font color="green">{cb_msg module='grn.message' key='GRN_MSG-44' replace='true'}</font>
            <input type="submit" value="{cb_msg module='grn.message' key='GRN_MSG-45' replace='true'}">
        </form>
    {/if}
    <p></p>
{/if}
{if ! $file.modifiable or ! $file.deletable}
    {assign var="no_restore" value=true}
{/if}
{include file="grn/file_view.tpl" download_page="message/file_download" restore_page="message/file_restore" linkparams=$linkparams}

{include file="grn/footer.tpl"}
