{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="mail"}<br>
{$pagetitle|escape}<br>
<hr>

{grn_cellular_pictogram key="person"}{cb_msg module='grn.mail.cellular' key="list_account"}
[{grn_cellular_link page="$pagepath/acco" aid=$account_info.aid from=$from text=$text accesskey=1 caption_module='grn.mail.cellular' caption_key="list_modify"}]<br>
{$account_info.account_name|escape}
<hr>
{cb_msg module='grn.mail.cellular' key="search_notice"}

{grn_cellular_form name="form" method="get" page="$pagepath/search" aid=$account_info.aid}
<input type="text" name="text" value="{$text|escape}" istyle="1" mode="hiragana"><br>
{grn_cellular_submit name="GO" accesskey="2" caption_module='grn.mail.cellular' caption_key="submit_search"}<br>
</form>

{if $mails}
    <hr>
    {foreach from=$mails item=mail_data}
        {if $mail_data.time_view_flag}
            {cb_date_format format='DateMiddle_YMD' date=$mail_data.time}<BR>
        {/if}
        {if $mail_data.unread}
            {grn_cellular_pictogram key="new"}
        {else}
            {grn_cellular_pictogram key="checked"}
        {/if}
        <a href={grn_cellular_pageurl page="$pagepath/look" mid=$mail_data.maid }>
        {if strlen($mail_data.subject) > 0}
            {$mail_data.subject|grn_cellular_truncate:$width|escape}
        {else}
            {cb_msg module='grn.mail.cellular' key="no_subject"}
        {/if}
        </a><BR>
        &nbsp;&nbsp;
        {if $mail_data.from_email}
            {if $mail_data.mail_with_tag_flag}
                {$mail_data.from_name|cat:$mail_data.from_email|grn_cellular_truncate:$width|escape}
            {else}
                {$mail_data.from_name|cat:"<"|cat:$mail_data.from_email|cat:">"|grn_cellular_truncate:$width|escape}
            {/if}
        {/if}
        <BR>
    {/foreach}


    {if $navi.previous_page_start_position != -1}
        <a href="{grn_cellular_pageurl page="$pagepath/search" sp=$navi.previous_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.cellular.common' key="link_back"}</a>&nbsp;
    {/if}
    {if $navi.next_page_start_position != -1}
        <a href="{grn_cellular_pageurl page="$pagepath/search" sp=$navi.next_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.cellular.common' key="link_next"}</a>
    {/if}
{/if}

<hr>

{grn_cellular_link page="$pagepath/list" aid=$account_info.aid cid=$cid accesskey=9 caption_module='grn.mail.cellular' caption_key="link_list"}<br>
{/strip}
{include file="cellular/footer.tpl"}
