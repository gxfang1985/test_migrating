{if ! $kintone_dialog_mode}
{if $smarty.const.ON_FOREST===1}
{include file="grn/warning_message.tpl"}
{include file="grn/header_contents_forest.tpl"}
{else}
{include file="grn/header_contents.tpl"}
{/if}
{/if}
<div id="container-wrap">
    <div id="content">
