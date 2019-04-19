{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{strip}
{foreach from=$list key=record_key item=record_item}
    {if $record_item.action_id eq "delete" || $record_item.facility_approval_invalid eq true }
        <li data-icon="false" data-theme="{$data_theme}" class="ui-btn" id="notif_{$record_key}">
    {elseif $record_item.module_id eq "grn.space"}
        {if $record_item.sub_module_id eq "grn.discussion"}
            {if isset( $record_item.org_data.comment )}
        <li onclick="__notifyCommon.redirectTo('{if !$is_history_list}{grn_pageurl page="space/mobile/application/discussion/detail" spid=$record_item.org_data.spaceId tid=$record_item.unique_id nid=$record_item.id cmid=$record_item.org_data.comment fragment="comment_top"}{else}{grn_pageurl page="space/mobile/application/discussion/detail" spid=$record_item.org_data.spaceId tid=$record_item.unique_id nhid=$record_item.id cmid=$record_item.org_data.comment fragment="comment_top"}{/if}', {if $record_item.has_mobile_view}true{else}false{/if})" data-icon="false" data-theme="{$data_theme}" class="ui-btn" id="notif_{$record_key}">
            {else}
        <li onclick="__notifyCommon.redirectTo('{if !$is_history_list}{grn_pageurl page="space/mobile/application/discussion/detail" spid=$record_item.org_data.spaceId tid=$record_item.unique_id nid=$record_item.id}{else}{grn_pageurl page="space/mobile/application/discussion/detail" spid=$record_item.org_data.spaceId tid=$record_item.unique_id nhid=$record_item.id}{/if}', {if $record_item.has_mobile_view}true{else}false{/if})" data-icon="false" data-theme="{$data_theme}" class="ui-btn" id="notif_{$record_key}">
            {/if}
        {elseif $record_item.sub_module_id eq "grn.todo"}
            {if isset( $record_item.org_data.comment )}
        <li onclick="__notifyCommon.redirectTo('{if !$is_history_list}{grn_pageurl page="space/mobile/application/todo/detail" spid=$record_item.org_data.spaceId tdid=$record_item.unique_id nid=$record_item.id cmid=$record_item.org_data.comment fragment="comment_top"}{else}{grn_pageurl page="space/mobile/application/todo/detail" spid=$record_item.org_data.spaceId tdid=$record_item.unique_id nhid=$record_item.id cmid=$record_item.org_data.comment fragment="comment_top"}{/if}', {if $record_item.has_mobile_view}true{else}false{/if})" data-icon="false" data-theme="{$data_theme}" class="ui-btn" id="notif_{$record_key}">
            {else}
        <li onclick="__notifyCommon.redirectTo('{if !$is_history_list}{grn_pageurl page="space/mobile/application/todo/detail" spid=$record_item.org_data.spaceId tdid=$record_item.unique_id nid=$record_item.id}{else}{grn_pageurl page="space/mobile/application/todo/detail" spid=$record_item.org_data.spaceId tdid=$record_item.unique_id nhid=$record_item.id}{/if}', {if $record_item.has_mobile_view}true{else}false{/if})" data-icon="false" data-theme="{$data_theme}" class="ui-btn" id="notif_{$record_key}">
            {/if}
        {else}
         <li onclick="__notifyCommon.redirectTo('{if !$is_history_list}{grn_pageurl page="space/mobile/application/discussion/index" spid=$record_item.space_id nid=$record_item.id}{else}{grn_pageurl page="space/mobile/application/discussion/index" spid=$record_item.space_id nhid=$record_item.id}{/if}', {if $record_item.has_mobile_view}true{else}false{/if})" data-icon="false" data-theme="{$data_theme}" class="ui-btn" id="notif_{$record_key}">
        {/if}
    {elseif $record_item.module_id eq "grn.schedule"}
        {if $record_item.action_id eq "requested"}
            <li onclick="__notifyCommon.redirectTo('{if !$is_history_list}{grn_pageurl page="schedule/mobile/operation/facility_approve" event=$record_item.org_data.event nid=$record_item.id  fragment=$record_item.fragment faid=$record_item.org_data.faid}{else}{grn_pageurl page="schedule/mobile/operation/facility_approve" event=$record_item.org_data.event nhid=$record_item.id fragment=$record_item.fragment faid=$record_item.org_data.faid}{/if}', {if $record_item.has_mobile_view}true{else}false{/if})" data-icon="false" data-theme="{$data_theme}" class="ui-btn" id="notif_{$record_key}">
        {else}
            <li onclick="__notifyCommon.redirectTo('{if !$is_history_list}{grn_pageurl page="schedule/mobile/view" uid=$uid event=$record_item.org_data.event bdate=$record_item.org_data.bdate nid=$record_item.id fragment=$record_item.fragment}{else}{grn_pageurl page="schedule/mobile/view" uid=$uid event=$record_item.org_data.event bdate=$record_item.org_data.bdate nhid=$record_item.id fragment=$record_item.fragment}{/if}', {if $record_item.has_mobile_view}true{else}false{/if})" data-icon="false" data-theme="{$data_theme}" class="ui-btn" id="notif_{$record_key}">
        {/if}
    {elseif $record_item.module_id eq "grn.message"}
        <li onclick="__notifyCommon.redirectTo('{if !$is_history_list}{grn_pageurl page="message/mobile/view" cid=$record_item.org_data.cid rid=$record_item.org_data.rid mid=$record_item.org_data.mid nid=$record_item.id fragment=$record_item.fragment}{else}{grn_pageurl page="message/mobile/view" cid=$record_item.org_data.cid rid=$record_item.org_data.rid mid=$record_item.org_data.mid nhid=$record_item.id fragment=$record_item.fragment}{/if}', {if $record_item.has_mobile_view}true{else}false{/if})" data-icon="false" data-theme="{$data_theme}" class="ui-btn" id="notif_{$record_key}">
    {elseif $record_item.module_id eq "grn.bulletin"}
        <li onclick="__notifyCommon.redirectTo('{if !$is_history_list}{grn_pageurl page="bulletin/mobile/view" aid=$record_item.unique_id nid=$record_item.id fragment=$record_item.fragment}{else}{grn_pageurl page="bulletin/mobile/view" aid=$record_item.unique_id nhid=$record_item.id fragment=$record_item.fragment}{/if}', {if $record_item.has_mobile_view}true{else}false{/if})" data-icon="false" data-theme="{$data_theme}" class="ui-btn" id="notif_{$record_key}">
    {elseif $record_item.module_id eq "grn.cabinet"}
        <li onclick="__notifyCommon.redirectTo('{if !$is_history_list}{grn_pageurl page="cabinet/view" fid=$record_item.unique_id nid=$record_item.id}{else}{grn_pageurl page="cabinet/view" fid=$record_item.unique_id nhid=$record_item.id}{/if}', {if $record_item.has_mobile_view}true{else}false{/if})" data-icon="false" data-theme="{$data_theme}" class="ui-btn" id="notif_{$record_key}">
    {elseif $record_item.module_id eq "grn.phonemessage"}
        <li onclick="__notifyCommon.redirectTo('{if !$is_history_list}{grn_pageurl page="phonemessage/history" uid=$record_item.org_data.uid nid=$record_item.id}{else}{grn_pageurl page="phonemessage/history" uid=$record_item.org_data.uid nhid=$record_item.id}{/if}', {if $record_item.has_mobile_view}true{else}false{/if})" data-icon="false" data-theme="{$data_theme}" class="ui-btn" id="notif_{$record_key}">
    {elseif $record_item.module_id eq "grn.mail"}
        <li onclick="__notifyCommon.redirectTo('{if !$is_history_list}{grn_pageurl page="mail/mobile/view" mid=$record_item.unique_id nid=$record_item.id}{else}{grn_pageurl page="mail/mobile/view" mid=$record_item.unique_id nhid=$record_item.id}{/if}', {if $record_item.has_mobile_view}true{else}false{/if})" data-icon="false" data-theme="{$data_theme}" class="ui-btn" id="notif_{$record_key}">
    {elseif $record_item.module_id eq "grn.workflow"}
        <li onclick="__notifyCommon.redirectTo('{if !$is_history_list}{grn_pageurl page="workflow/mobile/view" fid=$record_item.org_data.fid pid=$record_item.org_data.pid nid=$record_item.org_data.nid}{else}{grn_pageurl page="workflow/mobile/view" fid=$record_item.org_data.fid pid=$record_item.org_data.pid nhid=$record_item.org_data.nid}{/if}', {if $record_item.has_mobile_view}true{else}false{/if})" data-icon="false" data-theme="{$data_theme}" class="ui-btn" id="notif_{$record_key}">
    {elseif $record_item.module_id eq "grn.report"}
        <li onclick="__notifyCommon.redirectTo('{if !$is_history_list}{grn_pageurl page="report/mobile/view" rid=$record_item.org_data.rid nid=$record_item.id fragment=$record_item.fragment}{else}{grn_pageurl page="report/mobile/view" rid=$record_item.org_data.rid nhid=$record_item.id fragment=$record_item.fragment}{/if}', {if $record_item.has_mobile_view}true{else}false{/if})" data-icon="false" data-theme="{$data_theme}" class="ui-btn" id="notif_{$record_key}">
    {else}
        <li onclick="__notifyCommon.redirectTo('{if !$is_history_list}{grn_pageurl page="notification/notify_redirect" nid=$record_item.id ct=s}{else}{grn_pageurl page="notification/notify_redirect" nhid=$record_item.id ct=s}{/if}', false)" data-icon="false" data-theme="{$data_theme}" class="ui-btn" id="notif_{$record_key}">
    {/if}

    {if !$is_history_list && $record_item.has_read_btn }
        <span class="mobile_notification_read_grn">
            <a href="javascript:void(0)" onclick="__pendingPage.confirmNotification({$record_key},'{$short_id}',event)" class="ui-link">{cb_msg module='grn.notification.mobile' key='GRN_NTFC-3' replace='true'}</a>
        </span>
    {/if}

    <div class="mobile_list_table_td_grn">
        <div class="mobile_list_lines_grn">
            {if !$is_history_list}<span class="mobile_list_icon_unread_grn"></span>{/if}
            <ul>
                {if $record_item.module_id eq "grn.schedule"}
                <li class="mobile_notification_time_li_grn">
                    <span class="mobile_notification_toptitle_grn mobile_notification_icon_title_b_grn mobile_icon_{if $record_item.action_id eq "requested"}appfacility{else}appschedules{/if}_grn"></span>
                    <span class="mobile_notification_time_grn">{grn_date_format date = $record_item.event_start_ts}</span>
                </li>
                <li>
                    <span class="mobile_notification_title_grn">{$record_item.subject|escape}</span>
                </li>
                {else}
                <li>
                    <span class="mobile_notification_toptitle_grn mobile_notification_icon_title_b_grn {$record_item.subject_icon_css}"></span>
                    {if $record_item.module_id eq "grn.workflow" && $record_item.org_data.priority eq "1" }
                        <span class="mobile_icon_alerts_grn mobile_notification_icon_title_s_grn"></span>
                    {/if}
                        <span class="mobile_notification_title_grn">
                        {if $record_item.org_data.attached || $record_item.org_data.files > 0 ||$record_item.org_data.file }
                            <span class="mobile_list_icon_attachmentssub_grn"></span>
                        {/if}
                        {$record_item.subject|escape}
                        </span>
                    </li>
                {/if}

                {if $record_item.space_name}
                    <li>
                        <span class="mobile_notification_icon_title_s_grn mobile_icon_space_grn"></span>
                        <span class="mobile_notification_subtitle_grn">{$record_item.space_name|escape}</span>
                    </li>
                {/if}

                <li>
                    {if $record_item.module_id eq "grn.mail" || $record_item.module_id|substr:0:2 == "x."}
                        <span class="mobile_notification_icon_title_s_grn mobile_icon_user_grn"></span><span class="mobile_notification_user_grn">{grn_mail_name name_format='name' name=$record_item.sender_name}</span>
                    {else}
                        {grn_user_name_for_mobile_notification uid=$record_item.sender_id name=$record_item.sender_name users_info=$users_info app_id=$record_item.module_id|substr:4}
                    {/if}
                </li>

                <li>
                    <span class="mobile_notification_date_grn">{grn_date_format date = $record_item.timestamp}</span>
                </li>

                {if $record_item.abstract}
                    <li>
                        {if $record_item.module_id eq "grn.cabinet"}
                            <a class="mobile_notification_filelink_grn ui-link" href="javascript:void(0)" onclick="__notifyCommon.downloadFile('{if !$is_history_list}{grn_pageurl page="cabinet/download" postfix=$record_item.abstract|escape hid=$record_item.org_data.hid fid=$record_item.unique_id nid=$record_item.id}{else}{grn_pageurl page="cabinet/download" postfix=$record_item.abstract|escape hid=$record_item.org_data.hid fid=$record_item.unique_id nhid=$record_item.id}{/if}', event)">
                                {$record_item.abstract|escape}
                            </a>
                        {elseif $record_item.module_id eq "grn.schedule" && $record_item.facility_approval_invalid eq true}
                            <span class="mobile_notification_deletetext_grn">{$record_item.abstract|escape}</span>
                        {else}
                            <span class="mobile_notification_content_grn">{$record_item.abstract|escape}</span>
                        {/if}
                    </li>
                {/if}

                {if $record_item.action_id eq "delete"}
                <li>
                    {if $record_item.module_id eq "grn.schedule" && $record_item.facility_approval_invalid eq false}
                        <span class="mobile_notification_deletetext_grn">{cb_msg module='grn.notification.mobile' key='GRN_NTFC-5' replace='true'}</span>
                    {elseif $record_item.module_id eq "grn.space"}
                        <span class="mobile_notification_deletetext_grn">{cb_msg module='grn.notification.mobile' key='GRN_NTFC-6' replace='true'}</span>
                    {/if}
                </li>
                {/if}
            </ul>
        </div>
    </div>

    {if $record_item.action_id neq "delete" && $record_item.facility_approval_invalid eq false }
        {if $record_item.has_mobile_view }
            <span class="mobile_list_icon_arraylist_grn"></span>
        {else}
            <span class="mobile_list_icon_advancelistpc_grn mobile_icon_advancelistpc_grn"></span>
        {/if}
    {/if}
    </li>
{/foreach}
{/strip}
