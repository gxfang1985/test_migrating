====================================================================
{cb_msg module='grn.bulletin' key='GRN_BLLT-395' replace='true'}{$article.title|grn_noescape}
{cb_msg module='grn.bulletin' key='GRN_BLLT-396' replace='true'}{if $article.manually_enter_sender != null}
{grn_sender_name name=$article.manually_enter_sender no_image=true}{else}
{if $article.group_name}{$article.group_name|grn_noescape}({/if}{grn_user_name name=$article.creator_name|grn_noescape uid=$article.creator_uid users_info=$users_info only_text=1}{if $article.group_name}){/if}
{/if}

{cb_msg module='grn.bulletin' key='GRN_BLLT-397' replace='true'}{$article.category_name|grn_noescape}
{cb_msg module='grn.bulletin' key='GRN_BLLT-398' replace='true'}{grn_date_format date=$article.ctime format='DateTimeFull_YMDW_HM'}
{if ! $article.stime}
{if ! $article.etime}
{cb_msg module='grn.bulletin' key='GRN_BLLT-399' replace='true'}
{else}
{cb_msg module='grn.bulletin' key='GRN_BLLT-400' replace='true'} {grn_date_format date=$article.etime format='DateFull_YMDW'}
{/if}
{else}
{if $article.etime}
{cb_msg module='grn.bulletin' key='GRN_BLLT-401' replace='true'}{if $article.start_is_datetime}{grn_date_format date=$article.stime format='DateTimeFull_YMDW_HM'}{else}{grn_date_format date=$article.stime format='DateFull_YMDW'}{/if} {cb_msg module='grn.bulletin' key='GRN_BLLT-402' replace='true'} {if $article.end_is_datetime}{grn_date_format date=$article.etime format='DateTimeFull_YMDW_HM'}{else}{grn_date_format date=$article.etime format='DateFull_YMDW'}{/if}
{else}
{cb_msg module='grn.bulletin' key='GRN_BLLT-403' replace='true'}
{/if}
{/if}

{$article.data|grn_noescape}

{if $article.attach_files}
{foreach from=$article.attach_files item=file}
{$file.name|grn_noescape}
{/foreach}

{/if}
{if $article.follows}
====================================================================
{/if}
{foreach from=$article.follows item=follow}
{$follow.id|grn_noescape}{cb_msg module='grn.bulletin' key='GRN_BLLT-404' replace='true'}{grn_user_name name=$follow.creator_name|grn_noescape uid=$follow.creator_uid only_text=1 users_info=$users_info}
{grn_date_format date=$follow.ctime format='DateTimeFull_YMDW_HM'}

{$follow.data|grn_noescape}

{if $follow.attach_files}
{foreach from=$follow.attach_files item=file}
{$file.name|grn_noescape}
{/foreach}

{/if}
--------------------------------------------------------------------
{/foreach}
