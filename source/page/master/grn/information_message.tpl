<div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-193' replace='true'}</div>
{foreach name=license from=$licenses item=license}
{include file=$license.file license=$license is_demo_license=$license.is_demo_license}
{if 1 < $smarty.foreach.license.total}
<hr>
{/if}
{/foreach}

{if $smarty.const.ON_SAAS===1}
{if $saas_disk eq 1}
<br>
<div class="sub_title">{cb_msg module='grn.saas' key='GRN_SAAS-1' replace='true'}</div>
 <table class='list_column' border='1' cellspacing='0' cellpadding='2'>
 <tr> 
  <th>{cb_msg module='grn.saas' key='GRN_SAAS-2' replace='true'}</th>
  <th>{cb_msg module='grn.saas' key='GRN_SAAS-3' replace='true'}</th>
 </tr>
 <tr>
  <td>{cb_msg module='grn.saas' key='GRN_SAAS-4' replace='true'}</td><td nowrap>{$saas_disk_max_size}GB</td>
 </tr>
 <tr>
  <td>{cb_msg module='grn.saas' key='GRN_SAAS-5' replace='true'}</td><td nowrap>{$saas_disk_usage_size}GB</td>
 </tr>
 <tr>
  <td>{cb_msg module='grn.saas' key='GRN_SAAS-6' replace='true'}</td><td nowrap>{$saas_disk_rest_size}GB</td>
 </tr>
 </table>
</div>
{/if}
{/if}

<p>
{cb_msg module='grn.grn' key='GRN_GRN-194' replace='true'}<a href="{$app_path}/3rd_party_license/license.html">{cb_msg module='grn.grn' key='GRN_GRN-195' replace='true'}</a>{cb_msg module='grn.grn' key='GRN_GRN-196' replace='true'}
</p>

<div class="sub_title">{cb_msg module='grn.grn' key='GRN_GRN-197' replace='true'}</div>
{if $settings.blank}
 {assign var='target' value='_blank'}
{else}
 {assign var='target' value=''}
{/if}
<table class='list_column' width='100%' border='1' cellspacing='0' cellpadding='2'>
 <tr>
  <th>{cb_msg module='grn.grn' key='GRN_GRN-198' replace='true'}</th>
  <th>{cb_msg module='grn.grn' key='GRN_GRN-199' replace='true'}</th>
 </tr>
 {foreach from=$items item=item}
 <tr valign="top">
  <td>
   {grn_link_raw image='notify_cybozu20.gif' caption=$item.title page=$item.link target=$target}
  </td>
  <td nowrap>{grn_date_format date=$item.date format='DateTimeCompact'}</td>
 </tr>
 {/foreach}
</table>
<div class="item">
 <div class="contents_navi">
  {include file="grn/word_navi.tpl" navi=$navi.navi}
 </div>
</div>
