{if ! $duplication}
{literal}<script language="JavaScript" type="text/javascript">
<!--
var popupFacilityList_count = 0;
function popupFacilityList(Aform)
{
 if ( ! popupFacilityList_count)
 {
{/literal}
   var p = document.getElementById('div_{$var_CID}');
   var c = document.createElement('DIV');
   p.style.display = "";
   p.appendChild(c);
   c.innerHTML = '<iframe id="form_{$var_CID}" name="form_{$var_CID}" frameborder="no" scrolling="no" style="position:absolute; width:0em; height:0em;" src=""></iframe>';
{literal}
 }
{/literal}
    popupWin("","facility_list",800,600,0,0,0,1,0,1);
{literal}
 var form_frame = window.frames['form_{/literal}{$var_CID}{literal}'].document;
 var url = '{/literal}{grn_pageurl page=$popup_facility_list_link}{literal}';
 var html = '{/literal}{grn_doctype trim="true"}{literal}<html><body lang="{$html_tag_lang}"><form method="post" target="facility_list" action="' + url + '">';
 html += '<input type="hidden" name="system_display" value="{/literal}{$system_display}{literal}">';
{/literal}
{if $list_name}
{literal}
    var instance = grn.component.member_select_list.get_instance("{/literal}{$list_name}{literal}");
    var values = instance.getSelectedUsersValues();
    html += jQuery.map(values, function(value, count){
        if ( value.length > 0 && isFinite( value ) ) {
            return '<input type="hidden" name="cid[' + (count) + ']" value="' + value + '">'
        }else{
            return '';
        }
    }).join();
{/literal}
{else}
{literal}
 var options = Aform.elements['{/literal}{$var_CID}{literal}'];
 for ( i = 0, count = 0 ; i < options.length; i++ )
 {
  if( ! options[i].selected || ! options[i].value ) continue;
  var options_value = options[i].value.split(':');
  if ( options_value.length > 0 && isFinite( options_value[0] ) )
  {
   html += '<input type="hidden" name="cid[' + (count++) + ']" value="' + options_value[0] + '">';
  }
 }
 if(YAHOO.env.ua.ie < 9)
 {
    form_frame.clear();
 }
{/literal}
{/if}
{literal}
 html += '</form></body></html>';
 form_frame.write( html );
 form_frame.close();
 form_frame.forms[0].submit();
 popupfacilityList_count = 1;
 if( !grn.browser.chrome && !grn.browser.safari && typeof update_back_step == 'function' )
 {
    update_back_step();
 }
 return true;
}
//-->
</script>{/literal}

<div id="div_{$var_CID}" style="display:none; position:absolute; width:0; height:0;">&nbsp;</div>

{/if}
{literal}<script language="JavaScript" type="text/javascript">
{/literal}{if $form_name}{literal}
var form_name = document.getElementById('{/literal}{$form_name}{literal}');
{/literal}{/if}{literal}
</script>{/literal}
{if $list_name}
    <a href="javascript:void(0);" onClick="popupFacilityList();">{$caption}</a>
{else}
    <a href="javascript:void(0);" onClick="popupFacilityList(form_name);">{$caption}</a>
{/if}