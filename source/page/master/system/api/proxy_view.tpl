{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

{grn_delete title=$delete_info.title page=$delete_info.page data=$delete_info.data handler=$delete_info.handler}

{grn_customization_disabled_warning}

<div id="main_menu_part">
    <span class="menu_item">
        {capture name='proxy_api_edit'}{cb_msg module='grn.system.api' key='proxy_api_edit' replace='true'}{/capture}
        {grn_link page='system/api/proxy_modify' caption=$smarty.capture.proxy_api_edit image='modify20.gif' id=$proxy->getId()}
    </span>
    <span class="menu_item">
        {capture name='proxy_api_delete'}{cb_msg module='grn.system.api' key='proxy_api_delete' replace='true'}{/capture}
        {grn_link script='javascript:void(0)' caption=$smarty.capture.proxy_api_delete image='delete20.gif' element_id='proxy_delete'}
    </span>
</div>

<p>
<table class="view_table">
    <tr valign="top">
        <th nowrap>
            {cb_msg module='grn.system.api' key='proxy_field_status' replace='true'}
        </th>
        <td>
            {if $proxy->getActive() }
                <span class="font_green">
                    {cb_msg module='grn.system.api' key='proxy_field_status_apply' replace='true'}
                </span>
            {else}
                <span class="font_red">
                    {cb_msg module='grn.system.api' key='proxy_field_status_not_apply' replace='true'}
                </span>
            {/if}
        </td>
    </tr>

    <tr>
        <th nowrap>
            {cb_msg module='grn.system.api' key='proxy_field_proxy_id' replace='true'}
        </th>
        <td>
            {$proxy->getCode()|escape}
        </td>
    </tr>

    <tr>
        <th nowrap>
            {cb_msg module='grn.system.api' key='proxy_field_method' replace='true'}
        </th>
        <td>
            {$proxy->getMethod()|escape}
        </td>
    </tr>

    <tr>
        <th nowrap>
            {cb_msg module='grn.system.api' key='proxy_field_url' replace='true'}
        </th>
        <td>
            {$proxy->getUrl()|escape}
        </td>
    </tr>

    <tr valign="top">
        <th nowrap>
            {cb_msg module='grn.system.api' key='proxy_field_params' replace='true'}
        </th>
        <td>
            <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
                <tr>
                    <th nowrap>{cb_msg module='grn' key='column_key' replace='true'}</th>
                    <th nowrap>{cb_msg module='grn' key='column_value' replace='true'}</th>
                </tr>
                {foreach from=$proxy->getParams() item=proxy_param}
                    <tr valign="top">
                        <td><pre>{$proxy_param.key|escape}</pre></td>
                        <td><pre>{$proxy_param.value|escape}</pre></td>
                    </tr>
                {/foreach}
            </table>
        </td>
    </tr>

    <tr valign="top">
        <th nowrap>
            {cb_msg module='grn.system.api' key='proxy_field_headers' replace='true'}
        </th>
        <td>
            <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
                <tr>
                    <th nowrap>{cb_msg module='grn' key='column_key' replace='true'}</th>
                    <th nowrap>{cb_msg module='grn' key='column_value' replace='true'}</th>
                </tr>
                {foreach from=$proxy->getHeaders() item=proxy_header}
                    <tr valign="top">
                        <td><pre>{$proxy_header.key|escape}</pre></td>
                        <td><pre>{$proxy_header.value|escape}</pre></td>
                    </tr>
                {/foreach}
            </table>
        </td>
    </tr>

    {if $is_display_body}
    <tr valign="top">
        <th nowrap>
            {cb_msg module='grn.system.api' key='proxy_field_body' replace='true'}
        </th>
        <td>
            <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
                <tr>
                    <th nowrap>{cb_msg module='grn' key='column_key' replace='true'}</th>
                    <th nowrap>{cb_msg module='grn' key='column_value' replace='true'}</th>
                </tr>
                {foreach from=$proxy->getBody() item=proxy_body}
                    <tr valign="top">
                        <td><pre>{$proxy_body.key|escape}</pre></td>
                        <td><pre>{$proxy_body.value|escape}</pre></td>
                    </tr>
                {/foreach}
            </table>
        </td>
    </tr>
    {/if}

    <tr>
        <th nowrap>
            {cb_msg module='grn.system.api' key='proxy_field_created_by' replace='true'}
        </th>
        <td>
            {grn_user_name uid=$proxy->getCreator() name=$proxy->getCreatorName()}
            {grn_date_format date=$create_time format="DateTimeCompact"}
        </td>
    </tr>

    <tr>
        <th nowrap>
            {cb_msg module='grn.system.api' key='proxy_field_updated_by' replace='true'}
        </th>
        <td>
            {grn_user_name uid=$proxy->getModifier() name=$proxy->getModifierName()}
            {grn_date_format date=$modify_time format="DateTimeCompact"}
        </td>
    </tr>
</table>

{include file='grn/system_footer.tpl'}