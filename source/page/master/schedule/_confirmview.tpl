{literal}
<script language="JavaScript" type="text/javascript">
<!--
function appendSingleSelection(form,name,src_html)
{
  var html = src_html;
  var box = form.elements[name];
  if ( ! box ) return html;
  var box_value = box.options[box.selectedIndex].value;
  
  if ( box_value.length < 1 ) return html;
  html += '<input type="hidden" name="' + name + '" value="' + box_value + '">';
  return html;
}
function appendMultipleSelection(form,name,src_html)
{
  var html = src_html;
  var box = form.elements[name + '[]'];
  if ( ! box ) return html;
  var box_options = box.options;
  var count = 0;

  for ( i = 0; i < box_options.length; i++ )
  {
    var box_option = box_options[i];
    if (name != 'sITEM' && name != 'sUID' && ! box_option.selected ) continue;
    if ( box_option.value.length < 1 ) continue;
    var box_option_value = box_option.value.split(':');
    html += '<input type="hidden" name="' + name + '[' + (count++) + ']" value="' + box_option_value[0] + '">';
  }
  return html;
}
var openConfirm_count = 0;
function openConfirm(form, pagename)
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

  var popupWindow   = popupWin_returnWin("","popup",1034,675,0,0,0,1,0,1);
  Event.observe(window, 'unload', function(){if(popupWindow && !popupWindow.closed){popupWindow.close();}}, false);

  var form_frame = window.frames['form_frame'].document;
  var url = '{/literal}{grn_pageurl page='schedule/confirm'}{literal}';
  var member_add = grn.component.member_add.get_instance('member_select');
  var html = '{/literal}{grn_doctype trim="true"}{literal}<html lang="{$html_tag_lang}"><body><form method="POST" target="popup" action="' + url + '">';
  html += '<input type="hidden" name="session_no_use" value="1">';

  //single select
  html = appendSingleSelection(form,'start_year',html);
  html = appendSingleSelection(form,'start_month',html);
  html = appendSingleSelection(form,'start_day',html);
  html = appendSingleSelection(form,'start_hour',html);
  html = appendSingleSelection(form,'start_minute',html);
  html = appendSingleSelection(form,'end_year',html);
  html = appendSingleSelection(form,'end_month',html);
  html = appendSingleSelection(form,'end_day',html);
  html = appendSingleSelection(form,'end_hour',html);
  html = appendSingleSelection(form,'end_minute',html);
  //multiple select
  html += member_add.getFirstMemberSelectList().makeHTMLTextForConfirmView(false);
  html += member_add.candidateList.makeHTMLTextForConfirmView(true);
  if (grn.component.facility_add) {
    var facility_add = grn.component.facility_add.get_instance('facility_select');
    html += facility_add.facilityList.makeHTMLTextForConfirmView(false);
    html += facility_add.candidateList.makeHTMLTextForConfirmView(true);
  }


  if ( form.elements['uid'] )
  {
    html += '<input type="hidden" name="uid" value="' + form.elements['uid'].value + '">';
  }
  if ( form.elements['gid'] )
  {
    html += '<input type="hidden" name="gid" value="' + form.elements['gid'].value + '">';
  }
  if ( form.elements['bdate'] )
  {
    html += '<input type="hidden" name="bdate" value="' + form.elements['bdate'].value + '">';
  }
  html += '<input type="hidden" name="parent_page_name" value="' + pagename + '">';
  html += '<input type="hidden" name="timezone" value="' + form.elements['timezone'].value + '">';
  html += '<input type="hidden" name="end_timezone" value="' + form.elements['end_timezone'].value + '">';

  html += '</form></body></html>';
  form_frame.write( html );
  form_frame.close();
  form_frame.forms[0].submit();
  openConfirm_count = 1;
  if( !Prototype.Browser.Chrome && !Prototype.Browser.Safari && typeof update_back_step == 'function' )
  {
      update_back_step();
  }
  return false;
}
//-->
</script>
{/literal}

<div id="form_frame" style="display:none; position:absolute; width:0em; height:0em;">&nbsp;</div>

{literal}<script language="JavaScript" type="text/javascript">
{/literal}{if $form_name}{literal}
var form_name = document.getElementById('{/literal}{$form_name}{literal}');
{/literal}{/if}{literal}
</script>{/literal}
<span class="aButtonHighlight-grn">
    <a href="javascript:void(0);" onClick="javascript:openConfirm(form_name, '{$page_info.last}');">
        <span class="icon-blankB-grn"></span>
        <span class="aButtonText-grn">{cb_msg module='grn.schedule' key='GRN_SCH-170' replace='true'}</span>
    </a>
</span>
