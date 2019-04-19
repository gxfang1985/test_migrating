<div class="explanation">
{cb_msg module='grn.cabinet' key='GRN_CAB-192' replace='true'}
{grn_sentence caption=$node.name image='folder20.gif' class='bold'}
<br>
{cb_msg module='grn.cabinet' key='GRN_CAB-289' replace='true'}
</div>
<div class="aButtonHighlight-grn mTop10 mLeft10">
    {if $node.nid == 1}
        <a href={grn_pageurl page="$page_dir/access_copy_multi" hid=$node.nid top=$node.nid}>
    {else}
        <a href={grn_pageurl page="$page_dir/access_copy_multi" hid=$node.nid focused_id=$node.nid}>
    {/if}
        <span class="aButtonHighlight_img_grn">{grn_image image='access20.gif'}</span>
        <span class="aButtonText-grn">{cb_msg module='grn.cabinet' key='GRN_CAB-292' replace='true'}</span>
    </a>
</div>
{include file='grn/access_list.tpl' page_dir=$page_dir page_prefix=$page_prefix base_prefix=$base_prefix}

