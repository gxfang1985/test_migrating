{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

{grn_space_show_expiration_date_warning space=$space}

<h2>{cb_msg module='grn.space' key='appmanage-space-35' replace='true'}</h2>
<div class="space-app-addMenu-main-grn">
    <div class="space-app-addMenu-left-grn">
        <div class="space-app-addMenu-grn">
            <span class="space-app-addMenuBtn-grn">
                <a href="{grn_pageurl page='space/appmanage_add_link' spid=`$spid`}" id="appmanage_add_link">
                    <span class="space-app-addMenuBtn-text-grn">
                        {cb_msg module='grn.space' key='appmanage-space-36' replace='true'}
                    </span>
                </a>
            </span>
            <span class="space-app-addMenuText-grn">{cb_msg module='grn.space' key='appmanage-space-37' replace='true'}</span>
            <div class="clear_both"></div>
        </div>
        <div class="space-app-addMenu-grn">
            <span class="space-app-addMenuBtn-grn">
                <a href="{grn_pageurl page='space/appmanage_add_newapps' spid=`$spid`}" id="appmanage_add_newapps">
                    <span class="space-app-addMenuBtn-text-grn">
                        {cb_msg module='grn.space' key='appmanage-space-38' replace='true'}
                    </span>
                </a>
            </span>
            <span class="space-app-addMenuText-grn">{cb_msg module='grn.space' key='appmanage-space-39' replace='true'}</span>
            <div class="clear_both"></div>
        </div>
    </div>
    <div class="space-app-addMenu-right-grn">
        <div class="space-app-addMenu-right-label-grn">{cb_msg module='grn.space' key='appmanage-space-42' replace='true'}</div>
        <div class="space-app-addMenu-right-labelSub-grn"></div>
        <img border="0" src="{$app_path}/grn/image/cybozu/image-app-space/screenAddApp.png" />
    </div>
</div>
<div class="clear_both"></div>
{include file="grn/footer.tpl"}
