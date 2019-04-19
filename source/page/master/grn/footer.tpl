</div><!--end of mainarea-->

{if ! $kintone_dialog_mode}
<div id="footer" class="footer_grn">
    <table width="100%">
        <tr>
            <td class="nowrap-grn">
                <span class="footer_back_base_grn">{grn_backlink positions=$site_position}</span>
            </td>
            <td class="move_top_base_grn"><a class="move_top_grn" href="javascript:void(0);" onclick="jQuery('html, body').animate({ldelim} scrollTop:0 {rdelim}, 500 ); return false;"></a></td>
        </tr>
    </table>
</div>
{/if}
{include file="grn/_footer_common.tpl"}
