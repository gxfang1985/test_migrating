{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="mail"}<br>
{cb_msg module='grn.mail.cellular' key="to"}
<hr>
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
{if $use_history}
[<a href={grn_cellular_pageurl page="$pagepath/log" email=$to_list_data.email}>
{grn_cellular_pictogram key="foot"}</a>]
{else}
[{grn_cellular_pictogram key="foot"}]
{/if}

{grn_cellular_mailto mail=$to_list_data.email caption=$to_list_data.caption  width=$width}<BR>
<BR>

{/foreach}
{if $before_page}<a href={grn_cellular_pageurl page="$pagepath/to" mid=$mid pa=$before_page}>{cb_msg module='grn.cellular.common' key="link_back"}</a>&nbsp;{/if}

{if $next_page}<a href={grn_cellular_pageurl page="$pagepath/to" mid=$mid pa=$next_page}>{cb_msg module='grn.cellular.common' key="link_next"}</a>{/if}
<hr>
{grn_cellular_link page="$pagepath/look" mid=$mid accesskey=2 caption_module='grn.mail.cellular' caption_key="link_back"}<BR>
{grn_cellular_link page="$pagepath/list" aid=$aid cid=$cid accesskey=8 caption_module='grn.mail.cellular' caption_key="link_list"}<br>
{grn_cellular_link page="$pagepath/search" aid=$aid accesskey=9 caption_module='grn.mail.cellular' caption_key="link_search"}<br>
{/strip}
{include file="cellular/footer.tpl"}
