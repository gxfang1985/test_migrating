{if ! $folder_page}{assign var='folder_page' value=$page_info.all}{/if}
{if $folder.parent}
    <div class="tree_item">
    {if $garbage_page}
        {capture name='grn_cabinet_GRN_CAB_214'}{cb_msg module='grn.cabinet' key='GRN_CAB-214' replace='true'}{/capture}{capture name='grn_cabinet_GRN_CAB_215'}{cb_msg module='grn.cabinet' key='GRN_CAB-215' replace='true'}{/capture}{grn_link image='folder20.gif' page=$folder_page hid=$folder.parent.hid caption=$smarty.capture.grn_cabinet_GRN_CAB_214|cat:$folder.parent.name|cat:$smarty.capture.grn_cabinet_GRN_CAB_215}
        <div class="border-partition-common-grn"></div>
    {else}
        {capture name='grn_cabinet_GRN_CAB_216'}{cb_msg module='grn.cabinet' key='GRN_CAB-216' replace='true'}{/capture}{capture name='grn_cabinet_GRN_CAB_217'}{cb_msg module='grn.cabinet' key='GRN_CAB-217' replace='true'}{/capture}{grn_link image='folder20.gif' page=$folder_page hid=$folder.hid caption=$smarty.capture.grn_cabinet_GRN_CAB_216|cat:$folder.name|cat:$smarty.capture.grn_cabinet_GRN_CAB_217}
    {/if}
    </div>
{else}
    {if ! $garbage_page}
        <div class="tree_item">
        {capture name='grn_cabinet_GRN_CAB_218'}{cb_msg module='grn.cabinet' key='GRN_CAB-218' replace='true'}{/capture}{capture name='grn_cabinet_GRN_CAB_219'}{cb_msg module='grn.cabinet' key='GRN_CAB-219' replace='true'}{/capture}{grn_link image='folder20.gif' page=$folder_page hid=$folder.hid caption=$smarty.capture.grn_cabinet_GRN_CAB_218|cat:$folder.name|cat:$smarty.capture.grn_cabinet_GRN_CAB_219}
        </div>
    {/if}
{/if}
{if $garbage_page}
    <div class="sub_title">{if $folder.hid > 1}{cb_msg module='grn.cabinet' key='GRN_CAB-220' replace='true'}{/if}{cb_msg module='grn.cabinet' key='GRN_CAB-221' replace='true'}</div>

    {foreach from=$folder.children key=key item=item}
    <div class="tree_item">
    {grn_cabinet_folder_title page=$folder_page hid=$item.hid caption=$item.name child=$item.child_count subscribed=$item.subscribed notified=$item.notified image='folder20.gif'}
    </div>
    {/foreach}
    {if $garbage_page}
        <div class="border-partition-common-grn"></div>
        <div class="tree_item">
            {capture name='grn_cabinet_GRN_CAB_222'}{cb_msg module='grn.cabinet' key='GRN_CAB-222' replace='true'}{/capture}{grn_link image='trashbox20.gif' page=$garbage_page hid=$folder.hid caption=$smarty.capture.grn_cabinet_GRN_CAB_222}
        </div>
    {/if}
{/if}