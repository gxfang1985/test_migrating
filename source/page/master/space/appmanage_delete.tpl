{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

{grn_load_javascript file="grn/html/page/space/appmanage_delete.js"}

{literal}
<script language='JavaScript' type='text/javascript'>
<!--
var __page = grn.page.space.appmanage_delete;
//-->
</script>
{/literal}

{grn_space_show_expiration_date_warning space=$space}

<div style="text-align:center;">
    <div style="width:600px;margin:20px auto 20px auto;text-align:left;">
        {cb_msg module='grn.space' key='appmanage-space-20' replace='true'}<br />
        {cb_msg module='grn.space' key='appmanage-space-2' replace='true'}{$app->getApplicationName()|escape}<br />
        <br />
        <form name="form" id="appmanage_delete_form" action="{grn_pageurl page='space/command_appmanage_delete'}" method="post">
        <table>
            <tr>
                <td style="width:100px;">{cb_msg module='grn.space' key='appmanage-space-21' replace='true'}</td>
                <td>
                    {capture name='tmp1'}{cb_msg module='grn.space' key='appmanage-space-23' replace='true'}{/capture}
                    {capture name='tmp2'}{cb_msg module='grn.space' key='appmanage-space-24' replace='true'}{/capture}
                    {if $isOwner}
                        {grn_radio id="unlink" name='delete_method' value='unlink' caption=$smarty.capture.tmp1 checked=true }<br>
                        {grn_radio id="remove" name='delete_method' value='remove' caption=$smarty.capture.tmp2 }<br>
                    {else}
                        {grn_radio id="unlink" name='delete_method' value='unlink' caption=$smarty.capture.tmp1 checked=true }<br>
                        {grn_radio id="remove" name='delete_method' value='remove' caption=$smarty.capture.tmp2 disabled=true}<br>
                    {/if}
                    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}"></input>
                    <input type="hidden" name="spid" value="{$spid}"></input>
                    <input type="hidden" name="appid" value="{$app->getId()}"></input>
                </td>
            </tr>
        </table>
        <br />
        <div style="margin-left:100px;">
            <div class="mTop10 mBottom20">
                {capture name='grn_space_appmanage_space_41'}{cb_msg module='grn.space' key='appmanage-space-41' replace='true'}{/capture}
                {strip}
                    {grn_button id="remove_app_button" caption=$smarty.capture.grn_space_appmanage_space_41 spacing="normal"}
                    {grn_button action="cancel"}
                {/strip}
            </div>
        </div>
        </form>
    </div>
</div>
{include file="grn/footer.tpl"}