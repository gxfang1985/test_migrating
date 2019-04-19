<table width="100%">
    <tr valign="top">
        <td>
            <div class="mBottom5">
                <span class="sub_title">{$node.name}</span>
            {if $classification == "access"}
                {if $display_model}
                    {if $is_grant}
                        {capture name='grn_grn_GRN_GRN_1547'}{cb_msg module='grn.grn' key='GRN_GRN-1547' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_grn_GRN_GRN_1547 image='access20.gif'}
                    {elseif $is_revoke}
                        {capture name='grn_grn_GRN_GRN_1548'}{cb_msg module='grn.grn' key='GRN_GRN-1548' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_grn_GRN_GRN_1548 image='access20.gif'}
                    {/if}
                {/if}
            {elseif $classification == "notify"}
                {if $display_model}
                    {if ! $notify.force}
                        {capture name='grn_grn_GRN_GRN_1549'}{cb_msg module='grn.grn' key='GRN_GRN-1549' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_grn_GRN_GRN_1549 image='subscribe20.png'}
                    {else}
                        {capture name='grn_grn_GRN_GRN_1550'}{cb_msg module='grn.grn' key='GRN_GRN-1550' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_grn_GRN_GRN_1550 image='subscribe20.png'}
                    {/if}
                {/if}
            {/if}
            </div>
            <table width="100%">
                <tr valign="top">
                    <td>
                {if $classification == "access"}
                    {include file='grn/_access_list.tpl' view_mode=true}
                {elseif $classification == "notify"}
                    {include file='grn/_notify_list.tpl' view_mode=true}
                {/if}
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>