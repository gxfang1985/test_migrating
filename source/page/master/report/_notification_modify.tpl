{grn_title title=$page_title class=$page_info.parts[0]}
<form name="{$form_name}" method="post" action="{grn_pageurl page=$page_prefix|cat:'/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  <p class="explanation">
    {if $report.enable_member}{cb_msg module='grn.report' key='GRN_RPRT-148' replace='true'}{else}{cb_msg module='grn.report' key='disable_member_notification.attention' replace='true'}{/if}
  </p>
  <table class="std_form">
    <tr valign="top">
      <th>{capture name='grn_report_GRN_RPRT_149'}{cb_msg module='grn.report' key='GRN_RPRT-149' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_GRN_RPRT_149}</th>
      <td>
        <div style="display:none;">{grn_member_add name ="member_sUID" form_name=$form_name sUID='member_sUID' CID='member_CID' selected_users=$members function_name='memberPopupUserList' app_id='report' access_plugin=$plugin}</div>
        {php}
            $this->assign('search_box_options',array('is_use'       => TRUE,
                                                     'id_searchbox' => 'sUID_o_search_key'));
        {/php}
        {grn_member_add name="sUID" operator_add_name="sUID_o" search_box_options=$search_box_options form_name=$form_name sUID="sUID" CID="CID" selected_users=$notification app_id='report' access_plugin=$plugin}
      </td>
    </tr>
    <tr>
     {if $operator_open}
      <th>{capture name='grn_report_allow_operator'}{cb_msg module='grn.report' key='allow_operator' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_allow_operator necessary=true}</th><td>{capture name='grn_report_only_creator'}{cb_msg module='grn.report' key='only_creator' replace='true'}{/capture}{grn_radio name="operator-set" id="operator-set1" value="0" caption=$smarty.capture.grn_report_only_creator checked=0 onclick='display_off(\'operator_select\')'}{capture name='grn_report_set_operator'}{cb_msg module='grn.report' key='set_operator' replace='true'}{/capture}{grn_radio name="operator-set" id="operator-set2" value="1" checked=1 caption=$smarty.capture.grn_report_set_operator onclick='display_on(\'operator_select\')'}</td>
     {else}
      <th>{capture name='grn_report_allow_operator'}{cb_msg module='grn.report' key='allow_operator' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_allow_operator necessary=true}</th><td>{capture name='grn_report_only_creator'}{cb_msg module='grn.report' key='only_creator' replace='true'}{/capture}{grn_radio name="operator-set" id="operator-set1" value="0" caption=$smarty.capture.grn_report_only_creator checked=1 onclick='display_off(\'operator_select\')'}{capture name='grn_report_set_operator'}{cb_msg module='grn.report' key='set_operator' replace='true'}{/capture}{grn_radio name="operator-set" id="operator-set2" value="1" checked=0 caption=$smarty.capture.grn_report_set_operator onclick='display_on(\'operator_select\')'}</td>
     {/if}
    </tr> 
    <tr valign="top" id="operator_select"{if ! $operator_open} style="display:none;"{/if}>
      <th>{cb_msg module='grn.report' key='allow_user' replace='true'}</th>
      <td>{grn_operator_add name="sUID_o" form_name=$form_name operators_list_id="sUID_o" operators_candidate_list_id="operators_candidate_list" member_add_names="sUID:member_sUID" sUID_out_data=$operators selected_operators=$operators candidate_operators=$candidate_operators app_id='report'}</td>
    </tr>
    <tr>
      <td></td>
      <td>
          {strip}
              <div class="mTop10">
                  {capture name='grn_report_GRN_RPRT_150'}{cb_msg module='grn.report' key='GRN_RPRT-150' replace='true'}{/capture}
                  {capture name="onreportsave"}grn.component.member_add.prepareSubmit(["sUID", "sUID_o"]);grn.component.button.util.submit(this);{/capture}
                  {grn_button id="report_button_save" ui="main" spacing="normal" auto_disable=true caption=$smarty.capture.grn_report_GRN_RPRT_150 onclick=$smarty.capture.onreportsave|escape:"javasctipt"}
                  {grn_button id="report_button_cancel" action="cancel" page=$page_prefix|cat:'/'|cat:$view_page page_param_rid=$rid}
              </div>
          {/strip}
      </td>
    </tr>
  </table>
  <input type="hidden" name="rid" value="{$rid}">
 {if $is_system || $is_operation}
  <input type="hidden" name="cid" value="{$category_id}">
  <input type="hidden" name="fid" value="{$form_id}">
 {/if}
  <input type='hidden' name='fn' value="{$form_name}">
</form>
