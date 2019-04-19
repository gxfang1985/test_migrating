{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="mail"}<br>
{cb_msg module='grn.mail.cellular' key="look"}
<hr>
{grn_cellular_pictogram key="light"}{cb_msg module='grn.mail.cellular' key="title"}<BR>
{$mail_info.subject|escape}<BR>
{grn_cellular_pictogram key="memo"}{cb_msg module='grn.mail.cellular' key="content"}<BR>

{grn_cellular_string_split string=$mail_info.data page_paraname="bp"}<br>

{if strlen($from_info.email) > 0}
{grn_cellular_pictogram key="person"}{cb_msg module='grn.mail.cellular' key="from"}<BR>
{cb_date_format format='DateTimeMiddle_YMD_HM' date=$mail_info.ctime}<BR>

[
{if $use_history}
<a href={grn_cellular_pageurl page="$pagepath/log" aid=$aid mid=$mail_info.mid cid=$cid email=$from_info.urlencoded}>
{/if}
{grn_cellular_pictogram key="foot"}
{if $use_history}
</a>
{/if}
]
{if strlen($from_info.name) > 0}{$from_info.name|escape}<BR>{/if}
{grn_cellular_mailto mail=$from_info.email }<BR>
{/if}
<BR>
{if $mail_info.existence_attach_files}
[{grn_cellular_pictogram key="clip"}{cb_msg module='grn.mail.cellular' key="attach"}]<BR>
{/if}<BR>

{cb_msg module='grn.mail.cellular' key="look_to"}<BR>

{foreach from=$to_list item=to_list_data }
{if $to_list_data.type == 'to' && $to_list_data.no =='0'}
TO:<BR>
{/if}
{if $to_list_data.type == 'cc' && $to_list_data.no =='0'}
CC:<BR>
{/if}
{if $to_list_data.type == 'bcc' && $to_list_data.no =='0'}
Bcc:<BR>
{/if}

[
{if $use_history}
<a href={grn_cellular_pageurl page="$pagepath/log" aid=$aid mid=$mail_info.mid cid=$cid email=$to_list_data.urlencoded}>
{/if}
{grn_cellular_pictogram key="foot"}
{if $use_history}
</a>
{/if}
]


{grn_cellular_mailto mail=$to_list_data.email caption=$to_list_data.caption }<BR>

{/foreach}

{if $view_all_to_list}
<a href={grn_cellular_pageurl page="$pagepath/to" mid=$mail_info.mid }>{cb_msg module='grn.mail.cellular' key="view_all_list"}</a><BR>
{/if}
{if $from_info.email}
{grn_cellular_pictogram key="new_mail"}
<a href={grn_cellular_pageurl page="$pagepath/create" mid=$mail_info.mid}>{cb_msg module='grn.mail.cellular' key="reply"}</a><BR>

{grn_cellular_pictogram key="new_mail"}
<a href={grn_cellular_pageurl page="$pagepath/create" mid=$mail_info.mid reply=all}>{cb_msg module='grn.mail.cellular' key="reply_all"}</a><BR>
{/if}
<hr>
{grn_cellular_link page="$pagepath/list" aid=$aid cid=$cid accesskey=8 caption_module='grn.mail.cellular' caption_key="link_list"}<br>
{grn_cellular_link page="$pagepath/search" aid=$aid accesskey=9 caption_module='grn.mail.cellular' caption_key="link_search"}<br>
{/strip}
{include file="cellular/footer.tpl"}
