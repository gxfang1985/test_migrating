{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{assign var='form_name' value=$smarty.template|basename}

<div id="main_menu_part">
    <span class="menu_item">
        {if $fid != GRN_WORKFLOW_FOLDER_TYPE_APPROVAL_PLAN_ID}
            {capture name='grn_workflow_change'}{cb_msg module='grn.workflow' key='change_msg' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_change page='workflow/path_step_modify' image='modify20.gif' fid=$fid pid=$pid simple=$simple psid=$psid disabled=$not_modify cpsf=$cpsf tmp_key=$tmp_key alt=''}
        {/if}
    </span>
</div>

{grn_title title=$page_title class=$page_info.parts[0]|cat:' inline_block_grn mBottom10' no_style=1}

<div class="marginHalf">
 {grn_workflow_form_icon_image icon_type=$petition.icon_type icon_id=$petition.icon_id icon_url=$petition.icon_url}{if $petition.petition_number != ''}No.{$petition.petition_number|escape}{/if}
 <font size="+1"><span class="bold">{$petition.form_name|escape}{cb_msg module='grn.workflow' key='opened_parenthesis' replace='true'}{$petition.name|escape}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}</span></font>
</div>
<p></p>

<div class="border-partition-common-grn"></div>

<p>
<table class="view_table">
 <tr>
  <th nowrap valign="top">{cb_msg module='grn.workflow' key='path_step_name' replace='true'}</th>
  <td>{$col_role|escape}</td>
 </tr>
 <tr>
  <th nowrap valign="top">{cb_msg module='grn.workflow' key='path_class' replace='true'}</th>
  <td>
{if GRN_WORKFLOW_CIRCULAR == $col_type}
   {cb_msg module='grn.workflow' key='pass_along' replace='true'}
{else}
   {cb_msg module='grn.workflow' key="col_acceptance_type_`$col_acceptance_type`"}
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap valign="top">{cb_msg module='grn.workflow' key='path_change_permission' replace='true'}</th>
  <td>
{if $col_change_path}
   {grn_image image='check20.gif'}
{else}
   &nbsp;
{/if}</td>
 </tr>
 <tr>
  <th nowrap valign="top">{cb_msg module='grn.workflow' key='processor' replace='true'}</th>
  <td>
{if $col_skip || 0 >= $user_count}
   {cb_msg module='grn.workflow' key='skip'}
{else}
{foreach name=user from=$users item=user}
   <span class="voice">{grn_user_name uid=$user._id name=$user.col_display_name valid=$user.col_valid users_info=$users_info}</span><br>
{/foreach}
{/if}
  </td>
 </tr>
</table>
</p>

{include file='grn/footer.tpl'}
