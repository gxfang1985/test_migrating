{if ! $kintone_dialog_mode}
<!-- application menu -->
{grn_application_menu}

{if $page_info.parts[0] != "portal" || ($page_info.parts[0] == "portal" && $page_info.parts[1] == "operation") }
    {grn_site_position positions=$site_position}
{/if}
{/if}

{include file="grn/header_no_siteposition.tpl" display_appmenu="none" }

<div class="mainarea {$main_area_class}">
