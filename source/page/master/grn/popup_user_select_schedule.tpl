{if $url_params.system_display}
 {include file="grn/popup_system_head.tpl"}
{else}
 {include file="grn/popup_head.tpl"}
{/if}

{if ! $selected_tab}
{capture name='grn_grn_GRN_GRN_1084'}{cb_msg module='grn.grn' key='GRN_GRN-1084' replace='true'}{/capture}{assign var='organization_name' value=$smarty.capture.grn_grn_GRN_GRN_1084}
{capture name='grn_grn_GRN_GRN_1085'}{cb_msg module='grn.grn' key='GRN_GRN-1085' replace='true'}{/capture}{assign var='user_name' value=$smarty.capture.grn_grn_GRN_GRN_1085}
{else}
{capture name='grn_grn_GRN_GRN_1086'}{cb_msg module='grn.grn' key='GRN_GRN-1086' replace='true'}{/capture}{assign var='organization_name' value=$smarty.capture.grn_grn_GRN_GRN_1086}
{capture name='grn_grn_GRN_GRN_1087'}{cb_msg module='grn.grn' key='GRN_GRN-1087' replace='true'}{/capture}{assign var='user_name' value=$smarty.capture.grn_grn_GRN_GRN_1087}
{/if}

{if $select_func == 'multi_apply'}
{grn_load_javascript file="grn/html/component/url.js"}
{literal}
<script language="JavaScript" type="text/javascript">
<!--

function __grn_create_apply_url( parent_opener )
{
    {/literal}
    {if $url_params.return_page}
    var url = '{grn_pageurl page=$url_params.return_page|escape:"javascript"}';
    {else}
    var url = parent_opener.location.href;
    {/if}
    {literal}
    var selected_param = '?gid=selected';
    {/literal}{if $url_params.app_id == 'schedule'}{literal}
    var date_str = '';
    {/literal}{if $url_params.plid}{literal}
    if ( parent_opener.document.forms['personal_day{/literal}{$url_params.plid|escape:"javascript"}{literal}'].bdate )
    {
        date_str = parent_opener.document.forms['personal_day{/literal}{$url_params.plid|escape:"javascript"}{literal}'].bdate.value;
    }
    else
    {
        var param_elements = parent_opener.document.getElementsByName( 'bdate' );
        for( var i = 0; i < param_elements.length; i++ )
        {
            if (param_elements[i].getAttribute('value'))
            {
                date_str = param_elements[i].getAttribute('value');
                break;
            }
        }
    }
    {/literal}{else}{literal}
    var param_elements = parent_opener.document.getElementsByName( 'bdate' );
    for( var i = 0; i < param_elements.length; i++ )
    {
        if (param_elements[i].getAttribute('value'))
        {
            date_str = param_elements[i].getAttribute('value');
            break;
        }
    }
    {/literal}{/if}{literal}
    selected_param = selected_param + 'event=selected';
    {/literal}{/if}{literal}
    var url_array = url.split('?');
    if ( url_array.length < 2 )
    {
        var sharp_array = url.split('#');
        if ( sharp_array.length < 2 )
        {
            return url + selected_param;
        }
        else
        {
            return sharp_array[0] + selected_param;
        }
    }

    var url_params = grn.component.url.parseQueryString(url);
    url_params['gid'] = 'selected';
    {/literal}{if $url_params.app_id == 'schedule'}{literal}
    url_params['event'] = 'selected';
    if ( date_str && date_str != '' )
    {
        url_params['bdate'] = date_str;
    }
    delete url_params['sp'];
    {/literal}{/if}{literal}
    return url_array[0] + '?' + jQuery.param(url_params);
}

{/literal}
{if $selected_count > 0}
{literal}
var parent_opener = window.parent.opener;
parent_opener.location.href = __grn_create_apply_url( parent_opener );
{/literal}
{/if}
{literal}
window.close();

//-->
</script>
{/literal}

{elseif $select_func == 'apply' && $url_params.send_cgi_parameter && $item}
 {literal}
<script language="JavaScript" type="text/javascript">
<!--
var uid = "{/literal}{$item.value}{literal}";
var wpo = window.parent.opener;
var ls = wpo.location.search;
var lss = ls.split("&");
var lssl = lss.length;

var date_str = '';
{/literal}
{if $url_params.app_id == 'schedule'}
{literal}
var param_elements = wpo.document.getElementsByName('bdate');
for( var i = 0; i < param_elements.length; i++ )
{
    if (param_elements[i].getAttribute('value'))
    {
        date_str = param_elements[i].getAttribute('value');
        break;
    }
}
{/literal}
{/if}
{literal}

