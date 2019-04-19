{include file="cellular/header.tpl"}
{strip}

{grn_cellular_appname app_id="bulletin"}<br>
{$pagetitle|escape}<br>
<hr>
{cb_msg module='grn.bulletin.cellular' key="txt_search_notice"}

{grn_cellular_form name="form2" method="get" page="$pagepath/search"}
<input type="text" name="text" value="{$text|escape}" istyle="1" mode="hiragana"><br>
<input type=submit accesskey="1" value="{grn_cellular_pictogram key="num1"}{cb_msg module='grn.cellular' key="search"}"><br>
</form>

{if $result}
 <hr>
 {foreach from=$result item=article}
  {grn_cellular_link page="$pagepath/look1" aid=$article.aid icon="memo" caption=$article.title|regex_replace:"/[ \t\r\n]/":""|grn_cellular_truncate:$width}<br>
  {cb_date_format format='DateTimeCompact' date=$article.ntime}&nbsp;{$article.notifier_name|escape}<br>
 {/foreach}
 {include file="bulletin/cellular/navi.tpl"}
{/if}

<hr>

{grn_cellular_link page="$pagepath/list" cid=$cid accesskey="3" caption_module='grn.bulletin.cellular' caption_key="list"}<br>
{/strip}
{include file="cellular/footer.tpl"}
