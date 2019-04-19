{include file="cbpapi/header.tpl"}
<workflow:{$action}Response>
<returns>
    {foreach from=$file_for_view item=file_detail}
    <attachment_details>
    <file_header
        {grn_attr name="file_id" value=$file_detail.id require=true}
        {grn_attr name="request_form_id" value=$file_detail.request_form_id require=true}
        {grn_attr name="name" value=$file_detail.filename require=true}
        {grn_attr name="size" value=$file_detail.size|cat:" bytes" require=true}
    >
    </file_header>
    <file_information
        {grn_attr name="subject" value=$file_detail.title require=true}
        {if $file_detail.max_version === 0}
            {grn_attr name="versioning" value="Don't set" require=true}
        {else}
            {grn_attr name="versioning" value=$file_detail.max_version require=true}
        {/if}
        {grn_attr name="create_time" value=$file_detail.ctime->unix_ts require=true}
        {grn_attr name="modify_time" value=$file_detail.mtime->unix_ts require=true}
        {grn_attr name="description" value=$file_detail.memo require=true}
    >
    </file_information>
    </attachment_details>
    {/foreach}
</returns>
</workflow:{$action}Response>
{include file="cbpapi/footer.tpl"}