var eye = "";
if (ls)
{
    var delim = "";
    for( i = 0 ; i < lssl ; i ++ )
    {
        var lssli = lss[i];
        if ( !lssli.match(/^uid=/) && !lssli.match(/^gid=/) )
        {
            if ( date_str != '' && lssli.match(/^bdate=/) )
            {
                eye+= delim + 'bdate=' + date_str;
            }
            else
            {
                eye += delim + lssli;
                delim = "&";
            }
        }
    }
    eye += delim + "uid=" + uid;
}
else
{
    eye = "?uid=" + uid;
    if ( date_str != '' )
    {
        eye += '&bdate=' + date_str;
    }
}

wpo.location.href = wpo.location.pathname + eye;
window.close();
//-->
</script>
 {/literal}
{elseif $select_func == 'apply' && $url_params.no_multiple && $item}
 {literal}
<script language="JavaScript" type="text/javascript">
<!--
 {/literal}{if $item.type == 'group'}{literal}
var text = "[{/literal}{$item.name|escape:"javascript"}{literal}]";
 {/literal}{else}{literal}
var text = "{/literal}{$item.name|escape:"javascript"}{literal}";
 {/literal}{/if}{literal}
var id = "{/literal}{$item.value|escape:"javascript"}{literal}";
window.opener.setItem("{/literal}{$url_params.form_name|escape:"javascript"}{literal}", id, text);
window.close();
//-->
</script>
 {/literal}
{elseif $select_func == 'apply' && $url_params.no_multiple}
 {literal}
<script language="JavaScript" type="text/javascript">
<!--
window.close();
//-->
</script>
 {/literal}
{elseif $select_func == 'apply'}
 {literal}
<script language="JavaScript" type="text/javascript">
<!--
var options = new Array();
 {/literal}{foreach from=$apply_result item=option key=key}{literal}
options[{/literal}{$key}{literal}] = new Option();
  {/literal}{if $option.type == 'group'}{literal}
options[{/literal}{$key}{literal}].text = "[{/literal}{$option.name|escape:"javascript"}{literal}]";
  {/literal}{else}{literal}
options[{/literal}{$key}{literal}].text = "{/literal}{$option.name|escape:"javascript"}{literal}";
  {/literal}{/if}{literal}
options[{/literal}{$key}{literal}].value = "{/literal}{$option.value|escape:"javascript"}{literal}";
options[{/literal}{$key}{literal}].selected = true;
 {/literal}{/foreach}{literal}
var parent = window.opener;
var form_name = '{/literal}{$url_params.form_name|escape:"javascript"}{literal}';
var options_name = '{/literal}{$url_params.select_name|escape:"javascript"}{literal}';
if(parent.CheckOptions(form_name, options_name, '0'))
{
    parent.ClearOptions(form_name, options_name);
}
if ("{/literal}{$url_params.select_name|escape:"javascript"}{literal}" == "CID[]")
{
  window.opener.RewriteItemOptions("{/literal}{$url_params.form_name|escape:"javascript"}{literal}", "{/literal}{$url_params.select_name|escape:"javascript"}{literal}", options);
  window.opener.RewriteCategoryOptions("{/literal}{$url_params.form_name|escape:"javascript"}{literal}", "CGID", 'popup_user_select');
}
else
{
  window.opener.AddOptions("{/literal}{$url_params.form_name|escape:"javascript"}{literal}", "{/literal}{$url_params.select_name|escape:"javascript"}{literal}", options);
}
window.close();
//-->
</script>
 {/literal}
{else}
 {literal}
