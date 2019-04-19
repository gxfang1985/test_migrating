{include file='cellular/header.tpl'}
{strip}

{** トップページコンテンツの表示 **}
{foreach from=$top item=content key=app_id}
{include file='cellular/show_content.tpl' content=$content app_id=$app_id accesskey=''}
{/foreach}

<hr>
{** アプリケーションリンクの表示 **}
{foreach from=$index item=content key=app_id}
{include file='cellular/show_content.tpl' content=$content app_id=$app_id accesskey=-1}
{/foreach}

<a href="{grn_cellular_pageurl page='cellular/conf/menu'}">
{cb_msg module='grn.cellular.common' key='accesskey_nothing'}
{grn_cellular_pictogram key='config'}
{cb_msg module='grn.cellular.common' key='menu_conf'}
</a><br>
{grn_cellular_link page='cellular/menu' accesskey=0 caption_module='grn.cellular.common' caption_key='menu_reload'}<br>
{grn_cellular_form method='post' page='cellular/command_logout'}
    {grn_cellular_submit caption_module='grn.cellular.common' caption_key='log_out'}
</form>
<hr>
{/strip}
