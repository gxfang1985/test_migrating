{include file="grn/rewrite_category_options_wording.tpl"}
{grn_load_javascript file="grn/html/component/user_select/user_select.js"}
{grn_load_javascript file="grn/html/user_add.js"}
{grn_load_javascript file="grn/html/single_user_add.js"}
{literal}
<script language="JavaScript" type="text/javascript">
function PrepareSubmit( form )
{
    var selected_groups = form.elements['selected_groups_UID'];
    var selected_users = form.elements['selected_users_UID'];
    var selected = form.elements['UID'];
    if ( selected.value )
    {
        var co_value = selected.value.split(':');
        if ( co_value.length > 0 && isFinite( co_value[0] ) )
        {
            selected_users.value = co_value[0];
        }
        else if ( co_value.length > 0 && co_value[0].match(/g[0-9]+/) )
        {
            selected_groups.value = co_value[0].substr(1);
        }
        if ( co_value.length > 1 && isFinite( co_value[1] ) )
        {
            selected.value = co_value[0];
            selected_groups.value = co_value[1];
        }
    }
}
</script>
 {/literal}

<table border="0" cellspacing="0">
 <tr>
  <td valign="middle" style="padding-left:0">
   <table border="0" cellspacing="0" cellpadding="0">
    <tr>
     <td style="padding-left:0;">
      <input type="text" readonly name="member" value="{$selected_user.title}">
      <input type="hidden" name="UID" value="{$selected_user.id}">
      <input type="hidden" name="selected_groups_UID" value="">
      <input type="hidden" name="selected_users_UID" value="">
     </td>
    </tr>
   </table>
  </td>
  <td class="item_right_left">
   <br><br><br><input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-897' replace='true'}" onClick="EnterMember( this.form, 'CID[]', 'CID[]' )">

   <br><br><br><br><br><br><br><br><br><input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-898' replace='true'}" onClick="EnterMember( this.form, 'cITEM[]', 'cITEM[]', true )">

  </td>
  <td>
   <input type="text" name="keyword_CGID" size=22 maxlength="45" value="" onKeyPress="if(event.keyCode == 13) SearchCGID( this.form, '{grn_pageurl page='grn/user_add_search_users'}' ); return event.keyCode != 13;">
   <input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-899' replace='true'}" onClick="SearchCGID( this.form, '{grn_pageurl page='grn/user_add_search_users'}' );">
   <div class="margin_top">
{if $access_plugin}
 {capture name='grn_grn_GRN_GRN_900'}{cb_msg module='grn.grn' key='GRN_GRN-900' replace='true'}{/capture}{grn_popup_user_select_link caption=$smarty.capture.grn_grn_GRN_GRN_900 form_name=$form_name select_name=$sUID system=false system_display=false include_org=$include_org no_multiple=true access_plugin=$access_plugin plugin_session_name=$plugin_session_name plugin_data_name=$plugin_data_name}
{else}
 {capture name='grn_grn_GRN_GRN_901'}{cb_msg module='grn.grn' key='GRN_GRN-901' replace='true'}{/capture}{grn_popup_user_select_link caption=$smarty.capture.grn_grn_GRN_GRN_901 form_name=$form_name select_name=$sUID system=false system_display=false include_org=$include_org no_multiple=true}
{/if}
   </div>

