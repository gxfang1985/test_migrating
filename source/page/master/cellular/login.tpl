<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<META http-equiv="Content-Type" content="text/html; charset=Shift_JIS">
<head>
<meta name="robots" content="noindex, nofollow, noarchive">
<title>{cb_msg module='grn.cellular' key='GRN_CLLL-2' replace='true'}</title>
</head>
<body>
{cb_msg module='grn.cellular' key='GRN_CLLL-3' replace='true'}&nbsp;{cb_msg module='grn.cellular' key='GRN_CLLL-4' replace='true'}<br>
<hr>
<form name="{$page_info.last}" method="POST" action="{$url|escape}">
{* GRN2-1148 斁E��コード判別のためのパラメータでぁE*}
<input type="hidden" name="hint" value="ログイン画面">
{* /GRN2-1148 *}
<input type="hidden" name="_system" value="1">
{foreach from=$params item=value key=key}
<input type="hidden" name="{$key|escape}" value="{$value|escape}">
{/foreach}
{grn_cellular_pictogram key="id"}{cb_msg module='grn.cellular' key='GRN_CLLL-5' replace='true'}<br>
<input type="text" name="_account" value="" istyle="3" mode="alphabet"><br>
{grn_cellular_pictogram key="password"}{cb_msg module='grn.cellular' key='GRN_CLLL-6' replace='true'}<br>
<input type="password" name="_password"  maxlength="64" istyle="3" mode="alphabet"><br>
{if $accept_cookie == true}
<input type="checkbox" name="allow_auto_login">{cb_msg module='grn.cellular' key='GRN_CLLL-20' replace='true'}<br>
{/if}
<br>
{capture name='grn_cellular_GRN_CLLL_7'}{cb_msg module='grn.cellular' key='GRN_CLLL-7' replace='true'}{/capture}{grn_cellular_submit name="Submit" accesskey=1 caption=$smarty.capture.grn_cellular_GRN_CLLL_7}
</form>
<hr>
