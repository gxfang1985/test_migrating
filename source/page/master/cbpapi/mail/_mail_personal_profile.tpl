<personal_profile {grn_attr name="show_preview" value=$show_preview require=true}
                              {grn_attr name="send_charset" value=$send_charset require=true}
                              {grn_attr name="use_trash" value=$use_trash require=true}
                              {grn_attr name="use_status" value=$use_status require=true}
                              {grn_attr name="use_message_disposition_notification" value=$use_message_disposition_notification require=true}
                              {grn_attr name="reply_message_disposition_notification" value=$reply_message_dispositon_notification require=true}
                              >
  {foreach from=$froms item=name_info}
    <from_name account_id="{$name_info.account_id}" {grn_attr name="name" value=$name_info.from_name require=true} />
  {/foreach}
</personal_profile>