{if $settings.font_size == "large"}
    {assign var="font_size" value='font-size:140%;'}
{elseif $settings.font_size == "normal"}
    {assign var="font_size" value='font-size:100%;'}
{elseif $settings.font_size == "small"}
    {assign var="font_size" value='font-size:70%;'}
{/if}
{assign var="menu_count" value=1}
<div class="portal_frame portal_frame_application_menu_grn">
    <div class="margin_bottom portlet_appmenu">
        <div class="application_menu">
        {foreach name="menu" from=$extended_application key=e_aid item=e_app iteration=count}
            {if $settings.use_turnup}
                {assign var="menu_count" value="`$smarty.foreach.menu.iteration%$settings.turnup_size`"}
            {/if}
            <span class="appmenu-item" title="{$e_app.name}">{strip}
                <a href="{$e_app.location}">
                    {if $e_app.icon}
                        {if ! $e_app.app_id}
                            {*任意のURL画像あり*}
                            {if $settings.display_type != 3}<img border="0" class="appmenu-item-icon" src="{$e_app.icon}" alt="{$e_app.name}">{/if}
                        {else}
                            {*デフォルトアプリ*}
                            {if $settings.display_type != 3}<div class="icon-appMenu-{$e_app.app_id} appmenu-item-icon"></div>{/if}
                        {/if}
                    {else}
                        {*任意のURL画像なし*}
                        {if $settings.display_type != 3}<div class="icon-appMenu-defaultmenu appmenu-item-icon"></div>{/if}
                    {/if}
                    {if $settings.display_type != 1}<br>{/if}
                    <nobr>{if $settings.display_type != 2}{$e_app.name|escape}{/if}</nobr>
                </a>
            </span>{/strip}
            {if $menu_count==0 }<br>{/if}
        {/foreach}
        {$ct}
        </div>
    </div>
</div> <!--end of portal_frame -->
