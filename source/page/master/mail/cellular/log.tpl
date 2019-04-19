{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="mail"}<br>
{cb_msg module='grn.mail.cellular' key="log"}
<hr>
{*
{if  !$cannot_send}
    {grn_cellular_link page="$pagepath/create" aid=$category.aid cid=$category.cid accesskey=2 caption_module='grn.mail.cellular' caption_key="list_mail_create"}<br>
{/if}
<br>

<hr>
*}
{foreach from=$mails item=mail_data   }
    {if $mail_data.time_view_flag}
        {cb_date_format format='DateMiddle_YMD' date=$mail_data.time}<BR>
    {/if}
    
    {if $mail_data.unread}
        {grn_cellular_pictogram key="new"}
    {else}
        {grn_cellular_pictogram key="checked"}
    {/if}
    
    <a href={grn_cellular_pageurl page="$pagepath/look" mid=$mail_data.mid}>
    {if strlen($mail_data.subject) > 0}
        {$mail_data.subject|grn_cellular_truncate:$width|escape}
    {else}
        {cb_msg module='grn.mail.cellular' key="no_subject"}
    {/if}
    </a><BR>
    &nbsp;&nbsp;
    {if !$mail_data.mail_with_tag_flag}
        {$mail_data.name|cat:$mail_data.from_email|grn_cellular_truncate:$width|escape}<BR>
    {else}
        {$mail_data.name|cat:"<"|cat:$mail_data.from_email|cat:">"|grn_cellular_truncate:$width|escape}<BR>
    {/if}
{/foreach}


{if $navi.previous_page_start_position != -1}
     <a href="{grn_cellular_pageurl page="$pagepath/log" 
                                   sp=$navi.previous_page_start_position 
                                   params=$navi.params 
                                   fragment=$navi.fragment
                                   aid=$aid 
                                   mid=$mail_info.mid 
                                   cid=$cid 
                                   email=$navi.params.email
                                   }">{cb_msg module='grn.cellular.common' key="link_back"}</a>
{/if}
{if $navi.next_page_start_position != -1}
    &nbsp;
    <a href="{grn_cellular_pageurl page="$pagepath/log" 
                                   sp=$navi.next_page_start_position 
                                   params=$navi.params 
                                   fragment=$navi.fragment
                                   aid=$navi.params.aid 
                                   mid=$navi.params.mid 
                                   cid=$navi.params.cid 
                                   email=$navi.params.email
                                   }">{cb_msg module='grn.cellular.common' key="link_next"}</a>
{/if}
<hr>
{grn_cellular_link page="$pagepath/list" aid=$aid accesskey=8 caption_module='grn.mail.cellular' caption_key="link_list"}<br>
{grn_cellular_link page="$pagepath/search" aid=$aid accesskey=9 caption_module='grn.mail.cellular' caption_key="link_search"}<br>
{/strip}
{include file="cellular/footer.tpl"}
