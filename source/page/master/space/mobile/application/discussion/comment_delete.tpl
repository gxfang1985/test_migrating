{capture name='message'}{cb_msg module='grn.mobile' key='GRN_MOBILE-20' replace='true'}{/capture}
{include file='grn/mobile_delete.tpl' form_id='discussion_comment_delete'}
<form id="discussion_comment_delete" name="discussion/comment_delete" method="post" action="{grn_pageurl page='space/mobile/application/discussion/command_comment_delete'}" data-ajax="false">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" id="spaceid" name="spid" value="{$space_id}">
    <input type="hidden" id="threadid" name="tid" value="{$discussion_id}">
    <input type="hidden" id="cmid" name="cmid" value="{$comment_id}">
</form>
