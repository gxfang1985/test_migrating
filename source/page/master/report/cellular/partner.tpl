{include file="report/cellular/header.tpl"}
{strip}

{grn_report_cellular_appname}<br>
{$pagetitle|escape}<br>
<hr>

{$report.form_name|escape}({$report.name|escape})<br>
<hr>
{* ------------------------------------------------------------------------ *}
{foreach item=partner from=$partners}
    {if $partner->isAccessible() && $partner->getBookId() && $partner->getAddressId()}
      {grn_cellular_pictogram key="person"}<a href="{grn_cellular_pageurl page="address/cellular/look" bid=$partner->getBookId() cid=$partner->getAddressId()}">{$partner->getDisplayName()|escape}</a><br />
    {else}
      {grn_cellular_pictogram key="person"}{$partner->getDisplayName()|escape}<br />
    {/if}
{/foreach}
<hr>

{* ------------------------------------------------------------------------ *}
{grn_report_cellular_link page="$pagepath/look" accesskey=3 rid=$rid type=$type caption_module='grn.report.cellular' caption_key="look"}<br>
{grn_report_cellular_link page="$pagepath/list" accesskey=4 type=$type caption_module='grn.report.cellular' caption_key="list"}<br>
{grn_report_cellular_link page="$pagepath/search" accesskey=5 type=$type caption_module='grn.report.cellular' caption_key="search"}<br>

{/strip}
{include file="report/cellular/footer.tpl"}
