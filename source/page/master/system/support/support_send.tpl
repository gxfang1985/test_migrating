{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
<form method="post" action="https://support.cybozu.co.jp/support/garoon4/index.cbml"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{cb_msg module='grn.system.support' key='GRN_SY_SUP-1' replace='true'}<br>
{cb_msg module='grn.system.support' key='GRN_SY_SUP-2' replace='true'}<br>
{cb_msg module='grn.system.support' key='GRN_SY_SUP-3' replace='true'}<br>

<p>
<table class="view_table">
<colgroup>
 <col width="20%">
 <col width="80%">
</colgroup>
<!--
<tr>
<th nowrap>
{cb_msg module='grn.system.support' key='GRN_SY_SUP-4' replace='true'}
</th>
<td>
{$raw_subject|escape}
</td>
</tr>
-->
<tr>
<th nowrap>
{cb_msg module='grn.system.support' key='GRN_SY_SUP-5' replace='true'}
</th>
<td>
{$raw_id|escape}
</td>
</tr>

<tr>
<th nowrap>
{cb_msg module='grn.system.support' key='GRN_SY_SUP-6' replace='true'}
</th>
<td>
{$raw_name|escape}
</td>
</tr>

<tr>
<th nowrap>
{cb_msg module='grn.system.support' key='GRN_SY_SUP-7' replace='true'}
</th>
<td>
{$raw_yomi|escape}
</td>
</tr>

<tr>
<th nowrap>
{cb_msg module='grn.system.support' key='GRN_SY_SUP-8' replace='true'}
</th>
<td>
{$raw_admin_name|escape}
</td>
</tr>

<tr>
<th nowrap>
{cb_msg module='grn.system.support' key='GRN_SY_SUP-9' replace='true'}
</th>
<td>
{$raw_admin_yomi|escape}
</td>
</tr>

<tr>
<th nowrap>
{cb_msg module='grn.system.support' key='GRN_SY_SUP-10' replace='true'}
</th>
<td>
{$raw_group|escape}
</td>
</tr>

<tr>
<th nowrap>
{cb_msg module='grn.system.support' key='GRN_SY_SUP-11' replace='true'}
</th>
<td>
{$raw_email|escape}
</td>
</tr>

<tr>
<th nowrap>
{cb_msg module='grn.system.support' key='GRN_SY_SUP-12' replace='true'}
</th>
<td>
{$raw_phone|escape}
</td>
</tr>

{if $smarty.const.ON_SAAS!==1}
<tr>
<th nowrap>
{cb_msg module='grn.system.support' key='GRN_SY_SUP-13' replace='true'}
</th>
<td>
{$raw_expire}
</td>
</tr>

<tr>
<th nowrap>
{cb_msg module='grn.system.support' key='GRN_SY_SUP-15' replace='true'}
</th>
<td>
{$raw_os}
</td>
</tr>

<tr>
<th nowrap>
{cb_msg module='grn.system.support' key='GRN_SY_SUP-16' replace='true'}
</th>
<td>
{$raw_webserver}
</td>
</tr>

<tr>
<th nowrap>
{cb_msg module='grn.system.support' key='GRN_SY_SUP-17' replace='true'}
</th>
<td>
{$raw_docdir}
</td>
</tr>

<tr>
<th nowrap>
{cb_msg module='grn.system.support' key='GRN_SY_SUP-18' replace='true'}
</th>
<td>
{$raw_cgidir}
</td>
</tr>
{/if}

<tr>
<th nowrap>
{cb_msg module='grn.system.support' key='GRN_SY_SUP-19' replace='true'}
</th>
<td>
{$raw_usercount}
</td>
</tr>

<tr valign="top">
<th nowrap>
{cb_msg module='grn.system.support' key='GRN_SY_SUP-21' replace='true'}
</th>
<td>

<table class="admin_list_table">
<tr>
<th nowrap>
{cb_msg module='grn.system.support' key='GRN_SY_SUP-22' replace='true'}
</th>
<th nowrap>
{cb_msg module='grn.system.support' key='GRN_SY_SUP-23' replace='true'}
</th>
<th nowrap>
{cb_msg module='grn.system.support' key='GRN_SY_SUP-24' replace='true'}
</th>
</tr>

{foreach from=$raw_productinfo item=app}
<tr>
<td nowrap>
{$app.id|escape}
</td>
<td nowrap>
{$app.name|escape}
</td>
<td nowrap>
{$app.version|escape}
</td>
</tr>
{/foreach}

</table>

</td>
</tr>
</table>

<!--hidden-->
<input type="hidden" name="subject" value="{$enc_subject}">
<input type="hidden" name="id" value="{$enc_id}">
<input type="hidden" name="name" value="{$enc_name}">
<input type="hidden" name="yomi" value="{$enc_yomi}">
<input type="hidden" name="admin_name" value="{$enc_admin_name}">
<input type="hidden" name="admin_yomi" value="{$enc_admin_yomi}">
<input type="hidden" name="group" value="{$enc_group}">
<input type="hidden" name="email" value="{$enc_email}">
<input type="hidden" name="phone" value="{$enc_phone}">
<input type="hidden" name="expire" value="{$enc_expire}">
{if $smarty.const.ON_SAAS!==1}
<input type="hidden" name="os" value="{$enc_os}">
<input type="hidden" name="webserver" value="{$enc_webserver}">
<input type="hidden" name="docdir" value="{$enc_docdir}">
<input type="hidden" name="cgidir" value="{$enc_cgidir}">
{/if}
<input type="hidden" name="usercount" value="{$enc_usercount}">
<input type="hidden" name="productinfo" value="{$enc_productinfo}">
{capture name='grn_system_support_GRN_SY_SUP_25'}{cb_msg module='grn.system.support' key='GRN_SY_SUP-25' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_system_support_GRN_SY_SUP_25 page="system/support/support" sf="1"}
{capture name='grn_system_support_GRN_SY_SUP_26'}{cb_msg module='grn.system.support' key='GRN_SY_SUP-26' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_support_GRN_SY_SUP_26}
</form>

{include file='grn/support_footer.tpl'}
