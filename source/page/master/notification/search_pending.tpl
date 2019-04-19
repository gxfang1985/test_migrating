{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page=$page_info.all}">
    <p>
        <table class="std_form">
            <tr>
                <th>{cb_msg module='grn.notification' key='GRN_NTFC-111' replace='true'}</th>
                <td>
                    {grn_text necessary=true name="search_text" value=$search_text size="50"}
                    <input type="submit" name="Search" value="{cb_msg module='grn.notification' key='GRN_NTFC-112' replace='true'}">
                </td>
            </tr>
            <tr>
                <th>{cb_msg module='grn.notification' key='GRN_NTFC-123' replace='true'}</th>
                <td>
                    {capture name='grn_notification_GRN_NTFC_124'}{cb_msg module='grn.notification' key='GRN_NTFC-124' replace='true'}{/capture}{grn_checkbox name="search_keys[]" id="subject" value="subject" checked=$search_keys.subject caption=$smarty.capture.grn_notification_GRN_NTFC_124}
                    {if $available_space}
                        {capture name='grn_notification_GRN_NTFC_182'}{cb_msg module='grn.notification' key='GRN_NTFC-182' replace='true'}{/capture}{grn_checkbox name="search_keys[]" id="space_name" value="space_name" checked=$search_keys.space_name caption=$smarty.capture.grn_notification_GRN_NTFC_182}
                    {/if}
                    {capture name='grn_notification_GRN_NTFC_125'}{cb_msg module='grn.notification' key='GRN_NTFC-125' replace='true'}{/capture}{grn_checkbox name="search_keys[]" id="abstract" value="abstract" checked=$search_keys.abstract caption=$smarty.capture.grn_notification_GRN_NTFC_125}
                    {capture name='grn_notification_GRN_NTFC_126'}{cb_msg module='grn.notification' key='GRN_NTFC-126' replace='true'}{/capture}{grn_checkbox name="search_keys[]" id="sender_name" value="sender_name" checked=$search_keys.sender_name caption=$smarty.capture.grn_notification_GRN_NTFC_126}
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <div class="mTop10">
                        {capture name='grn_notification_GRN_NTFC_127'}{cb_msg module='grn.notification' key='GRN_NTFC-127' replace='true'}{/capture}
                        {grn_button id='notifications_button_search' action='submit' ui='main' caption=$smarty.capture.grn_notification_GRN_NTFC_127}
                    </div>
                </td>
            </tr>
        </table>
    </p>
    <p>
        <div class="sub_title">
            {cb_msg module='grn.notification' key='GRN_NTFC-128' replace='true'} 
            {include file="grn/smart_data_count_310.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}
        </div>
        <div class="navi">
            <nobr>{include file="grn/word_navi.tpl" navi=$view_set.navi}</nobr>
        </div>
        <table class="list_column">
        {if $available_space}
            <colgroup>
                <col width="30%">
                <col width="20%">
                <col width="30%">
                <col width="20%">
            </colgroup>
            <tr>
                <th nowrap>{cb_msg module='grn.notification' key='GRN_NTFC-131' replace='true'}</th>
                <th nowrap>{cb_msg module='grn.notification' key='GRN_NTFC-185' replace='true'}</th>
                <th nowrap>{cb_msg module='grn.notification' key='GRN_NTFC-132' replace='true'}</th>
                <th nowrap>{cb_msg module='grn.notification' key='GRN_NTFC-133' replace='true'}</th>
            </tr>
            {foreach from=$search_result item=notify}
            <tr>
                {grn_notification_data_row notify=$notify data_type='notify' subject_cols=$subject_cols space_cols=$space_cols abstract_cols=$abstract_cols name_cols=$name_cols checkbox=0 no_abstract=$no_abstract no_name=$no_name no_date=1 users_info=$users_info}
            </tr>
            {/foreach}
        {else}
            <colgroup>
                <col width="35%">
                <col width="35%">
                <col width="30%">
            </colgroup>
            <tr>
                <th nowrap>{cb_msg module='grn.notification' key='GRN_NTFC-131' replace='true'}</th>
                <th nowrap>{cb_msg module='grn.notification' key='GRN_NTFC-132' replace='true'}</th>
                <th nowrap>{cb_msg module='grn.notification' key='GRN_NTFC-133' replace='true'}</th>
            </tr>
            {foreach from=$search_result item=notify}
            <tr>
                {grn_notification_data_row notify=$notify data_type='notify' subject_cols=$subject_cols space_cols=$space_cols abstract_cols=$abstract_cols name_cols=$name_cols checkbox=0 no_space_name=true no_abstract=$no_abstract no_name=$no_name no_date=1 users_info=$users_info}
            </tr>
            {/foreach}
        {/if}
        {foreach from=$search.search_item item=search_item}
            <tr>
                <td nowrap>
                    <a href="{cb_pageurl page=$search_item.url}">{$search_item.title}</a>
                </td>
                <td nowrap>{$search_item.data}</td>
                <td nowrap>{$search_item.name}</td>
            </tr>
        {/foreach}
        </table>
        <div class="navi">
            <nobr>{include file="grn/word_navi.tpl" navi=$view_set.navi}</nobr>
        </div>
        <input type="hidden" name="module_id" value="{$module_id}">
        <input type="hidden" name="not_first_search" value="1">
    </p>
</form>

{include file='grn/footer.tpl'}
