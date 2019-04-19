 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-1' replace='true'}
  </th>
  <td>
      {$authenticate_driver.name|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-2' replace='true'}
  </th>
  <td>
      {$authenticate_method.driver_settings.variable_name|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-3' replace='true'}
  </th>
  <td>
      {cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-4' replace='true'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-5' replace='true'}
  </th>
  <td>
      {$authenticate_method.driver_settings.credential_prefix|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-6' replace='true'}
  </th>
  <td>
      {$authenticate_method.driver_settings.credential_suffix|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.authenticate' key='GRN_SY_AU_AU-7' replace='true'}
  </th>
  <td>
      {$repository_method.display_name|escape}
  </td>
 </tr>
