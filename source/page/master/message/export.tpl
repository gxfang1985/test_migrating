====================================================================
{cb_msg module='grn.message' key='GRN_MSG-5' replace='true'}{$message.subject|grn_noescape}
{cb_msg module='grn.message' key='GRN_MSG-6' replace='true'}{$message.creator|grn_noescape}
{cb_msg module='grn.message' key='GRN_MSG-7' replace='true'}{$message.addressees|grn_noescape}
{if $message.managers neq ''}
{cb_msg module='grn.message' key='GRN_MSG-386' replace='true'}{$message.managers|grn_noescape}
{/if}
{if $message.delete_addressees neq ''}
{cb_msg module='grn.message' key='GRN_MSG-8' replace='true'}{$message.delete_addressees|grn_noescape}
{/if}
{if $message.deleted_addressees neq ''}
{cb_msg module='grn.message' key='GRN_MSG-before385' replace='true'}{$app_name|grn_noescape}{cb_msg module='grn.message' key='GRN_MSG-385' replace='true'}{$message.deleted_addressees|grn_noescape}
{/if}
{if $message.unsubscribe neq ''}
{cb_msg module='grn.message' key='GRN_MSG-387' replace='true'}{$message.unsubscribe|grn_noescape}
{/if}
{cb_msg module='grn.message' key='GRN_MSG-9' replace='true'}{grn_date_format date=$message.ctime format='DateTimeFull_YMDW_HM'}
{if $message.mtime}
{cb_msg module='grn.message' key='GRN_MSG-10' replace='true'}{grn_date_format date=$message.mtime format='DateTimeFull_YMDW_HM'}
{/if}

{$message.data|grn_noescape}

{if $message.attach_files}
{foreach from=$message.attach_files item=file}
{$file.name|grn_noescape}
{/foreach}
{/if}
{if $message.follows}

====================================================================
{foreach from=$message.follows item=follow}
{$follow.id|grn_noescape}{cb_msg module='grn.message' key='GRN_MSG-11' replace='true'}{$follow.creator|grn_noescape}
{grn_date_format date=$follow.ctime format='DateTimeFull_YMDW_HM'}
{if $follow.mention_name}

{$follow.mention_name|grn_noescape}
{/if}

{$follow.data|grn_noescape}

{if $follow.attach_files}
{foreach from=$follow.attach_files item=file}
{$file.name|grn_noescape}
{/foreach}

{/if}
--------------------------------------------------------------------
{/foreach}
{/if}
