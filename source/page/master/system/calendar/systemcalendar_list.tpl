{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div id="main_menu_part">
    <span class="menu_item">{capture name='grn_system_calendar_GRN_SY_CA_70'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-70' replace='true'}{/capture}{grn_link page='system/calendar/add' caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_70 scid=$selected.id image='calendar20.gif'}</span>
    {if $selected.id > 1}
        {assign var='disabled' value=''}
    {else}
        {assign var='disabled' value='TRUE'}
    {/if}
    <span class="menu_item">{capture name='grn_system_calendar_GRN_SY_CA_72'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-72' replace='true'}{/capture}{grn_link page='system/calendar/event_add' caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_72 image='write20.gif' scid=$selected.id bdate=$bdate->year}</span>
    <span class="menu_item">{capture name='grn_system_calendar_GRN_SY_CA_73'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-73' replace='true'}{/capture}{grn_link page='system/calendar/event_delete_all' caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_73 image='delete20.gif' all=1 scid=$selected.id}</span>
    <div id="rare_menu_part_under">
        <span class="menu_item">{capture name='grn_system_calendar_GRN_SY_CA_74'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-74' replace='true'}{/capture}{grn_link page='system/calendar/import1' caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_74 image='import20.gif' scid=$selected.id bdate=$bdate->year}</span>
        <span class="menu_item">{capture name='grn_system_calendar_GRN_SY_CA_75'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-75' replace='true'}{/capture}{grn_link page='system/calendar/export' caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_75 image='export20.gif' scid=$selected.id bdate=$bdate->year}</span>
    </div>
</div>
<p>
<table width="100%">
    <tr valign="top">
        <td id="tree_part" width="30%">
            {foreach from=$systemcalendar item=item}
                {strip}
                <div class="tree_item">
                    {if $item.id == $selected.id}
                        <div class="hilight"><span class="bold">
                            {grn_link image='calendar20.gif' page=$page_info.all scid=$item.id caption=$item.title}
                        </span></div>
                    {else}
                        {grn_link image='calendar20.gif' page=$page_info.all scid=$item.id caption=$item.title}
                    {/if}
                </div>
                {/strip}
            {/foreach}
        </td>
        <td id="view_part" width="70%">
            <form name="auto_import_holiday" method="post" action="{grn_pageurl page='system/calendar/command_auto_import_holiday'}">
                <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                <div>
                    <span class="sub_title">{$selected.title|escape}</span>
                    {if $selected_id == '1'}{assign var='disabled' value=1}{/if}
                    {capture name='grn_system_calendar_GRN_SY_CA_76'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-76' replace='true'}{/capture}{grn_link image='detail20.gif' page='system/calendar/view' scid=$selected.id caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_76 disabled=$disabled}
                    {if $exist_holiday_data_url}
                        {strip}
                        <span class="mLeft10">
                            <input type="hidden" name="scid" value="{$selected.id}">
                            <input type="hidden" name="bdate" value="{$bdate->year}">
                            <input type="submit" name="auto_import" value="{cb_msg module='grn.system.calendar' key='GRN_SY_CA-102' replace='true'}">
                        </span>
                        {/strip}
                    {/if}
                </div>
            </form>
            <p>
            <form name="{$form_name}" method="post" action="{grn_pageurl page='system/calendar/event_delete_multi'}">
                <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                <div class="margin_bottom">
                    <span class="sub_title">{grn_date_format date=$bdate format="DateFull_Y"}</span>&nbsp;
                    <button onclick="location.href='{grn_pageurl page=$page_info.all bdate=$bdate->year-1 scid=$selected.id}';return false;">&nbsp;&nbsp;<img src="{$app_path}/grn/image/cybozu/arrow_back_single.gif?{$build_date}" align='absmiddle'>&nbsp;&nbsp;</button>
                    <button onclick="location.href='{grn_pageurl page=$page_info.all scid=$selected.id}';return false;"> {cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-17' replace='true'} </button>
                    <button onclick="location.href='{grn_pageurl page=$page_info.all bdate=$bdate->year+1 scid=$selected.id}';return false;">&nbsp;&nbsp;<img src="{$app_path}/grn/image/cybozu/arrow_next_single.gif?{$build_date}" align='absmiddle'>&nbsp;&nbsp;</button>
                </div>
                <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
                    <colgroup>
                        <col width="5%">
                        <col width="15%">
                        <col width="60%">
                        <col width="20%">
                    </colgroup>
                    <tr>
                        <th nowrap>{include file="grn/checkall.tpl" elem_name="eid[]"}</th>
                        <th nowrap>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-80' replace='true'}</th>
                        <th nowrap>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-81' replace='true'}</th>
                        <th nowrap>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-82' replace='true'}</th>
                    </tr>
                    {foreach from=$selected.event item=event}
                        {capture name=_date}{grn_date_format date=$event.date format="DateFull_MD"}{/capture}
                        <tr valign="top">
                            <td><input type="checkbox" name="eid[]" value="{$event.id}"></td>
                            <td nowrap>{grn_link page='system/calendar/event_view' caption=$smarty.capture._date event=$event.id scid=$selected.id image='detail20.gif'}</td>
                            {if $event.type == 1}
                                <td>{$event.detail|escape|nl2br}</td><td>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-83' replace='true'}</td>
                            {elseif $event.type == 5}
                                <td>{$event.detail|escape|nl2br}</td><td>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-100' replace='true'}</td>
                            {else}
                                <td>{$event.detail|escape|nl2br}</td><td>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-84' replace='true'}</td>
                            {/if}
                        </tr>
                    {/foreach}
               </table>
               <div class="margin_top">
                   {cb_msg module='grn.system.calendar' key='GRN_SY_CA-85' replace='true'}{capture name='grn_system_calendar_GRN_SY_CA_86'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-86' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_86 onclick="if(!grn_is_checked(this.form,'eid[]')) return false;"}
               </div>
               <input type="hidden" name="scid" value="{$selected.id}">
               <input type="hidden" name="bdate" value="{$bdate->year}">
           </form>
        </td>
    </tr>
</table>

{include file='grn/system_footer.tpl'}
