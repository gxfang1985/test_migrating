<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

{*
 * エラーページのテンプレート
 * @see include/fw/error_handler.html
 *}

<html>
<head>
<meta name="robots" content="noindex, nofollow, noarchive">
<title>{cb_msg module='grn' key='GRN_GRN-58' replace='true'}</title>
</head>

<body>
<p><b>{cb_msg module='grn.cellular' key="Error"}({$ErrorNumber})</b></p>
{$ErrorDiag|grn_noescape}
<p><b>{cb_msg module='grn.cellular' key="Cause"}</b></p>
{$ErrorCause|grn_noescape}
{if $HaveAdditional}
<p><b>{cb_msg module='grn.cellular' key="Additional Information"}</b></p>
{foreach from=$AdditionalMessage item=current}
{$current|grn_noescape}
<br><br>
{/foreach}
{/if}
<p><b>{cb_msg module='grn.cellular' key="Counter Measure"}</b></p>
{$ErrorCounterMeasure|grn_noescape}

<p>{cb_msg module='grn.cellular' key="Press Back Button"}</p>

{**
 * デバッグモードが指定されているとき、コールスタックを表示する
 * $show_backtrace はフレームワーク標準で定義されている。
 *}
{if $show_backtrace}
<hr>
<b>( Beta/Debug only. by common.ini )</b>

<h3>Developer Info</h3>
{$ErrorDeveloperInfo|grn_noescape}

<h3>Backtrace</h3>

<p>
How to read backtraces(to be written) / {cb_msg module='grn' key='GRN_GRN-61' replace='true'}
</p>
<pre>
{$ErrorDetailTable|grn_noescape}
</pre>
{/if}
{**
 * 未実装: ユーザ言語と管理者言語が異なる場合の、第二言語によるエラー
 * 表示機能
 *}


{* コピーライトと以下の閉じタグは自動的に出力される
</body>
</html>
*}
