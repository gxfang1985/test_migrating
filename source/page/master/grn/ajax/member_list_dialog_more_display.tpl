{if $case == "prepend"}
<span id="display_{$id}_close">
    {cb_msg module='grn' key='grn.grn_members_name.ellipsis' replace='true'}
    <span class="nowrap-grn">
        <small>
            {cb_msg module='grn' key='grn.grn_members_name.expand_start' replace='true'}
            <a href="javascript:void(0);display_on_off('display_{$id}_close:display_{$id}_open')">
            {cb_msg module='grn' key='grn.grn_members_name.expand_description' replace='true'}
            </a>
            {cb_msg module='grn' key='grn.grn_members_name.expand_end' replace='true'}
        </small>
    </span>
</span>
<span id="display_{$id}_open" style="display:none">
{/if}

{if $case == "append"}
    <span class="nowrap-grn">
        <small>
            {cb_msg module='grn' key='grn.grn_members_name.shorten_start' replace='true'}
            <a href="javascript:void(0);display_on_off('display_{$id}_close:display_{$id}_open')">
                {cb_msg module='grn' key='grn.grn_members_name.shorten_description' replace='true'}
            </a>
            {cb_msg module='grn' key='grn.grn_members_name.shorten_end' replace='true'}
        </small>
    </span>
{/if}