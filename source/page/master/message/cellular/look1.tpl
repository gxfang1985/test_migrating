{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="message"}<br>
{$pagetitle|escape}<br>
<hr>

{if $compdata.is_snapshot}
    {cb_msg module='grn.message.cellular' key='GRN_MSG_CE-2' replace='true'}
    {grn_cellular_appname app_id="message" no_icon="1"}
    {cb_msg module='grn.message.cellular' key="txt_snapshot_message"}<br>
    {cb_msg module='grn.message.cellular' key="txt_deleted_prefix"}
    {grn_date_format format="DateTimeMiddle_YMDW_HM" date=$compdata.delete_time}<br>
    <hr>
{else}
    {if !$is_garbage && $compdata.message_type != 2}
        {grn_cellular_link page="$pagepath/follow" rid="$rid" mid="$mid" accesskey="1" caption_module='grn.message.cellular' caption_key="link_follow"}<br>
    {/if}
{/if}

{$compdata.subject|escape}<br>

{if $is_garbage}
    {cb_msg module='grn.message.cellular' key="txt_garbage_message"}<br>
{else}
    {if $compdata.message_type == 1}
        {cb_msg module='grn.message.cellular' key="txt_send_message"}<br>
    {elseif $compdata.message_type == 2}
        {cb_msg module='grn.message.cellular' key="txt_draft_message"}<br>
    {/if}
{/if}
<hr>

{grn_cellular_pictogram key="clock"}
{grn_date_format format="DateTimeShort_YMD_HM" date=$compdata.ctime}<br>

{grn_cellular_pictogram key="person"}
{$compdata.creator_name|escape}<br>

{grn_cellular_pictogram key="memo"}

{grn_cellular_string_split string=$compdata.data page_paraname="bp"}<BR>

{if $need_confirm}
    [{grn_cellular_pictogram key="checked"}{cb_msg module='grn.message.cellular' key="txt_need_confirm"}]<br>
{/if}

{if $attach_files}
    [{grn_cellular_pictogram key="clip"}{cb_msg module='grn.message.cellular' key="txt_attach_file"}]<br>
{/if}

{if !$compdata.is_snapshot && !$is_garbage && $compdata.message_type == 0 && $need_confirm && !$confirmed}
    {if $attach_files}
        {cb_msg module='grn.message.cellular' key='GRN_MSG_CE-3' replace='true'}<br>
    {else}
        {assign var='form_name' value='message/cellular/confirm'}
        {grn_cellular_form name=$form_name method=post page="$pagepath/command_confirm" rid="$rid" mid="$mid"}
        {grn_cellular_submit caption_module='grn.message.cellular' caption_key="submit_confirm"}
        </form>
    {/if}
{/if}

{if $addresses}
    <br>
    {grn_cellular_pictogram key="joint"}{cb_msg module='grn.message.cellular' key="txt_address"}<br>
    {foreach from=$addresses item=name}
        &nbsp;&nbsp;{$name|escape}<br>
    {/foreach}
    {if $more_address}
        &nbsp;&nbsp;{grn_cellular_link page="$pagepath/look3" rid="$rid" mid="$mid" caption_module='grn.message.cellular' caption_key="link_look3"}<br>
    {/if}
{/if}

{if count($followdata) gt 0}
    <a name="follow"></a>
    <hr>
    {foreach item=one from=$followdata}
        {grn_cellular_pictogram key="follow"}
        {grn_cellular_link page="$pagepath/look2" rid=$rid mid=$mid fid=$one.fid caption=$one.title|regex_replace:"/[ \t\r\n]/":""|default:"."|grn_cellular_truncate:$width}<br>
        {$one.id}{cb_msg module='grn.message.cellular' key='GRN_MSG_CE-4' replace='true'}{grn_date_format format='DateTimeCompact' date=$one.date}&nbsp;{$one.post_user|escape}<br>
    {/foreach}
    <br>
    {if $prev_follow}
        {grn_cellular_link page="$pagepath/look1" rid="$rid" mid="$mid" bp="$bp" fp="$prev_fp" fragment="follow" caption_module='grn.cellular.common' caption_key="link_back"}
        &nbsp;
    {/if}
    {if $next_follow}
        {grn_cellular_link page="$pagepath/look1" rid="$rid" mid="$mid" bp="$bp" fp="$next_fp" fragment="follow" caption_module='grn.cellular.common' caption_key="link_next"}
    {/if}
{/if}

<hr>
{if $is_operator}
    {if $compdata.message_type == 2}
        {grn_cellular_link page="$pagepath/create" accesskey=2 rid="$rid" mid="$mid" cid=$cid cs=1 caption_module='grn.message.cellular' caption_key="link_draftsend"}<br>
        {if $attach_files}
            ({cb_msg module='grn.message.cellular' key="txt_draftsend_attachfile"})<br>
        {/if}
    {elseif !$is_garbage}
        {grn_cellular_link page="$pagepath/change" accesskey=2 rid="$rid" mid="$mid" cid=$cid cs=1 caption_module='grn.message.cellular' caption_key="link_change"}<br>
    {/if}
{/if}

{grn_cellular_link page="$pagepath/delete" rid="$rid" mid="$mid" caption_module='grn.message.cellular' caption_key="link_delete"}<br>
<hr>

{grn_cellular_link page="$pagepath/list" accesskey=3 cid=$cid caption_module='grn.message.cellular' caption_key="link_list"}<br>
{grn_cellular_link page="$pagepath/search" accesskey=4 caption_module='grn.message.cellular' caption_key="link_search"}<br>

{/strip}
{include file="cellular/footer.tpl"}
