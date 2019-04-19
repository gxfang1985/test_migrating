{if $portlet.settings.font_size == "large"}
    {assign var="font_size" value='140%'}
{elseif $portlet.settings.font_size == "normal"}
    {assign var="font_size" value='100%'}
{elseif $portlet.settings.font_size == "small"}
    {assign var="font_size" value='70%'}
{/if}

<div class="portal_frame portal_frame_calendar_grn">
    <table class="portlet_calendar_base_grn">
        <tr valign="top">
        {foreach from=$months key=index item=weeks}
            <td>
                <table class="portlet_calendar_grn" style="font-size:{$font_size};">{strip}
                    <colgroup>
                        <col width="14%">
                        <col width="14%">
                        <col width="14%">
                        <col width="14%">
                        <col width="14%">
                        <col width="14%">
                        <col width="14%">
                    </colgroup>
                    <tr>
                        <td colspan="7" class="portlet_calendar_th_grn">
                            {if $index == $table_info.first}
                            <span class="moveButtonBase-grn mRight7 mLeft7" title="{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-16' replace='true'}">
                                <a href="{grn_pageurl page=$page_info.all bdate=$navi.prev pid=$portlet.pid}">
                                    <span class="moveButtonArrowLeft-grn"></span>
                                </a>
                            </span>
                            {/if}
                            <span class="vAlignMiddle-grn">{grn_date_format date=$table_info.months[$index] format="DateFull_YM"}</span>
                            {if $index == $table_info.last}
                            <span class="moveButtonBase-grn mRight7 mLeft7" title="{cb_msg module='grn.portal.portlet' key='GRN_POT_PO-18' replace='true'}">
                                <a href="{grn_pageurl page=$page_info.all bdate=$navi.next pid=$portlet.pid}">
                                    <span class="moveButtonArrowRight-grn"></span>
                                </a>
                            </span>
                            {/if}
                        </td>
                    </tr>
                    <tr>
                    {foreach from=$weeks[0] key=date item=day}
                        {if $day.real_type == 's_date_saturday'}
                        <td class="portlet_calendar_saturday_grn">
                        {elseif $day.real_type == 's_date_sunday'}
                        <td class="portlet_calendar_sunday_grn">
                        {else}
                        <td class="portlet_calendar_weekday_grn">
                        {/if}
                            <span>{$day.day_of_week}</span>
                        </td>
                    {/foreach}
                    </tr>
                    {foreach from=$weeks item=week}
                    <tr>
                        {foreach from=$week key=date item=day}
                            {if $day.enable == 1}
                                <td class="{$day.type}" align="center" nowrap>{grn_link page='index' caption=$day.day bdate=$date}</td>
                            {else}
                                <td class="{$day.type}" align="center" nowrap><font color=gray>{$day.day}</font></td>
                            {/if}
                        {/foreach}
                    </tr>
                    <tr>
                        {foreach from=$week key=date item=day}
                            {if $today === $date}
                            <td class="s_today">
                            {else}
                            <td class="s_calendar">
                            {/if}
                            {foreach from=$day.events item=event}
                                <div>{grn_calendar_event type=$event.type data=$event.data icon=$event.icon}</div>
                            {foreachelse}
                                <br>
                            {/foreach}
                            </td>
                        {/foreach}
                    </tr>
                    {/foreach}
                </table>{/strip}
            </td>
        {/foreach}
        </tr>
    </table>
</div> <!--end of portal_frame -->
