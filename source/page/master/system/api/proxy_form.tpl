{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

{grn_customization_disabled_warning}

{assign var='form_name' value="system/api/proxy_`$view_mode`"}

<div id="form_error_message"></div>

<form name="{$form_name}" method="post" data-mode="{$view_mode}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

    {if $view_mode == "modify"}
        <input type="hidden" name="id" value="{$proxy->getId()}">
    {/if}

    <table class="std_form">
        <tr>
            <th nowrap>
                {cb_msg module='grn.system.api' key='proxy_field_status' replace='true'}
            </th>
            <td>
                <span class="radiobutton_base_grn">
                    {capture name='proxy_field_status_apply'}{cb_msg module='grn.system.api' key='proxy_field_status_apply' replace='true'}{/capture}
                    {grn_radio id="apply" name="status_apply" value="1" caption=$smarty.capture.proxy_field_status_apply checked=$apply}
                </span>
                <span class="radiobutton_base_grn">
                    {capture name='proxy_field_status_not_apply'}{cb_msg module='grn.system.api' key='proxy_field_status_not_apply' replace='true'}{/capture}
                    {grn_radio id="do_not_apply" name="status_apply" value="0" caption=$smarty.capture.proxy_field_status_not_apply checked=$not_apply}
                </span>
            </td>
        </tr>

        <tr>
            <th nowrap>
                {capture name='field_proxy_id'}{cb_msg module='grn.system.api' key='proxy_field_proxy_id' replace='true'}{/capture}
                {grn_show_input_title title=$smarty.capture.field_proxy_id necessary=1}
            </th>
            <td>
                {grn_text necessary=true name="code" value=$proxy->getCode() size="50" disable_return_key=true}
            </td>
        </tr>

        <tr>
            <th nowrap>
                {cb_msg module='grn.system.api' key='proxy_field_method' replace='true'}
            </th>
            <td>
                {grn_select name='method' options=$methods}
            </td>
        </tr>

        <tr>
            <th nowrap>
                {capture name='field_url'}{cb_msg module='grn.system.api' key='proxy_field_url' replace='true'}{/capture}
                {grn_show_input_title title=$smarty.capture.field_url necessary=1}
            </th>
            <td>
                {grn_text necessary=true name="url" value=$proxy->getUrl() size="50" maxlength="-1" disable_return_key=true}
            </td>
        </tr>

        <tr>
            <th nowrap>
                {cb_msg module='grn.system.api' key='proxy_field_params' replace='true'}
            </th>
            <td id="proxy_params_area" class="move_list_grn">
            </td>
        </tr>

        <tr>
            <th nowrap>
                {cb_msg module='grn.system.api' key='proxy_field_headers' replace='true'}
            </th>
            <td id="proxy_headers_area" class="move_list_grn">
            </td>
        </tr>

        <tr>
            <th nowrap>
                {cb_msg module='grn.system.api' key='proxy_field_body' replace='true'}
            </th>
            <td id="proxy_body_area" class="move_list_grn">
            </td>
        </tr>

        <tr>
            <td></td>
            <td>
                {if $view_mode == "add"}
                    {capture name='proxy_button_add'}{cb_msg module='grn.system.api' key='proxy_button_add' replace='true'}{/capture}
                    {grn_button_submit class="margin js_button_save" button_type="submit" caption=$smarty.capture.proxy_button_add}
                    {grn_button_cancel page='system/api/proxy_list'}
                {elseif $view_mode == "modify"}
                    {capture name='proxy_button_save'}{cb_msg module='grn.system.api' key='proxy_button_save' replace='true'}{/capture}
                    {grn_button_submit class="margin js_button_save" button_type="submit" caption=$smarty.capture.proxy_button_save}
                    {grn_button_cancel page='system/api/proxy_view' id=$proxy->getId()}
                {/if}
            </td>
        </tr>
    </table>
</form>

{grn_load_javascript file="grn/html/component/validator.js"}
{grn_load_javascript file="grn/html/component/editable_table.js"}
{grn_load_javascript file="grn/html/component/KeyValueEditableTable.js"}
{grn_load_javascript file="grn/html/page/system/api/proxy_form.js"}
<script>grn.page.system.api.proxy_form.init(document.forms["{$form_name}"], {$data_for_js|@json_encode});</script>

{include file='grn/system_footer.tpl'}