{if $account_deleted or $size_error or $remaining or $notify_count or $size_over}
<div class="mobile_zero_height_grn mobile-div-title-grn">&nbsp;</div>
<div class="mobile_mail_grn mobile-div-title-grn">
  <div class="mobile_box_area_grn">
      {if $account_deleted}
        <span class="mobile_box_message_grn"><span class="mobile_icon_information_grn"></span>{cb_msg module='grn.mail' key='GRN_MAIL-115' replace='true'}<span class="mobile_bold_grn">{cb_msg module='grn.mail' key='GRN_MAIL-116' replace='true'}</span>{cb_msg module='grn.mail' key='GRN_MAIL-117' replace='true'}</span>
      {else}
        {if $size_error}
          <span class="mobile_box_message_grn"><span class="mobile_icon_information_grn"></span>
            {cb_msg module='grn.mail' key='GRN_MAIL-122' replace='true'}{$app_name|escape}{cb_msg module='grn.mail' key='GRN_MAIL-123' replace='true'}
          </span>
          <div class="mobile_box_linktext_grn">
            {strip}
              <span class="mobile_icon_listmarks_grn"></span>
              <a href="{grn_pageurl page='mail/cannot_receive' aid=$account_id cid=$category_id}">{cb_msg module='grn.mail' key='GRN_MAIL-124' replace='true'}{$app_name|escape}{cb_msg module='grn.mail' key='GRN_MAIL-125' replace='true'}</a>
            {/strip}
          </div>
        {/if}
        {if $remaining}
          <span class="mobile_box_message_grn"><span class="mobile_icon_information_grn"></span>{cb_msg module='grn.mail.mobile' key='GRN_MAIL_MOBILE-6' replace='true'}{$app_name|escape}{cb_msg module='grn.mail.mobile' key='GRN_MAIL_MOBILE-7' replace='true'}<span class="mobile_bold_grn">{cb_msg module='grn.mail.mobile' key='GRN_MAIL_MOBILE-8' replace='true'}{cb_msg module='grn.mail' key='GRN_MAIL-425' replace='true'}{cb_msg module='grn.mail.mobile' key='GRN_MAIL_MOBILE-9' replace='true'}</span>{cb_msg module='grn.mail.mobile' key='GRN_MAIL_MOBILE-10' replace='true'}</span>
        {/if}
        {if $notify_count}
          <span class="mobile_box_message_grn"><span class="mobile_icon_information_grn"></span>{cb_msg module='grn.mail.mobile' key='GRN_MAIL_MOBILE-11' replace='true'}<span class="mobile_bold_grn">{$notify_count|escape}</span>{cb_msg module='grn.mail.mobile' key='GRN_MAIL_MOBILE-12' replace='true'}</span>
        {/if}
        {if $size_over}
          <span class="mobile_box_message_grn"><span class="mobile_icon_information_grn"></span>{cb_msg module='grn.mail' key='GRMSG_MAIL_1' app_name=$app_name|escape mailbox_size=$mailbox_size|escape}</span>
          <span class="mobile_box_message_grn">{cb_msg module='grn.mail' key='GRMSG_MAIL_2' app_name=$app_name|escape mailbox_size=$mailbox_size|escape}({cb_msg module='grn.mail' key='GRMSG_MAIL_3' app_name=$app_name|escape}<span class="mobile_bold_grn">{grn_format_filesize size=$mail_size unit='MB'}</span>)</span>
        {/if}
      {/if}
  </div>
</div>
{/if}