<script language="JavaScript" type="text/javascript">
<!--
function search(form)
{
  form.select_func.value='browse';
  form.s_oid.value=-1;
  form.submit();
}
//-->
</script>
 {/literal}
  {include file="grn/popup_header.tpl"}
  <div class="popup_content_base_grn">
  <form name="list" method="POST" action="{grn_pageurl page='grn/popup_user_select_schedule'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  {foreach from=$url_params item=param key=key}
  <input type="hidden" name="{$key}" value="{$param|escape}">
  {/foreach}
  <input type="hidden" name="select_func" value="{$select_func|escape}">
  <input type="hidden" name="selected_tab" value="{$selected_tab|escape}">
  <input type="hidden" name="s_oid" value="{$s_oid|escape}">
  <input type="hidden" name="org_id" value="{$org_id|escape}">
  <!-- tab start -->
  <div class="tab_menu">
 {if $selected_tab == 0}
  {assign var='tab_status' value='on'}
 {else}
  {assign var='tab_status' value='off'}
 {/if}
   <div class="tab">
    <span class="tab_left_{$tab_status}"></span>
    <span class="tab_{$tab_status}">{capture name='grn_grn_GRN_GRN_1088'}{cb_msg module='grn.grn' key='GRN_GRN-1088' replace='true'}{/capture}{grn_link page=$page_info.all select_func='browse' selected_tab=0 params=$url_params caption=$smarty.capture.grn_grn_GRN_GRN_1088}</span>
    <span class="tab_right_{$tab_status}"></span>
   </div>
 {if $facility_tab}
  {if $selected_tab}
   {assign var='tab_status' value='on'}
  {else}
   {assign var='tab_status' value='off'}
  {/if}
   <div class="tab">
    <span class="tab_left_{$tab_status}"></span>
    <span class="tab_{$tab_status}">{capture name='grn_grn_GRN_GRN_1089'}{cb_msg module='grn.grn' key='GRN_GRN-1089' replace='true'}{/capture}{grn_link page=$page_info.all select_func='browse' selected_tab=1 params=$url_params caption=$smarty.capture.grn_grn_GRN_GRN_1089}</span>
    <span class="tab_right_{$tab_status}"></span>
   </div>
 {/if}
  </div>
  <div class="tab_menu_end">&nbsp;</div>
  <div class="clear_both_1px">&nbsp;</div>
  <!-- tab end -->

  <table width="100%" style="border-collapse:collapse;" cellpadding="5" cellspacing="0">
  <tr valign="top">
  <!-- Tree -->
  {include file='grn/org_tree.tpl'}
  <td class="wrap-tree-view">

  <span class="tree-view-label">{cb_msg module='grn.grn' key='GRN_GRN-1505' replace='true'}{$organization_name}{cb_msg module='grn.grn' key='GRN_GRN-1506' replace='true'}</span>

  <div id="tree_view" class="tree-view">
  {if $org_id}
  {capture name='grn_grn_GRN_GRN_1091'}{cb_msg module='grn.grn' key='GRN_GRN-1091' replace='true'}{/capture}{grn_link page='grn/popup_user_select_schedule' top=1 caption=$smarty.capture.grn_grn_GRN_GRN_1091 select_func='browse' selected_tab=$selected_tab params=$url_params}
  {else}
  {capture name='grn_grn_GRN_GRN_1092'}{cb_msg module='grn.grn' key='GRN_GRN-1092' replace='true'}{/capture}{grn_link page='grn/popup_user_select_schedule' top=1 caption=$smarty.capture.grn_grn_GRN_GRN_1092 class='tree-select-current' select_func='browse' selected_tab=$selected_tab params=$url_params}
  {/if}
    <div id="org_tree"></div>
  </div>

  </td>
  <!-- End Tree -->

  <td id="tree_view_right" class="wrap-tree-view-right" width="70%">

   <!-- search start -->
   <div class="popup_content_search_grn">
    <table>
    <tr>
    <td>
    <nobr>
    <input type="text" name="searchword" size=22 maxlength="45" value="{if $s_oid==-1}{$url_params.searchword|escape}{/if}" onKeyPress="if (event.keyCode == 13) search(this.form);">
    <input type="button" id="searchbutton" value="{$user_name}{cb_msg module='grn.grn' key='GRN_GRN-1093' replace='true'}" onClick="search(this.form);">
    </nobr>
    {include file="grn/popup_user_select_search_info.tpl"}
    </td>
    </tr>
    </table>
   </div>
   <!-- search end -->

   {if ! $selected_tab}
   {if $s_oid == 0}
  <small style="margin-top:0.5em;">{cb_msg module='grn.grn' key='GRN_GRN-1096' replace='true'}{$organization_name}</small>
  <div class="bold" style="padding-bottom:2px;border-bottom:2px dashed #dddddd;margin-bottom:0.5em;">{grn_image image='organize20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-1097' replace='true'}</div>
  <small style="margin-bottom:0.5em;">{cb_msg module='grn.grn' key='GRN_GRN-1098' replace='true'}{$user_name}</small>
   {elseif $s_oid != -1}
  <small style="margin-top:0.5em;">{cb_msg module='grn.grn' key='GRN_GRN-1099' replace='true'}{$organization_name}</small>
  <div class="bold" style="padding-bottom:2px;border-bottom:2px dashed #dddddd;margin-bottom:0.5em;">{if $org_id==-2}{grn_image image='organize20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-1136' replace='true'}{else}{grn_organize_name gid=$org_id}{/if}</div>
  <small style="margin-bottom:0.5em;">{cb_msg module='grn.grn' key='GRN_GRN-1102' replace='true'}{$user_name}</small>
   {else}
  <small style="margin-top:0.5em;">{cb_msg module='grn.grn' key='GRN_GRN-1103' replace='true'}{$organization_name}</small>
  <div class="bold" style="padding-bottom:2px;border-bottom:2px dashed #dddddd;margin-bottom:0.5em;">{if $org_id==0}{grn_image image='organize20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-1104' replace='true'}{elseif $org_id==-2}{grn_image image='organize20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-1136' replace='true'}{else}{grn_organize_name gid=$org_id}{/if}</div>
  <small style="margin-bottom:0.5em;">{cb_msg module='grn.grn' key='GRN_GRN-1108' replace='true'}</small>
   {/if}
  {else}
   {if ! isset( $s_oid ) || $s_oid == 0}
  <small style="margin-top:0.5em;">{cb_msg module='grn.grn' key='GRN_GRN-1109' replace='true'}{$organization_name}</small>
  <div class="bold" style="padding-bottom:2px;border-bottom:2px dashed #dddddd;margin-bottom:0.5em;">{grn_image image='facilitygroup20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-1110' replace='true'}</div>
  <small style="margin-bottom:0.5em;">{cb_msg module='grn.grn' key='GRN_GRN-1111' replace='true'}{$user_name}</small>
   {elseif $s_oid > 0}
  <small style="margin-top:0.5em;">{cb_msg module='grn.grn' key='GRN_GRN-1112' replace='true'}{$organization_name}</small>
  <div class="bold" style="padding-bottom:2px;border-bottom:2px dashed #dddddd;margin-bottom:0.5em;">{grn_image image='facilitygroup20.gif'}{$facility_group_name}</div>
  <small style="margin-bottom:0.5em;">{cb_msg module='grn.grn' key='GRN_GRN-1113' replace='true'}{$user_name}</small>
   {elseif $s_oid == -3}
