<div {if $portlet.use_frame && $portlet.frame_style}class="portlet_information_frame_{$portlet.frame_style}_grn"{/if}>
    <div class="portal_frame portal_frame_notices_grn">
        <table class="portal_notices_table_grn">
            <tr>
                <td>
                    {if $portlet.editor}
                    {$portlet.data|grn_noescape}
                    {else}
                    {grn_format body=$portlet.data}
                    {/if}
                </td>
            </tr>
        </table>
    </div>
</div><!--end of portal_frame -->
