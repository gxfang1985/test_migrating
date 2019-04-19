<table class="top_title">{strip}
    <tbody>
    <tr>
        <td>
            <span class="portlet_title_grn">
                <a href="{grn_pageurl page='address/user_list' disabled=$disable_address}">{$page_title}</a>
            </span>
        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_presence_grn">
    <table class="list_column" width="100%">{strip}
        <tr>
            <td nowrap>
                <div class="mTop3 mBottom3">
                    {$presence.info|escape}
                    {if $presence.mtime}
                        {if $presence.old}
                            <span class="attention">
                        {/if}
                        &nbsp;[{grn_date_format date=$presence.mtime format="DateTimeCompact"}]
                        {if $presence.old}
                            </span>
                        {/if}
                    {/if}
                </div>
                <form name="presence" method="post" action="{grn_pageurl page='presence/portlet/command_view_attendee'}">
                    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                    <div class="mBottom3">
                        {grn_select class='element_grn mRight3' name='status' options=$options default=0}
                        <input type="text" name="memo" class="input_text_grn mRight3" size="25" maxlength="100">
                        <span class="aButtonStandard-grn">
                            <a href="javascript:void(0)" onclick="jQuery(this).parents('form').submit();return false;">
                                <span>
                                    {cb_msg module='grn.presence.portlet' key='GRN_PRSC_PTLT-1' replace='true'}
                                </span>
                            </a>
                        </span>
                    </div>
                </form>
            </td>
        </tr>
    </table>{/strip}
</div> <!--end of portal_frame -->
