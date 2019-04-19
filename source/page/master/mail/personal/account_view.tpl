{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

{if $system.user_all_permission || $system.user_account_modify}
    <div id="main_menu_part">
        {if $system.user_account_modify}
            <span class="menu_item">{capture name='grn_mail_personal_GRN_MAIL_PE_164'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-164' replace='true'}{/capture}{grn_link image='modify20.gif' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_164 page='mail/personal/account_modify' aid=$set.aid}</span>
        {/if}
        {if $system.user_all_permission}
            <span class="menu_item">{capture name='grn_mail_personal_GRN_MAIL_PE_165'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-165' replace='true'}{/capture}{grn_link image='delete20.gif' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_165 page='mail/personal/account_delete' aid=$set.aid}</span>
        {/if}
    </div>
{/if}

<p></p>

<table class="view_table">
    <tr>
        <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-166' replace='true'}</th>
        <td>{$set.name|escape}</td>
    </tr>
</table>

<p></p>

<div class="sub_title">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-167' replace='true'}</div>
<table class="view_table">
    <tr>
        <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-168' replace='true'}</th>
        <td>{$set.mail_server|escape}&nbsp;&nbsp;{include file='mail/_mailserver_viewlist.tpl'}</td>
    </tr>
    <tr>
        <th nowrap>E-mail</th>
        <td>{$set.email|escape}</td>
    </tr>
    <tr>
        <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-169' replace='true'}</th>
        <td>{$set.account|escape}</td>
    </tr>
    {if $system.user_leave_server_mail}
        <tr>
            <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-170' replace='true'}{$app_name|escape}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-171' replace='true'}</th>
            <td>{if $set.leave_server_mail eq 'LEAVE'}{capture name='grn_mail_personal_GRN_MAIL_PE_172'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-172' replace='true'}{/capture}{grn_sentence image='check20.gif' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_172}{else}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-173' replace='true'}{/if}</td>
        </tr>
    {/if}
    {if $set.set_send}
        <tr>
            <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-174' replace='true'}</th>
            <td>{$set.send_account|escape}</td>
        </tr>
    {/if}
    {if $system.user_all_permission}
        <tr>
            <th nowrap>
                {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-238' replace='true'}
            </th>
            <td>
                {if !$set.stop}
                    <font color="green">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-239' replace='true'}</font>
                {else}
                    <font color="red">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-240' replace='true'}</font>
                {/if}
            </td>
        </tr>
    {/if}
</table>

{include file='grn/personal_footer.tpl'}
