{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

{grn_space_show_expiration_date_warning space=$space}

<div style="text-align:center;">
    <div style="width:600px;margin:20px auto 20px auto;">
        <div style="text-align:left;">
            {cb_msg module='grn.space' key='appmanage-space-8' replace='true'}<br /><br />
            {cb_msg module='grn.space' key='appmanage-space-2' replace='true'}{$app.name}<br />
        </div>
        <br />
        <div>
            <form method="post" action="{grn_pageurl page='space/command_appmanage_add_newapps'}">
                <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}"></input>
                <input type="hidden" name="spid" value="{$spid}"></input>
                <input type="hidden" name="kappid" value="{$app.id}"></input>
                <div class="mTop10 mBottom20">
                    {capture name='grn_space_appmanage_space_3'}{cb_msg module='grn.space' key='appmanage-space-3' replace='true'}{/capture}
                    {strip}
                        {grn_button action="submit" caption=$smarty.capture.grn_space_appmanage_space_3 spacing="normal"}
                        {grn_button action="cancel"}
                    {/strip}
                </div>
            </form>
        </div>
    </div>
</div>
{include file="grn/footer.tpl"}