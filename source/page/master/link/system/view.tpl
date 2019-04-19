{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$link.title class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_link_system_GRN_LNK_SY_87'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-87' replace='true'}{/capture}{grn_link page='link/system/modify' caption=$smarty.capture.grn_link_system_GRN_LNK_SY_87 image='modify20.gif' cid=$category.cid lid=$link.lid}</span>
<span class="menu_item">{capture name='grn_link_system_GRN_LNK_SY_88'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-88' replace='true'}{/capture}{grn_link page='link/system/move' caption=$smarty.capture.grn_link_system_GRN_LNK_SY_88 image='move20.gif' cid=$category.cid lid=$link.lid s_cid=$category.cid}</span>
<span class="menu_item">{capture name='grn_link_system_GRN_LNK_SY_89'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-89' replace='true'}{/capture}{grn_link page='link/system/delete' caption=$smarty.capture.grn_link_system_GRN_LNK_SY_89 image='delete20.gif' cid=$category.cid lid=$link.lid}</span>
</div>

 <p>
 <table class="view_table" width="80%">
  <colgroup>
   <col width="20%">
   <col width="80%">
  </colgroup>
  <tr>
   <th>{cb_msg module='grn.link.system' key='GRN_LNK_SY-90' replace='true'}</th>
   <td>
{foreach from=$category.path item=path}
 {if $path.cid == GRN_LINK_CATEGORY_ROOT_ID}
    {grn_link image='category20.gif' page='link/system/list' caption=$path.title}
 {else}
    &gt; {grn_link caption=$path.title page='link/system/list' cid=$path.cid}
 {/if}
{/foreach}
{if $category.cid != GRN_LINK_CATEGORY_ROOT_ID}
    &gt; {grn_link page='link/system/list' cid=$category.cid caption=$category.title}
{/if}
   </td>
  </tr>
  <tr>
   <th nowrap>{cb_msg module='grn.link.system' key='GRN_LNK_SY-92' replace='true'}</th>
   <td>{$link.title|escape}</td>
  </tr>
  <tr>
   <th>URL</th>
   <td>
{if $set_popup}
    {if $link.sid > 0}
     {grn_sso_link caption=$link.url sso_id=$link.sid app_id="link" id_list=$link.sso_param redirect_url=$link.url target='_blank'}&nbsp;&nbsp;&nbsp;&nbsp;
     {grn_sso_link caption='' sso_id=$link.sid app_id="link" id_list=$link.sso_param redirect_url=$link.url image='window20.gif'}
    {else}
     {capture name='grn_link_system_GRN_LNK_SY_93'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-93' replace='true'}{/capture}{grn_link_raw caption=$link.url page=$link.url target='_blank' title=$smarty.capture.grn_link_system_GRN_LNK_SY_93 no_script=true}&nbsp;&nbsp;&nbsp;&nbsp;
     {capture name='grn_link_system_GRN_LNK_SY_94'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-94' replace='true'}{/capture}{grn_link_raw caption='' page=$link.url image='window20.gif' alt=$smarty.capture.grn_link_system_GRN_LNK_SY_94 no_script=true}
    {/if}
{else}
    {if $link.sid > 0}
     {grn_sso_link caption=$link.url sso_id=$link.sid app_id="link" id_list=$link.sso_param redirect_url=$link.url}&nbsp;&nbsp;&nbsp;&nbsp;
     {grn_sso_link caption='' sso_id=$link.sid app_id="link" id_list=$link.sso_param redirect_url=$link.url image='blank20.gif' target='_blank'}
    {else}
     {grn_link_raw caption=$link.url page=$link.url no_script=true}&nbsp;&nbsp;&nbsp;&nbsp;
     {capture name='grn_link_system_GRN_LNK_SY_95'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-95' replace='true'}{/capture}{grn_link_raw caption='' page=$link.url image='blank20.gif' alt=$smarty.capture.grn_link_system_GRN_LNK_SY_95 no_script=true target='_blank'}
    {/if}
{/if}
   </td>
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.link.system' key='GRN_LNK_SY-96' replace='true'}</th>
   <td>{grn_format body=$link.memo}</td>
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.link.system' key='GRN_LNK_SY-97' replace='true'}</th>
   <td>{$link.sso_name|escape}</td>
  </tr>
  <tr>
   <th nowrap>{cb_msg module='grn.link.system' key='GRN_LNK_SY-98' replace='true'}</th>
   <td>
       {grn_user_name uid=$link.creator_uid name=$link.creator_name}
       {grn_date_format format='DateTimeFull_YMDW_HM' date=$link.ctime}
   </td>
  </tr>
  <tr>
   <th nowrap>
      {cb_msg module='grn.link.system' key='GRN_LNK_SY-99' replace='true'}
   </th>
   <td>
       {grn_user_name uid=$link.modify_uid name=$link.modify_name}
       {grn_date_format format='DateTimeFull_YMDW_HM' date=$link.mtime}
   </td>
  </tr>
 </table>

{include file="grn/system_footer.tpl"}
