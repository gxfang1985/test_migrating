<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<META http-equiv="Content-Type" content="text/html; charset=Shift_JIS">
<head>
<meta name="robots" content="noindex, nofollow, noarchive">
<title>{cb_msg module='grn.cellular' key='GRN_CLLL-9' replace='true'}</title>
</head>
<body>
{cb_msg module='grn.cellular' key='GRN_CLLL-10' replace='true'}&nbsp;{cb_msg module='grn.cellular' key='GRN_CLLL-11' replace='true'}<br>
<hr>
{if $pwd_expired.expiration_days > 0}
<form name="{$page_info.last}" method="POST" action="{$url|escape}">
{if $sid_name}
<input type="hidden" name="{$sid_name}" value="{$sid_value}">
{/if}
<input type="hidden" name="_system" value="2">
<input type="hidden" name="_uid" value="{$pwd_expired.uid}">
<input type="hidden" name="_pwd_ticket" value="{$pwd_expired.ticket}">
{foreach from=$params item=value key=key}
<input type="hidden" name="{$key|escape}" value="{$value|escape}">
{/foreach}
{cb_msg module='grn.cellular' key='GRN_CLLL-12' replace='true'}{$pwd_expired.expiration_days}{cb_msg module='grn.cellular' key='GRN_CLLL-13' replace='true'}
<br>
{capture name='grn_cellular_GRN_CLLL_14'}{cb_msg module='grn.cellular' key='GRN_CLLL-14' replace='true'}{/capture}{grn_cellular_submit name="Submit" accesskey=0 caption=$smarty.capture.grn_cellular_GRN_CLLL_14}
</form>
{else}{cb_msg module='grn.cellular' key='GRN_CLLL-15' replace='true'}
{/if}
<form name="{$page_info.last}" method="POST" action="{$url|escape}">
{if $sid_name}
<input type="hidden" name="{$sid_name}" value="{$sid_value}">
{/if}
<input type="hidden" name="_system" value="2">
<input type="hidden" name="_exec" value="1">
<input type="hidden" name="_uid" value="{$pwd_expired.uid}">
<input type="hidden" name="_pwd_ticket" value="{$pwd_expired.ticket}">
{foreach from=$params item=value key=key}
<input type="hidden" name="{$key|escape}" value="{$value|escape}">
{/foreach}
{grn_cellular_pictogram key="id"}{cb_msg module='grn.cellular' key='GRN_CLLL-16' replace='true'}<br>
{$pwd_expired.account}<br>
{grn_cellular_pictogram key="password"}{cb_msg module='grn.cellular' key='GRN_CLLL-17' replace='true'}<br>
<input type="password" name="_password"  maxlength="64" istyle="3" mode="alphabet"><br>
{grn_cellular_pictogram key="password"}{cb_msg module='grn.cellular' key='GRN_CLLL-18' replace='true'}<br>
<input type="password" name="_retype"  maxlength="64" istyle="3" mode="alphabet"><br>
<br>
{capture name='grn_cellular_GRN_CLLL_19'}{cb_msg module='grn.cellular' key='GRN_CLLL-19' replace='true'}{/capture}{grn_cellular_submit name="Submit" accesskey=1 caption=$smarty.capture.grn_cellular_GRN_CLLL_19}
</form>
<hr>
