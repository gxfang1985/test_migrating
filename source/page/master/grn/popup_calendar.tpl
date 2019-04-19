{include file="grn/doctype.tpl"}
{if ! $script_name}
 {assign var='script_name' value='cb_ui_select_date_init_date_select'}
{/if}
{if ! $script_name2}
 {assign var='script_name2' value='cb_ui_select_date_display_calendar'}
{/if}
<html lang="{$html_tag_lang}">
<head>
<meta name="robots" content="noindex, nofollow, noarchive">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Pragma" content="no-cache">
<title>{$page_title}</title>
{grn_load_css file="grn/html/std.css"}
<link href="{$app_path}/grn/html/font-{$html_tag_lang}.css?{$build_date}" rel="stylesheet" type="text/css">
{if $browser.type === "msie" && $browser.ver_major <= 11}
 {grn_load_css file="grn/html/ie11.css"}
{/if}
{literal}
<style type="text/css">
<!--
body {
  background: url("");
  min-width: 16.5em;
  _height: 15.5em;
  margin: 0;
  padding: 0;
}
table {
  margin-left: auto;
  margin-right: auto;
  text-align: center;
}
table.cal a {
  display: block;
  width: 100%;
  height: 100%;
}
* html table.cal th,
* html table.cal td {
  line-height: 1.2;
}
table.cal a:hover {
  background-color: #c6cbeb;
}
-->
</style>
<script language="JavaScript" type="text/javascript">
<!--
function Close()
{
    window.parent.{/literal}{$script_name2|escape:"javascript"}{literal}("{/literal}{$form_name|escape:"javascript"}{$prefix|escape:"javascript"}{literal}SetDateCal");
}
function SetDate(nYear, nMonth, nDay, prefix)
{
{/literal}
 {if $form_name}
    window.parent.{$script_name|escape:"javascript"}( "{$form_name|escape:"javascript"}", nYear, nMonth, nDay, prefix);
    var select_form_name = window.parent.document.forms["{$form_name|escape:"javascript"}"]; // GTM-1605
 {else}
    window.parent.{$script_name|escape:"javascript"}( nYear, nMonth, nDay, prefix);
    var select_form_name = window.parent.form; // GTM-1605
 {/if}

 // GTM-1605
 if(select_form_name !== "undefined")
    window.parent.cb_ui_select_date_reset_year_range( select_form_name, prefix);
 // end GTM-1605

 {if $on_change}
    window.parent.{$on_change|escape:"javascript"};
 {/if}
{literal}
    Close();
}
//-->
</script>
{/literal}
</head>
<body>
<div class="popup_calendar">

<form name="{$form_name|escape}" method="GET" action="{grn_pageurl page=$ajax_page script_name=$script_name script_name2=$script_name2 on_change=$on_change}">

<table style="width:300px">
 <tr>
  <td colspan="3" align="center" valign="top" nowrap>{capture name='grn_grn_GRN_GRN_565'}{cb_msg module='grn.grn' key='GRN_GRN-565' replace='true'}{/capture}{grn_link image='close20.gif' page='#' caption=$smarty.capture.grn_grn_GRN_GRN_565 script='javascript:Close();'}</td>
 </tr>
 <tr>
  <td nowrap align="left" style="width:5%">
   {if $prev_date}
    <input type="button" value=" &lt;&lt; " onClick='location.href="{grn_pageurl page=$ajax_page date=$prev_date prefix=$prefix form_name=$form_name script_name=$script_name script_name2=$script_name2 on_change=$on_change}"'>
   {/if}
  </td>
  <td nowrap align="center" style="width:90%">
   {grn_select_date prefix='popup_' form_name=$form_name|escape date=$current_date start_year=1970 date_order='Yn' no_calendar="" onchange='popup_init(this.form)'}
   <input type="hidden" name="date" value="" />
   <input type="hidden" name="form_name" value="{$form_name|escape}" />
   <input type="hidden" name="prefix" value="{$prefix|escape}" />
   <input name="script_name" type="hidden" value="{$script_name|escape}" />
   <input name="script_name2" type="hidden" value="{$script_name2|escape}" />
   <input name="on_change" type="hidden" value="{$on_change|escape}" />
{literal}
   <script type="text/javascript">
     function popup_init(form) {
       var year = document.getElementById("popup_year").value;
       var month = parseInt(document.getElementById("popup_month").value);
       if(10 > month) month = "0" + month;

       var date = year + "-" + month + "-01";
       form["date"].value = date;
       form.submit();
     }
   </script>
   {/literal}
  </td>
  <td nowrap align="right" style="width:5%">{if $next_date}<input type="button" value=" &gt;&gt; " onClick='location.href="{grn_pageurl page=$ajax_page date=$next_date prefix=$prefix form_name=$form_name script_name=$script_name script_name2=$script_name2 on_change=$on_change}"'>{/if}</td>
 </tr>
</table>

<table class="cal" style="width:300px" border="0" cellspacing="0" cellpadding="2">
 <tr class="popup_calendar_band_grn">
  <th class="popup_calendar_band_sunday_grn">{cb_msg module='grn.grn' key='GRN_GRN-566' replace='true'}</th>
  <th>{cb_msg module='grn.grn' key='GRN_GRN-567' replace='true'}</th>
  <th>{cb_msg module='grn.grn' key='GRN_GRN-568' replace='true'}</th>
  <th>{cb_msg module='grn.grn' key='GRN_GRN-569' replace='true'}</th>
  <th>{cb_msg module='grn.grn' key='GRN_GRN-570' replace='true'}</th>
  <th>{cb_msg module='grn.grn' key='GRN_GRN-571' replace='true'}</th>
  <th class="popup_calendar_band_saturday_grn">{cb_msg module='grn.grn' key='GRN_GRN-572' replace='true'}</th>
 </tr>
{foreach from=$week_list item=week}
 <tr>
 {foreach from=$week item=date}
  <td align="center" class="{$date.date_type|escape:"javascript"}">
   {if $date.year <= 2037 and $date.year >= 1970 and not ($date.year == 1970 and $date.month == 1 and $date.day <= 2)}
   <a href="javascript:SetDate({$date.year|escape:"javascript"}, {$date.month|escape:"javascript"}, {$date.day|escape:"javascript"}, '{$prefix|escape:"javascript"|escape:"html"}')">{$date.day|escape}</a>
   {/if}
  </td>
 {/foreach}
 </tr>
{/foreach}
</table>
</form>
</div>
