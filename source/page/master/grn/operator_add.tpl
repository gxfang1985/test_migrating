{grn_load_javascript file="grn/html/component/operator_add.js"}
{grn_load_javascript file="grn/html/component/member_select_list.js"}

<table border="0" cellspacing="0">
    <tr>
        <td valign="bottom" style="padding-left:0">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td style="padding-left:0; padding-bottom:0"></td>
                </tr>
            </table>
            {php}
                $this->assign('search_box_options',    array('is_use'=>FALSE));
                $this->assign('pulldown_parts_options',array('is_use'=>FALSE));
                $this->assign('order_parts_options',   array('is_use'=>FALSE));
            {/php}
            {grn_member_add name=$name
                            app_id=$app_id
                            search_box_options=$search_box_options
                            pulldown_parts_options=$pulldown_parts_options
                            order_parts_options=$order_parts_options
                            sUID=$operators_list_id
                            CID=$operators_candidate_list_id
                            selected_users=$selected_operators
                            candidate_users=$candidate_operators
                            form_name=$form_name
            }
        </td>
    </tr>
    <tr>
        <td></td>
        <td></td>
        <td>
        </td>
    </tr>
</table>
<script language="JavaScript" type="text/javascript">
    <!--
    new grn.component.operator_add.OperatorAdd("{$name}", "{$form_name}", "{$operators_list_id}", "{$operators_candidate_list_id}", {$member_add_names|@json_encode});
    //-->
</script>