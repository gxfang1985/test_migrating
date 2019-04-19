{include file="grn/header_no_siteposition.tpl"}
{if $page_info.parts[0] != "portal" || ($page_info.parts[0] == "portal" && ($page_info.parts[1] == "operation" || $page_info.parts[1] == "personal")) }
{grn_site_position_personal positions=$site_position}
{/if}
<div class="mainarea">
