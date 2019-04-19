<form name="settings" method="post" action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="pid"   value="{$portlet.pid}">
<input type="hidden" name="plid"  value="{$portlet.plid}">
<input type="hidden" name="ppid"  value="{$portlet.ppid}">
<input type="hidden" name="display" value="{$display}">

<table class="std_form">{strip}
 <tr>
  <th nowrap>
      {cb_msg module='grn.todo.portlet' key='GRN_TOD_PO-13' replace='true'}
  </th>
  <td>
      {grn_select name='font_size' options=$font_options}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.todo.portlet' key='GRN_TOD_PO-14' replace='true'}
  </th>
  <td>
  <select name="rows">
  {foreach from=$select_numbers item=num}
   {if $num == -1}
  <option value="{$num}"{if $portlet.settings.rows == $num} selected{/if}>{cb_msg module='grn.todo.portlet' key='GRN_TOD_PO-15' replace='true'}
   {else}
  <option value="{$num}"{if $portlet.settings.rows == $num} selected{/if}>{$num}
   {/if}
  {/foreach}
  </select>&nbsp;{cb_msg module='grn.todo.portlet' key='GRN_TOD_PO-16' replace='true'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.todo.portlet' key='GRN_TOD_PO-17' replace='true'}
  </th>
  <td>{cb_msg module='grn.todo.portlet' key='GRN_TOD_PO-35' replace='true'}
      {include file='todo/_rank_star_select.tpl' id='todo_portlet_setting_rank_star_select' name='priority' priority=$portlet.settings.priority}
      {cb_msg module='grn.todo.portlet' key='GRN_TOD_PO-36' replace='true'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.todo.portlet' key='GRN_TOD_PO-29' replace='true'}
  </th>
  <td>
  <select name="sort_column">
  <option value='category'{if $portlet.settings.sort_column == 'category'} selected{/if}>{cb_msg module='grn.todo.portlet' key='GRN_TOD_PO-30' replace='true'}
  <option value='expiration'{if $portlet.settings.sort_column == 'expiration'} selected{/if}>{cb_msg module='grn.todo.portlet' key='GRN_TOD_PO-31' replace='true'}
  <option value='priority'{if $portlet.settings.sort_column == 'priority'} selected{/if}>{cb_msg module='grn.todo.portlet' key='GRN_TOD_PO-32' replace='true'}
  </select>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       <input type="submit" class="margin" name="apply" value="{cb_msg module='grn.todo.portlet' key='GRN_TOD_PO-33' replace='true'}">
       <input type="submit" name="cancel" value="{cb_msg module='grn.todo.portlet' key='GRN_TOD_PO-34' replace='true'}">
  </td>
 </tr>
</table>{/strip}

</form>
