<mail xmlns:mail="http://schemas.cybozu.co.jp/mail/2008" key="{$mail.mid}" version="{$mail.version}" 
        {grn_attr name="subject" value=$mail.subject require=true}
        {grn_attr name="body" value=$mail.data require=true}
        {grn_attr name="folder_key" value=$mail.cid require=true} 
        {grn_attr name="html_body" value=$mail.html_data}
        {grn_attr name="date" value=$mail.date}
        {grn_attr name="read" value=$mail.read}
        {grn_attr name="size" value=$mail.size}
        {grn_attr name="is_draft" value=$mail.draft}
        {if $mail.sender} is_sent="true" {else} is_sent="false" {/if}
        {grn_attr name="is_sent_disposition_notification" value=$mail.is_sent_disposition_notification}
        >
        {if is_array($mail.files)&& count($mail.files) > 0 }
            {foreach from=$mail.files item=file}
            <mail:file id="{$file.fid}" {grn_attr name="name" value=$file.name require=true} {grn_attr name="mime_type" value=$file.mime}
            {grn_attr name="size" value=$file.size} />
            {/foreach}
        {/if}
        {if is_array($mail.from)&& count($mail.from) > 0 }
            {foreach from=$mail.from item=from}
            <mail:from {grn_attr name="name" value=$from.name} {grn_attr name="address" value=$from.address require=true} />
            {/foreach}
        {/if}
        {if is_array($mail.sender)&& count($mail.sender) > 0 }
            {foreach from=$mail.sender item=sender}
            <mail:sender {grn_attr name="name" value=$sender.name} {grn_attr name="address" value=$sender.address require=true} />
            {/foreach}
        {/if}
        {if is_array($mail.to)&& count($mail.to) > 0 }
            {foreach from=$mail.to item=to}
            <mail:to {grn_attr name="name" value=$to.name} {grn_attr name="address" value=$to.address require=true} />
            {/foreach}
        {/if}
        {if is_array($mail.cc)&& count($mail.cc) > 0 }
            {foreach from=$mail.cc item=cc}
            <mail:cc {grn_attr name="name" value=$cc.name} {grn_attr name="address" value=$cc.address require=true}/>
            {/foreach}
        {/if}
        {if is_array($mail.bcc)&& count($mail.bcc) > 0 }
            {foreach from=$mail.bcc item=bcc}
            <mail:bcc {grn_attr name="name" value=$bcc.name} {grn_attr name="address" value=$bcc.address require=true} />
            {/foreach}
        {/if}
        {if is_array($mail.reply_to)&& count($mail.reply_to) > 0 }
            {foreach from=$mail.reply_to item=reply_to}
            <mail:reply_to {grn_attr name="name" value=$reply_to.name} {grn_attr name="address" value=$reply_to.address require=true} />
            {/foreach}
        {/if}
        {if is_array($mail.confirmation_to)&& count($mail.confirmation_to) > 0 }
            {foreach from=$mail.confirmation_to item=confirmation_to}
            <mail:disposition_notification_to {grn_attr name="name" value=$confirmation_to.name} {grn_attr name="address" value=$confirmation_to.address require=true} />
            {/foreach}
        {/if}
        {if is_array($mail.source)&& count($mail.source) > 0 }
            {foreach from=$mail.source item=source}
            <mail:source id="{$source.id}" {grn_attr name="size" value=$source.size} />
            {/foreach}
        {/if}
</mail>