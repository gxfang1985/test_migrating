{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

{grn_space_show_expiration_date_warning space=$space}

<h2>{cb_msg module='grn.space' key='appmanage-space-40' replace='true'}</h2>
<div class="space-app-kintoneApps-grn">
    {if count($apps)}
        {foreach from=$apps item=app}
            <div class="space-app-kintoneAppWrap-grn">
                <div class="space-app-kintoneAppDetail-grn">
                    <div class="space-app-kintoneAppDetailInner-grn">
                        <div class="space-app-kintoneAppImage-grn">
                            <img src="{$app.icons.NORMAL}">
                        </div>
                        <div class="space-app-kintoneAppName-grn">
                            {$app.name}
                        </div>
                        <p class="space-app-kintoneAppText-grn">
                            {$app.description}
                        </p>
                    </div>
                    <div class="space-app-kintoneAppInfo-grn">
                        <span class="space-app-kintoneAppInfo-user-grn"><label>{cb_msg module='grn.space' key='appmanage-space-5' replace='true'}</label>{$app.creator.name}</span>
                        <span class="space-app-kintoneAppInfo-date-grn"><label>{cb_msg module='grn.space' key='appmanage-space-6' replace='true'}</label>{grn_date_format date=$app.createdAt_datetime}</span>
                        <div class="clear_both"></div>
                    </div>
                </div>
                <div class="space-app-kintoneAppAction-grn">
                    <a class="icon-add-grn" href="{grn_pageurl page='space/appmanage_add_link_check' spid=$spid kappid=$app.id}">{cb_msg module='grn.space' key='appmanage-space-7' replace='true'}</a>
                </div>
            </div>
        {/foreach}
    {else}
        <div class="space-app-kintoneApp-noApplication-grn">
            {cb_msg module="grn.space" key="appmanage-space-43" replace="true"}
        </div>
    {/if}
</div>
<div class="clear_both"></div>
{include file="grn/footer.tpl"}