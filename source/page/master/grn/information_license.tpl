{if $smarty.const.ON_SAAS!==1}
<p>
{* 試用期間中の場合 *}
{if $is_demo_license}
{if $license.remind_days >= 0}
{cb_msg module='grn.grn' key='GRN_GRN-1293' replace='true'} {grn_date_format date=$license.limit format="DateFull_YMD"}&nbsp;{cb_msg module='grn.grn' key='GRN_GRN-1294' replace='true'}<span class="bold"><span class="font_red">{$license.remind_days|escape}</span></span>{cb_msg module='grn.grn' key='GRN_GRN-1296' replace='true'}<br>
{else}
<span class="font_red">{cb_msg module='grn.grn' key='GRN_GRN-1299' replace='true'}</span><br>
{cb_msg module='grn.grn' key='GRN_GRN-1300' replace='true'}<br>
{/if}
{else}

{* ライセンス登録済み *}
{cb_msg module='grn.grn' key='GRN_GRN-1301' replace='true'} {$customer_id}<br>
{if $license.remind_days >= 0}
{cb_msg module='grn.grn' key='GRN_GRN-1302' replace='true'}{grn_date_format date=$license.service_limit format="DateFull_YMD"}{cb_msg module='grn.grn' key='GRN_GRN-1303' replace='true'}<span class="bold"><span class="font_red">{$license.remind_days|escape}</span></span>{cb_msg module='grn.grn' key='GRN_GRN-1304' replace='true'}<br>
{cb_msg module='grn.grn' key='GRN_GRN-1305' replace='true'}<br>
{else}
<span class="font_red">{cb_msg module='grn.grn' key='GRN_GRN-1306' replace='true'}</span><br>
{if $license.remind_days + 30 >= 0 }
{cb_msg module='grn.grn' key='GRN_GRN-1307' replace='true'}<span class="bold"><span class="font_red">{$license.remind_days+30}</span></span>{cb_msg module='grn.grn' key='GRN_GRN-1308' replace='true'}<br>
{else}
{cb_msg module='grn.grn' key='GRN_GRN-1309' replace='true'}<br>
{/if}
{/if}
<a href="http://cybozu.co.jp/welcome/garoon4/002.html">{cb_msg module='grn.grn' key='GRN_GRN.service.license' replace='true'}</a><br />
{cb_msg module='grn.grn' key='GRN_GRN-1310' replace='true'}<br>
{/if}
</p>
{/if}
<table class="std_table">
 <tr>
  <td>{cb_msg module='grn.grn' key='GRN_GRN-1311' replace='true'}</td><td>&nbsp;{cb_msg module='grn.grn' key='GRN_GRN-1312' replace='true'}&nbsp;</td><td><strong>{$user_count.all|escape}</strong>&nbsp;{cb_msg module='grn.grn' key='GRN_GRN-1313' replace='true'}</td>
 </tr>
 <tr>
  <td>{cb_msg module='grn.grn' key='GRN_GRN-1314' replace='true'}</td><td>&nbsp;{cb_msg module='grn.grn' key='GRN_GRN-1315' replace='true'}&nbsp;</td><td><strong>{$user_count.stop|escape}</strong>&nbsp;{cb_msg module='grn.grn' key='GRN_GRN-1316' replace='true'}</td>
 </tr>
 <tr>
  <td>{cb_msg module='grn.grn' key='GRN_GRN-1317' replace='true'}</td><td>&nbsp;{cb_msg module='grn.grn' key='GRN_GRN-1318' replace='true'}&nbsp;</td><td><strong>{$user_count.regist|escape}</strong>&nbsp;{cb_msg module='grn.grn' key='GRN_GRN-1319' replace='true'}</td>
 </tr>
{if $smarty.const.ON_SAAS===1}
 <tr>
  <td><span class="attention">{cb_msg module='grn.saas' key='GRN_SAAS-7' replace='true'}</span></td><td>&nbsp;<span class="attention">{cb_msg module='grn.saas' key='GRN_SAAS-8' replace='true'}</span>&nbsp;</td><td><span class="attention"><strong>{$saas_license_user|escape}</strong>&nbsp;{cb_msg module='grn.saas' key='GRN_SAAS-9' replace='true'}</span></td>
 </tr>
{/if}
</table>
