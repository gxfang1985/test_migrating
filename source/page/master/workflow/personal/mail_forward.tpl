{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<script type="text/javascript">
{literal}
jQuery(document).ready(function(){
    toggleUserEmail();
});
        
function toggleUserEmail()
{
    var forward_user_email= jQuery("#forward_user_email");
    if(forward_user_email.length > 0)
    {
        var other_email_address = jQuery("#other_email_address");
        if ( forward_user_email.prop( "checked" ) )
        {
            other_email_address.prop("disabled", true);
        }
        else
        {
            other_email_address.prop("disabled", false);
        }
    }
} 
{/literal}
</script>
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/personal/command_'|cat:$page_info.last}">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{if $available_system_email && $allow_mail_notification}
<table class="std_form">
   <tr>
      <th nowrap>{cb_msg module='grn.workflow.personal' key='GRN_WKF_PS-28' replace='true'}</th>
      <td>{capture assign='grn_workflow_personal_GRN_WKF_PS_29'}{cb_msg module='grn.workflow.personal' key='GRN_WKF_PS-29' replace='true'}{/capture}
          {grn_checkbox name='forward_email' id='forward_email' value='1' caption=$grn_workflow_personal_GRN_WKF_PS_29 checked=$forward_email}</td>
   </tr>
   <tr>
      <th nowrap>{cb_msg module='grn.workflow.personal' key='GRN_WKF_PS-30' replace='true'}</th>
      <td>{capture name='grn_workflow_personal_GRN_WKF_PS_31'}{cb_msg module='grn.workflow.personal' key='GRN_WKF_PS-31' replace='true'}{$user_email_address}{/capture}
      {grn_checkbox name='forward_user_email' id='forward_user_email' value='1' caption= $smarty.capture.grn_workflow_personal_GRN_WKF_PS_31 checked=$forward_user_email onclick='toggleUserEmail();'}<br>
      {grn_text name='other_email_address' id='other_email_address' size='50' value=$other_email_address}
      </td>
   </tr>
   <tr>
      <td></td>
      <td>{capture name='grn_workflow_personal_GRN_WKF_PS_33'}{cb_msg module='grn.workflow.personal' key='GRN_WKF_PS-33' replace='true'}{/capture}
          {grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_personal_GRN_WKF_PS_33}
          {grn_button_cancel}
      </td>
   </tr>
</table>

{else}
  <p>
    <div class="explanation">{cb_msg module='grn.workflow.personal' key='GRN_WKF_PS-27' replace='true'}</div>
  </p>
{/if}

</form>

{include file="grn/personal_footer.tpl"}
