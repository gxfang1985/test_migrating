{capture name=cancel_button}
{grn_button_cancel class="margin" page="system/user/org_import_index"}
{/capture}

{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-155' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-695' replace='true'}</div> 
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-148' replace='true'}</div> 
{/capture}

{capture name=sub_explanation}
{cb_msg module='grn.system.user' key='GRN_SY_US-284' replace='true'}<br>
<br>
{if ! $is_admin}
<div class="attention">{cb_msg module='grn.system.user' key='GRN_SY_US-286' replace='true'}<br>
  {cb_msg module='grn.system.user' key='GRN_SY_US-287' replace='true'}{cb_msg module='grn.system.user' key='GRN_SY_US-288' replace='true'}<br>
{/if}
{/capture}

{include file='grn/std_import2.tpl' config_id='system' cancel_button=$smarty.capture.cancel_button prev_page='system/user/organization_name_import1' post_page='system/user/command_organization_name_import2' column_explanation=$smarty.capture.explanation sub_explanation=$smarty.capture.sub_explanation}
