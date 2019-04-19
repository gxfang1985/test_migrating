{include file='grn/head.tpl'}
{include file='grn/header_no_siteposition.tpl'}

{include file='phonemessage/_title_search.tpl'}

<div class="mainarea">
    <div id="menu_part">
        <div id="smart_main_menu_part">
            <!--group_select-->
            {assign var='form_name' value=$smarty.template|basename}
            <form name="{$form_name}" method="post" action="{grn_pageurl page='phonemessage/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                {grn_org_select user_id=$login_id selected_id=$selected_id app_id=$app_id return_url="phonemessage/index" all=true access_plugin=$access_plugin plugin_session_name=$plugin_session_name plugin_data_name=$plugin_data_name}
            </form>
        </div>
        <div id="smart_rare_menu_part">
            {capture name='grn_phonemessage_GRN_PHM_37'}{cb_msg module='grn.phonemessage' key='GRN_PHM-37' replace='true'}{/capture}
            {grn_simple_search caption=$application_name|cat:$smarty.capture.grn_phonemessage_GRN_PHM_37 name='search_text' action='phonemessage/search' page='phonemessage/search' gid=$group_id with_detail=true}
        </div>
    </div>

    {capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}{/capture}
    {include file="grn/smart_word_navi_310.tpl" navi=$view_set.navi navi_right=$smarty.capture.navi_right}

    <table class="list_column" width="100%">
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
            <th nowrap>{cb_msg module='grn.phonemessage' key='GRN_PHM-56' replace='true'}</th>
            <th nowrap>&nbsp;</th>
            <th nowrap class="tAlignCenter-grn">{cb_msg module='grn.phonemessage' key='GRN_PHM-86' replace='true'}</th>
            <th nowrap>{if $active_presence}{cb_msg module='grn.phonemessage' key='GRN_PHM-87' replace='true'}{/if}</th>
            {if $schedule_available}
            <th nowrap>{cb_msg module='grn.phonemessage' key='GRN_PHM-88' replace='true'}</th>
            {/if}
        </tr>
        {foreach from=$accesses key=user_id item=access name="access_loop"}
            <tr class="{if $smarty.foreach.access_loop.iteration % 2 == 0}lineone{else}linetwo{/if}">
                <td nowrap>
                    {if $imageIcon}
                        <table class="profileImageBaseList-grn"><tbody><tr>
                        <td width="1">{grn_user_image_icon userInfo=$users_info.$user_id photoUrl=$users_info.$user_id.photoUrl userId=$user_id loginId=$login_id size=$iconSize}</td>
                        <td nowrap="">{if $sso == GRN_PHONEMESSAGE_SSO_DEFAULT}{grn_user_name uid=$user_id users_info=$users_info noimage=true}{else}{grn_sso_link uid=$user_id caption=$users.$user_id.col_display_name sso_id=$sso app_id="phonemessage" id_list=$users.$user_id.sso}{/if}</td></tr></tbody>
                        </table>
                    {else}
                        {if $sso == GRN_PHONEMESSAGE_SSO_DEFAULT}{grn_user_name uid=$user_id users_info=$users_info}{else}{grn_sso_link uid=$user_id caption=$users.$user_id.col_display_name sso_id=$sso app_id="phonemessage" id_list=$users.$user_id.sso}{/if}</td>
                    {/if}
                <td nowrap>
                    {if $access.add}{assign var='disabled' value=true}{else}{assign var='disabled' value=false}{/if}
                    {capture name='grn_phonemessage_GRN_PHM_58'}{cb_msg module='grn.phonemessage' key='GRN_PHM-58' replace='true'}{/capture}{grn_link page='phonemessage/add' caption=$smarty.capture.grn_phonemessage_GRN_PHM_58 gid=$group_id uid=$user_id image='telmemo20_w.gif' disabled=$disabled}&nbsp;
                    {if $access.browse}{assign var='disabled' value=true}{else}{assign var='disabled' value=false}{/if}
                    {if 0 < $users.$user_id.newmessage_count}{assign var='class_name' value='telmemo20_u'}{else}{assign var='class_name' value='telmemo20'}{/if}
                    {capture name='grn_phonemessage_GRN_PHM_59'}{cb_msg module='grn.phonemessage' key='GRN_PHM-59' replace='true'}{/capture}{grn_link page='phonemessage/history' gid=$group_id uid=$user_id caption=$smarty.capture.grn_phonemessage_GRN_PHM_59 image=$class_name|cat:'.gif' disabled=$disabled}
                </td>
                <td nowrap class="tAlignCenter-grn">
                    {if 0 < $users.$user_id.email_flags}{grn_image image='image-common/mark_check16.png'}{else}{/if}
                </td>
                <td nowrap>
                    {if $active_presence}
                        {assign var='presence' value=$access.presence}
                        {grn_link page=$presence.page caption=$presence.info uid=$user_id disabled=$presence.disabled}
                        {if $presence.mtime}<br>
                            {if $presence.old}<span class="attention">{/if}
                            {grn_date_format date=$presence.mtime format="DateTimeCompact"}
                            {if $presence.old}</span>{/if}
                        {/if}
                    {/if}
                </td>
                {if $schedule_available}
                <td nowrap>
                {foreach from=$users_event.$user_id.schedule_event.event item=event}
                    <div class="{$event.type} normalEventElement group_week_calendar_item">
                        {if ! $event.private}{if $event.type == "share_temporary" || $event.type == "temporary"}<span class="{$event.type}">{/if}<a href="{grn_pageurl page='schedule/view' event=$event.id bdate=$schedule_event.date uid=$user_id gid=$group_id}">{/if}{$event.data|grn_noescape}{if $event.is_private}{grn_image image="image-common/privateMark_sub16.png"}{/if}{if ! $event.private}</a>{if $event.type == "share_temporary" || $event.type == "temporary"}</span>{/if}{/if}
                    </div>
                {/foreach}
                </td>
                {/if}
            </tr>
        {/foreach}
  </table>
  {capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$view_set.start_count end_num=$view_set.end_count all_num=$view_set.count}{/capture}

{include file='grn/footer.tpl'}
