{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{if $no_setting neq '0'}
    {include file='mail/_no_setting.tpl'}
{else}
    {if $system.user_all_permission || $system.user_account_modify}
        <div id="main_menu_part">
            {if $system.user_all_permission}
                <span class="menu_item">{capture name='grn_mail_personal_GRN_MAIL_PE_233'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-233' replace='true'}{/capture}{grn_link image='write20.gif' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_233 page='mail/personal/account_add' disabled=$disabled_add_account}</span>
            {/if}
            {if $system.user_account_modify}
                <span class="menu_item">{capture name='grn_mail_personal_GRN_MAIL_PE_234'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-234' replace='true'}{/capture}{grn_link image='order20.gif' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_234 page='mail/personal/account_order' disabled=$disabled_change_order}</span>
            {/if}
        </div>
    {/if}
    <p></p>
    <table class="list_column">
        <colgroup>
            <col width="40%">
            <col width="25%">
            <col width="35%">
        </colgroup>
        <tr>
            <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-236' replace='true'}</th>
            <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-237' replace='true'}</th>
            <th nowrap>E-mail</th>
        </tr>
        {foreach name=account_count from=$account_list item=account}
            <tr valign="top">
                {assign var='account_class' value=''}
                {if $account.stop}
                    {assign var='account_class' value='gray'}
                {/if}
                {if $account.deleted}
                    {assign var='account_class' value='column_red'}
                {/if}
                <td class="{$account_class}">{grn_link image='mailaccount20.gif' caption=$account.title page='mail/personal/account_view' aid=$account.aid}</td>
                <td class="{$account_class}">{$account.mailserver.name|escape}</td>
                <td class="{$account_class}">{$account.email|escape}</td>
            </tr>
        {/foreach}
    </table>
    <div class="margin_top">
        <div class="small_notes">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-243' replace='true'}</div>
        {if $system.user_all_permission}
            <div class="small_notes">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-235' replace='true'}</div>
        {/if}
    </div>
{/if}

{include file='grn/personal_footer.tpl'}
