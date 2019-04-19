{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/ui/command_'|cat:$page_info.last}"
      xmlns="http://www.w3.org/1999/html"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <table class="std_form">
        <tbody>
        <tr>
            <td colspan="2">
                <div class="subtitle">{cb_msg module='grn.system.ui' key='GRN_SY_UI-34' replace='true'}</div>
                {if $isLicensed}
                    <div class="explanation">{cb_msg module='grn.system.ui' key='GRN_SY_UI-250' replace='true'}</div>
                {else}
                    <div class="explanation">{cb_msg module='grn.system.ui' key='GRN_SY_UI-35' replace='true'}</div>
                {/if}
            </td>
        </tr>
        {if $isLicensed}
            <tr>
                <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-251' replace='true'}</th>
                <td>
                    {capture name='grn_system_ui_GRN_SY_UI_252'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-252' replace='true'}{/capture}
                    {grn_checkbox name="mobile_view" id="mobile_view" value="1" checked=$config.mobile_view caption=$smarty.capture.grn_system_ui_GRN_SY_UI_252}
                </td>
            </tr>
            <tr>
                <td colspan="2"><br>
                    <div class="explanation">{cb_msg module='grn.system.ui' key='GRN_SY_UI-35' replace='true'}</div>
                </td>
            </tr>
        {/if}
        <tr>
            <th nowrap id="th_user_icon_format">{cb_msg module='grn.system.ui' key='GRN_SY_UI-248' replace='true'}</th>
            <td id="td_user_icon_format">
                {capture name='grn_system_ui_GRN_SY_UI_249'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-249' replace='true'}{/capture}
                {grn_checkbox name="user_icon" id="user_icon" value="1" checked=$config.user_icon caption=$smarty.capture.grn_system_ui_GRN_SY_UI_249}
                <br>
                {cb_msg module='grn.system.ui' key='GRN_SY_UI-36' replace='true'}
            </td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-37' replace='true'}</th>
            <td>
                {capture name='grn_system_ui_GRN_SY_UI_38'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-38' replace='true'}{/capture}
                {grn_checkbox name="inline_thumbnail" id="inline_thumbnail" value="1" checked=$config.inline_thumbnail caption=$smarty.capture.grn_system_ui_GRN_SY_UI_38}
                <br>
                {cb_msg module='grn.system.ui' key='GRN_SY_UI-39' replace='true'}
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="subtitle">{cb_msg module='grn.system.ui' key='GRN_SY_UI-40' replace='true'}</div>
                <div class="explanation">{cb_msg module='grn.system.ui' key='GRN_SY_UI-66' replace='true'}</div>
             </td>
        </tr>
        <tr>
            <td>
                <div class="sub_title">{cb_msg module='grn.system.ui' key='GRN_SY_UI-68' replace='true'}</div>
            </td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-69' replace='true'}</th>
            <td>{grn_select_numbers select_name=$config.list_max.select_name options=$config.list_max.options padding=$config.list_max.padding selected=$config.list_max.selected}&nbsp;{cb_msg module='grn.system.ui' key='GRN_SY_UI-70' replace='true'}</td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn' key='grn.ui.maximum.number.of.comments' replace='true'}</th>
            <td>
            {grn_select_numbers select_name=$config.follow_max.select_name options=$config.follow_max.options padding=$config.follow_max.padding selected=$config.follow_max.selected}&nbsp;{cb_msg module='grn.system.ui' key='GRN_SY_UI-72' replace='true'}
            </td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-73' replace='true'}</th>
            <td>{grn_select_numbers select_name=$config.subject_width.select_name options=$config.subject_width.options padding=$config.subject_width.padding selected=$config.subject_width.selected}&nbsp;{cb_msg module='grn.system.ui' key='GRN_SY_UI-74' replace='true'}</td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn' key='grn.ui.num.of.body.and.comments' replace='true'}</th>
            <td>{grn_select_numbers select_name=$config.truncate_width.select_name options=$config.truncate_width.options padding=$config.truncate_width.padding selected=$config.truncate_width.selected}&nbsp;{cb_msg module='grn.system.ui' key='GRN_SY_UI-76' replace='true'}</td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-77' replace='true'}</th>
            <td>{grn_select_numbers select_name=$config.name_width.select_name options=$config.name_width.options padding=$config.name_width.padding selected=$config.name_width.selected}&nbsp;{cb_msg module='grn.system.ui' key='GRN_SY_UI-78' replace='true'}</td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-79' replace='true'}</th>
            <td>{grn_select name=$config.mailto_application.select_name options=$config.mailto_application.options}</td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-80' replace='true'}, jpeg {cb_msg module='grn.system.ui' key='GRN_SY_UI-81' replace='true'}</th>
            <td>{capture name='grn_system_ui_GRN_SY_UI_82'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-82' replace='true'}{/capture}{grn_checkbox name=$config.inline_setting.name id=$config.inline_setting.name value="1" checked=$config.inline_setting.checked caption=$smarty.capture.grn_system_ui_GRN_SY_UI_82}</td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-83' replace='true'}</th>
            <td>
                <label>
                    <select name="export_charset">
                        {if ! $config.export_charset.fixed}
                        <option value="">{cb_msg module='grn.system.ui' key='GRN_SY_UI-84' replace='true'}
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
            <th id="th-username-format">{cb_msg module='grn.system.ui' key='GRN_SY_UI-244' replace='true'}</th>
            <td id="td-username-format">
            {if $nickname_enabled}
                {capture name='grn_system_ui_GRN_SY_UI_245'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-245' replace='true'}{/capture}
                {grn_checkbox name="user_name_format" id="user_name_format" value="1" checked=$config.user_name_format caption=$smarty.capture.grn_system_ui_GRN_SY_UI_245}
                <br />
            {/if}
            {capture name='grn_system_ui_GRN_SY_UI_246'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-246' replace='true'}{/capture}
            {grn_checkbox name="show_priority_group" id="show_priority_group" value="1" checked=$config.show_priority_group caption=$smarty.capture.grn_system_ui_GRN_SY_UI_246}
            </td>
        </tr>
        <tr>
        </tr>
        <tr>
            <td><br>
                <div class="sub_title">{cb_msg module='grn.system.ui' key='GRN_SY_UI-85' replace='true'}</div>
            </td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-86' replace='true'}</th>
            <td>{grn_select_numbers select_name=$config.area_width.select_name options=$config.area_width.options padding=$config.area_width.padding selected=$config.area_width.selected}&nbsp;{cb_msg module='grn.system.ui' key='GRN_SY_UI-87' replace='true'}</td>
        </tr>
        <tr>
            <th nowrap>{cb_msg module='grn.system.ui' key='GRN_SY_UI-88' replace='true'}</th>
            <td>{grn_select_numbers select_name=$config.area_height.select_name options=$config.area_height.options padding=$config.area_height.padding selected=$config.area_height.selected}</td>
        </tr>
        <tr>
            <td></td>
            <td>{capture name='grn_system_ui_GRN_SY_UI_89'}{cb_msg module='grn.system.ui' key='GRN_SY_UI-89' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_ui_GRN_SY_UI_89}{grn_button_cancel}</td>
        </tr>
        </tbody>
    </table>
</form>

{include file="grn/system_footer.tpl"}
