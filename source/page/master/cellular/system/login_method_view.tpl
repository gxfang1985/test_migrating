{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$login_method.display_name class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_cellular_system_GRN_CLLL_SY_2'}{cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-2' replace='true'}{/capture}{grn_link page='cellular/system/login_method_modify' caption=$smarty.capture.grn_cellular_system_GRN_CLLL_SY_2 image='modify20.gif'}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>
      {cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-3' replace='true'}
  </th>
  <td>
      {$login_method.display_name|escape}
  </td>
 </tr>
{**grn_auth_include_method method=$login_method display="view-system"**}
 <tr>
  <th nowrap>
      {cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-4' replace='true'}
  </th>
  <td>
      {$login_driver.name|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-5' replace='true'}
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
 <tr>
  <th nowrap>
      {cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-6' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$login_method.creator_uid name=$login_method.creator_name}
       {grn_date_format date=$login_method.ctime format="DateTimeCompact"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.cellular.system' key='GRN_CLLL_SY-7' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$login_method.modify_uid name=$login_method.modify_name}
       {grn_date_format date=$login_method.mtime format="DateTimeCompact"}
  </td>
 </tr>
</table>

{include file="grn/system_footer.tpl"}
