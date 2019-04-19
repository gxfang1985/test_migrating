{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id='phonemessage'}<br>
{cb_msg module='grn.phonemessage.cellular' key="look_title"}<br>
<hr>

{grn_date_format date=$telmsg.send_time format="DateTimeCompact"}
<BR>

{$telmsg.client_name|escape}
{cb_msg module='grn.phonemessage.cellular' key="look_from"}<BR>
<BR>

{grn_cellular_pictogram key="memo"}
{$telmsg.matter|escape}<BR>
<BR>

{if $telmsg.telephone_number}
    {cb_msg module='grn.phonemessage.cellular' key="look_tel"}
    {grn_cellular_tel tel=$telmsg.telephone_number}<BR>
{/if}
{grn_cellular_pictogram key="clip"}
{cb_msg module='grn.phonemessage.cellular' key="look_memo"}<BR>
{grn_cellular_string_split string=$telmsg.message page_paraname="bp"}<BR>


<BR>

{grn_cellular_pictogram key="person"}
{cb_msg module='grn.phonemessage.cellular' key="look_write"}<BR>
{$telmsg.sender_name|escape}<BR>
<BR>
{if $telmsg.confirm_time == NULL}
    {grn_cellular_form method=post page="$pagepath/command_look" mid=$telmsg.mid}
    {grn_cellular_submit accesskey=1 caption_module='grn.phonemessage.cellular' caption_key="look_checked"}
    </form>
{/if}
<hr>
{/strip}

{if $notify_path}
{grn_cellular_link page="$notify_path/list" app_id="phonemessage"  accesskey=2 caption_module='grn.phonemessage.cellular' caption_key="list"}<BR>
{/if}

{include file="cellular/footer.tpl"}
