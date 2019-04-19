{* This file is a common hader parts of
 * detail_{checkbox,
 *         menu_string,
 *         numeric,
 *         calc_numeric (workflow only),
 *         radio,
 *         string_multiple,
 *         string_single,
 *         route_search (workflow only),
 *         time (report only),
 *         date, 
 *         file}.tpl
 * if you need modify above files,
 * Please maintenance this file and and above files
 * [Warning] If you modify detail_file.tpl, Please maintenace this file
 *           and detaile_file.tpl
 *}
{* header *}
{if $config_id}
{include file="grn/`$config_id`_head.tpl"}
{include file="grn/`$config_id`_header.tpl"}
{else}
{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{/if}

{if $page_title}
 {grn_title title=$page_title class=$page_info.parts[0]}
{/if}

