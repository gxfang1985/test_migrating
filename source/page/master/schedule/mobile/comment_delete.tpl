{capture name='message'}{cb_msg module='grn.mobile' key='GRN_MOBILE-20' replace='true'}{/capture}
{include file='grn/mobile_delete.tpl' form_id='schedule_comment_delete'}
<form id="schedule_comment_delete" name="schedule/comment_delete" method="post" action="{grn_pageurl page='schedule/mobile/command_comment_delete'}" data-ajax="false">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="event" value="{$event_id}">
    <input type="hidden" name="bdate" value="{$bdate}">
    <input type="hidden" name="follow_id" value="{$follow_id}">
    <input type="hidden" name="uid" value="{$user_id}">
    <input type="hidden" name="gid" value="{$group_id}">
    <input type="hidden" name="referer_key" value="{$referer_key}">
</form>
