{if $account_deleted or $size_error or $remaining or $notify_count or $size_over}
<div class="notes">
  {if $account_deleted}
    {grn_delete title=$account_delete_info.title page=$account_delete_info.page no_confirm=$account_delete_info.no_confirm data=$account_delete_info.data handler=$account_delete_info.handler}
    <div>
      {cb_msg module='grn.mail' key='GRN_MAIL-115' replace='true'}<span class="bold">{cb_msg module='grn.mail' key='GRN_MAIL-116' replace='true'}</span>{cb_msg module='grn.mail' key='GRN_MAIL-117' replace='true'}<br>
      {cb_msg module='grn.mail' key='GRN_MAIL-118' replace='true'}{$app_name|escape}{cb_msg module='grn.mail' key='GRN_MAIL-119' replace='true'} {capture name='grn_mail_GRN_MAIL_120'}{cb_msg module='grn.mail' key='GRN_MAIL-120' replace='true'}{/capture}{grn_button_submit name='delete_account' caption=$smarty.capture.grn_mail_GRN_MAIL_120 id="btn_account_delete" class="buttonStandard-grn" onclick="return false;"} {cb_msg module='grn.mail' key='GRN_MAIL-121' replace='true'}<br>
    </div>
  {else}
    {if $size_error}
      <p>
        {cb_msg module='grn.mail' key='GRN_MAIL-122' replace='true'}{$app_name|escape}{cb_msg module='grn.mail' key='GRN_MAIL-123' replace='true'}<br>
      </p>
      <ul>
        <li><span class="nowrap-grn"><a href="javascript:void(0);" onclick="window.location='{grn_pageurl page=mail/cannot_receive aid=$account_id}&cid='+grn.page.mail.mail_3pane.cid">{grn_image image='view20.gif'}{cb_msg module='grn.mail' key='GRN_MAIL-124' replace='true'}{$app_name|escape}{cb_msg module='grn.mail' key='GRN_MAIL-125' replace='true'}</a></span></li>
      </ul>
    {/if}
    {if $remaining}
      <p>{cb_msg module='grn.mail' key='GRN_MAIL-126' replace='true'}{$app_name|escape}{cb_msg module='grn.mail' key='GRN_MAIL-127' replace='true'}<span class="bold">{cb_msg module='grn.mail' key='GRN_MAIL-128' replace='true'}{cb_msg module='grn.mail' key='GRN_MAIL-425' replace='true'}{cb_msg module='grn.mail' key='GRN_MAIL-129' replace='true'}</span>{cb_msg module='grn.mail' key='GRN_MAIL-130' replace='true'}</p>
    {/if}
    {if $notify_count}
      <p>{cb_msg module='grn.mail' key='GRN_MAIL-131' replace='true'}<span class="bold">{cb_msg module='grn.mail' key='GRN_MAIL-132' replace='true'}{$notify_count|escape}{cb_msg module='grn.mail' key='GRN_MAIL-133' replace='true'}</span>{cb_msg module='grn.mail' key='GRN_MAIL-134' replace='true'}</p>
    {/if}
    {if $size_over}
      <p>
        {cb_msg module='grn.mail' key='GRMSG_MAIL_1' app_name=$app_name|escape mailbox_size=$mailbox_size|escape}<br>
        {cb_msg module='grn.mail' key='GRMSG_MAIL_2' app_name=$app_name|escape mailbox_size=$mailbox_size|escape}({cb_msg module='grn.mail' key='GRMSG_MAIL_3' app_name=$app_name|escape}<span class="bold">{grn_format_filesize size=$mail_size unit='MB'}</span>)
      </p>
    {/if}
  {/if}
</div>
{/if}