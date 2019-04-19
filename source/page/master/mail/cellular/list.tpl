{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="mail"}<br>
{cb_msg module='grn.mail.cellular' key="list"}
<hr>

{if !$no_account_server_data}

{if $size_error}
  {grn_cellular_appname app_id="mail" no_icon=1}{cb_msg module='grn.mail.cellular' key='GRN_MAIL_CE-4' replace='true'}{grn_cellular_appname app_id="mail" no_icon=1}{cb_msg module='grn.mail.cellular' key='GRN_MAIL_CE-5' replace='true'}<br>
{/if}
{if $remaining}
  {cb_msg module='grn.mail.cellular' key='GRN_MAIL_CE-6' replace='true'}{grn_cellular_appname app_id="mail" no_icon=1}{cb_msg module='grn.mail.cellular' key='GRN_MAIL_CE-7' replace='true'}<br>
{/if}
{if $notify_count > 0}
  {cb_msg module='grn.mail.cellular' key='GRN_MAIL_CE-8' replace='true'}&nbsp;{$notify_count|escape}&nbsp;{cb_msg module='grn.mail.cellular' key='GRN_MAIL_CE-9' replace='true'}<br>
{/if}

{grn_cellular_pictogram key="person"}{cb_msg module='grn.mail.cellular' key="list_account"}
[{grn_cellular_link page="$pagepath/acco" aid=$account_info.aid accesskey=1 caption_module='grn.mail.cellular' caption_key="list_modify"}]<br>

{$account_info.account_name|escape}
<hr>
{if  !$cannot_send}
    {grn_cellular_link page="$pagepath/create" aid=$category.aid cid=$category.cid accesskey=2 caption_module='grn.mail.cellular' caption_key="list_mail_create"}<br>
<hr>
{/if}

{if $folders_count > 0}

    {grn_cellular_form name="form" method="get" page="$pagepath/list" aid=$account_info.aid}
    <select name="cid">
    {foreach from=$folders item=item}
        <option value="{$item.cid|escape}"{if $item.cid === $category_id} selected{/if}>
        {$item.name|escape}{if $item.unread_num > 0}[{$item.unread_num}]{/if}
        </option>
    {/foreach}
    </select><br>
    {grn_cellular_submit name="GO" caption_module='grn.mail.cellular' caption_key="list_move"}<br>
    </form>

{/if}

{if  !$cannot_send}
    {grn_cellular_form name="form" method="post" page="$pagepath/command_receive" aid=$account_info.aid}
    {grn_cellular_submit name="receive" accesskey="3" caption_module='grn.mail.cellular' caption_key="list_new_mail_check"}<br>
    </form>
{else}
    {$user_limit_error}
{/if}

{if $mails}
    <hr>
    {foreach from=$mails item=mail_data   }
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
        {if $mail_data.mail_with_tag_flag}
            {$mail_data.name|cat:$mail_data.email|grn_cellular_truncate:$width|escape}
        {else}
            {if $mail_data.email}
            {$mail_data.name|cat:"<"|cat:$mail_data.email|cat:">"|grn_cellular_truncate:$width|escape}
            {/if}
        {/if}
        <BR>
    {/foreach}


    {if $navi.previous_page_start_position != -1}
        <a href="{grn_cellular_pageurl page="$pagepath/list" sp=$navi.previous_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.cellular.common' key="link_back"}</a>&nbsp;
    {/if}
    {if $navi.next_page_start_position != -1}
        <a href="{grn_cellular_pageurl page="$pagepath/list" sp=$navi.next_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.cellular.common' key="link_next"}</a>
    {/if}
{/if}
<hr>

{grn_cellular_link page="$pagepath/search" aid=$category.aid accesskey=9 caption_module='grn.mail.cellular' caption_key="link_search"}<br>

{else}
    {cb_msg module='grn.mail.cellular' key="no_account_no_server_data"}<BR>
    <hr>
{/if}
{/strip}
{include file="cellular/footer.tpl"}
