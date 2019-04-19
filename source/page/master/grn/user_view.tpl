{include file="grn/doctype.tpl"}
<html lang="{$html_tag_lang}">
<head>
<meta name="robots" content="noindex, nofollow, noarchive">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<title>{$page_title}</title>
{grn_load_css file="grn/html/std.css"}
{grn_load_css file="grn/html/msgbox.css"}
<link href="{$app_path}/grn/html/font-{$html_tag_lang}.css?{$build_date}" rel="stylesheet" type="text/css">
{grn_load_css file="grn/html/Designsimple-white.css"}
{grn_load_prototype_js}
{grn_load_javascript file="grn/common/base.js"}
{grn_load_javascript file="grn/html/component/autofit.js"}
</head>
<body>
<div id="body">
<div class="popup_title_grn">
 <div class="float_left">
     {grn_title title=$builtin_items.display_name.value class=$page_info.parts[0]}
 </div>
 <a href="#" onclick="window.close();" role="button">
  <div title="{cb_msg module='grn.grn' key='GRN_GRN-840' replace='true'}"
       aria-label="{cb_msg module='grn.grn' key='GRN_GRN-840' replace='true'}" class="subWindowClose-grn"></div>
 </a>
 <div class="clear_both_0px"></div>
</div>

<p>
<table class="view_table">
   <!--builtin_items-->
{foreach from=$builtin_items key=item_id item=item}
    {if $item.use && $item.show && $item_id != "display_name_language" && $item_id != "nickname"}
 <tr valign="top">
  <th nowrap>
        {$item.display_name|escape}
  </th>
  <td>
        {capture name='body'}{/capture}
        {include file='grn/_action_item_view_contents.tpl'}
        {if $smarty.capture.body}{if $item.sso == 0}{$smarty.capture.body|grn_noescape}{else}{grn_sso_link caption=$smarty.capture.body sso_id=$item.sso app_id="uum" id_list=$sso}{/if}{/if}
  </td>
 </tr>
    {/if}
{/foreach}
   <!--builtin_items_end-->

   <!--extended_items-->
{foreach from=$extended_items key=item_id item=item}
    {if $item.use && $item.show}
 <tr valign="top">
  <th nowrap>
        {$item.display_name|escape}
  </th>
  <td>
        {capture name='body'}{/capture}
        {include file='grn/_action_item_view_contents.tpl'}
        {if $smarty.capture.body}{if $item.sso == 0}{$smarty.capture.body|grn_noescape}{else}{grn_sso_link caption=$smarty.capture.body sso_id=$item.sso app_id="uum" id_list=$sso}{/if}{/if}
  </td>
 </tr>
    {/if}
{/foreach}
   <!--extended_items_end-->
</table>

</div><!--body_end-->
