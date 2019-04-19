{capture name='message'}{cb_msg module='grn.mobile' key='GRN_MOBILE-20' replace='true'}{/capture}
{include file='grn/mobile_delete.tpl' form_id='bulletin_comment_delete'}
<form id="bulletin_comment_delete" name="bulletin/comment_delete" method="post" action="{grn_pageurl page='bulletin/mobile/command_comment_delete'}" data-ajax="false">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="cid" value="{$cid}">
    <input type="hidden" name="aid" value="{$aid}">
    <input type="hidden" name="follow_id" value="{$follow_id}">
</form>
