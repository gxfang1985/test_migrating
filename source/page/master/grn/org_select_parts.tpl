<select name="gid" onChange="this.form.action='{grn_pageurl page='grn/command_org_select'}';this.form.submit();" style="{$select_style}">
{foreach from=$group_options item=option}
{if $option.type == 1}
<option value="{$option.value}"{if $option.selected}selected{/if}>{$option.name|escape}{cb_msg module='grn.grn' key='GRN_GRN-1006' replace='true'}</option>
{elseif $option.type == 2}
<option value="{$option.value}"{if $option.selected}selected{/if}>{$option.name|escape}{cb_msg module='grn.grn' key='GRN_GRN-1008' replace='true'}</option>
{elseif $option.type == 3}
<option value="{$option.value}"{if $option.selected}selected{/if}>{$option.name|escape}{cb_msg module='grn.grn' key='GRN_GRN-1009' replace='true'}</option>
{elseif $option.type == 4}
<option value="{$option.value}"{if $option.selected}selected{/if}>{cb_msg module="grn.common" key="title_frequent_group" name=$option.name}</option>
{elseif $option.type == 5}
<option value="{$option.value}"{if $option.selected}selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-1010' replace='true'}</option>
{elseif $option.type == 6}
<option value="{$option.value}"{if $option.selected}selected{/if}>{$option.name|escape}{cb_msg module='grn.grn' key='GRN_GRN-1011' replace='true'}</option>
{elseif $option.type == 7}
<option value="{$option.value}"{if $option.selected}selected{/if}>{cb_msg module='grn.grn' key='GRN_GRN-1012' replace='true'}</option>
{elseif $option.type == 8}
<option value="{$option.value}"{if $option.selected}selected{/if}>{cb_msg module="grn.common" key="title_oftenused_group" name=$option.name}</option>
{/if}
{/foreach}
</select>
<input type="hidden" name="page" value="{$return_url}">
<span class="nowrap-grn">{capture name='grn_grn_GRN_GRN_1013'}{cb_msg module='grn.grn' key='GRN_GRN-1013' replace='true'}{/capture}{grn_popup_user_select_link caption=$smarty.capture.grn_grn_GRN_GRN_1013 app_id=$app_id return_page=$return_url form_name=$form_name system=false system_display=false multi_apply=true access_plugin=$access_plugin plugin_session_name=$plugin_session_name plugin_data_name=$plugin_data_name}</span>
{*
<a href="#" onClick="javascript:popupWin('{grn_pageurl page='grn/popup_group' gid=$selected_id return_url=$return_url tp=$tp ppid=$ppid}','html','','',0,0,1,1,0,1);">{grn_image image='blank20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-1014' replace='true'}</a>
*}
