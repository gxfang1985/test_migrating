 <table class="view_table" width="80%">
  <colgroup>
   <col width="20%">
   <col width="80%">
  </colgroup>
  <tr>
   <th>{cb_msg module='grn.report' key='GRN_RPRT-126' replace='true'}</th>
   <td>{$filter.col_name|escape:"html"}</td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.report' key='form' replace='true'}</th>
   <td>
       {if $filter.col_formtype == 0}
           {cb_msg module='grn.report' key='all.form' replace='true'}
       {elseif $filter.col_formtype == 1}
           {cb_msg module='grn.report' key='match.form' replace='true'}{$filter.form_condition.col_text}
       {elseif $filter.col_formtype == 2}
           {$form_name|escape}
       {/if}
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.report' key='GRN_RPRT-127' replace='true'}</th>
   <td>
       {if $filter.col_or == 0}
           {cb_msg module='grn.report' key='GRN_RPRT-128' replace='true'}
       {else}
           {cb_msg module='grn.report' key='GRN_RPRT-129' replace='true'}
       {/if}
       {include file="report/_condition_view.tpl" conditions=$conditions}
   </td>
  </tr>
 </table>
