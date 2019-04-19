 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-1' replace='true'}
  </th>
  <td>
      {$login_driver.name|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-2' replace='true'}
  </th>
  <td>
      {$login_method.driver_settings.variable_name|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-3' replace='true'}
  </th>
  <td>
      {cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-4' replace='true'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-5' replace='true'}
  </th>
  <td>
      {$login_method.driver_settings.credential_prefix|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-6' replace='true'}
  </th>
  <td>
      {$login_method.driver_settings.credential_suffix|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.login' key='GRN_SY_AU_LO-7' replace='true'}
  </th>
  <td>
      {$repository_method.display_name|escape}
  </td>
 </tr>
