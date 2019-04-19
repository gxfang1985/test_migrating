 <tr>
  <th nowrap>
      {cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-55' replace='true'}
  </th>
  <td>
      {$sso_driver.name|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-56' replace='true'}
  </th>
  <td>
      {$sso_method.driver_settings.target_url|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-57' replace='true'}
  </th>
  <td>
      {if $sso_method.available_window == 1}
       {cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-58' replace='true'}
      {else}
       {cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-59' replace='true'}
      {/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-60' replace='true'}
  </th>
  <td>
      {if $sso_method.available_personal == 1}
       {cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-61' replace='true'}
      {else}
       {cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-62' replace='true'}
      {/if}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-63' replace='true'}
  </th>
  <td>
      <table class="view_table">
      <tr>
       <th style="width:50%" nowrap>{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-64' replace='true'}</th>
       <th style="width:50%" nowrap>{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-65' replace='true'}</th>
      </tr>
      {foreach from=$sso_method.driver_settings.personal_params key=param_name item=param_value}
      <tr>
       <td style="width:50%">{$param_name|escape}</td>
       <td style="width:50%">{$param_value|escape}</td>
      </tr>
      {/foreach}
      </table>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-66' replace='true'}
  </th>
  <td>
      <table class="view_table">
      <tr>
       <th style="width:50%" nowrap>{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-67' replace='true'}</th>
       <th style="width:50%" nowrap>{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-68' replace='true'}</th>
      </tr>
      {foreach from=$sso_method.driver_settings.system_params key=param_name item=param_value}
      <tr>
       <td style="width:50%">{$param_name|escape}</td>
       <td style="width:50%">{$param_value|escape}</td>
      </tr>
      {/foreach}
      </table>
  </td>
 </tr>
