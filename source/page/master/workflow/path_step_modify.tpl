{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p>
<div class="explanation">
{cb_msg module='grn.workflow' key='select_processor' replace='true'}<br>
{cb_msg module='grn.workflow' key='show_comment_on_path_history_screen' replace='true'}
</div>
</p>

<p>
<div class="marginHalf">
 {grn_workflow_form_icon_image icon_type=$petition.icon_type icon_id=$petition.icon_id icon_url=$petition.icon_url}{if $petition.petition_number != ''}No.{$petition.petition_number|escape}{/if}
 <font size="+1"><span class="bold">{$petition.form_name|escape}{cb_msg module='grn.workflow' key='opened_parenthesis' replace='true'}{$petition.name|escape}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}</span></font>
</div>
</p>

<div class="border-partition-common-grn"></div>

<table class="std_form">
 <tr>
  <th align="left" nowrap>{cb_msg module='grn.workflow' key='path_step_name' replace='true'}</th>
  <td>{$col_role|escape}</td>
 </tr>
 <tr>
  <th align="left" nowrap>{cb_msg module='grn.workflow' key='path_class' replace='true'}</th>
  <td>
{if GRN_WORKFLOW_CIRCULAR == $col_type}
   {cb_msg module='grn.workflow' key='pass_along' replace='true'}
{else}
   {cb_msg module='grn.workflow' key="col_acceptance_type_`$col_acceptance_type`"}
{/if}
  </td>
 </tr>
 <tr>
  <th align="left" valign="top" nowrap>{cb_msg module='grn.workflow' key='processor' replace='true'}</th>
  <td valign="bottom" style="padding-left:0">
{foreach name=user from=$users item=user}
{if GRN_WORKFLOW_RESULT_UNPROCESSING < $user.col_result}
   <span class="voice">{grn_user_name uid=$user._id name=$user.col_display_name valid=$user.col_valid users_info=$users_info}</span><br>
{/if}
{/foreach}
   {grn_member_add name='member_select' app_id='workflow' form_name=$form_name selected_users=$selected_users show_omitted=true use_order_parts=false access_plugin=$plugin}
  </td>
 </tr>
 <tr>
  <th align="left" valign="top" nowrap>{cb_msg module='grn.workflow' key='user_made_change' replace='true'}</th>
  <td colspan="3">{grn_user_name uid=$login.id name=$login.name users_info=$users_info}</td>
 </tr>
 <tr valign="top">
  <th align="left" nowrap>{cb_msg module='grn.workflow' key='comment' replace='true'}</th>
  <td>
   {grn_textarea name='col_comment' rows=5 cols=60 value=$col_comment}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      <div class="mTop10">
          {strip}
              {capture name='grn_workflow_change'}{cb_msg module='grn.workflow' key='change' replace='true'}{/capture}
              {grn_button id='workflow_button_save' ui='main' action='submit' spacing='normal' caption=$smarty.capture.grn_workflow_change onclick="grn_onsubmit_common(); document.forms['$form_name'].submit();"}
              {grn_button id='workflow_button_cancel' action='cancel' page='workflow/path_step_view' page_param_pid=$pid page_param_fid=$fid page_param_psid=$psid page_param_simple=$simple page_param_cpsf=$cpsf page_param_tmp_key=$tmp_key}
          {/strip}
      </div>
  </td>
 </tr>
</table>

<input type="hidden" name="fid" value="{$fid|escape}">
<input type="hidden" name="pid" value="{$pid|escape}">
<input type="hidden" name="simple" value="{$simple|escape}">
<input type="hidden" name="psid" value="{$psid|escape}">
<input type="hidden" name="cpsf" value="{$cpsf|escape}">
<input type="hidden" name="tmp_key" value="{$tmp_key|escape}">
</form>

{literal}
    <script>
        function grn_onsubmit_common() {
            if (grn.base.isNamespaceDefined("grn.component.member_add")) {
                var member_select = grn.component.member_add.get_instance("member_select");
                if (member_select) {
                    member_select.prepareSubmit();
                }
            }
        }
    </script>
{/literal}

{include file='grn/footer.tpl'}
