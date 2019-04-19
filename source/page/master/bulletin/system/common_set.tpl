{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/system/command_common_set'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

    <p>
    <table class="std_form">
        <!--category_items-->
        <tr>
            <th>{capture name='grn_bulletin_system_GRN_BLLT_SYS_75'}{cb_msg module='grn' key='grn.comment.permission' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_75}</th>
            <td>{capture name='grn_bulletin_system_GRN_BLLT_SYS_76'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-76' replace='true'}{/capture}{grn_checkbox name='enable_follow' id='enable_follow' value=1 checked=$enable_follow caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_76}</td>
        </tr>
        <tr>
            <th>{capture name='grn_bulletin_system_GRN_BLLT_SYS_77'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-77' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_77}</th>
            <td>{capture name='grn_bulletin_system_GRN_BLLT_SYS_78'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-78' replace='true'}{/capture}{grn_checkbox name='enable_htmleditor' id='enable_htmleditor' value=1 checked=$enable_htmleditor caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_78}</td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn' key='grn.comment.permission.conf.anchor' replace='true'}</th>
            <td>
                {capture name='grn_bulletin_system_GRN_BLLT_SYS_80'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-80' replace='true'}{/capture}{grn_checkbox name="enable_follow_autolink" id="enable_follow_autolink" value="1" caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_80 checked=$enable_follow_autolink}
            </td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-176' replace='true'}</th>
            <td>
                {capture name='grn_bulletin_system_GRN_BLLT_SYS_177'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-177' replace='true'}{/capture}{grn_checkbox name="enable_acknowledgement" id="enable_acknowledgement" value="1" caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_177 checked=$enable_acknowledgement}
            </td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-178' replace='true'}</th>
            <td>
                {grn_load_javascript file="grn/html/page/bulletin/system/common_set.js"}
                {capture name='grn_bulletin_system_GRN_BLLT_SYS_179'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-179' replace='true'}{/capture}
                {grn_checkbox name="enable_manually_enter_sender" id="enable_manually_enter_sender" value="1" caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_179 checked=$enable_manually_enter_sender}

                <br>
                <label id="default_value_from_label" {if !$enable_manually_enter_sender}class="form_disable"{/if}>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-180' replace='true'}</label>
                <input id="user_name" type="radio" value="0" name="default_value_from" {if $default_value_from=='0'}checked{/if} {if !$enable_manually_enter_sender}disabled{/if}>
                <label id="user_name_label" for="user_name" {if $enable_manually_enter_sender}onmouseover="this.style.color='#ff0000'" onmouseout="this.style.color=''"{/if} {if !$enable_manually_enter_sender}class="form_disable"{/if}>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-181' replace='true'}</label>
                <input id="input_manually" type="radio" value="1" name="default_value_from" {if $default_value_from=='1'}checked{/if} {if !$enable_manually_enter_sender}disabled{/if}>
                <label id="input_manually_label" for="input_manually" {if $enable_manually_enter_sender}onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'"{/if} {if !$enable_manually_enter_sender}class="form_disable"{/if}>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-182' replace='true'}</label>
            </td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-183' replace='true'}</th>
            <td>
                {capture name='grn_bulletin_system_GRN_BLLT_SYS_184'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-184' replace='true'}{/capture}{grn_checkbox name="enable_confirm_authority_read_and_notification_users" id="enable_confirm_authority_read_and_notification_users" value="1" caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_184 checked=$enable_confirm_authority_read_and_notification_users}
            </td>
        </tr>
        <tr>
            <td><br></td>
            <td>
                {capture name='grn_bulletin_system_GRN_BLLT_SYS_81'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-81' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_81}
                {grn_button_cancel}
            </td>
        </tr>
    </table>

</form>
{include file="grn/system_footer.tpl"}
