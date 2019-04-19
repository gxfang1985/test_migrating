
<script language="JavaScript">
{literal}
<!--
function onChangeField( form )
{
    form.change_type.value = 1;
    form.submit();
}
{/literal}
//-->
</script>

<p><div class="explanation">{cb_msg module='grn.workflow.system' key='w_select_route_to_split_y' replace='true'}<br>
{capture name='grn_workflow_system_w_item_type_required_y'}{cb_msg module='grn.workflow.system' key='w_item_type_required_y' replace='true'}{/capture}{validate form=$form_name field="type" criteria="notEmpty" message=$smarty.capture.grn_workflow_system_w_item_type_required_y transform="cb_trim" append="validation_errors"}<br>
{capture name='grn_workflow_system_w_split_item_required_y'}{cb_msg module='grn.workflow.system' key='w_split_item_required_y' replace='true'}{/capture}{validate form=$form_name field="item" criteria="notEmpty" message=$smarty.capture.grn_workflow_system_w_split_item_required_y transform="cb_trim" append="validation_errors"}<br>

<p>
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_item_type' replace='true'}</th>
  <td>
    <select name="type"  onChange="onChangeField( this.form )">
      {html_options options=$types selected=$type}
    </select>
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_split_item_y' replace='true'}</th>
  <td>
    <select name="item">
      {html_options options=$items selected=$item}
    </select>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
   {grn_button_submit class='margin' caption="$btn_name"}
   {grn_button_cancel page='workflow/system/form_view' cid=$category_id fid=$form_id}
  </td>
 </tr>
</table>

