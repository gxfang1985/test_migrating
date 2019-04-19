{include file="cbpapi/header.tpl"}
<report:{$action}Response>
    <returns xmlns="">
    {foreach key=follow_id item=follow from=$follows}
        <follow id="{$follow_id}" number="{$follow.follow_id}" {grn_attr name="text" value=$follow.data require=true}
                     {grn_attr name="html_text" value=$follow.html} 
                     xmlns:flw="http://schemas.cybozu.co.jp/report/2008">
                {foreach key=file_id item=file from=$follow.attach_files}
                    <flw:file id="{$file_id}" {grn_attr name="name" value=$file.file_info.name require=true}
                             {grn_attr name="size" value=$file.file_info.size}
                             {grn_attr name="mime_type" value=$file.file_info.mime} />
                {/foreach}
            <flw:creator {grn_attr name="user_id" value=$follow.creator } {grn_attr name="name" value=$follow.creator_name require=true} date="{$follow.creator_date}" />
        </follow>
    {/foreach}
    </returns>
</report:{$action}Response>
{include file="cbpapi/footer.tpl"}