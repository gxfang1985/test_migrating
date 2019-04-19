<div class="search_navi">
    <form name="user_week{$portletId}" method="GET" action="{grn_pageurl page=$page}">
        <input type="hidden" name="gid" value="search">
        <input type="hidden" name="type_search" value="user">
        <div class="searchboxChangeTarget-grn">
            <div class="searchbox-grn">
                <div class="searchbox-select-schedule"></div>
                <div id="searchbox-schedule-{$portletId}" class="input-text-outer-schedule searchbox-keyword-schedule">
                    <input type="text" name="search_text" value="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-176' replace='true'}" autocomplete="off" name="search_text" class="input-text-schedule prefix-grn" id="schedules_search_text" maxlength="100">
                    <input type="button" id="searchbox-submit-schedules-{$portletId}" class="searchbox-submit-schedule" onclick="JavaScript:void(0);">
                </div>
            </div>
        </div>
    </form>
</div>
