{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

{assign var="form_name" value="user_column_list"}
<form name="{$form_name}" method="post" action="{cb_pageurl page='system/user/command_user_column_list_modify'}">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_system_user_GRN_SY_US_239'}{cb_msg module='grn.system.user' key='GRN_SY_US-239' replace='true'}{/capture}{grn_link page='system/user/user_column_add' caption=$smarty.capture.grn_system_user_GRN_SY_US_239 image='write20.gif'}</span>
<span class="menu_item">{capture name='grn_system_user_GRN_SY_US_240'}{cb_msg module='grn.system.user' key='GRN_SY_US-240' replace='true'}{/capture}{grn_link page='system/user/user_column_order' caption=$smarty.capture.grn_system_user_GRN_SY_US_240 image='order20.gif'}</span>
</div>

<p>
<div class="explanation">
{cb_msg module='grn.system.user' key='GRN_SY_US-241' replace='true'}<br>
{cb_msg module='grn.system.user' key='GRN_SY_US-704' replace='true'}<br>
</div>

<p>
<div class="sub_title">{cb_msg module='grn.system.user' key='GRN_SY_US-242' replace='true'}</div>
<table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
 <colgroup>
  <col width="20%">
  <col width="17%">
  <col width="9%">
  <col width="9%">
  <col width="9%">
  <col width="9%">
  <col width="9%">
  <col width="9%">
  <col width="9%">
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-243' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-244' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-245' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-246' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-247' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-248' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-249' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-250' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-701' replace='true'}</th>
 </tr>

{foreach from=$default_columns key=clid item=column}
 <tr valign="top">
  <td nowrap>{grn_link page='system/user/user_column_view' caption=$column.display_name clid=$clid}</td>
  <td nowrap>{$column.id|escape}</td>
  <td align="center" nowrap>{if $column.use_disabled}{if $column.use}{grn_image image='check16.gif'}{/if}{else}{grn_checkbox name="default_columns[$clid][use]" id="use_$key" value=1 checked=$column.use}{/if}</td>
  <td align="center" nowrap>{if $column.show_disabled}{if $column.show}{grn_image image='check16.gif'}{/if}{else}{grn_checkbox name="default_columns[$clid][show]" id="show_$key" value=1 checked=$column.show}{/if}</td>
  <td align="center" nowrap>{if $column.display_disabled}{if $column.display}{grn_image image='check16.gif'}{/if}{else}{grn_checkbox name="default_columns[$clid][display]" id="display_$key" value=1 checked=$column.display}{/if}</td>
  <td align="center" nowrap>{if $column.necessary_disabled}{if $column.necessary}{grn_image image='check16.gif'}{/if}{else}{grn_checkbox name="default_columns[$clid][necessary]" id="necessary_$key" value=1 checked=$column.necessary}{/if}</td>
  <td align="center" nowrap>{if $column.not_modify_disabled}{if $column.not_modify}{grn_image image='check16.gif'}{/if}{else}{grn_checkbox name="default_columns[$clid][not_modify]" id="not_modify_$key" value=1 checked=$column.not_modify}{/if}</td>
  <td align="center" nowrap>{if $column.cellular_disabled}{if $column.cellular}{grn_image image='check16.gif'}{/if}{else}{grn_checkbox name="default_columns[$clid][cellular]" id="cellular_$key" value=1 checked=$column.cellular}{/if}</td>
  <td align="center" nowrap>{if $column.search_disabled}{if $column.search}{grn_image image='check16.gif'}{/if}{else}{grn_checkbox name="default_columns[$clid][search]" id="necessary_$key" value=1 checked=$column.search}{/if}</td>
 </tr>
{/foreach}
</table>

<p>
<div class="sub_title">{cb_msg module='grn.system.user' key='GRN_SY_US-251' replace='true'}</div>
<table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
 <colgroup>
  <col width="20%">
  <col width="17%">
  <col width="9%">
  <col width="9%">
  <col width="9%">
  <col width="9%">
  <col width="9%">
  <col width="9%">
  <col width="9%">
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-252' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-253' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-254' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-255' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-256' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-257' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-258' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-259' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-701' replace='true'}</th>
 </tr>

{foreach from=$extension_columns key=clid item=column}
 <tr valign="top">
  <td nowrap>{grn_link page='system/user/user_column_view' caption=$column.display_name clid=$clid}</td>
  <td nowrap>{$column.id|escape}</td>
  <td align="center" nowrap>{grn_checkbox name="extension_columns[$clid][use]" id="use_$key" value=1 checked=$column.use disabled=$column.use_disabled}</td>
  <td align="center" nowrap>{grn_checkbox name="extension_columns[$clid][show]" id="show_$key" value=1 checked=$column.show disabled=$column.show_disabled}</td>
  <td align="center" nowrap>{grn_checkbox name="extension_columns[$clid][display]" id="display_$key" value=1 checked=$column.display disabled=$column.display_disabled}</td>
  <td align="center" nowrap>{if $column.necessary_disabled}{if $column.necessary}{grn_image image='check16.gif'}{/if}{else}{grn_checkbox name="extension_columns[$clid][necessary]" id="necessary_$key" value=1 checked=$column.necessary disabled=$column.necessary_disabled}{/if}</td>
  <td align="center" nowrap>{if $column.not_modify_disabled}{if $column.not_modify}{grn_image image='check16.gif'}{/if}{else}{grn_checkbox name="extension_columns[$clid][not_modify]" id="not_modify_$key" value=1 checked=$column.not_modify disabled=$column.not_modify_disabled}{/if}</td>
  <td align="center" nowrap>{grn_checkbox name="extension_columns[$clid][cellular]" id="cellular_$key" value=1 checked=$column.cellular disabled=$column.cellular_disabled}</td>
  <td align="center" nowrap>{grn_checkbox name="extension_columns[$clid][search]" id="search_$key" value=1 checked=$column.search disabled=$column.search_disabled}</td>
 </tr>
{/foreach}

</table>

<input class="margin" type="submit" value="{cb_msg module='grn.system.user' key='GRN_SY_US-260' replace='true'}">
{grn_button_cancel page='system/common_list' id='user'}

</form>
{include file='grn/system_footer.tpl'}