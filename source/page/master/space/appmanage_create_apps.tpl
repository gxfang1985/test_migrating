{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

{grn_load_javascript file="grn/html/page/space/appmanage_create.js"}

{grn_space_show_expiration_date_warning space=$space}

<h2>{$page_title}</h2>
<form method="post" name="space/appmanage_create_apps" enctype="multipart/form-data" action="{grn_pageurl page='space/command_appmanage_create_apps'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}"></input>
    <input type="hidden" name="spid" value="{$spid}"></input>
    <table class="std_form">
        <tr>
            <th>{cb_msg module='grn.space' key='appmanage-space-15' replace='true'}</th>
            <td>
                <input type="text" name="appname" id="appname" size="50" maxlength="64"></input>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <div class="mTop10">
                    {capture name='grn_space_appmanage_space_18'}{cb_msg module='grn.space' key='appmanage-space-18' replace='true'}{/capture}
                    {strip}
                        {grn_button action="submit" ui="main" id="app_create"
                            caption=$smarty.capture.grn_space_appmanage_space_18
                            spacing="normal" disabled=true}
                        {grn_button action="cancel" page="space/appmanage_add_newapps" page_param_spid=$spid}
                    {/strip}
                </div>
            </td>
        </tr>
    </table>
</form>
{include file="grn/footer.tpl"}
