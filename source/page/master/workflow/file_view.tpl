{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

{grn_title title=$page_title class=$page_info.parts[0]|cat:' inline_block_grn mBottom10' no_style=1}

{if $enable_lock}
    {if $file.locked == 'other'}
        <div>{cb_msg module='grn.workflow' key='key_16_1' replace='true'}&nbsp;{grn_user_name uid=$file.locked_owner_uid name=$file.locked_owner_name}&nbsp;{cb_msg module='grn.workflow' key='key_16_2' replace='true'}</div>
    {elseif $file.locked == 'login'}
        <form name="unlock" method="post" action='{grn_pageurl page="workflow/command_file_unlock"}'><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
            <input type="hidden" name="cid" value="{$cid}">
            <input type="hidden" name="rid" value="{$rid}">
            <input type="hidden" name="mid" value="{$mid}">
            <input type="hidden" name="rfid" value="{$rfid}">
            <input type="hidden" name="frm"  value="{$frm}">
            <font color="green">{cb_msg module='grn.workflow' key='key_16_3' replace='true'}</font><input type="submit" value="{cb_msg module='grn.workflow' key='unlock_file' replace='true'}">
        </form>
    {/if}
    <p></p>
{/if}
{include file="grn/file_view.tpl" download_page="workflow/file_download" linkparams=$linkparams}
{include file="grn/footer.tpl"}
