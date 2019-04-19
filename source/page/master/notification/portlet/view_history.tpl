<table class="top_title">{strip}
    <tbody>
    <tr>
        <td>
            <span class="portlet_title_grn">
                <a href="{grn_pageurl page='notification/index' module_id=$module_id read=1}">{$page_title|escape}</a>
            </span>
        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_confirmed_notification_grn">
    {include file="notification/portlet/_view_history_content.tpl"}
</div> <!--end of portal_frame -->
