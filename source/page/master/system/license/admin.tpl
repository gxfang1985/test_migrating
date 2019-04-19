{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
<div id="main_menu_part">
<span class="menu_item">{capture name='grn_system_license_GRN_SY_LI_7'}{cb_msg module='grn.system.license' key='GRN_SY_LI-7' replace='true'}{/capture}{grn_link page='system/license/register' caption=$smarty.capture.grn_system_license_GRN_SY_LI_7 image='modify20.gif'}</span>
<span class="menu_item">{capture name='grn_system_license_GRN_SY_LI_8'}{cb_msg module='grn.system.license' key='GRN_SY_LI-8' replace='true'}{/capture}{grn_link page='system/license/history' caption=$smarty.capture.grn_system_license_GRN_SY_LI_8 image='detail20.gif'}</span>
</div>
{* デモライセンスでない *}
{if !$is_demo_license}
   <p>
    {if $user_count.regist > $license.users }
    <font color="red">
    {cb_msg module='grn.system.license' key='GRN_SY_LI-9' replace='true'}<br>
    {cb_msg module='grn.system.license' key='GRN_SY_LI-10' replace='true'}<br>
    </font><br>
    {/if}
    {cb_msg module='grn.system.license' key='GRN_SY_LI-13' replace='true'}<br>
   </p>
    <div class="sub_title">{cb_msg module='grn.system.license' key='GRN_SY_LI-14' replace='true'}</div>
    <table class="view_table">
    <tr>
     <th nowrap>
      {cb_msg module='grn.system.license' key='GRN_SY_LI-15' replace='true'}
     </td>
     <td>
      {$license.users|escape} {cb_msg module='grn.system.license' key='GRN_SY_LI-16' replace='true'}
     </td>
    </tr>
    <tr>
     <th nowrap>
      {cb_msg module='grn.system.license' key='GRN_SY_LI-17' replace='true'}
     </td>
     <td>
      {grn_date_format date=$license.service_limit format="DateFull_YMD"|escape}
     </td>
    </tr>
    </table>
{else}
   <p><strong><font color="red">{cb_msg module='grn.system.license' key='GRN_SY_LI-21' replace='true'}</font></strong></p>
   <p>
 {if $license.remind_days >= 0}
   {cb_msg module='grn.system.license' key='GRN_SY_LI-22' replace='true'}&nbsp;<strong>{grn_date_format date=$license.limit format="DateFull_YMD"}</strong>&nbsp;{cb_msg module='grn.system.license' key='GRN_SY_LI-23' replace='true'}&nbsp;{cb_msg module='grn.system.license' key='GRN_SY_LI-24' replace='true'}&nbsp;<strong>{$license.remind_days}{cb_msg module='grn.system.license' key='GRN_SY_LI-25' replace='true'}</strong>&nbsp;{cb_msg module='grn.system.license' key='GRN_SY_LI-26' replace='true'}&nbsp;{cb_msg module='grn.system.license' key='GRN_SY_LI-27' replace='true'}<br>
 {else}
   {cb_msg module='grn.system.license' key='GRN_SY_LI-28' replace='true'}<br>
 {/if}
   </p>
{/if}
<p>
<table class="std_table">
 <tr>
  <td>{cb_msg module='grn.system.license' key='GRN_SY_LI-29' replace='true'}</td><td>&nbsp;{cb_msg module='grn.system.license' key='GRN_SY_LI-30' replace='true'}&nbsp;</td><td><strong>{$user_count.all|escape}</strong>&nbsp;{cb_msg module='grn.system.license' key='GRN_SY_LI-31' replace='true'}</td>
 </tr>
 <tr>
  <td>{cb_msg module='grn.system.license' key='GRN_SY_LI-32' replace='true'}</td><td>&nbsp;{cb_msg module='grn.system.license' key='GRN_SY_LI-33' replace='true'}&nbsp;</td><td><strong>{$user_count.stop|escape}</strong>&nbsp;{cb_msg module='grn.system.license' key='GRN_SY_LI-34' replace='true'}</td>
 </tr>
 <tr>
  <td>{cb_msg module='grn.system.license' key='GRN_SY_LI-35' replace='true'}</td><td>&nbsp;{cb_msg module='grn.system.license' key='GRN_SY_LI-36' replace='true'}&nbsp;</td><td><strong>{$user_count.regist|escape}</strong>&nbsp;{cb_msg module='grn.system.license' key='GRN_SY_LI-37' replace='true'}</td>
 </tr>
</table>
</p>

{include file="grn/system_footer.tpl"}
