{if $url_params.system_display}
 {include file="grn/popup_system_head.tpl"}
{else}
 {include file="grn/popup_head.tpl"}
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
  if(form_name.indexOf("report/") != -1 )
  {
    var sname_ele = parent.document.forms[form_name].elements["CID_o[]"];
    if(sname_ele)
    {
        window.opener.AddOptions("{/literal}{$url_params.form_name|escape:"javascript"}{literal}", "CID_o[]", options);
    }
  }
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
  <form name="list" method="POST" action="{grn_pageurl page='grn/popup_user_select'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  {foreach from=$url_params item=param key=key}
  <input type="hidden" name="{$key}" value="{$param|escape}">
  {/foreach}
  <input type="hidden" name="select_func" value="{$select_func|escape}">
  <input type="hidden" name="selected_tab" value="{$selected_tab|escape}">
  <input type="hidden" name="s_oid" value="{$s_oid|escape}">
  <input type="hidden" name="org_id" value="{$org_id|escape}">
  <!-- tab start -->
  <div class="tab_menu">
 {if $selected_tab && $extension_items}
  {assign var='tab_status' value='off'}
 {else}
  {assign var='tab_status' value='on'}
 {/if}
   <div class="tab">
    <span class="tab_left_{$tab_status}"></span>
    <span class="tab_{$tab_status}">{capture name='grn_grn_GRN_GRN_200'}{cb_msg module='grn.grn' key='GRN_GRN-200' replace='true'}{/capture}{grn_link page=$page_info.all select_func='browse' selected_tab=0 s_oid=$s_oid params=$url_params caption=$smarty.capture.grn_grn_GRN_GRN_200}</span>
    <span class="tab_right_{$tab_status}"></span>
   </div>
 {if $extension_items}
  {if $selected_tab}
   {assign var='tab_status' value='on'}
  {else}
   {assign var='tab_status' value='off'}
  {/if}
   <div class="tab">
    <span class="tab_left_{$tab_status}"></span>
    <span class="tab_{$tab_status}">{grn_link page=$page_info.all select_func='browse' selected_tab=1 s_oid=$s_oid params=$url_params caption=$extension_items.caption}</span>
    <span class="tab_right_{$tab_status}"></span>
   </div>
 {/if}
  </div>
  <div class="tab_menu_end">&nbsp;</div>
  <div class="clear_both_1px">&nbsp;</div>
  <!-- tab end -->

 {if ! $selected_tab || ! $extension_items }{* ユーザー選択時 *}

  <table width="100%" style="border-collapse:collapse;" cellpadding="5" cellspacing="0">
  <tr valign="top">
  <!-- Tree -->
  {include file='grn/org_tree.tpl'}
  <td class="wrap-tree-view">
  <span class="tree-view-label">{cb_msg module='grn.grn' key='GRN_GRN-201' replace='true'}</span>
  <div id="tree_view" class="tree-view">
  {if $org_id}
  {capture name='grn_grn_GRN_GRN_202'}{cb_msg module='grn.grn' key='GRN_GRN-202' replace='true'}{/capture}{grn_link page='grn/popup_user_select' top=1 caption=$smarty.capture.grn_grn_GRN_GRN_202 select_func='browse' selected_tab=0 params=$url_params}
  {else}
  {capture name='grn_grn_GRN_GRN_203'}{cb_msg module='grn.grn' key='GRN_GRN-203' replace='true'}{/capture}{grn_link page='grn/popup_user_select' top=1 caption=$smarty.capture.grn_grn_GRN_GRN_203 class='tree-select-current' select_func='browse' selected_tab=0 params=$url_params}
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
    <input type="button" id="searchbutton" value="{cb_msg module='grn.grn' key='GRN_GRN-204' replace='true'}" onClick="search(this.form);"{if $selected_tab && $extension_items} disabled{/if}>
    </nobr>
    {include file="grn/popup_user_select_search_info.tpl"}
    </td>
    </tr>
    </table>
   </div>
   <!-- search end -->

   {if $s_oid == 0}
  <small style="margin-top:0.5em;">{cb_msg module='grn.grn' key='GRN_GRN-206' replace='true'}</small>
  <div class="bold" style="padding-bottom:2px;border-bottom:2px dashed #dddddd;margin-bottom:0.5em;">{grn_image image='organize20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-207' replace='true'}</div>
  <small style="margin-bottom:0.5em;">{cb_msg module='grn.grn' key='GRN_GRN-208' replace='true'}</small>
   {elseif $s_oid != -1}
  <small style="margin-top:0.5em;">{cb_msg module='grn.grn' key='GRN_GRN-209' replace='true'}</small>
  <div class="bold" style="padding-bottom:2px;border-bottom:2px dashed #dddddd;margin-bottom:0.5em;">{if $org_id==-2}{grn_image image='organize20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-210' replace='true'}{else}{grn_organize_name gid=$org_id}{/if}</div>
  <small style="margin-bottom:0.5em;">{cb_msg module='grn.grn' key='GRN_GRN-211' replace='true'}</small>
   {else}
  <small style="margin-top:0.5em;">{cb_msg module='grn.grn' key='GRN_GRN-212' replace='true'}</small>
  <div class="bold" style="padding-bottom:2px;border-bottom:2px dashed #dddddd;margin-bottom:0.5em;">{if $org_id==0}{grn_image image='organize20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-213' replace='true'}{elseif $org_id==-2}{grn_image image='organize20.gif'}{cb_msg module='grn.grn' key='GRN_GRN-214' replace='true'}{else}{grn_organize_name gid=$org_id}{/if}</div>
  <small style="margin-bottom:0.5em;">{cb_msg module='grn.grn' key='GRN_GRN-215' replace='true'}</small>
   {/if}
   {if $url_params.no_multiple}{** 単数選択の場合 **}
  <select id="s_id" name="s_id[]" size=12 style="width:100%">
     {foreach from=$candidate item=item}
      {if $item.type == 'group'}
  <option value="{$item.id}">[{$item.name|escape}]</option>
      {else}
  <option value="{$item.id}">{$item.name|escape}</option>
      {/if}
     {/foreach}
  </select>
   {else}{** 複数選択の場合 **}
  {if $url_params.multi_apply}{assign var=allselect value='selected'}{/if}
  <select id="c_id" name="c_id[]" size=10 style="width:100%" multiple>
     {foreach from=$candidate item=item}
      {if $item.type == 'group'}
  <option value="{$item.id}" {$allselect}>[{$item.name|escape}]</option>
      {else}
  <option value="{$item.id}" {$allselect}>{$item.name|escape}</option>
      {/if}
     {/foreach}
  </select>

  <div class="margin_vert">
  <input type="button" id="add" value="{cb_msg module='grn.grn' key='GRN_GRN-220' replace='true'}" onClick="this.form.select_func.value='add';">&nbsp;
  <input type="button" id="remove" value="{cb_msg module='grn.grn' key='GRN_GRN-221' replace='true'}" onClick="this.form.select_func.value='remove';">
  </div>

  <select id="s_id" name="s_id[]" size=10 style="width:100%" multiple>
     {foreach from=$selected item=item}
      {if $item.type == 'group'}
  <option value="{$item.id}">[{$item.name|escape}]</option>
      {else}
  <option value="{$item.id}">{$item.name|escape}</option>
      {/if}
     {/foreach}
  </select>
   {/if}
   {if ! $url_params.no_multiple}
  <div class="adjust_link">{cb_msg module='grn.grn' key='GRN_GRN-224' replace='true'}</div>
   {/if}
  {strip}
      <div class="mTop15 mBottom15">
          {if $url_params.form_name =='schedule/personal_day' ||
          $url_params.form_name =='schedule/personal_week' ||
          $url_params.form_name =='schedule/personal_month' }
              {capture name='grn_grn_app_name_225'}{$app_name}{cb_msg module='grn.grn' key='GRN_GRN-225' replace='true'}{/capture}
              {grn_button id='grn_popup_user_select_button_apply' ui='main' action='submit' spacing='normal' caption=$smarty.capture.grn_grn_app_name_225
              onclick="document.forms['list'].select_func.value='apply'; document.forms['list'].submit();"}
          {elseif $url_params.multi_apply}
              {capture name='grn_grn_226'}{cb_msg module='grn.grn' key='GRN_GRN-226' replace='true'}{/capture}
              {grn_button id='grn_popup_user_select_button_apply' ui='main' action='submit' spacing='normal' caption=$smarty.capture.grn_grn_226
              onclick="document.forms['list'].select_func.value='multi_apply'; document.forms['list'].submit();"}
          {else}
              {capture name='grn_grn_227'}{cb_msg module='grn.grn' key='GRN_GRN-227' replace='true'}{/capture}
              {grn_button id='grn_popup_user_select_button_apply' ui='main' action='submit' spacing='normal' caption=$smarty.capture.grn_grn_227
              onclick="document.forms['list'].select_func.value='apply'; document.forms['list'].submit();"}
          {/if}
          {capture name='grn_grn_228'}{cb_msg module='grn.grn' key='GRN_GRN-228' replace='true'}{/capture}
          {grn_button id='grn_popup_user_select_button_cancel' action='cancel' acption=$smarty.capture.grn_grn_228 onclick='window.close();'}
      </div>
  {/strip}

  </td>
  </tr>
  </table>

  <script language="JavaScript">
  <!--

  var treeName = 'org_tree';
  var asyncURL = '{grn_pageurl page='grn/popup_user_select_json'}';
  var pageName = '{$page_name|escape:"url"}';
  var linkURL = '{grn_pageurl page='grn/popup_user_select' select_func='browse' selected_tab=0 params=$url_params}';

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

      orgTree.createNode(root, -2, '{/literal}{cb_msg module='grn.grn' key='GRN_GRN-229' replace='true'}{literal}', 0);

      tree.draw();
  }

  YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));
  YAHOO.util.Event.addListener(window, "load", createExternalNodes());

  {/literal}
  //-->
  </script>

 {else}{* 追加アイテム選択時 *}

