{if $all_num > 0 }
    <span id="start_num{$position}">{$start_num}</span>-<span id="end_num{$position}">{$end_num}</span> 
    {cb_msg module='grn.grn' key='GRN_GRN-115' replace='true'}
    <span id="all_num">{$all_num}</span> 
    {cb_msg module='grn.grn' key='GRN_GRN-114' replace='true'}
{else}
    {cb_msg module='grn.common' key='navigate_before'}
    <span id="start_num{$position}">{$start_num}</span>-<span id="end_num{$position}">{$end_num}</span> 
    {cb_msg module='grn.common' key='navigate_after'}
    <span id="all_num" style="display:none"></span>
{/if}
