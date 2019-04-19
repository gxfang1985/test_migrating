====================================================================
{cb_msg module='grn.mail' key='GRN_MAIL-317' replace='true'}{$mail.subject|grn_noescape}
{cb_msg module='grn.mail' key='GRN_MAIL-318' replace='true'}{grn_mail_name type=$name_type name_format=$name_format nolink=1 noimage=1 no_htmlencode=1 name=$mail.from mid=$mail.id}
{cb_msg module='grn.mail' key='GRN_MAIL-319' replace='true'}{grn_mail_name type=$name_type name_format=$name_format nolink=1 noimage=1 no_htmlencode=1 name=$mail.to mid=$mail.id}
{if $mail.cc neq ''}
CC    {cb_msg module='grn.mail' key='GRN_MAIL-320' replace='true'}{grn_mail_name type=$name_type name_format=$name_format nolink=1 noimage=1 no_htmlencode=1 name=$mail.cc mid=$mail.id}
{/if}
{if $mail.bcc neq ''}
BCC   {cb_msg module='grn.mail' key='GRN_MAIL-321' replace='true'}{grn_mail_name type=$name_type name_format=$name_format nolink=1 noimage=1 no_htmlencode=1 name=$mail.bcc mid=$mail.id}
{/if}
{cb_msg module='grn.mail' key='GRN_MAIL-322' replace='true' }{grn_date_format date=$mail.ctime format='DateTimeFull_YMDW_HM'}

{$mail.data|grn_noescape}

{if $mail.attach_files}
{foreach from=$mail.attach_files item=file}
{$file.name|grn_noescape}
{/foreach}
{/if}