{if ! is_null( $extension_items.groups ) }
<table width="100%" style="border-collapse:collapse;" cellpadding="5" cellspacing="0">
 <tr valign="top">
  <td width="30%" style="height:300;border:6px solid #dddddd;">
  {foreach from=$extension_items.groups item=item_group}
    <div class="tree_item">
    {if $item_group.id == $url_params.item_group_id}
    {assign var=selected_group_title value=$item_group.title}
    <div class="bold">
    <span class="hilight">{grn_link page=$page_info.all caption=$item_group.title item_group_id=$item_group.id select_func='browse' selected_tab=$selected_tab params=$url_params}</span>
    </div>
    {else}
     {grn_link page=$page_info.all caption=$item_group.title item_group_id=$item_group.id select_func='browse' selected_tab=$selected_tab params=$url_params}
    {/if}
    </div>
  {/foreach}
  </td>
  <td id="view_part" width="70%">
{/if}
  <div class="margin_vert">
  {if ! is_null( $extension_items.groups ) }
  <small style="margin-top:0.5em;">{cb_msg module='grn.grn' key='GRN_GRN-230' replace='true'}{$extension_items.group_caption|escape}</small>
  <br>
  {if $extension_items.group_icon}{grn_image image=$extension_items.group_icon}{/if}
  <span class="bold">{$selected_group_title|escape}</span>
  {else}
  <span class="bold">{$extension_items.caption|escape}{cb_msg module='grn.grn' key='GRN_GRN-231' replace='true'}</span>
  {/if}
  </div>

   {if $url_params.no_multiple}{** 単数選択の場合 **}
  <select id="s_id" name="s_id[]" size=10 style="width:80%">
     {foreach from=$candidate item=item}
      {if $item.type == 'group'}
  <option value="{$item.id}">[{$item.name|escape}]</option>
      {else}
  <option value="{$item.id}">{$item.name|escape}</option>
      {/if}
     {/foreach}
  </select>
   {else}{** 複数選択の場合 **}
  <select id="c_id" name="c_id[]" size=10 style="width:80%" multiple>
     {foreach from=$candidate item=item}
      {if $item.type == 'group'}
  <option value="{$item.id}">[{$item.name|escape}]</option>
      {else}
  <option value="{$item.id}">{$item.name|escape}</option>
      {/if}
     {/foreach}
  </select>

  <div class="margin_vert">
  <input type="button" id="add" value="{cb_msg module='grn.grn' key='GRN_GRN-236' replace='true'}" onClick="this.form.select_func.value='add';">&nbsp;
  <input type="button" id="remove" value="{cb_msg module='grn.grn' key='GRN_GRN-237' replace='true'}" onClick="this.form.select_func.value='remove';">
  </div>

  <select id="s_id" name="s_id[]" size=10 style="width:80%" multiple>
     {foreach from=$selected item=item}
      {if $item.type == 'group'}
  <option value="{$item.id}">[{$item.name|escape}]</option>
      {else}
  <option value="{$item.id}">{$item.name|escape}</option>
      {/if}
     {/foreach}
  </select>
   {/if}
  {strip}
      <div class="mTop15 mBottom15">
      {if $url_params.form_name =='schedule/personal_day' ||
      $url_params.form_name =='schedule/personal_week' ||
      $url_params.form_name =='schedule/personal_month' }
          {capture name='grn_grn_app_name_240'}{$app_name}{cb_msg module='grn.grn' key='GRN_GRN-240' replace='true'}{/capture}
          {grn_button id='grn_popup_user_select_button_apply' ui='main' action='submit' spacing='normal' caption=$smarty.capture.grn_grn_app_name_240
          onclick="document.forms['list'].select_func.value='apply'; document.forms['list'].submit();"}
      {elseif $url_params.multi_apply}
          {capture name='grn_grn_241'}{cb_msg module='grn.grn' key='GRN_GRN-241' replace='true'}{/capture}
          {grn_button id='grn_popup_user_select_button_apply' ui='main' action='submit' spacing='normal' caption=$smarty.capture.grn_grn_241
          onclick="document.forms['list'].select_func.value='multi_apply'; document.forms['list'].submit();"}
      {else}
          {capture name='grn_grn_242'}{cb_msg module='grn.grn' key='GRN_GRN-242' replace='true'}{/capture}
          {grn_button id='grn_popup_user_select_button_apply' ui='main' action='submit' spacing='normal' caption=$smarty.capture.grn_grn_242
          onclick="document.forms['list'].select_func.value='apply'; document.forms['list'].submit();"}
      {/if}
      {capture name='grn_grn_243'}{cb_msg module='grn.grn' key='GRN_GRN-243' replace='true'}{/capture}
      {grn_button id='grn_popup_user_select_button_cancel' action='cancel' acption=$smarty.capture.grn_grn_243 onclick='window.close();'}
      </div>
  {/strip}
{if ! is_null( $extension_items.groups )}
  </td>
 </tr>
