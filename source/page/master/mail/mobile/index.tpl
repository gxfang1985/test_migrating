{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{grn_load_javascript file='grn/html/page/mail/mobile/index.js'}
<script language="JavaScript" type="text/javascript">
    grn.page.mail.mobile.index.mobileMailIndexUrl = "{grn_pageurl page='mail/mobile/index'}";
</script>
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-withList-grn">
    {if $account_list|@count > 1}
        {include file="grn/mobile_breadcrumb.tpl" select_menu_include_file="mail/mobile/_select_account.tpl"}
    {else}
        {include file='grn/mobile_breadcrumb.tpl'}
    {/if}
    {if $no_setting neq '0'}
        {grn_title title=$app_name class=$page_info.parts[0]}
        {include file='mail/_no_setting.tpl'}
    {else}
        {include file='mail/mobile/_notes.tpl'}
        {include file='mail/mobile/_receive_button.tpl'}
        {include file='grn/mobile_folder_list.tpl'}
    {/if}
</div>
