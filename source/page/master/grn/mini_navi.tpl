{if $navi.page}
{assign var=page value=$navi.page}
{else}
{assign var=page value=$page_info.all}
{/if}
<div class="word_navi">
{if $navi.previous_page_start_position != -1}
 <a href="{grn_pageurl page=$page sp=0 params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.grn' key='GRN_GRN-183' replace='true'}</a>
{else}
 <span class="navi_off">{cb_msg module='grn.grn' key='GRN_GRN-184' replace='true'}</span>
{/if}
 &nbsp;|&nbsp;
{if $navi.previous_page_start_position != -1}
 <a href="{grn_pageurl page=$page sp=$navi.previous_page_start_position params=$navi.params fragment=$navi.fragment}">&lt;&lt;{cb_msg module='grn.grn' key='GRN_GRN-185' replace='true'}{$navi.number_on_page}{cb_msg module='grn.grn' key='GRN_GRN-186' replace='true'}</a>
{else}
 <span class="navi_off">&lt;&lt;{cb_msg module='grn.grn' key='GRN_GRN-187' replace='true'}{$navi.number_on_page}{cb_msg module='grn.grn' key='GRN_GRN-188' replace='true'}</span>
{/if}
 &nbsp;|&nbsp;
{if $navi.next_page_start_position != -1}
 <a href="{grn_pageurl page=$page sp=$navi.next_page_start_position params=$navi.params fragment=$navi.fragment}">{cb_msg module='grn.grn' key='GRN_GRN-189' replace='true'}{$navi.number_on_page}{cb_msg module='grn.grn' key='GRN_GRN-190' replace='true'}&gt;&gt;</a>
{else}
 <span class="navi_off">{cb_msg module='grn.grn' key='GRN_GRN-191' replace='true'}{$navi.number_on_page}{cb_msg module='grn.grn' key='GRN_GRN-192' replace='true'}&gt;&gt;</span>
{/if}
</div>
{* 前または後ろがない場合のhtmlイメージはまだ *}
