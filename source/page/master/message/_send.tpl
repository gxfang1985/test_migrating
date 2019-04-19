{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th>{capture name='grn_message_GRN_MSG_12'}{cb_msg module='grn.message' key='GRN_MSG-12' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_message_GRN_MSG_12 necessary=true}</th>
  <td>{capture name='grn_message_GRN_MSG_13'}{cb_msg module='grn.message' key='GRN_MSG-13' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" message=$smarty.capture.grn_message_GRN_MSG_13 transform="cb_trim" append="validation_errors"}{grn_text name="title" value=$message.subject size="50" disable_return_key=true}</td>
 </tr>
 <tr>
  <th>{cb_msg module='grn.message' key='GRN_MSG-14' replace='true'}</th>
  <td>{grn_user_name uid=$login.id}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.message' key='GRN_MSG-15' replace='true'}</th>
  <td>
{include file="grn/richeditor.tpl" html=$message.html text=$message.data cols=$cols rows=$rows enable=$use_editor class="form_textarea_grn"}
  </td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.message' key='GRN_MSG-16' replace='true'}</th>
  <td>{include file="grn/attach_file.tpl" attached_files=$message.attached_files disable_return_key=true}</td>
 <tr valign="top">
  <th>{capture name='grn_message_GRN_MSG_17'}{cb_msg module='grn.message' key='GRN_MSG-17' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_message_GRN_MSG_17 necessary=true}</th>
  <td>
   {capture name='grn_message_GRN_MSG_18'}{cb_msg module='grn.message' key='GRN_MSG-18' replace='true'}{/capture}{validate form=$form_name field="sUID" criteria="notEmpty" message=$smarty.capture.grn_message_GRN_MSG_18 append="validation_errors"}
   {grn_member_add name='sUID' app_id='message' form_name=$form_name selected_users=$addressee_users include_org=true add_org_with_users=true access_plugin=$plugin add_org_with_users=true operator_add_name='sUID_o'}
  </td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.message' key='GRN_MSG-19' replace='true'}</th>
  <td>
   {capture name='grn_message_GRN_MSG_20'}{cb_msg module='grn.message' key='GRN_MSG-20' replace='true'}{/capture}{grn_checkbox name="confirm" id="3" value="1" caption=$smarty.capture.grn_message_GRN_MSG_20 checked=$message.confirm}<br>
   <div class="sub_explanation">{cb_msg module='grn.message' key='GRN_MSG-21' replace='true'}</div>
  </td>
 </tr>
 <tr>
{if $operator_open}
  <th>{capture name='grn_message_GRN_MSG_390'}{cb_msg module='grn.message' key='GRN_MSG-390' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_message_GRN_MSG_390 necessary=true}</th><td>{capture name='grn_message_GRN_MSG_391'}{cb_msg module='grn.message' key='GRN_MSG-391' replace='true'}{/capture}{grn_radio name="operator-set" id="operator-set1" value="0" caption=$smarty.capture.grn_message_GRN_MSG_391 checked=0 onclick='display_off(\'operator_select\')'}{capture name='grn_message_GRN_MSG_392'}{cb_msg module='grn.message' key='GRN_MSG-392' replace='true'}{/capture}{grn_radio name="operator-set" id="operator-set2" value="1" checked=1 caption=$smarty.capture.grn_message_GRN_MSG_392 onclick='display_on(\'operator_select\')'}</td>
{else}
  <th>{capture name='grn_message_GRN_MSG_393'}{cb_msg module='grn.message' key='GRN_MSG-393' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_message_GRN_MSG_393 necessary=true}</th><td>{capture name='grn_message_GRN_MSG_394'}{cb_msg module='grn.message' key='GRN_MSG-394' replace='true'}{/capture}{grn_radio name="operator-set" id="operator-set1" value="0" caption=$smarty.capture.grn_message_GRN_MSG_394 checked=1 onclick='display_off(\'operator_select\')'}{capture name='grn_message_GRN_MSG_395'}{cb_msg module='grn.message' key='GRN_MSG-395' replace='true'}{/capture}{grn_radio name="operator-set" id="operator-set2" value="1" checked=0 caption=$smarty.capture.grn_message_GRN_MSG_395 onclick='display_on(\'operator_select\')'}</td>
{/if}
 </tr>
 <tr valign="top" id="operator_select"{if ! $operator_open} style="display:none;"{/if}><th>{cb_msg module='grn.message' key='GRN_MSG-396' replace='true'}</th>
  <td>{grn_operator_add name='sUID_o'
         form_name=$form_name operators_list_id='sUID_o' operators_candidate_list_id='operators_candidate_list'
         member_add_names='sUID' selected_operators=$operation_users candidate_operators=$addressee_users_filter app_id='message'}</td>
 </tr>
 <tr>
  <td></td>
  <td>
   {include file="$button_file"}
  </td>
 </tr>
</table>
<input type="hidden" name="cmd">
<input type="hidden" name="cid" value="{$category_id}">
<input type="hidden" name="rid" value="{$relation_id}">
<input type="hidden" name="mid" value="{$message_id}">
<input type="hidden" name="tmp_key" value="{$tmp_key}">
{literal}
<script>
<!--
function grn_onsubmit_common()
{
    grn.component.member_add.prepareSubmit(["sUID", "sUID_o"]);
}
//-->
</script>
{/literal}
