{include file="cbpapi/header.tpl"}
<message:{$action}Response>
    <returns xmlns="">
    {foreach key=follow_id item=follow from=$follows}
        <follow id="{$follow_id}" number="{$follow.id}" {grn_attr name="text" value=$follow.data require=true}
                     {grn_attr name="html_text" value=$follow.html_data} 
                     xmlns:flw="http://schemas.cybozu.co.jp/message/2008">
        {foreach key=file_id item=file from=$follow.files}
            <flw:file id="{$file_id}" {grn_attr name="name" value=$file.name require=true}
                     {grn_attr name="size" value=$file.size}
                     {grn_attr name="mime_type" value=$file.mime} />
        {/foreach}
            <flw:creator {grn_attr name="user_id" value=$follow.creator_id} {grn_attr name="name" value=$follow.creator_name require=true} date="{$follow.creator_date}" />
        </follow>
    {/foreach}
    </returns>
</message:{$action}Response>
{include file="cbpapi/footer.tpl"}