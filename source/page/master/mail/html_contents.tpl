{include file="grn/doctype.tpl"}
<html lang="{$html_tag_lang}">
<head>
    <meta name="robots" content="noindex, nofollow, noarchive">
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <meta http-equiv="Content-Style-Type" content="text/css">
    <meta http-equiv="Content-Script-Type" content="text/javascript">
    <link href="{$app_path}/grn/html/font-{$html_tag_lang}.css?{$build_date}" rel="stylesheet" type="text/css">
    <title>{$page_title}</title>
    <link rel="shortcut icon" href="{$app_path}/grn/image/cybozu/garoon.ico?{$build_date}">
</head>
<body>
    {$data|grn_noescape}
</body>
</html>