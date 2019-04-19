{include file="cbpapi/header.tpl"}
<message:{$action}Response>
<returns>
    {if is_array($folders) && count($folders) > 0 }
    {foreach from=$folders item=folder}
        <folder id="{$folder.folder_id}" version="{$folder.mtime->unix_ts}" {grn_attr name="name" value=$folder.folder_name require=true}
        {grn_attr name="description" value=$folder.memo} {grn_attr name="order" value=$folder.view_order}
        {grn_attr name="parent_folder_id" value=$folder.parent_id} {grn_attr name="folder_type" value=$folder.folder_type require=true}>
            {if is_array($folder.children) && count($folder.children) > 0 }
                {foreach from=$folder.children key=id item=child}
                    <folder xmlns="http://schemas.cybozu.co.jp/message/2008" id="{$id}" />
                {/foreach}
            {/if} 
            {if is_array($folder.threads) && count($folder.threads) > 0 }
                {foreach from=$folder.threads item=thread}
                    <thread xmlns="http://schemas.cybozu.co.jp/message/2008" id="{$thread.id}" />
                {/foreach}
            {/if}        
        </folder>
        {/foreach}
    {/if}
</returns>
</message:{$action}Response>
{include file="cbpapi/footer.tpl"}