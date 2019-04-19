{include file='grn/head.tpl'}
{include file='grn/header.tpl'}

<h2 class="{$page_info.parts[0]}">{$page_title}<span style="font-size:70%;font-weight:normal">
</span></h2> 
{assign var='form_name' value=$smarty.template|basename}
<p>
<form name="{$form_name}" method="post" action="{grn_pageurl page='phonemessage/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="cid" value="{$category_id}">
    <input type="hidden" name="gid" value="{$group_id}">
    <input type="hidden" name="uid" value="{$user.uid}">
    <input type="hidden" name="receiver" value="{$user.uid}">
    <input type="hidden" name="sender" value="{$login.id}">
    <input type="hidden" name="current_timestamp" value="{$current_timestamp}">
    <table class="std_form">
        <tr>
            <th>{cb_msg module='grn.phonemessage' key='GRN_PHM-20' replace='true'}</th>
            <td>
                {grn_user_name uid=$user.uid}{if $user.email_flags}<br>{cb_msg module='grn.phonemessage' key='GRN_PHM-21' replace='true'}{/if}
            </td>
        </tr>
        <tr>
            <th>{cb_msg module='grn.phonemessage' key='GRN_PHM-22' replace='true'}</th>
            <td>
                {grn_date_format format='DateLong_YMDW'}
                {grn_select_time prefix='fixed_' time=$current_time}&nbsp;{cb_msg module='grn.phonemessage' key='GRN_PHM-23' replace='true'}
            </td>
        </tr>
        <tr>
            <th>{cb_msg module='grn.phonemessage' key='GRN_PHM-24' replace='true'}</th>
            <td>{grn_text name='client_name' style='width:347px;'}&nbsp;{cb_msg module='grn.phonemessage' key='GRN_PHM-25' replace='true'}</td>
        </tr>
        <tr valign="top">
            <th>{cb_msg module='grn.phonemessage' key='GRN_PHM-26' replace='true'}</th>
            <td>
                {capture name='grn_phonemessage_GRN_PHM_27'}{cb_msg module='grn.phonemessage' key='GRN_PHM-27' replace='true'}{/capture}{capture name='grn_phonemessage_GRN_PHM_28'}{cb_msg module='grn.phonemessage' key='GRN_PHM-28' replace='true'}{/capture}{grn_radio name='matter' id='matter_1' value="please_call" caption=$smarty.capture.grn_phonemessage_GRN_PHM_28 checked=true}
                &nbsp;{cb_msg module='grn.phonemessage' key='GRN_PHM-29' replace='true'}{grn_text name='telephone_number' style='width:121px;'}<br>
                {capture name='grn_phonemessage_GRN_PHM_30'}{cb_msg module='grn.phonemessage' key='GRN_PHM-30' replace='true'}{/capture}{capture name='grn_phonemessage_GRN_PHM_31'}{cb_msg module='grn.phonemessage' key='GRN_PHM-31' replace='true'}{/capture}{grn_radio name='matter' id='matter_2' value="just_give_my_regards" caption=$smarty.capture.grn_phonemessage_GRN_PHM_31}<br>
                {capture name='grn_phonemessage_GRN_PHM_32'}{cb_msg module='grn.phonemessage' key='GRN_PHM-32' replace='true'}{/capture}{capture name='grn_phonemessage_GRN_PHM_33'}{cb_msg module='grn.phonemessage' key='GRN_PHM-33' replace='true'}{/capture}{grn_radio name='matter' id='matter_3' value="i_will_leave_a_message" caption=$smarty.capture.grn_phonemessage_GRN_PHM_33}<br>
            </td>
        </tr>
        <tr valign="top">
            <th>{cb_msg module='grn.phonemessage' key='GRN_PHM-34' replace='true'}</th>
            <td>{grn_textarea name='message' style='width:345px;'}</td>
        </tr>
        <tr>
            <th>{cb_msg module='grn.phonemessage' key='GRN_PHM-35' replace='true'}</th>
            <td>{grn_user_name uid=$login.id nolink=true}</td>
        </tr>
        <tr>
            <td></td>
            <td>
                <div class="mTop10">
                    {strip}
                        {capture name='grn_phonemessage_GRN_PHM_36'}{cb_msg module='grn.phonemessage' key='GRN_PHM-36' replace='true'}{/capture}
                        {grn_button id="phone_messages_button_send" action='submit' ui='main' spacing='normal' caption=$smarty.capture.grn_phonemessage_GRN_PHM_36}
                        {if $application}
                            {grn_button id="phone_messages_button_cancel" action='cancel' page=$application.cancel_page page_param_uid=$application.uid page_param_gid=$application.gid page_param_bdate=$application.bdate page_param_sp=$application.sp}
                        {else}
                            {grn_button id="phone_messages_button_cancel" action='cancel' page='phonemessage/index' page_param_gid=$group_id page_param_sf=1}
                        {/if}
                    {/strip}
                </div>
            </td>
        </tr>
    </table>
</form>

{include file='grn/footer.tpl'}
