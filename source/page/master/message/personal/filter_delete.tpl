<form name="message/personal/filter_delete" method="post" action="{grn_pageurl page='message/personal/command_filter_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <p>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-8' replace='true'}<span class="bold">{grn_sentence image="msgfilter20.gif" caption=$selected.title|cb_mb_truncate}</span>{cb_msg module='grn.message.personal' key='GRN_MSG_PE-9' replace='true'}&nbsp;{cb_msg module='grn.message.personal' key='GRN_MSG_PE-10' replace='true'}</p>
<input type="hidden" name="mfid" value="{$selected.mfid}">
</form>

