{include file="cbpapi/header.tpl"}
<bulletin:{$action}Response>
    <returns xmlns="">
    {if is_array($follows) && count($follows) > 0 }
    {foreach from=$follows item=follow}
     <follow topic_id="{$follow.topic_id}" id="{$follow.follow_id}" number="{$follow.id}" {grn_attr name="text" value=$follow.data require=true}
             {grn_attr name="html_text" value=$follow.html}
             xmlns:flw="http://schemas.cybozu.co.jp/bulletin/2008">
          {foreach from=$follow.attach_files item=file}
            <flw:file id="{$file.id}" {grn_attr name="name" value=$file.name require=true}
                     {grn_attr name="size" value=$file.size}
                     {grn_attr name="mime_type" value=$file.mime} />
          {/foreach}
          <flw:creator {grn_attr name="user_id" value=$follow.creator_uid} {grn_attr name="name" value=$follow.creator_name require=true} date="{$follow.creator_date}" />
     </follow>
    {/foreach}
    {/if}
    </returns>
</bulletin:{$action}Response>
{include file="cbpapi/footer.tpl"}