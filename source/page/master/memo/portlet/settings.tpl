<form name="settings" method="post" action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="pid"   value="{$portlet.pid}">
<input type="hidden" name="plid"  value="{$portlet.plid}">
<input type="hidden" name="ppid"  value="{$portlet.ppid}">
<input type="hidden" name="display" value="{$display}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.memo.portlet' key='GRN_MEM_PO-5' replace='true'}
  </th>
  <td>
      {grn_select name='font_size' options=$font_options}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.memo.portlet' key='GRN_MEM_PO-6' replace='true'}
  </th>
{if $display == 'set-personal'}
  <td>{include file="memo/_folder_menu.tpl" param_name="did" pdid=$folder_id}</td>
{else}
  <td>{cb_msg module="grn.memo" key="lastest_folder_name"}</td>
{/if}
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.memo.portlet' key='GRN_MEM_PO-7' replace='true'}
  </th>
  <td>
       <select name='rows'>
        <option value='3'{if $portlet.settings.rows == 3} selected{/if}>&nbsp;3</option>
        <option value='5'{if $portlet.settings.rows == 5} selected{/if}>&nbsp;5</option>
        <option value='10'{if $portlet.settings.rows == 10} selected{/if}>10</option>
        <option value='20'{if $portlet.settings.rows == 20} selected{/if}>20</option>
        <option value='30'{if $portlet.settings.rows == 30} selected{/if}>30</option>
       </select>&nbsp;{cb_msg module='grn.memo.portlet' key='GRN_MEM_PO-8' replace='true'}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       <input type="submit" name="apply" value="{cb_msg module='grn.memo.portlet' key='GRN_MEM_PO-9' replace='true'}">
       <input type="submit" name="cancel" value="{cb_msg module='grn.memo.portlet' key='GRN_MEM_PO-10' replace='true'}">
  </td>
 </tr>
</table>

</form>
