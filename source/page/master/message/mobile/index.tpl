{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-withList-grn">
{include file='grn/mobile_breadcrumb.tpl'}
{include file='grn/mobile_folder_list.tpl'}
</div>