<!-- category select -->
   <div class="margin_vert">
   <select id="CGID" name="CGID" onChange="ChangeCGID( this.form );" {if $category_option_disabled}disabled{/if}>
   {if $category_option_disabled} <option>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option> {/if}
{foreach from=$category_options item=option}
 {if $option.type == 1}
    <option value="{$option.value}">{$option.name|escape}{cb_msg module='grn.grn' key='GRN_GRN-902' replace='true'}{cb_msg module='grn.grn' key='GRN_GRN-903' replace='true'}</option>
 {elseif $option.type == 2}
    <option value="{$option.value}" selected>{$option.name|escape}{cb_msg module='grn.grn' key='GRN_GRN-904' replace='true'}</option>
 {elseif $option.type == 3}
    <option value="{$option.value}">{$option.name|escape}{cb_msg module='grn.grn' key='GRN_GRN-905' replace='true'}</option>
 {elseif $option.type == 4}
    <option value="{$option.value}">{cb_msg module="grn.common" key="title_frequent_group" name=$option.name}</option>
 {elseif $option.type == 5}
    <option value="{$option.value}">{cb_msg module='grn.grn' key='GRN_GRN-906' replace='true'}{cb_msg module="grn.common" key="title_frequent_users"}{cb_msg module='grn.grn' key='GRN_GRN-907' replace='true'}</option>
 {elseif $option.type == 6}
    <option value="{$option.value}">{cb_msg module="grn.common" key="title_oftenused_group" name=$option.name}</option>
 {/if}
{/foreach}
   </select>
   <iframe id="sub_CGID" name="sub_CGID" frameborder="no" scrolling="no" style="position:absolute; width:0em; height:0em;" src="{$app_path}/grn/html/space.html?{$build_date}">
   </iframe>
{literal}
<script language="JavaScript" type="text/javascript">
<!--
function ChangeCGID( form )
{
  var item_options = new Array();
{/literal}{foreach from=$item_options key=id item=options}{literal}
  item_options['{/literal}{$id}{literal}'] = new Array();
 {/literal}{foreach from=$options key=option_id item=option}{literal}
  item_options['{/literal}{$id}{literal}'][{/literal}{$option_id}{literal}] = new Option();
  item_options['{/literal}{$id}{literal}'][{/literal}{$option_id}{literal}].value = '{/literal}{$option.value}{literal}';
  {/literal}{if $option.type == 'user'}{literal}
  item_options['{/literal}{$id}{literal}'][{/literal}{$option_id}{literal}].text = '{/literal}{$option.name|escape:"javascript"}{literal}';
  {/literal}{elseif $option.type == 'group'}{literal}
  item_options['{/literal}{$id}{literal}'][{/literal}{$option_id}{literal}].text = '[{/literal}{$option.name|escape:"javascript"}{literal}]';
  {/literal}{/if}{literal}
 {/literal}{/foreach}{literal}
{/literal}{/foreach}{literal}
  var selected_category = form.elements['CGID'].value;
  RewriteItemOptionsWithoutSelectedAttribute( form.name, 'CID[]', item_options[selected_category] );

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
        "search_login_name_CGID": "0"
        {literal}
    };
    {/literal}{if $access_plugin}
    parameters["plugin_session_name_CGID"] = "{$plugin_session_name}";
    parameters["plugin_data_name_CGID"] = "{$plugin_data_name}";
    {/if}{literal}

    var target = "sub_CGID";
    searchByKeyword(target, url, parameters);
}
//-->
</script>
{/literal}
   </div>
<!-- category select -->

<!-- item select -->
   <div class="margin_vert">
   <select name="CID[]" size="8" class="select_multiple_display_grn" style="min-width:500px;">
{foreach from=$selected_item_options item=option}
 {if $option.type == 'user'}
    <option value="{$option.value}">{$option.name|escape}</option>
 {elseif $option.type == 'group'}
    <option value="{$option.value}">[{$option.name|escape}]</option>
 {/if}
{/foreach}
    <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
   </select>
   </div>
<!-- item select -->

<!-- userinfo list -->
   <div class="margin_vert">
 {capture name='grn_grn_GRN_GRN_909'}{cb_msg module='grn.grn' key='GRN_GRN-909' replace='true'}{/capture}{grn_popup_user_list_link caption=$smarty.capture.grn_grn_GRN_GRN_909 form_name=$form_name system_display=false}
   </div>
<!-- userinfo list -->

<!-- facility list -->

<input type="text" id="facility_search_text" value="" maxlength="45" size="22" onkeypress="if(event.keyCode == 13)searchFacility( '{$page_name}' ); "/>
<input type="button" onclick="searchFacility( '{$page_name}' );" value="{cb_msg module='grn.grn' key='GRN_GRN-910' replace='true'}"/>

{include file="schedule/_item_add_dropdown_part.tpl" prefer_fg_button=1}
{* {include file="schedule/_select_group.tpl"} *}

  <div class="margin_top">
  <iframe id="spinner_iframe" src="{$app_path}/grn/html/space.html?{$build_date}" frameborder="no" style="width:16; height:16; position:absolute; margin:3px 0 0 3px; z-index:2; display:none;"></iframe>

      <select id='facility-item' name="cITEM[]" size="5" class="select_multiple_display_grn" style="min-width:500px;">
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
              <td nowrap="">{cb_msg module='grn.grn' key='GRN_GRN-911' replace='true'}</td>
              <td> <span style="" id="selected-path"></span> </td> </tr>
       </tbody>
 </table>
<div class="margin_top">
{capture name='grn_grn_GRN_GRN_912'}{cb_msg module='grn.grn' key='GRN_GRN-912' replace='true'}{/capture}{grn_popup_facility_list_link caption=$smarty.capture.grn_grn_GRN_GRN_912 form_name=$form_name var_CID='cITEM[]' system_display=false duplication=$duplication}
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
        grnUrl: "schedule/json/accessible_facility",
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
        grnUrl: "schedule/json/search_facility",
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
        YAHOO.global.updateTitle('{/literal}{cb_msg module='grn.schedule' key='GRN_SCH-807' replace='true'}{literal}');
    });
    YAHOO.global.dropdown.facility.insertNode(
        {"oid":"s", "name":'{/literal}{cb_msg module='grn.schedule' key='GRN_SCH-807' replace='true'}{literal}', 'is_selected': true, 'extra_param':'1', 'count':0, 'children':[] } );
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
            parent_path_node.innerHTML = '{/literal}{cb_msg module='grn.grn' key='GRN_GRN-914' replace='true'}{literal}';
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
