 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.personal.sso.sso' key='GRN_PRS_SO_S-25' replace='true'}
  </th>
  <td>
      <table class="view_table">
      <tr>
       <th style="width:40%" nowrap>{cb_msg module='grn.personal.sso.sso' key='GRN_PRS_SO_S-26' replace='true'}</td>
       <th style="width:60%" nowrap>{cb_msg module='grn.personal.sso.sso' key='GRN_PRS_SO_S-27' replace='true'}</td>
      </tr>
      {foreach from=$sso_method.driver_settings.personal_params key=param_name item=param_value}
      <tr>
       <td style="width:40%">{$param_name|escape}</td>
       <td style="width:60%">{$param_value|escape}</td>
      </tr>
      {/foreach}
      </table>
  </td>
 </tr>
