<div class="facility_info_grn">
 <table class="list_column" {$font_size}>
  <tr>
   <th>
   {cb_msg module='grn.schedule' key='GRN_SCH-723' replace='true'}
   </th>
   <th>
   {cb_msg module='grn.schedule' key='GRN_SCH-724' replace='true'}
   </th>
   <th>
   {cb_msg module='grn.schedule' key='GRN_SCH-854' replace='true'}
   </th>
   <th>
   {cb_msg module='grn.schedule' key='GRN_SCH-855' replace='true'}
   </th>
   <th>
   {cb_msg module='grn.schedule' key='GRN_SCH-856' replace='true'}
   </th>
   <th>
   {cb_msg module='grn.schedule' key='GRN_SCH-1101' replace='true'}
   </th>
   <th>
   {cb_msg module='grn.schedule' key='GRN_SCH-725' replace='true'}
   </th>
  </tr>
{foreach from=$facility_list key=facility_id item=facility_info}
  <tr>
  <td>
  {grn_image image='facility20.gif'} {$facility_info.col_name}
  </td>
  <td>
  {if $facility_info.ancestors}
    {cb_msg module='grn.schedule' key='GRN_SCH-726' replace='true'} {foreach from=$facility_info.ancestors item="ancestor"} &gt; {$ancestor.col_name} {/foreach}
  {else}
    {cb_msg module='grn.schedule' key='GRN_SCH-727' replace='true'}
  {/if}
  </td>
  
  {if $facility_info.advance == 'unlimit'}
   <td>{cb_msg module='grn.schedule' key='GRN_SCH-857' replace='true'}</td>
  {elseif $facility_info.advance > 0 }
   <td>{$facility_info.advance}{cb_msg module='grn.schedule' key='GRN_SCH-858' replace='true'}</td>
  {else}
        <td>&nbsp;</td>
  {/if}
  
  {if $facility_info.maxtime == 'unlimit'}
        <td>{cb_msg module='grn.schedule' key='GRN_SCH-857' replace='true'}</td>
  {elseif $facility_info.maxtime > 0}
        <td>{$facility_info.maxtime}{cb_msg module='grn.schedule' key='GRN_SCH-867' replace='true'}</td>
  {else}
        <td>&nbsp;</td>
  {/if}
  
  {if $facility_info.modifyuser == 'creator'}
   <td>{cb_msg module='grn.schedule' key='GRN_SCH-860' replace='true'}</td>
  {elseif $facility_info.modifyuser == 'member'}
   <td>{cb_msg module='grn.schedule' key='GRN_SCH-861' replace='true'}</td>
  {elseif $facility_info.modifyuser == 'grantuser'}
   <td>{cb_msg module='grn.schedule' key='GRN_SCH-859' replace='true'}</td>
  {else}
        <td>&nbsp;</td>
  {/if}
  
  <td>
  {if $facility_info.approval == '1'}
    {grn_image image="image-common/mark_check16.png"}
  {else}
    &nbsp;
  {/if}
  </td>

  <td>
    {$facility_info.col_memo|grn_noescape}
  </td>
  </tr>
{/foreach}
 </table>
</div>
