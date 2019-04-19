{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="bulletin"}<br>
{$pagetitle|escape}<br>
<hr>

{if $categories_count > 0}

    {grn_cellular_form name="form" method="get" page="$pagename"}
    <select name="cid">
    {foreach from=$categories item=item}
        <option value="{$item.cid|escape}"{if $item.cid === $current_cid} selected{/if}>
        {$item.name|escape}
        </option>
    {/foreach}
    </select><br>
    {grn_cellular_submit name="GO" accesskey="1" caption_module='grn.bulletin.cellular' caption_key="txt_select"}<br>
    </form>

{/if}

{if $articles}
    <br>
    {foreach from=$articles item=article}
        {grn_cellular_link page="$pagepath/look1" aid=$article.aid from="list" icon="memo" caption=$article.title|regex_replace:"/[ \t\r\n]/":""|grn_cellular_truncate:$width}<br>
        {cb_date_format format='DateTimeCompact' date=$article.ntime}&nbsp;{$article.notifier_name|escape}<br>
    {/foreach}
    {include file="bulletin/cellular/navi.tpl"}
{/if}

<hr>

{grn_cellular_link page="$pagepath/search" accesskey="4" caption_module='grn.bulletin.cellular' caption_key="search"}<br>
{/strip}
{include file="cellular/footer.tpl"}
