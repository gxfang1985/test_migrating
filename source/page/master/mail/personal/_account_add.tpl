{if $system.user_all_permission}{include file='grn/indispensable.tpl'}{/if}
<table class="std_form">
    <colgroup>
        <col style="width:10em">
        <col>
    </colgroup>
    <tr valign="top">
        <th nowrap>
            {capture name='grn_mail_personal_GRN_MAIL_PE_1'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-1' replace='true'}{/capture}
            {grn_show_input_title title=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_1}
        </th>
        <td>
            {grn_text name='name' size='50' value=$set.name}
            <div class="sub_explanation">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-2' replace='true'}</div>
        </td>
    </tr>
    <tr>
        <td nowrap>
            <br>
            <div class="sub_title">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-4' replace='true'}</div>
        </td>
    </tr>
    <tr>
        <th nowrap>
            {capture name='grn_mail_personal_GRN_MAIL_PE_5'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-5' replace='true'}{/capture}
            {grn_show_input_title title=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_5 necessary=$system.user_all_permission}
        </th>
        <td>
            {if $system.user_all_permission}
                {capture name='grn_mail_personal_GRN_MAIL_PE_275'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-275' replace='true'}{/capture}
                {validate form=$page_info.all field="mail_server" criteria="notEmpty" message=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_275 append="validation_errors"}
                {grn_select name='mail_server' options=$mail_server onchange="changeDisplay(this,'display_set_send_account',$server_set_send,'sm');changeDisplay(this,'display_set_send_password',$server_set_send,'sm');"}
            {else}
                {$set.mail_server|escape}
            {/if}
            {if $set.msid eq ''}
                &nbsp;{include file='mail/_mailserver_viewlist.tpl'}
            {else}
                <span class="required">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-6' replace='true'}</span>
            {/if}
        </td>
    </tr>
    <tr>
        <th nowrap>
            {grn_show_input_title title='E-mail' necessary=$system.user_all_permission}
        </th>
        <td>
            {if $system.user_all_permission}
                {capture name='grn_mail_personal_GRN_MAIL_PE_276'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-276' replace='true'}{/capture}
                {validate form=$page_info.all criteria="notEmpty" field="email" message=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_276 transform="cb_trim" append="validation_errors"}
                {grn_text name='email' size='50' value=$set.email}
            {else}
                {$set.email|escape}
            {/if}
        </td>
    </tr>
    <tr>
        <th nowrap>
            {capture name='grn_mail_personal_GRN_MAIL_PE_7'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-7' replace='true'}{/capture}
            {grn_show_input_title title=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_7 necessary=$system.user_all_permission}
        </th>
        <td>
            {if $system.user_all_permission}
                {capture name='grn_mail_personal_GRN_MAIL_PE_277'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-277' replace='true'}{/capture}
                {validate form=$page_info.all criteria="notEmpty" field="account" message=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_277 transform="cb_trim" append="validation_errors"}
                {grn_text name='account' size='50' value=$set.account}
            {else}
                {$set.account|escape}
            {/if}
        </td>
    </tr>
    <tr>
        <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-8' replace='true'}</th>
        <td>{capture name='grn_mail_personal_GRN_MAIL_PE_9'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-9' replace='true'}{/capture}{grn_password name="password" purpose='modify' size=50 maxlength=64 title=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_9 disable_return_key=true}</td>
    </tr>
    {if $system.user_leave_server_mail}
        <tr>
            <th nowrap>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-10' replace='true'}{$app_name|escape}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-11' replace='true'}</th>
            <td>
                {if $set.leave_server_mail eq 'LEAVE'}
                    {capture name='grn_mail_personal_GRN_MAIL_PE_12'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-12' replace='true'}{/capture}{grn_radio name='leave_server_mail' id='leave_server_mail1' value='LEAVE' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_12 checked=TRUE}&nbsp;{capture name='grn_mail_personal_GRN_MAIL_PE_13'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-13' replace='true'}{/capture}{grn_radio name='leave_server_mail' id='leave_server_mail2' value='DELETE' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_13}
                    <br>
                {else}
                    {capture name='grn_mail_personal_GRN_MAIL_PE_14'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-14' replace='true'}{/capture}{grn_radio name='leave_server_mail' id='leave_server_mail1' value='LEAVE' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_14}&nbsp;{capture name='grn_mail_personal_GRN_MAIL_PE_15'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-15' replace='true'}{/capture}{grn_radio name='leave_server_mail' id='leave_server_mail2' value='DELETE' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_15 checked=TRUE}
                    <br>
                {/if}
            </td>
        </tr>
    {/if}

    <tr id="display_set_send_account" {if ! $set.set_send}style="display:none"{/if}>
        <th nowrap>
            {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-16' replace='true'}
        </th>
        <td>
            {if $system.user_all_permission}
                {grn_text name='send_account' size='50' value=$set.send_account}
            {else}
                {$set.send_account|escape}
            {/if}
        </td>
    </tr>
    <tr id="display_set_send_password" {if ! $set.set_send}style="display:none"{/if}>
        <th nowrap>
            {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-17' replace='true'}
        </th>
        <td>
            {capture name='grn_mail_personal_GRN_MAIL_PE_18'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-18' replace='true'}{/capture}{grn_password name="send_password" purpose='modify' size=50 maxlength=64 title=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_18 disable_return_key=true}
        </td>
    </tr>
    {if $system.user_all_permission}
        <tr>
            <th nowrap>
                {cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-241' replace='true'}
            </th>
            <td>
                {capture name='grn_mail_personal_GRN_MAIL_PE_242'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-242' replace='true'}{/capture}
                {if $set.stop}
                    {grn_checkbox name="stop" id='stop1' value='1' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_242 checked=TRUE}
                {else}
                    {grn_checkbox name="stop" id='stop1' value='1' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_242}
                {/if}
            </td>
        </tr>
    {/if}
    <tr>
        <td></td>
        <td>
            {include file="$button_file"}
        </td>
    </tr>
</table>
