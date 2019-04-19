{assign var="select_size" value=5}
{assign var="group_id" value="f"}
{include file="grn/rewrite_category_options_wording.tpl"}
{grn_load_javascript file="grn/html/component/user_select/user_select.js"}
{grn_load_javascript file="grn/html/user_add.js"}
{grn_load_javascript file="grn/html/single_user_add.js"}
{grn_load_javascript file="grn/html/form_disable.js"}
<form name="{$form_name}" id="{$form_name}" method="post" action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="refresh" value="">
<input type="hidden" name="pid" value="{$portlet.pid}">
<input type="hidden" name="plid" value="{$portlet.plid}">
<input type="hidden" name="ppid" value="{$portlet.ppid}">
<input type="hidden" name="display" value="{$display}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-8' replace='true'}
  </th>
  <td>
      {grn_select name='font_size' options=$font_options}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-9' replace='true'}
  </th>
  <td>

{if $display != 'set-system' && $display != 'set-operation'}
 {grn_single_user_add form_name=$form_name selected_user=$initialize_users access_plugin=$access_plugin plugin_session_name=$plugin_session_name plugin_data_name=$plugin_data_name include_org=$show_organize item_group=$item_group default_group_name=$default_group_name page_name=$page_name show_affiliation_group=$show_affiliation_group group_id=$group_id ftree_async_page=$ftree_async_page ftree_page_name=$ftree_name}
{else}
<table border="0" cellspacing="0">
 <tr>
  <td valign="middle" style="padding-left:0">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr>
     <td style="padding-left:0;">
      <input type="text" readonly name="member" value="{$initialize_users.title}">
      <input type="hidden" name="UID" value="{$initialize_users.id}">
     </td>
    </tr>
   </table>
  </td>
  <td class="item_right_left">
   <br><br><br><input type="button" value="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-11' replace='true'}" onClick="EnterMember( this.form, 'CID[]', 'CID[]' )">

   <br><br><br><br><br><br><br><br><br><input type="button" value="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-12' replace='true'}" onClick="EnterMember( this.form, 'cITEM[]', 'cITEM[]', true )">

  </td>
  <td>
   <input type="text" name="keyword_CGID" size=22 maxlength="45" value="" onKeyPress="if(event.keyCode == 13) SearchCGID( this.form, '{grn_pageurl page='grn/user_add_search_users'}' ); return event.keyCode != 13;">
   <input type="button" value="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-13' replace='true'}" onClick="SearchCGID( this.form, '{grn_pageurl page='grn/user_add_search_users'}' );">
   <div class="margin_top">
{if $display == 'set-system'}
 {capture name='grn_schedule_portlet_GRN_SCH_PO_14'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-14' replace='true'}{/capture}{grn_popup_user_select_link caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_14 form_name=$form_name select_name=$sUID system=true system_display=true include_org=$show_organize no_multiple=true access_plugin=$access_plugin plugin_session_name=$plugin_session_name plugin_data_name=$plugin_data_name}
{else}
 {capture name='grn_schedule_portlet_GRN_SCH_PO_15'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-15' replace='true'}{/capture}{grn_popup_user_select_link caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_15 form_name=$form_name select_name=$sUID system=false system_display=false include_org=$show_organize no_multiple=true access_plugin=$access_plugin plugin_session_name=$plugin_session_name plugin_data_name=$plugin_data_name}
{/if}
   </div>

<!-- category select -->
   <div class="margin_vert">
   <select id="CGID" name="CGID" onChange="ChangeCGID( this.form );">
    <option value="login" selected>{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-16' replace='true'}</option>
   </select>
   <iframe id="sub_CGID" name="sub_CGID" frameborder="no" scrolling="no" style="position:absolute; width:0em; height:0em;" src="{$app_path}/grn/html/space.html?{$build_date}">
   </iframe>
{literal}
<script language="JavaScript" type="text/javascript">
<!--
function ChangeCGID( form )
{
  var item_options = new Array();
  item_options['login'] = new Array();
  item_options['login'][0] = new Option();
  item_options['login'][0].value = '0';
  item_options['login'][0].text = '{/literal}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-17' replace='true'}{literal}';
  var selected_category = form.elements['CGID'].value;
  RewriteItemOptionsWithoutSelectedAttribute( form.name, 'CID[]', item_options[selected_category]);
  
  if ( form.elements['CGID'].options[0].value == 'search' ) {
      form.elements['CGID'].options[0] = null;
  }
  
  form.elements['CID[]'].focus();
}
function SearchCGID( form, url )
{
    var parameters = {
        {/literal}
        "keyword_CGID" : form.elements["keyword_CGID"].value,
        "target_form_name_CGID": "{$form_name}",
        "target_category_select_name_CGID": "CGID",
        "target_item_select_name_CGID": "CID[]",
        "search_login_name_CGID": {if $display == 'set-system'}"1"{else}"0"{/if}
        {literal}
    };
    {/literal}
    parameters["plugin_session_name_CGID"] = "{$plugin_session_name}";
    parameters["plugin_data_name_CGID"] = "{$plugin_data_name}";
    {literal}

    var target = "sub_CGID";
    searchByKeyword(target, url, parameters);
}
//-->
</script>
{/literal}
   </div>
<!-- category select ==>

<!-- item select -->
   <div class="margin_vert">
   <select name="CID[]" size=8 multiple class="select_multiple_display_grn" style="min-width:500px;">
    <option value="0" selected>{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-18' replace='true'}</option>
    <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
   </select>
   </div>
<!-- item select -->

<!-- userinfo list -->
   <div class="margin_vert">
{if $display == 'set-system'}
 {capture name='grn_schedule_portlet_GRN_SCH_PO_19'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-19' replace='true'}{/capture}{grn_popup_user_list_link caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_19 form_name=$form_name system_display=true}
{else}
 {capture name='grn_schedule_portlet_GRN_SCH_PO_20'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-20' replace='true'}{/capture}{grn_popup_user_list_link caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_20 form_name=$form_name system_display=false}
{/if}
   </div>
<!-- userinfo list -->

<!-- facility list -->

<input type="text" id="facility_search_text" value="" maxlength="45" size="22" onkeypress="if(event.keyCode == 13)searchFacility( '{$page_name}' ); "/>
<input type="button" onclick="searchFacility( '{$page_name}' );" value="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-21' replace='true'}"/>

<div class="margin_top"></div>
{include file="schedule/_item_add_dropdown_part.tpl" prefer_fg_button=1}

  <div class="margin_top">
  <iframe id="spinner_iframe" src="{$app_path}/grn/html/space.html?{$build_date}" frameborder="no" style="width:16; height:16; position:absolute; margin:3px 0 0 3px; z-index:2; display:none;"></iframe>

      <select id='facility-item' name="cITEM[]" size="{$select_size}" class="select_multiple_display_grn" style="min-width:500px;">
{foreach from=$item_group key=set_cid item=cITEM_set}
       <option value="{$cITEM_set._id}" >{$cITEM_set.col_name|escape}
{/foreach}
 {if $browser.os_type == 'mac'}
        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
 {else}
       <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option> 
 {/if}
      </select>

  </div>
    
    <table cellspacing="0" cellpadding="0" border="0" style="{if ! $show_affiliation_group}display:none;{/if} margin-top:2px;" class="facility_group_path" id="facility-group">
       <tbody><tr valign="top">
              <td nowrap="">{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-22' replace='true'}</td>
              <td> <span style="" id="selected-path"></span> </td> </tr>
       </tbody>
 </table>
<div class="margin_top">
{capture name='grn_schedule_portlet_GRN_SCH_PO_23'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-23' replace='true'}{/capture}{grn_popup_facility_list_link caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_23 form_name=$form_name var_CID='cITEM[]' system_display=false duplication=$duplication}
           </div>

<script type="text/javascript"><!--
{if $show_affiliation_group}
var facility_cache =  {include file="schedule/json/facility.tpl" facility=$item_group};
{else}
var facility_cache = new Array();
{/if}

{literal}
function ChangeITEM( form_name, argLoadItem )
{
    var form = document.getElementById( form_name );
    var a = form.elements['cITEM[]'].options;
    var lo = new Option( a[a.length-1].text, "" );
    for( i = a.length-1 ; i > 0 ; i-- ) a[i] = null;
    a[0] = lo;

  var parent_form = form.elements['cITEM[]'].parentNode;

  var spinner_iframe = document.getElementById( 'spinner_iframe' );
  spinner_iframe.style.display = "";

  var spinner_img = document.createElement( 'div' );
  spinner_img.id = 'spinner-img';
  spinner_img.style.position = 'absolute';
  spinner_img.style.margin = '3px 0pt 0pt 3px';
  spinner_img.style.zIndex = '2';
  spinner_img.style.height = '16';
  spinner_img.style.width = '16';
  parent_form.insertBefore( spinner_img, document.getElementById( 'facility-item' ) );

  var conn = YAHOO.util.Connect;
  var postDataArray = new Array();
  for( var key in argLoadItem ) {
    postDataArray.push( key + "=" + argLoadItem[key] );
  }
  postDataArray.push( 'page_name={/literal}{$page_name}{literal}' );

  var postString = postDataArray.join( '&' );

  if ( argLoadItem['fagid'] == 0) {
    display_on( 'facility-group' );
  }
  else {
    display_off( 'facility-group' );
  }

  form.elements['cITEM[]'].disabled = true;

  var requestPage = new grn.component.ajax.request(
  {
      grnUrl: {/literal}{if $display == 'set-system'}"schedule/system/json/accessible_facility"{else}"schedule/json/accessible_facility"{/if}{literal},
      method: "post",
      dataType: "json",
      grnRedirectOnLoginError: true,
      data: postString
  });

  requestPage.send().done(function (facility_cache) {
      for (var i = 0; i < facility_cache.length; i++) {
          au(a, facility_cache[i]['id'], facility_cache[i]['name']);
      }
      parent_form.removeChild(spinner_img);
      spinner_iframe.style.display = "none";
      selectFacility();
      form.elements['cITEM[]'].disabled = false;
      form.elements['cITEM[]'].focus();
  });
}

function searchFacility( form_name )
{
    var form = document.getElementById( form_name );
    var a = form.elements['cITEM[]'].options;
    var lo = new Option( a[a.length-1].text, "" );
    for( i = a.length-1 ; i > 0 ; i-- ) a[i] = null;
    a[0] = lo;


  var parent_form = form.elements['cITEM[]'].parentNode;

  var spinner_iframe = document.getElementById( 'spinner_iframe' );
  spinner_iframe.style.display = "";

  var spinner_img = document.createElement( 'div' );
  spinner_img.id = 'spinner-img';
  spinner_img.style.position = 'absolute';
  spinner_img.style.margin = '3px 0pt 0pt 3px';
  spinner_img.style.zIndex = '2';
  spinner_img.style.height = '16';
  spinner_img.style.width = '16';
  parent_form.insertBefore( spinner_img, document.getElementById( 'facility-item' ) );

  display_on( 'facility-group' );

  form.elements['cITEM[]'].setAttribute( 'readonly', 'readonly' );

  var node = document.getElementById( 'facility_search_text' );
  var conn = YAHOO.util.Connect;

  var requestPage = new grn.component.ajax.request(
  {
      grnUrl: {/literal}{if $display == 'set-system'}"schedule/system/json/search_facility"{else}"schedule/json/search_facility"{/if}{literal},
      method: "post",
      dataType: "json",
      grnRedirectOnLoginError: true,
      data: 'search_text=' + node.value + '&page_name={/literal}{$page_name}{literal}'
  });

  requestPage.send().done(function (facility_cache) {
      for (var i = 0; i < facility_cache.length; i++) {
          au(a, facility_cache[i]['id'], facility_cache[i]['name']);
      }
      parent_form.removeChild(spinner_img);
      spinner_iframe.style.display = "none";
      selectFacility();
      form.elements['cITEM[]'].disabled = false;
      form.elements['cITEM[]'].focus();
      YAHOO.global.updateTitle('{/literal}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-24' replace='true'}{literal}');
  });

  YAHOO.global.dropdown.facility.insertNode(
      {"oid":"s", "name":'{/literal}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-24' replace='true'}{literal}', 'is_selected': true, 'extra_param':'1', 'count':0, 'children':[] } );
  }

function selectFacility()
{
  var selected = window.document.getElementById( 'facility-item' ).value;
  var data = null;
  for( var i =0; i < facility_cache.length; i++) {
    if( facility_cache[ i ]['id'] == selected ) {
      if( facility_cache[ i ]['id'] == selected ){
        data = facility_cache[i];
      }
    }
  }

  var parent_path_node = window.document.getElementById( 'selected-path' );

  var num_selected_items = 0;
  var facility_item_options = window.document.getElementById('facility-item').options;
  for( var i =0 ;  i < facility_item_options.length; i++ ) {
    if ( facility_item_options[i].selected ){
      num_selected_items ++;
    }
  }

  if ( num_selected_items  != 1){
    parent_path_node.innerHTML = '';
  } else if ( data == null) {
    parent_path_node.innerHTML = '';
  } else{
    var tmpArray = new Array();

    if ( data['ancestors'].length > 0 ){
      for( var i = 0; i < data['ancestors'].length; i++ ){
	tmpArray.push( data['ancestors'][i]['name'].escapeHTML() );
      }
      parent_path_node.innerHTML = tmpArray.join( ' &gt; ' );
    }
    else {
      parent_path_node.innerHTML = '{/literal}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-25' replace='true'}{literal}';
    }
  }
}

YAHOO.util.Event.addListener( window, 'load', function() {
    YAHOO.util.Event.addListener( window.document.getElementById( 'facility-item' ), 'change', selectFacility );
} );


//-->
</script>{/literal}

<!-- facility list -->

  </td>
 </tr>
</table>
{/if}

  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {if $display == 'set-system'}
        {capture name='grn_schedule_portlet_GRN_SCH_PO_26'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-26' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_26}
        {capture name='grn_schedule_portlet_GRN_SCH_PO_27'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-27' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_27 page='portal/system/view' pid=$portlet.pid}
       {elseif $display == 'set-operation'}
        {capture name='grn_schedule_portlet_GRN_SCH_PO_28'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-28' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_28}
        {capture name='grn_schedule_portlet_GRN_SCH_PO_29'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-29' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_29 page='portal/operation/view' pid=$portlet.pid}
       {else}
        {capture name='grn_schedule_portlet_GRN_SCH_PO_30'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-30' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_30 onclick="PrepareSubmit( this.form );"}
        {capture name='grn_schedule_portlet_GRN_SCH_PO_31'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-31' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_31 page='portal/personal/view' pid=$portlet.pid}
       {/if}
  </td>
 </tr>
</table>

</form>
