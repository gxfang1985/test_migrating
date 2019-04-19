{grn_load_javascript file="grn/html/component/member_modify_order.js"}
{grn_load_javascript file="grn/html/component/member_select_list.js"}
<script language="JavaScript" type="text/javascript">
    <!--
    new grn.component.member_modify_order.MemberModifyOrder("member_modify_order", "{$form_name}", "{$list_name}");
    //-->
</script>
<div id="one_parts">
    <div id="action">
        <table class="table_plain_grn">
            <tr>
                <td class="buttonSlectOrder-grn pRight7">
                    <div id="{$list_name}_order_top" class="mBottom10">
                        <a class="order_top_grn"
                           aria-label="{cb_msg module='grn.grn' key='GRN_GRN-1564' replace='true'}"
                           title="{cb_msg module='grn.grn' key='GRN_GRN-1564' replace='true'}"
                           href="javascript:void(0)"></a>
                    </div>
                    <div id="{$list_name}_order_up" class="mBottom10">
                        <a class="order_up_grn"
                           aria-label="{cb_msg module='grn.grn' key='GRN_GRN-1565' replace='true'}"
                           title="{cb_msg module='grn.grn' key='GRN_GRN-1565' replace='true'}"
                           href="javascript:void(0)"></a>
                    </div>
                    <div id="{$list_name}_order_down" class="mBottom10">
                        <a class="order_down_grn"
                           aria-label="{cb_msg module='grn.grn' key='GRN_GRN-1566' replace='true'}"
                           title="{cb_msg module='grn.grn' key='GRN_GRN-1566' replace='true'}"
                           href="javascript:void(0)"></a>
                    </div>
                    <div id="{$list_name}_order_bottom" class="mBottom10">
                        <a class="order_bottom_grn"
                           aria-label="{cb_msg module='grn.grn' key='GRN_GRN-1567' replace='true'}"
                           title="{cb_msg module='grn.grn' key='GRN_GRN-1567' replace='true'}"
                           href="javascript:void(0)"></a>
                    </div>
                </td>
                <td class="item_select">
                    {grn_member_select_list selected_item_options=$selected_item_options list_name=$list_name style="height: 300px;" }
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    {include file=$buttons_file}
                </td>
            </tr>
        </table>
    </div>
</div>
<input type="hidden" name="{$list_name}">
