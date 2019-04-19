 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-58' replace='true'}
  </th>
  <td>
      {$authenticate_driver.name|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-59' replace='true'}
  </th>
  <td>
{if $authenticate_method.driver_settings.cookie_mode eq '1'}
      {cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-60' replace='true'}.2
{else}
      {cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-61' replace='true'}
{/if}
  </td>
 </tr>
{if $authenticate_method.driver_settings.cookie_mode eq '1'}
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-62' replace='true'}
  </th>
  <td>
      {$authenticate_method.driver_settings.cookie_name|escape}
  </td>
 </tr>
{/if}
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-63' replace='true'}
  </th>
  <td>
      {cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-64' replace='true'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-65' replace='true'}
  </th>
  <td>
      {$authenticate_method.driver_settings.expire_time|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-66' replace='true'}
  </th>
  <td>
      {$authenticate_method.driver_settings.cookie_domain|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-67' replace='true'}
  </th>
  <td>
      {$repository_method.display_name|escape}
  </td>
 </tr>
