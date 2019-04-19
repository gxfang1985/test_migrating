<div class="explanation">
{cb_msg module='grn.bulletin' key='GRN_BLLT-52' replace='true'}<br>
{cb_msg module='grn.bulletin' key='GRN_BLLT-53' replace='true'}{grn_sentence caption=$node.name image='category20.gif' class='bold'}<br>
{cb_msg module='grn.bulletin' key='GRN_BLLT-590' replace='true'}
</div>
<div class="aButtonHighlight-grn mTop10 mLeft10">
    {if $node.nid == 1}
        <a href={grn_pageurl page="$page_dir/notify_copy_multi" cid=$node.nid top=$node.nid}>
    {else}
        <a href={grn_pageurl page="$page_dir/notify_copy_multi" cid=$node.nid focused_id=$node.nid}>
    {/if}
        <span class="aButtonHighlight_img_grn">{grn_image image='subscribe20.png'}</span>
        <span class="aButtonText-grn">{cb_msg module='grn.bulletin' key='GRN_BLLT-617' replace='true'}</span>
    </a>
</div>
{include file='grn/notify_list.tpl' page_dir=$page_dir page_prefix=$page_prefix base_prefix=$base_prefix}