<small style="margin-top:0.5em;">{cb_msg module='grn.grn' key='GRN_GRN-1114' replace='true'}{$organization_name}</small>
<div class="bold" style="padding-bottom:2px;border-bottom:2px dashed #dddddd;margin-bottom:0.5em;">{grn_image image='facilitygroup20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-1115' replace='true'}</div>
   {elseif $s_oid == -2}
  <small style="margin-top:0.5em;">{cb_msg module='grn.grn' key='GRN_GRN-1116' replace='true'}{$organization_name}</small>
<div class="bold" style="padding-bottom:2px;border-bottom:2px dashed #dddddd;margin-bottom:0.5em;">{grn_image image='facilitygroup20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-1137' replace='true'}</div>
   {elseif $s_oid == -1}
  <small style="margin-top:0.5em;">{cb_msg module='grn.grn' key='GRN_GRN-1118' replace='true'}{$organization_name}</small>
  <div class="bold" style="padding-bottom:2px;border-bottom:2px dashed #dddddd;margin-bottom:0.5em;">
{grn_image image='facilitygroup20.gif'}{if $org_id==0}{cb_msg module='grn.grn' key='GRN_GRN-1119' replace='true'}
{elseif $org_id==-2}{cb_msg module='grn.grn' key='GRN_GRN-1137' replace='true'}
{elseif $org_id==-3}{cb_msg module='grn.grn' key='GRN_GRN-1121' replace='true'}
{else}{$facility_group_name}{/if}
</div>
  <small style="margin-bottom:0.5em;">{cb_msg module='grn.grn' key='GRN_GRN-1122' replace='true'}</small>
   {/if}

  {/if}

   {if $url_params.no_multiple}{** 単数選択の場合 **}
  <select name="s_id[]" class="select_multiple_display_grn" size=12 style="width:100%">
     {foreach from=$candidate item=item}
      {if $item.type == 'group'}
  <option value="{$item.id}">[{$item.name|escape}]</option>
      {elseif $item.group_name}
  <option value="{$item.id}">{$item.name|escape}{cb_msg module='grn.grn' key='GRN_GRN-1123' replace='true'}{$item.group_name|escape}{cb_msg module='grn.grn' key='GRN_GRN-1124' replace='true'}</option>
      {else}
  <option value="{$item.id}">{$item.name|escape}</option>
      {/if}
     {/foreach}
  </select>
   {else}{** 複数選択の場合 **}
  {if $url_params.multi_apply}{assign var=allselect value='selected'}{/if}
  <select name="c_id[]" size=10 style="width:100%" multiple>
     {foreach from=$candidate item=item}
      {if $item.type == 'group'}
  <option value="{$item.id}" {$allselect}>[{$item.name|escape}]</option>
      {elseif $item.group_name}
  <option value="{$item.id}" {$allselect}>{$item.name|escape}{cb_msg module='grn.grn' key='GRN_GRN-1125' replace='true'}{$item.group_name|escape}{cb_msg module='grn.grn' key='GRN_GRN-1126' replace='true'}</option>
      {else}
  <option value="{$item.id}" {$allselect}>{$item.name|escape}</option>
      {/if}
     {/foreach}
  </select>

  <div class="margin_vert">
  <input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-1127' replace='true'}" onClick="this.form.select_func.value='add';this.form.submit();">&nbsp;
  <input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-1128' replace='true'}" onClick="this.form.select_func.value='remove';this.form.submit();">
  </div>

  <select name="s_id[]" size=10 style="width:100%" multiple>
     {foreach from=$selected item=item}
      {if $item.type == 'group'}
  <option value="{$item.id}">[{$item.name|escape}]</option>
      {elseif $item.group_name}
  <option value="{$item.id}">{$item.name|escape}{cb_msg module='grn.grn' key='GRN_GRN-1129' replace='true'}{$item.group_name|escape}{cb_msg module='grn.grn' key='GRN_GRN-1130' replace='true'}</option>
      {else}
  <option value="{$item.id}">{$item.name|escape}</option>
      {/if}
     {/foreach}
  </select>
   {/if}
   {if ! $url_params.no_multiple}
  <div class="adjust_link">{cb_msg module='grn.grn' key='GRN_GRN-1131' replace='true'}</div>
   {/if}
  <p>
   {if $url_params.form_name =='schedule/personal_day' ||
    $url_params.form_name =='schedule/personal_week' ||
    $url_params.form_name =='schedule/personal_month' }
   <input type=button value="{cb_msg module='grn.grn' key='GRN_GRN-1132-2' replace='true'}{$app_name}{cb_msg module='grn.grn' key='GRN_GRN-1132' replace='true'}" onClick="this.form.select_func.value='apply';this.form.submit()">
   {elseif $url_params.multi_apply}
   <input type=button value="{cb_msg module='grn.grn' key='GRN_GRN-1133' replace='true'}" onClick="this.form.select_func.value='multi_apply';this.form.submit()">
   {else}
   <input type=button value="{cb_msg module='grn.grn' key='GRN_GRN-1134' replace='true'}" onClick="this.form.select_func.value='apply';this.form.submit()">
   {/if}
   <input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-1135' replace='true'}" onClick="window.close();">
  </p>

  </td>
  </tr>
  </table>

  <script language="JavaScript">
  <!--

  var treeName = 'org_tree';
  var asyncURL = '{grn_pageurl page='grn/popup_user_select_json'}';
  var pageName = '{$page_name|escape:"url"}';
  var linkURL = '{grn_pageurl page='grn/popup_user_select_schedule' select_func='browse' selected_tab=$selected_tab params=$url_params}';

  {if $org_id}
  var selectedOID = '{$org_id|escape:javascript}';
  {else}
  var selectedOID = 0;
  {/if}

  var orgTree = new YAHOO.grn.orgTree(treeName, asyncURL, pageName, linkURL, selectedOID);
  orgTree.setOidKey( 's_oid');
  var treeData = {include org=$org file='grn/org_json.tpl'};

  setTreeHeight('tree_view', 'tree_view_right');

  {literal}

  function createExternalNodes() {
      var tree = orgTree.getTree();
      var root = tree.getRoot();
{/literal}
{if ! $selected_tab}
      orgTree.createNode(root, -2, '{cb_msg module='grn.grn' key='GRN_GRN-1136' replace='true'}', 0);
{else}
      orgTree.createNode(root, -2, '{cb_msg module='grn.grn' key='GRN_GRN-1137' replace='true'}', 0);
{if $allow_all_facility}
      orgTree.createNode(root, -3, '{cb_msg module='grn.grn' key='GRN_GRN-1138' replace='true'}', 0);
{/if}
{/if}
{literal}
      tree.draw();
  }

  YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));
  YAHOO.util.Event.addListener(window, "load", createExternalNodes());

  {/literal}
  //-->
  </script>
  </form>
  </div>

</div><!--body_end-->
{/if}
