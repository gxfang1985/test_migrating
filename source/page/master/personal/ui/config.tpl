{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='personal/ui/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <table class="std_form">
        <tr>
            <td>
                <div class="sub_title">{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-28' replace='true'}</div>
            </td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-29' replace='true'}</th>
            <td>{grn_select_numbers select_name=$config.list_max.select_name options=$config.list_max.options selected=$config.list_max.selected padding=$config.list_max.padding}&nbsp;{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-30' replace='true'}</td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn' key='grn.ui.maximum.number.of.comments' replace='true'}</th>
            <td>{grn_select_numbers select_name=$config.follow_max.select_name options=$config.follow_max.options selected=$config.follow_max.selected padding=$config.follow_max.padding}&nbsp;{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-32' replace='true'}</td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-33' replace='true'}</th>
            <td>{grn_select_numbers select_name=$config.subject_width.select_name options=$config.subject_width.options selected=$config.subject_width.selected padding=$config.subject_width.padding}&nbsp;{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-34' replace='true'}</td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn' key='grn.ui.num.of.body.and.comments' replace='true'}</th>
            <td>{grn_select_numbers select_name=$config.truncate_width.select_name options=$config.truncate_width.options selected=$config.truncate_width.selected padding=$config.truncate_width.padding}&nbsp;{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-36' replace='true'}</td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-37' replace='true'}</th>
            <td>{grn_select_numbers select_name=$config.name_width.select_name options=$config.name_width.options selected=$config.name_width.selected padding=$config.name_width.padding}&nbsp;{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-38' replace='true'}</td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-39' replace='true'}</th>
            <td>{grn_select name=$config.mailto_application.select_name options=$config.mailto_application.options}</td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-40' replace='true'}</th>
            <td>{capture name='grn_personal_ui_GRN_PRS_UI_42'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-42' replace='true'}{/capture}{grn_checkbox name="inline_setting" id="inline_setting" value="1" checked=$config.inline_setting caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_42}</td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-43' replace='true'}</th>
            <td>
                <label>
                    <select name="export_charset">
                        {if ! $config.export_charset.fixed}
                        <option value="">{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-44' replace='true'}
                        {/if}
                        {foreach from=$config.export_charset.encodings key=encoding item=name}
                            {if ! $config.export_charset.fixed || $config.export_charset.default == $encoding}
                            <option value="{$encoding}"{if $encoding == $config.export_charset.value} selected{/if}>{$name}
                            {/if}
                        {/foreach}
                    </select>
                </label>
            </td>
        </tr>
        <tr>
            <th nowrap id="th-username-format">{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-183' replace='true'}</th>
            <td id="td-username-format">
            {if $nickname_enabled}
                {capture name='grn_personal_ui_GRN_PRS_UI_184'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-184' replace='true'}{/capture}
                {grn_checkbox name="user_name_format" id="user_name_format" value="1" checked=$config.user_name_format caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_184}
                <br />
            {/if}
            {capture name='grn_personal_ui_GRN_PRS_UI_187'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-187' replace='true'}{/capture}
            {grn_checkbox name="show_priority_group" id="show_priority_group" value="1" checked=$config.show_priority_group caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_187}
            </td>
        </tr>
        {if $system_config.user_icon}
        <tr>
            <th id="th_user_icon_format">{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-188' replace='true'}</th>
            <td id="td_user_icon_format">
            {capture name='grn_personal_ui_GRN_PRS_UI_189'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-189' replace='true'}{/capture}
            {grn_checkbox name="user_icon" id="user_icon" value="1" checked=$config.user_icon caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_189}
            </td>
        </tr>
        {/if}
        <tr>
            <td><br></td>
        </tr>
        <tr>
            <td><div class="sub_title">{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-45' replace='true'}</div></td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-46' replace='true'}</th>
            <td>{grn_select_numbers select_name=$config.area_width.select_name options=$config.area_width.options padding=$config.area_width.padding selected=$config.area_width.selected}&nbsp;{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-47' replace='true'}</td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-48' replace='true'}</th>
            <td>{grn_select_numbers select_name=$config.area_height.select_name options=$config.area_height.options padding=$config.area_height.padding selected=$config.area_height.selected}</td>
        </tr>
        <tr>
            <td></td>
            <td>
            {capture name='grn_personal_ui_GRN_PRS_UI_49'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-49' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_49}{grn_button_cancel}
            </td>
        </tr>
    </table>
</form>
{include file='grn/personal_footer.tpl'}
{*
{include file='grn/for-screenshot.tpl'}
{literal}<script>
GrnDoc_Clip("1", "#th-username-format");
GrnDoc_Clip("2", "#td-username-format");
</script>{/literal}
*}
