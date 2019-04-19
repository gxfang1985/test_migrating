{include file='cellular/header.tpl'}
{strip}
{grn_cellular_pictogram key='config'}{grn_appname app_id='notification'}<br>

{cb_msg module='grn.notification.cellular.conf' key='title'}<br>

<hr>

{cb_msg module='grn.notification.cellular.conf' key="msg"}<br>
<br>
<form method=post action="{grn_cellular_pageurl page="notification/cellular/command_conf"}">

{foreach from=$conf key=app_id item=app}
    <input type=checkbox name='aid[]' value="{$app_id}"{if $app.enable > 0} checked{/if}>
    {if $app.icon}
        {grn_cellular_pictogram key=$app.icon}
    {/if}
    {grn_appname app_id=$app_id}<br>
{/foreach}

{grn_cellular_submit accesskey=1}

</form>
{/strip}
{include file='cellular/conf/footer.tpl'}
