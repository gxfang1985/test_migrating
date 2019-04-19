{strip}
{foreach from=$data.apps item=app key=app_id}
{if $app.internal}
    {if $can_use_external_access}
        {if $app.external || $app_id eq 'cellular'}
            {capture name='class_name'}{$app_id}{$app.internal}{/capture}
            {capture name="external_forbidden"}{cb_msg module='grn.system.application' key='GRN_SY_AP-100' replace='true'}{/capture}
        {else}
            {capture name='class_name'}{$app_id}2{/capture}
            {capture name="external_forbidden"}{cb_msg module='grn.system.application' key='GRN_SY_AP-102' replace='true'}{/capture}
        {/if}
    {else}
        {capture name='class_name'}{$app_id}{$app.internal}{/capture}
        {capture name="external_forbidden"}{cb_msg module='grn.system.application' key='GRN_SY_AP-100' replace='true'}{/capture}
    {/if}
{else}
    {capture name='class_name'}{$app_id}0{/capture}
    {capture name="external_forbidden"}{cb_msg module='grn.system.application' key='GRN_SY_AP-101' replace='true'}{/capture}
{/if}

{if $smarty.capture.external_forbidden eq ''}
    <span title="{grn_appname app_id=$app_id}" aria-label="{grn_appname app_id=$app_id}" class="{$smarty.capture.class_name} icon_app_permission_set_grn"></span>
{else}
    <span title="{grn_appname app_id=$app_id}:{$smarty.capture.external_forbidden}" aria-label="{grn_appname app_id=$app_id}:{$smarty.capture.external_forbidden}" class="{$smarty.capture.class_name} icon_app_permission_set_grn"></span>
{/if}

{/foreach}{/strip}<!--{grn_image image=$app.icon class=app$cssclass}-->