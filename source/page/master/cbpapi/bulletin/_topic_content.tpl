<topic xmlns:th="http://schemas.cybozu.co.jp/bulletin/2008" 
        id="{$topic.aid}" version="{$topic.version}" 
        {grn_attr name="category_id" value=$topic.cid require=true}
        {if $topic.can_follow } can_follow="true" {else} can_follow="false" {/if}
        {grn_attr name="manually_enter_sender" value=$topic.manually_enter_sender}
        {grn_attr name="subject" value=$topic.title require=true}
        {if $topic.is_draft} is_draft="true" {else} is_draft="false" {/if}
        {if $topic.stime} {if $topic.start_is_datetime } start_is_datetime="true" {else} start_is_datetime="false" {/if} {/if}
        {if $topic.etime} {if $topic.end_is_datetime } end_is_datetime="true" {else} end_is_datetime="false" {/if} {/if}
        {grn_attr name="start_datetime" value=$topic.stime}
        {grn_attr name="end_datetime" value=$topic.etime}
        {grn_attr name="creator_group_id" value=$topic.creator_group_id}
        {if $topic.published } published="true"  {if $topic.unread } unread="true" {else} unread="false" {/if} {else} published="false" {/if}
        {if $topic.expired } expired="true" {else} expired="false" {/if}
        >
        <th:content {grn_attr name="body" value=$topic.data require=true} {grn_attr name="html_body" value=$topic.html}>
        {if is_array($topic.attach_files) && count($topic.attach_files) > 0 }
            {foreach from=$topic.attach_files item=file}
                <th:file id="{$file.id}" {grn_attr name="name" value=$file.name require=true} {grn_attr name="size" value=$file.size}
                {grn_attr name="mime_type" value=$file.mime}/>
            {/foreach}
        {/if}
        </th:content>
        
        {if is_array($topic.follows) && count($topic.follows) > 0 }
            {foreach from=$topic.follows item=follow}
                <th:follow id="{$follow.follow_id}" number="{$follow.id}" />
            {/foreach}
        {/if}
        
        <th:creator {grn_attr name="user_id" value=$topic.creator_uid } {grn_attr name="name" value=$topic.creator_name require=true} date="{$topic.creator_date}" />
        <th:modifier {grn_attr name="user_id" value=$topic.modifier_uid } {grn_attr name="name" value=$topic.modifier_name require=true} date="{$topic.modifier_date}" />
</topic>