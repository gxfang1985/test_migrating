<thread xmlns:th="http://schemas.cybozu.co.jp/message/2008" id="{$thread.mid}" version="{$thread.version}" {if $thread.need_confirm } confirm="true" {else} confirm="false" {/if}
        {grn_attr name="subject" value=$thread.subject require=true} {if $thread.is_snapshot eq '1' } snapshot="{$thread.delete_time}" {/if}
        {if $thread.type eq '2' } is_draft="true" {else} is_draft="false" {/if}>
        {if is_array($thread.addressees) && count($thread.addressees) > 0 }
            {foreach from=$thread.addressees item=addressee}
                <th:addressee {grn_attr name="user_id" value=$addressee.id } {grn_attr name="name" value=$addressee.name require=true} deleted="{$addressee.delete_flag}"
                {if $addressee.confirmed } confirmed="true" {else} confirmed="false" {/if} />
            {/foreach}
        {/if}
        <th:content {grn_attr name="body" value=$thread.data require=true} {grn_attr name="html_body" value=$thread.html_data}>
        {if is_array($thread.attach_files) && count($thread.attach_files) > 0 }
            {foreach from=$thread.attach_files item=file}
                <th:file id="{$file.rfid}" {grn_attr name="name" value=$file.name require=true} {grn_attr name="size" value=$file.size}
                {grn_attr name="mime_type" value=$file.mime}/>
            {/foreach}
        {/if}
        </th:content>
        {if is_array($thread.follow) && count($thread.follow) > 0 }
            {foreach from=$thread.follow item=follow}
                <th:follow id="{$follow.follow_id}" number="{$follow.id}" />
            {/foreach}
        {/if}
        {if is_array($thread.folders) && count($thread.folders) > 0 }
            {foreach from=$thread.folders item=folder}
                <th:folder id="{$folder.fid}" />
            {/foreach}
        {/if}
        <th:creator {grn_attr name="user_id" value=$thread.creator_uid } {grn_attr name="name" value=$thread.creator_name require=true} date="{$thread.creator_date}" />
        <th:modifier {grn_attr name="user_id" value=$thread.modifier_uid } {grn_attr name="name" value=$thread.modifier_name require=true} date="{$thread.modifier_date}" />
</thread>