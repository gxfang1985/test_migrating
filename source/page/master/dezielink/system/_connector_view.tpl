{grn_title title=$page_title class=""}
{if !$auth_available}
<div>
  <p>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-113' replace='true'}</p>
  <ul>
    <li>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-114' replace='true'}.2</li>
  </ul>
  <div class="explanation">{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-115' replace='true'}.{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-116' replace='true'}</div>
</div>
{else}
<div id="main_menu_part">
<span class="menu_item">{capture name='grn_dezielink_system_GRN_DZL_SY_117'}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-117' replace='true'}{/capture}{grn_link page=$edit_page caption=$smarty.capture.grn_dezielink_system_GRN_DZL_SY_117 image='modify20.gif'}</span>
</div>
<p></p>
<table class="view_table" width="80%">
<colgroup>
<col width="20%">
<col width="80%">
</colgroup>
{if $connector_available}
<tr>
  <th nowrap>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-118' replace='true'}</th>
  <td>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-119' replace='true'}</td>
</tr>
<tr>
  <th nowrap>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-120' replace='true'}</th>
  <td>{grn_link caption=$url script=$url target="_blank" no_script='true'}</td>
</tr>
<tr>
  <th nowrap>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-121' replace='true'}</th>
  <td nowrap>{if $sync_user}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-122' replace='true'}&nbsp;&nbsp;{$period_data}{else}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-123' replace='true'}{/if}&nbsp;&nbsp;<input type="button" name="syncuser" id="syncuser" value="{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-124' replace='true'}" onclick="location.href='{grn_pageurl page=$sync_user_page}'"></td>
</tr>
{if !$is_office_module}
  <tr>
    <th nowrap>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-125' replace='true'}</th>
    <td>{if $portlet_available}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-126' replace='true'}&nbsp;&nbsp;{if $portlet_cache_expire!=0}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-127' replace='true'}&nbsp;{$portlet_cache_expire}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-128' replace='true'}{/if}{else}{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-129' replace='true'}{/if}</td>
  </tr>
{/if}
{else}
<tr>
  <th nowrap>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-130' replace='true'}</th>
  <td>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-131' replace='true'}</td>
</tr>
<tr>
  <th nowrap>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-132' replace='true'}</th>
  <td>&nbsp;</td>
</tr>
<tr>
  <th nowrap>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-133' replace='true'}</th>
  <td>&nbsp;</td>
</tr>
{if !$is_office_module}
  <tr>
    <th nowrap>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-134' replace='true'}</th>
    <td>&nbsp;</td>
  </tr>
{/if}
{/if}{*end if: connector_available*}
<tr>
  <th nowrap>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-135' replace='true'}</th>
  {if $creator_info}
  <td>{grn_user_name uid=$creator_info.user.uid name=$creator_info.user.display_name}&nbsp;{grn_date_format date=$creator_info.ctime format="DateShort_MDW"}</td>
  {else}
  <td><br/></td>
  {/if}
</tr>
<tr>
  <th nowrap>{cb_msg module='grn.dezielink.system' key='GRN_DZL_SY-136' replace='true'}</th>
  {if $modifier_info}
  <td>{grn_user_name uid=$modifier_info.user.uid name=$modifier_info.user.display_name}&nbsp;{grn_date_format date=$modifier_info.mtime format="DateShort_MDW"}</td>
  {else}
  <td><br/></td>
  {/if}
</tr>
</table>
{/if}{*end if: !auth_available*}
{include file="grn/system_footer.tpl"}
