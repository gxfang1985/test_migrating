{capture name=cancel_button}
{grn_button_cancel class="margin" page="system/user/org_import_index"}
{/capture}
{include file='system/user/_organization_csv_columns.tpl'}
{capture name=sub_explanation}
{cb_msg module='grn.system.user' key='GRN_SY_US-281' replace='true'}<br>
{cb_msg module='grn.system.user' key='GRN_SY_US-282' replace='true'}<br>
{cb_msg module='grn.system.user' key='GRN_SY_US-283' replace='true'}<br>
<br>
{cb_msg module='grn.system.user' key='GRN_SY_US-284' replace='true'}<br>
<br>
{if $is_admin}
<div class="attention">{cb_msg module='grn.system.user' key='GRN_SY_US-285' replace='true'}</div>
{else}
<div class="attention">{cb_msg module='grn.system.user' key='GRN_SY_US-286' replace='true'}<br>
  {cb_msg module='grn.system.user' key='GRN_SY_US-287' replace='true'}{cb_msg module='grn.system.user' key='GRN_SY_US-288' replace='true'}<br>
  {cb_msg module='grn.system.user' key='GRN_SY_US-289' replace='true'}{cb_msg module='grn.system.user' key='GRN_SY_US-290' replace='true'}</div>
{/if}
{/capture}
{include file='grn/std_import2.tpl' config_id='system' cancel_button=$smarty.capture.cancel_button prev_page='system/user/organization_import1' post_page='system/user/command_organization_import2' column_explanation=$smarty.capture.explanation sub_explanation=$smarty.capture.sub_explanation}
