{assign var="form_name" value=$smarty.template|basename}
{include file='system/user/_organization_csv_columns.tpl'}
{capture name=sub_explanation}
{if $is_admin}
{cb_msg module='grn.system.user' key='GRN_SY_US-408' replace='true'}<br>
{cb_msg module='grn.system.user' key='GRN_SY_US-409' replace='true'}<br>
{cb_msg module='grn.system.user' key='GRN_SY_US-410' replace='true'}<br>
{else}
{cb_msg module='grn.system.user' key='GRN_SY_US-411' replace='true'}<br>
{cb_msg module='grn.system.user' key='GRN_SY_US-412' replace='true'}{cb_msg module='grn.system.user' key='GRN_SY_US-413' replace='true'}<br>
{cb_msg module='grn.system.user' key='GRN_SY_US-414' replace='true'}<br>
{cb_msg module='grn.system.user' key='GRN_SY_US-415' replace='true'}<br>
{cb_msg module='grn.system.user' key='GRN_SY_US-416' replace='true'}<br>
{/if}
<br>
{cb_msg module='grn.system.user' key='GRN_SY_US-417' replace='true'}<br>
<br>
{if $is_admin}
<div class="attention">{cb_msg module='grn.system.user' key='GRN_SY_US-418' replace='true'}</div>
{else}
<div class="attention">{cb_msg module='grn.system.user' key='GRN_SY_US-419' replace='true'}{cb_msg module='grn.system.user' key='GRN_SY_US-420' replace='true'}</div>
{/if}
{/capture}
{include file='grn/std_import1.tpl' config_id='system' cancel_page='system/user/org_import_index' post_page='system/user/command_organization_import1' column_explanation=$smarty.capture.explanation sub_explanation=$smarty.capture.sub_explanation}
