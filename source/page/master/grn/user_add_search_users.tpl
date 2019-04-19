{include file="grn/doctype.tpl"}
<html lang="{$html_tag_lang}">
<head>
<meta name="robots" content="noindex, nofollow, noarchive">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
{literal}
<script language="javascript" type="text/javascript">
<!--
function RewriteTarget()
{
    var target_form_name = "{/literal}{$target_form_name|escape:javascript}{literal}";
    var target_category_select_name = "{/literal}{$target_category_select_name|escape:javascript}{literal}";
    var target_item_select_name = "{/literal}{$target_item_select_name|escape:javascript}{literal}";
    var item_array = [
    {/literal}{foreach from=$item_options item=item name=options}{literal}
     {
                "value" : "{/literal}{$item.value|escape:javascript}{literal}",
                "text"  : "{/literal}{$item.name|escape:javascript}{literal}"
     }
    {/literal}{if !$smarty.foreach.options.last},{/if}
    {/foreach}{literal}
    ];
    parent.RewriteItemOptions( target_form_name, target_item_select_name, item_array );
    parent.RewriteCategoryOptions( target_form_name, target_category_select_name );
    if( typeof parent.update_back_step == 'function' )
    {
        parent.update_back_step();
    }
    parent.document.forms[target_form_name].elements[target_item_select_name].focus();
}
//-->
</script>
{/literal}
</head>
<body onLoad="RewriteTarget();">
</body>
