 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-31' replace='true'}
  </th>
  <td>
      {$login_driver.name|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-32' replace='true'}
  </th>
  <td>
      {strip}
          {foreach from=$repository_method.display_names item=display_name name=display_names}
              {if ! $smarty.foreach.display_names.first}
                  ,&nbsp;
              {/if}
              {$display_name}
          {/foreach}
      {/strip}
  </td>
 </tr>
