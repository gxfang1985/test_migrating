{if $settings.font_size == "large"}
    {assign var="font_size" value='font-size:140%;'}
{elseif $settings.font_size == "normal"}
    {assign var="font_size" value=''}
{elseif $settings.font_size == "small"}
    {assign var="font_size" value='font-size:70%;'}
{/if}
{include file="schedule/_show_full_short_title.tpl" function_click="showFullShortTitle('show_title_phonemessage','phonemessage','index',true);" schedule_id='phonemessage'}
<div style="{$font_size}">
    <form name="phonemessage{$portlet.plid}" method="post" action="{grn_pageurl page='phonemessage/index'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        <table class="top_title">{strip}
            <tbody>
            <tr>
                <td>
                    <span class="portlet_title_grn">
                        <a href="{grn_pageurl page='phonemessage/index' module_id=$module_id}">{$page_title|escape}</a>
                    </span>
              </td>
            </tr>
            </tbody>
        </table>{/strip}

        <div class="portal_frame portal_frame_phonemessage_grn">
            <table id="phonemessage" class="list_column" width="100%">
                <colgroup>
                {if $schedule_available}
                    <col width="20%">
                    <col width="15%">
                    <col width="15%">
                    <col width="25%">
                    <col width="25%">
                {else}
                    <col width="25%">
                    <col width="20%">
                    <col width="20%">
                    <col width="35%">
                {/if}
                </colgroup>

                <tr>
                    <td colspan="{if $schedule_available}5{else}4{/if}">
                        <div class="margin_bottom">
                            {grn_org_select user_id=$user_id selected_id=$selected_id app_id=$app_id return_url="phonemessage/index" all=true tp='pm' ppid=$portlet.plid select_style="font-size:100%;" access_plugin=$access_plugin plugin_session_name=$plugin_session_name plugin_data_name=$plugin_data_name}
                        </div>
                        <input type="hidden" name="tp" value="pm">
                        <div class="sub_title">
                            {cb_msg module='grn.phonemessage.portlet' key='GRN_PHM_PO-9' replace='true'}
                            {include file="grn/smart_data_count_310.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}
                        </div>
                    </td>
                </tr>
                <tr>
                    <th nowrap>{cb_msg module='grn.phonemessage.portlet' key='GRN_PHM_PO-12' replace='true'}</th>
                    <th nowrap>&nbsp;</th>
                    <th nowrap class="tAlignCenter-grn">{cb_msg module='grn.phonemessage.portlet' key='GRN_PHM_PO-24' replace='true'}</th>
                    <th nowrap>{if $active_presence}<span class="mRight10">{cb_msg module='grn.phonemessage.portlet' key='GRN_PHM_PO-25' replace='true'}</span>{/if}</th>
                    {if $schedule_available}
                    <th nowrap><span class="mRight15">{cb_msg module='grn.phonemessage.portlet' key='GRN_PHM_PO-26' replace='true'}</span></th>
                    {/if}
                </tr>
                {foreach from=$accesses key=user_id item=access}
                <tr valign="top">
                    <td nowrap class="phonemessage_portlet_partition_grn">
                        {if $sso == GRN_PHONEMESSAGE_SSO_DEFAULT}
                            {grn_user_name uid=$user_id truncated=$name_width}
                        {else}
                            {grn_sso_link uid=$user_id caption=$users.$user_id.display_name truncated_caption=$name_width sso_id=$sso app_id="phonemessage" id_list=$users.$user_id.sso }
                        {/if}
                    </td>
                    <td nowrap class="phonemessage_portlet_partition_grn">
                        {if $access.add}
                            {assign var='disabled' value=true}
                        {else}
                            {assign var='disabled' value=false}
                        {/if}

                        {capture name='grn_phonemessage_portlet_GRN_PHM_PO_14'}{cb_msg module='grn.phonemessage.portlet' key='GRN_PHM_PO-14' replace='true'}{/capture}
                        {grn_link page='phonemessage/add' caption='' title=$smarty.capture.grn_phonemessage_portlet_GRN_PHM_PO_14 gid=$group_id uid=$user_id image='telmemo20_w.gif' disabled=$disabled class="mRight10" br=true no_image_class=true}
   
                        {if $access.browse}
                            {assign var='disabled' value=true}
                        {else}
                            {assign var='disabled' value=false}
                        {/if}

                        {if 0 < $users.$user_id.newmessage_count}
                            {assign var='image_name' value='telmemo20_u.gif'}
                        {else}
                            {assign var='image_name' value='telmemo20.gif'}
                        {/if}

                        {capture name='grn_phonemessage_portlet_GRN_PHM_PO_15'}{cb_msg module='grn.phonemessage.portlet' key='GRN_PHM_PO-15' replace='true'}{/capture}
                        {grn_link page='phonemessage/history' gid=$group_id uid=$user_id caption='' title=$smarty.capture.grn_phonemessage_portlet_GRN_PHM_PO_15 image=$image_name disabled=$disabled br=true}
                    </td>
                    <td nowrap class="tAlignCenter-grn phonemessage_portlet_partition_grn">
                        {if 0 < $users.$user_id.email_flags}
                            {grn_image image='image-common/mark_check16.png'}
                        {/if}
                    </td>
                    <td class="textSub-grn phonemessage_portlet_partition_grn">
                        {if $active_presence}
                            {assign var='presence' value=$access.presence}
                            {if !$presence.disabled && !$presence.mtime}
                                {grn_link page=$presence.page caption='' title=$presence.info uid=$user_id disabled=$presence.disabled image='write20.gif'}
                            {/if}
                            {if $presence.mtime}
                                {grn_link page=$presence.page caption=$presence.info uid=$user_id disabled=$presence.disabled br=true}<br>
                                {if $presence.old}<span class="attention">{/if}
                                {grn_date_format date=$presence.mtime format="DateTimeCompact"}
                                {if $presence.old}</span>{/if}
                            {/if}
                        {/if}
                    </td>
                    {if $schedule_available}
                    <td class="phonemessage_event_base_grn phonemessage_portlet_partition_grn">
                        <table width="100%" cellspacing="0" cellpadding="0" class="calendar scheduleWrapper scheduleWrapperGroupWeek portlet_groupweek tableFixed hideEventTitle">
                            <tbody>
                            <tr class="schedule_user_tr">
                                <td valign="top" class="s_user_week normalEvent phonemessage_event_grn">
                                {foreach from=$users_event.$user_id.schedule_event.event item=event}
                                    <div class="{if $event.type != 'share_temporary' && $event.type != 'temporary'}{$event.type}{/if} normalEventElement group_week_calendar_item">
                                        <div class="listTime">{$event.time_schedule|grn_noescape}</div>
                                        <div class="{if $event.allday}groupWeekEventTitleAllday{else}groupWeekEventTitle{/if}">
                                            {if ! $event.private}
                                                {if $event.type == "share_temporary" || $event.type == "temporary"}
                                                    <span class="{$event.type}">
                                                {/if}
                                                <a href="{grn_pageurl page='schedule/view' event=$event.id bdate=$schedule_event.date uid=$user_id gid=$group_id}">
                                            {/if}
                                            {$event.data|grn_noescape}
                                            {if $event.is_private}
                                                {grn_image image="image-common/privateMark_sub16.png"}
                                            {/if}
                                            {if ! $event.private}
                                                </a>
                                                {if $event.type == "share_temporary" || $event.type == "temporary"}
                                                    </span>
                                                {/if}
                                            {/if}
                                        </div>
                                    </div>
                                {/foreach}
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </td>
                    {/if}
                </tr>
                {/foreach}
                <tr>
                    <td colspan="{if $schedule_available}5{else}4{/if}" style="padding:0px" nowrap>
                        <div class="m_small">
                            <div class="navi">
                                {include file="grn/word_navi.tpl" navi=$view_set.navi}
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</div> {*end of portal_frame *}
