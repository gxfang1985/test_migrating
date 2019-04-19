<tr>
    <th>{cb_msg module="grn.space" key="space-member-set-1" replace="true"}</th>
    <td>{grn_member_add name="sUID"
                        form_name=$form_name
                        access_plugin=$plugin
                        sUID="sUID"
                        CGID="CGID"
                        CID="CID"
                        selected_users=$selected_users
                        include_org=true
                        popup_include_org=true
                        app_id="space"
                        require_role_tab=true
                        operator_add_name="sUID_o"
        }</td>
</tr>
<tr>
    <th>{cb_msg module="grn.space" key="space-member-set-2" replace="true"}</th>
    <td>{capture name="space_member_set_3"}{cb_msg module="grn.space" key="space-member-set-3" replace="true"}{/capture}
        {grn_checkbox name="operator-set" id="operator-set" value="1" caption=$smarty.capture.space_member_set_3 checked=$open_status}
        <div id="operator_select" valign="top" {if !$open_status}style="display:none;"{/if}>
            {grn_operator_add name="sUID_o"
                              form_name=$form_name
                              operators_list_id="sUID_o"
                              operators_candidate_list_id="operators_candidate_list"
                              member_add_names="sUID"
                              selected_operators=$selected_operators
                              candidate_operators=$candidate_operators
                              app_id="space"
            }
        </div>
    </td>
</tr>
{literal}
<script type="text/javascript">
jQuery('#operator-set').on('click',function(){
    if(jQuery("#operator_select").css("display") == "none")
    {
        jQuery("#operator_select").css("display", "");
    }
    else
    {
        jQuery("#operator_select").css("display", "none");
    }
});
</script>
{/literal}
