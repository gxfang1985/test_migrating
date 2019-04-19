{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

{grn_load_javascript file="grn/html/page/space/appmanage_view.js"}

{literal}
<script language='JavaScript' type='text/javascript'>
<!--

var __page = grn.page.space.appmanage_view;
__page.url = {/literal}"{grn_pageurl page='space/command_sync'}"{literal};
__page.spid = {/literal}{$spid}{literal};
__page.ticket = {/literal}"{$csrf_ticket}"{literal};
{/literal}{if $needSync}{literal}
jQuery(document).ready(function(){
        __page.sync();
    });
{/literal}{/if}{literal}
//-->
</script>
{/literal}

{grn_space_show_expiration_date_warning space=$space}

<h2>{grn_title title=$page_title}</h2>
<div id="menu_part">
    <div id="smart_main_menu_part">
        <span class="menu_item"><nobr><a href="{grn_pageurl page='space/appmanage_add' spid=$spid}" class="icon-add-grn">{cb_msg module='grn.space' key='appmanage-space-34' replace='true'}</a></nobr></span>
    </div>
</div>

<table class="list_column space-appList-grn">
    <colgroup>
        <col width="60%">
        <col width="30%">
        <col width="10%">
    </colgroup>
    <tr>
        <th>{cb_msg module='grn.space' key='appmanage-space-26' replace='true'}</th>
        <th>{cb_msg module='grn.space' key='appmanage-space-28' replace='true'}</th>
        <th></th>
    </tr>

    {foreach from=$apps item=app name="app_loop"}
        <tr class="{if $smarty.foreach.app_loop.iteration % 2 == 0}lineone{else}linetwo{/if}">
            <td>
                <div class="space-appList-appImage-grn"><img src="{$app.icons.NORMAL}" /></div>
                <span class="space-appList-appName-grn">{$app.name}</span>
                <span class="space-appList-appText-grn">{$app.description}</span>
            </td>
            <td>{$app.name}</td>
            <td><a class="icon-delete-grn" href="{grn_pageurl page='space/appmanage_delete' spid=`$spid` appid=`$app.applicationId`}">{cb_msg module='grn.space' key='appmanage-space-33' replace='true'}</a></td>
        </tr>
    {/foreach}
</table>

<div id="sync_panel" style="display:none;">
    <div id="syncing" style="display:none">
        <div style="width:100%;text-align:center;">
            <div style="margin:50px 0 50px 0;">
                {grn_image image='spinner.gif'}
            </div>
            {cb_msg module='grn.space' key='appmanage-space-30' replace='true'}
        </div>
    </div>
    <div id="sync_complete" style="display:none">
        <div style="width:100%;text-align:center;">
            <div style="margin:50px 0 50px 0;">
                {cb_msg module='grn.space' key='appmanage-space-31' replace='true'}
            </div>
            <input type="button" style="width:100px;" value="OK" onclick="__page.closeDialog()" />
        </div>
    </div>
    <div id="sync_failure" style="display:none">
        <div style="width:100%;text-align:center;">
            <div style="margin:20px 0 10px 20;text-align:left;">
                <b>{cb_msg module='fw.error' key="Error"} (<span id="error_code"></span>)</b><br />
                <span id="error_diag"></span><br />
                <b>{cb_msg module='fw.error' key="Cause"}</b><br />
                <span id="error_cause"></span><br />
                <b>{cb_msg module='fw.error' key="Counter Measure"}</b><br />
                <span id="error_counter"></span><br />
            </div>
            <input type="button" style="width:100px;" value="OK" onclick="__page.closeDialog()" />
        </div>
    </div>
</div>
{include file="grn/footer.tpl"}