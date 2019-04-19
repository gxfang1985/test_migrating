<table>
    <tbody>
        {foreach from=$conditions item=c}
            <tr>
                <td style="width:auto;border:none;">
                    <span class="filtercondition_target">
                        {if $c.col_type == 6}
                            {$c.item_name}
                        {else}
                            {cb_msg module='grn.report' key="condition.target.`$c.col_type`" }
                        {/if}
                    </span>
                </td>
                <td style="width:auto;border:none;">
                    {if $c.col_type == 2 || ($c.col_type == 6 && ( $c.item_type == 'grn.report.date' || $c.item_type == 'grn.report.time' ) )}
                        {cb_msg module='grn.report' key="condition.type.date.`$c.col_condition`" }
                    {elseif $c.col_type == 6 && $c.item_type == 'grn.report.checkbox'}
                        {if $c.value}
                            {cb_msg module='grn.report' key="condition.item.checked" replace="true"}
                        {else}
                            {cb_msg module='grn.report' key="condition.item.unchecked" replace="true"}
                        {/if}
                    {elseif $c.col_type == 6 && $c.item_type == 'grn.report.file'}
                        {if $c.value}
                            {cb_msg module='grn.report' key="condition.item.file.attached" replace="true"}
                        {else}
                            {cb_msg module='grn.report' key="condition.item.file.unattached" replace="true"}
                        {/if}
                    {else}
                        {cb_msg module='grn.report' key="condition.type.`$c.col_condition`" }
                    {/if}
                </td>
                <td style="width:auto;border:none;">
                    <span class="filtercondition_value">
                        {if $c.item_type != 'grn.report.file' && $c.item_type != 'grn.report.checkbox'}
                            {$c.value}
                        {/if}
                    </span>
                </td>
            </tr>
        {/foreach}
    </tbody>
</table>
