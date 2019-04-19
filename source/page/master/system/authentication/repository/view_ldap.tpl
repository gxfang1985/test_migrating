 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-27' replace='true'}
  </th>
  <td>
      {$repository_driver.name|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-65' replace='true'}
  </th>
  <td>
  {if $repository_method.driver_settings.ssl == 1}
    {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_70'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-70' replace='true'}{/capture}{grn_sentence image='check20.gif' caption=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_70}
  {else}
    {capture name='grn_system_authentication_repository_GRN_SY_AU_RE_71'}{cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-71' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_system_authentication_repository_GRN_SY_AU_RE_71 image='spacer20.gif'}
  {/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-28' replace='true'}
  </th>
  <td>
      {$repository_method.driver_settings.server|escape}
  </td>
 </tr>
 {if $repository_method.driver_settings.ssl != 1}
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-29' replace='true'}
  </th>
  <td>
      {$repository_method.driver_settings.port|escape}
  </td>
 </tr>
 {/if}
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-30' replace='true'}
  </th>
  <td>
      {if $repository_method.driver_settings.use_anonymous == 1}
       {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-31' replace='true'}
      {else}
       {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-32' replace='true'}
      {/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-33' replace='true'}
  </th>
  <td>
      {$repository_method.driver_settings.account|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-34' replace='true'}
  </th>
  <td>
      {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-35' replace='true'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-36' replace='true'}
  </th>
  <td>
      {$repository_method.driver_settings.base_dn|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-37' replace='true'}
  </th>
  <td>
      {$repository_method.driver_settings.search_filter|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-38' replace='true'}
  </th>
  <td>
      {if $repository_method.driver_settings.authenticate_type == 1}
       SASL DIGEST-MD5      
      {elseif $repository_method.driver_settings.authenticate_type == 2} 
       SASL CRAM-MD5 
      {else}
       {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-39' replace='true'} {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-40' replace='true'}
      {/if}
  </td>
 </tr>
 <tr>
     <th nowrap>
         {cb_msg module='grn.system.authentication.repository' key='GRN_SY_AU_RE-72' replace='true'}
     </th>
     <td>
         {include file="system/authentication/repository/_view_affix_condition.tpl" driver_settings=$repository_method.driver_settings}
     </td>
 </tr>
