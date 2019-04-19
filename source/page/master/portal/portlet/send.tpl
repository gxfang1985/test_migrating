<table class="top_title">
    <tr>
        <td>
            <div class="portlet_action_grn">{strip}
            {foreach from=$applications item=app}
                {if $app.hide neq true}
                    <span class="nowrap-grn mRight10{if $app.disabled} action_base_disable_grn{/if}">
                        <a href="{if $app.disabled}javascript:void(0){else}{grn_pageurl page=$app.page}{/if}" class="icon_{$app.id}_b_grn icon_inline_grn">
                            {$app.name}{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-40' replace='true'}
                        </a>
                    </span>
                {/if}
            {/foreach}
            </div>{/strip}
        </td>
    </tr>
</table>
