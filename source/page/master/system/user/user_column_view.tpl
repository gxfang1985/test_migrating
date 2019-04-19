{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_system_user_GRN_SY_US_169'}{cb_msg module='grn.system.user' key='GRN_SY_US-169' replace='true'}{/capture}{grn_link page='system/user/user_column_modify' caption=$smarty.capture.grn_system_user_GRN_SY_US_169 image='modify20.gif' clid=$column.clid}</span>
{if $column.is_extension}
<span class="menu_item">{capture name='grn_system_user_GRN_SY_US_170'}{cb_msg module='grn.system.user' key='GRN_SY_US-170' replace='true'}{/capture}{grn_link page='system/user/user_column_delete' caption=$smarty.capture.grn_system_user_GRN_SY_US_170 image='delete20.gif' clid=$column.clid}</span>
{/if}
</div>

<p>
<table class="view_table">
<tr>
<th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-171' replace='true'}</th>
<td>{$column.display_name|escape}</td>
</tr>
{if $column.is_extension}
<tr>
<th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-172' replace='true'}</th>
<td>{$column.type|escape}</td>
</tr>
{/if}
<tr>
<th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-173' replace='true'}</th>
<td>{$column.id|escape}</td>
</tr>
<tr>
<th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-174' replace='true'}</th>
<td>{if $column.use}{cb_msg module='grn.system.user' key='GRN_SY_US-175' replace='true'}{else}{cb_msg module='grn.system.user' key='GRN_SY_US-176' replace='true'}{/if}</td>
</tr>
<tr>
<th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-177' replace='true'}</th>
<td>{if $column.show}{cb_msg module='grn.system.user' key='GRN_SY_US-178' replace='true'}{else}{cb_msg module='grn.system.user' key='GRN_SY_US-179' replace='true'}{/if}</td>
</tr>
<tr>
<th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-180' replace='true'}</th>
<td>{if $column.display}{cb_msg module='grn.system.user' key='GRN_SY_US-181' replace='true'}{else}{cb_msg module='grn.system.user' key='GRN_SY_US-182' replace='true'}{/if}</td>
</tr>
<tr>
<th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-183' replace='true'}</th>
<td>{if $column.necessary}{cb_msg module='grn.system.user' key='GRN_SY_US-184' replace='true'}{else}{cb_msg module='grn.system.user' key='GRN_SY_US-185' replace='true'}{/if}</td>
</tr>
<tr>
<th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-186' replace='true'}</th>
<td>{if $column.not_modify}{cb_msg module='grn.system.user' key='GRN_SY_US-187' replace='true'}{else}{cb_msg module='grn.system.user' key='GRN_SY_US-188' replace='true'}{/if}</td>
</tr>
{if $cellular_licensed}
<tr>
<th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-189' replace='true'}</th>
<td>{if $column.cellular}{cb_msg module='grn.system.user' key='GRN_SY_US-190' replace='true'}{else}{cb_msg module='grn.system.user' key='GRN_SY_US-191' replace='true'}{/if}</td>
</tr>
{/if}
<tr>
<th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-701' replace='true'}</th>
<td>{if $column.search}{cb_msg module='grn.system.user' key='GRN_SY_US-702' replace='true'}{else}{cb_msg module='grn.system.user' key='GRN_SY_US-703' replace='true'}{/if}</td>
</tr>
<tr>
<th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-192' replace='true'}</th>
<td>{$column.sso_name|escape}</td>
</tr>
</table>

{include file='grn/system_footer.tpl'}
