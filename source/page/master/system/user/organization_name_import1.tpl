{assign var="form_name" value=$smarty.template|basename}
{capture name='explanation'}
   <div><span class="bold">1.</span>&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-155' replace='true'}</div> 
   <div><span class="bold">2.</span>&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-695' replace='true'}</div> 
   <div><span class="bold">3.</span>&nbsp;{cb_msg module='grn.system.user' key='GRN_SY_US-148' replace='true'}</div> 
{/capture}
{capture name=sub_explanation}
{if ! $is_admin}
{cb_msg module='grn.system.user' key='GRN_SY_US-411' replace='true'}<br>
{cb_msg module='grn.system.user' key='GRN_SY_US-412' replace='true'}{cb_msg module='grn.system.user' key='GRN_SY_US-413' replace='true'}<br>
{/if}
<br>
{cb_msg module='grn.system.user' key='GRN_SY_US-417' replace='true'}<br>
{/capture}
{include file='grn/std_import1.tpl' config_id='system' column_explanation=$smarty.capture.explanation sub_explanation=$smarty.capture.sub_explanation cancel_page='system/user/org_import_index' post_page='system/user/command_organization_name_import1'}
