<form name="schedule_search{$portlet.plid}" method="GET" action="{grn_pageurl page='schedule/index'}">
    <table class="top_title">{strip}
        <tr>
            <td>
                <span class="portlet_title_grn nowrap-grn mRight5 element_grn">{$page_title|escape:"html"}</span>
                <input type="hidden" name="gid" value="search">
                <input name="search_text" class="input_text_grn mRight3" size="20" maxlength="100">
                <span class="aButtonStandard-grn">
                    <a href="javascript:void(0)" onclick="jQuery(this).parents('form').submit();return false;">
                        <span>
                            {cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-176' replace='true'}
                        </span>
                    </a>
                </span>
            </td>
        </tr>
    </table>{/strip}
</form>
