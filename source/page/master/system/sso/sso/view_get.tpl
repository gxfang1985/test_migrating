 <tr>
  <th nowrap>
      {cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-23' replace='true'}
  </th>
  <td>
      {$sso_driver.name|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-24' replace='true'}
  </th>
  <td>
      {$sso_method.driver_settings.target_url|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-25' replace='true'}
  </th>
  <td>
      {if $sso_method.available_window == 1}
       {cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-26' replace='true'}
      {else}
       {cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-27' replace='true'}
      {/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-28' replace='true'}
  </th>
  <td>
      {if $sso_method.available_personal == 1}
       {cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-29' replace='true'}
      {else}
       {cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-30' replace='true'}
      {/if}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-31' replace='true'}
  </th>
  <td>
      <table class="view_table">
      <tr>
       <th style="width:50%" nowrap>{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-32' replace='true'}</th>
       <th style="width:50%" nowrap>{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-33' replace='true'}</th>
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
      {cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-34' replace='true'}
  </th>
  <td>
      <table class="view_table">
      <tr>
       <th style="width:50%" nowrap>{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-35' replace='true'}</th>
       <th style="width:50%" nowrap>{cb_msg module='grn.system.sso.sso' key='GRN_SY_SS_SS-36' replace='true'}</th>
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