</table>
{/if}

 {/if}
<input type="hidden" name="selected_users_c_id" value="" />
<input type="hidden" name="selected_users_s_id" value="" />
  </form>
  </div>

{if ! $url_params.no_multiple}{** 複数選択の場合 **}
{literal}
<script type="text/javascript">

jQuery("#add").on("click", function(event){
    var form = document.forms["list"];
    PrepareSubmit(form, "c_id");
    unSelected(form, "s_id");
    form.submit();
});

jQuery("#remove").on("click", function(event){
    var form = document.forms["list"];
    PrepareSubmit(form, "s_id");
    unSelected(form, "c_id");
    form.submit();
});

function PrepareSubmit( form, sUID )
{
    if( typeof form.elements[sUID] == "undefined" ) return;
    var src = form.elements[sUID].options;
    var selected_users = form.elements['selected_users_' + sUID];
    selected_users.value = '';

    var udelim = '';
    for( i = 0 ; i < src.length ; i ++ )
    {
        var co = src[i];
        var co_value = co.value;
        if( ! co_value || ! co.selected || co_value.length <= 0) continue;

        // {Number}:g{Number} OR {Number} OR g{Number}
        if( co_value.match(/[0-9]+:g[0-9]+/) || isFinite( co_value ) || co_value.match(/g[0-9]+/) )
        {
            selected_users.value += udelim + co_value;
            udelim = ',';
        }
        co.selected = false;
    }
}
function unSelected(form, item_name)
{
    if( typeof form.elements[item_name] == "undefined" ) return;
    var src = form.elements[item_name].options;
    for( i = 0 ; i < src.length ; i ++ )
    {
        src[i].selected = false;
    }
}

</script>
{/literal}
{/if}
</div><!--body_end-->
{/if}
