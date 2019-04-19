{literal}
<script language="JavaScript" type="text/javascript">
<!--
var openConfirm_count = 0;
function openConfirm{/literal}_{$faid|escape:"javascript"}_{$index|escape:"javascript"}{literal}(form, prefix)
{

 if ( ! openConfirm_count)
 {
{/literal}
   var p = document.getElementById('form_frame');
   var c = document.createElement('DIV');
   p.style.display = "";
   p.appendChild(c);
   c.innerHTML = '<iframe id="form_frame" name="form_frame" frameborder="no" scrolling="no" style="position:absolute; width:0em; height:0em;" src=""></iframe>';
{literal}
 }

  popupWin("","popup",800,600,0,0,0,1,0,1);

  var form_frame = window.frames['form_frame'].document;
  var url = '{/literal}{grn_pageurl page='schedule/confirm'}{literal}';
  var html = '{/literal}{grn_doctype trim="true"}{literal}<html lang="{$html_tag_lang}"><body><form method="POST" target="popup" action="' + url + '">';
  html += '<input type="hidden" name="session_no_use" value="1">';
  html += '<input type="hidden" name="date_prefix" value="'+prefix+'">';
  html += '<input type="hidden" name="'+prefix+'year" value="{/literal}{$date->year}{literal}">';
  html += '<input type="hidden" name="'+prefix+'month" value="{/literal}{$date->month}{literal}">';
  html += '<input type="hidden" name="'+prefix+'day" value="{/literal}{$date->day}{literal}">';
  html += '<input type="hidden" name="'+prefix+'hour" value="{/literal}{$set_hour}{literal}">';
  html += '<input type="hidden" name="'+prefix+'minute" value="0">';
  html += '<input type="hidden" name="end_year" value="{/literal}{$date->year}{literal}">'
  html += '<input type="hidden" name="end_month" value="{/literal}{$date->month}{literal}">';
  html += '<input type="hidden" name="end_day" value="{/literal}{$date->day}{literal}">';
  html += '<input type="hidden" name="end_hour" value="{/literal}{$end_hour}{literal}">';
  html += '<input type="hidden" name="end_minute" value="0">';
  html += '<input type="hidden" name="hide_display_time_set" value="1">';

{/literal}
  {foreach from=$selected_members key=key item=item}
   html += '<input type="hidden" name="sUID[{$key|escape}]" value="{$key|escape}">';
  {/foreach}
  {if $faid !== GRN_SCHD_ADJUST_NO_FACILITY}
   html += '<input type="hidden" name="sITEM[{$faid|escape}]" value="{$faid|escape}">';
  {else}
   html += grn_get_selected_facilities_form();
  {/if}
  {literal}

  html += '</form></body></html>';
  form_frame.write( html );
  form_frame.close();
  form_frame.forms[0].submit();
  openConfirm_count = 1;
}
//-->
</script>
{/literal}

<div id="form_frame" style="position:absolute; width:0em; height:0em;">&nbsp;</div>
{grn_image image="cal_gday20.gif"}<a href="javascript:openConfirm_{$faid|escape:"javascript"}_{$index|escape:"javascript"}($('{$form_name|escape:"javascript"}'), 'candidate_');">{cb_msg module='grn.schedule' key='GRN_SCH-391' replace='true'}</a>
