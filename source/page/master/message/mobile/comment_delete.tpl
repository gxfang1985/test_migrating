{capture name='message'}{cb_msg module='grn.mobile' key='GRN_MOBILE-20' replace='true'}{/capture}
{include file='grn/mobile_delete.tpl' form_id='message_comment_delete'}
<form id="message_comment_delete" name="message/comment_delete" method="post" action="{grn_pageurl page='message/mobile/command_comment_delete'}" data-ajax="false">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="cid" value="{$cid}">
    <input type="hidden" name="rid" value="{$rid}">
    <input type="hidden" name="mid" value="{$mid}">
    <input type="hidden" name="follow_id" value="{$follow_id}">
</form>
