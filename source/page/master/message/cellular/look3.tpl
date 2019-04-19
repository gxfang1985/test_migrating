{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="message"}<br>
{$pagetitle|escape}<br>
<hr>

{if $is_snapshot}
    {cb_msg module='grn.message.cellular' key='GRN_MSG_CE-5' replace='true'}
    {grn_cellular_appname app_id="message" no_icon="1"}
    {cb_msg module='grn.message.cellular' key="txt_snapshot_message"}<br>
    {cb_msg module='grn.message.cellular' key="txt_deleted_prefix"}
    {grn_date_format format='DateTimeMiddle_YMDW_HM' date=$del_time}<br>
    <hr>
{/if}

{grn_cellular_pictogram key="memo"}{$title|escape}<br>

<hr>
{foreach item=name from=$sendto}
    {grn_cellular_pictogram key="person"}{$name|escape}<br>
{/foreach}
{if $del_user > 0}
    {cb_msg module='grn.message.cellular' key="txt_deleted_user_comment"}
    ({$del_user}{cb_msg module='grn.message.cellular' key="txt_deleted_user_person"})<br>
{/if}
<hr>

{grn_cellular_link page="$pagepath/look1" rid="$rid" mid="$mid" caption_module='grn.message.cellular' caption_key="link_look"}<br>
{grn_cellular_link page="$pagepath/list" accesskey=3 cid=$cid caption_module='grn.message.cellular' caption_key="link_list"}<br>
{grn_cellular_link page="$pagepath/search" accesskey=4 caption_module='grn.message.cellular' caption_key="link_search"}<br>

{/strip}
{include file="cellular/footer.tpl"}
