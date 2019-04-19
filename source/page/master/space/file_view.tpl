{include file="grn/doctype.tpl"}
<html lang="{$html_tag_lang}">
<head>
<meta name="robots" content="noindex, nofollow, noarchive">
    <title>{$page_title}</title>
<link href="{$app_path}/grn/html/std.css?{$build_date}" rel="stylesheet" type="text/css">
<link href="{$app_path}/grn/html/font-{$html_tag_lang}.css?{$build_date}" rel="stylesheet" type="text/css">
</head>
<body>
<div>
<div>
<div style="margin:10px;">
    <img src="{grn_pageurl page='space/file_download' spid=$spid tid=$tid fid=$fid ticket=$ticket hash=$hash postfix=$file_name}">
{include file='grn/footer.tpl'}
