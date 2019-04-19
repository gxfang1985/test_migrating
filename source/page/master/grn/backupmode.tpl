{include file="grn/doctype.tpl"}
<html lang="{$html_tag_lang}">
<head>
<meta name="robots" content="noindex, nofollow, noarchive">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<title>{$page_title}</title>
{grn_load_css file="grn/html/std.css"}
<link href="{$app_path}/grn/html/font-{$html_tag_lang}.css?{$build_date}" rel="stylesheet" type="text/css">
</head>
<body>
<div class="headbar">
<table class="layout" width="100%">
 <tr>
  <td width="25%" nowrap><a href="{grn_pageurl page='index'}">{grn_image image='grnlogo_blue.gif'}</a></td>
 </tr>
</table>
<div id="one_parts">
 <!--view--->
 <div id="view">
  <div class="center_block">
   <div class="center_list">
    {if $start && $end}{grn_date_format date=$start format="TimeLong_HM"}{cb_msg module='grn.grn' key='GRN_GRN-1349' replace='true'}{grn_date_format date=$end format="TimeLong_HM"}{cb_msg module='grn.grn' key='GRN_GRN-1350' replace='true'}{/if}{cb_msg module='grn.grn' key='GRN_GRN-1351' replace='true'}
   </div>
  </div>
 </div>
 <!--view_end--->
</div>
</div>
