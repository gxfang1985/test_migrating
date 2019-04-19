{include file="grn/doctype.tpl"}
{assign var="frm_name" value="frmAddress"}
<html lang="{$html_tag_lang}">
<head>
<meta name="robots" content="noindex, nofollow, noarchive">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
    {grn_load_css file="grn/html/std.css"}
    <link href="{$app_path}/grn/html/font-{$html_tag_lang}.css?{$build_date}" rel="stylesheet" type="text/css">
</head>
<body>
<form name="{$frm_name}" action="{grn_pageurl page='address/mail_address_index'}" method="post">
</form>
<table style="width:100%; height:100%"><tr><td align="center"><div class="loading">{grn_image image="spinner.gif"}{cb_msg module='grn.mail' key='GRN_MAIL-107' replace='true'}</div></td></tr></table>
<script language="JavaScript" type="text/javascript">
{literal}
    if(opener.closed)
    {
        window.close();
    }
    
    // get params from parent window
    var params = opener.getFormParams();
    
    var frm = document.forms["{/literal}{$frm_name}{literal}"];

    // add params to forms
    for(key in params)
    {
        var value = params[key];
        if(typeof value == 'function') continue;
        
        var element = document.createElement('input');
        element.name = key;
        element.type = 'hidden';
        element.value = value;
        
        frm.appendChild(element);
    }
    
    // submit form
    frm.submit();
{/literal}
</script>
</body>
</html>
