====================================================================
{cb_msg module='grn.memo' key='GRN_MEM-1' replace='true'}{$content.title|grn_noescape}
{cb_msg module='grn.memo' key='GRN_MEM-2' replace='true'}{grn_date_format date=$content.ctime format='DateTimeFull_YMDW_HM'}
{cb_msg module='grn.memo' key='GRN_MEM-3' replace='true'}{grn_date_format date=$content.mtime format='DateTimeFull_YMDW_HM'}

{$content.data|grn_noescape}

{foreach from=$content.files item=file}
{$file.name|grn_noescape}
{/foreach}

