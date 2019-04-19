{if $url_params.system_display}
 {include file="grn/popup_system_head.tpl"}
{else}
 {include file="grn/popup_head.tpl"}
{/if}
{if $select_func == 'apply' && $url_params.send_cgi_parameter && $item}
 {literal}
<script language="JavaScript" type="text/javascript">
<!--
var uid = "{/literal}{$item.value}{literal}";
var wpo = window.parent.opener;
var ls = wpo.location.search;
var lss = ls.split("&");
var lssl = lss.length;

var eye = "";
if (ls)
{
    var delim = "";
    for( i = 0 ; i < lssl ; i ++ )
    {
        var lssli = lss[i];
        if ( !lssli.match(/^uid=/) && !lssli.match(/^gid=/) )
        {
            eye += delim + lssli;
            delim = "&";
        }
    }
    eye += delim + "uid=" + uid;
}
else
{
    eye = "?uid=" + uid;
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
options[{/literal}{$key}{literal}].text = "{/literal}{$option.name|escape:"javascript"} {$option.email|escape:"javascript"}{literal}";
  {/literal}{/if}{literal}
options[{/literal}{$key}{literal}].value = "{/literal}user:{$option.value|escape:"javascript"}{literal}";
options[{/literal}{$key}{literal}].selected = true;
 {/literal}{/foreach}{literal}
var parent = window.opener;
var form_name = '{/literal}{$url_params.form_name|escape:"javascript"}{literal}';
var options_name = '{/literal}{$url_params.select_name|escape:"javascript"}{literal}';
if(parent.CheckOptions(form_name, options_name, '0'))
{
    parent.ClearOptions(form_name, options_name);
}

window.opener.AddOptions("{/literal}{$url_params.form_name|escape:"javascript"}{literal}", "{/literal}{$url_params.select_name|escape:"javascript"}{literal}", options);

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
  form.search_org_id.value = form.s_oid.value;
  if(form.search_org_id.value==-2)
  { 
    form.search_org_id.value=-1;
  }
  form.s_oid.value=-1;
  form.submit();
}
//-->
</script>
 {/literal}
  {include file="grn/popup_header.tpl"}
  <div class="popup_content_base_grn">
  <form name="list" method="POST" action="{grn_pageurl page='address/popup_user_email_select'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  {foreach from=$url_params item=param key=key}
  <input type="hidden" name="{$key}" value="{$param|escape}">
  {/foreach}
  <input type="hidden" name="select_func" value="{$select_func|escape}">
  <input type="hidden" name="selected_tab" value="{$seleted_tab|escape}">
  <input type="hidden" name="s_oid" value="{$s_oid|escape}">

 {if ! $selected_tab || ! $extension_items }{* ユーザー選択時 *}

  <table width="100%" style="border-collapse:collapse;" cellpadding="5" cellspacing="0">
  <tr valign="top">
  <!-- Tree -->
  {include file='grn/org_tree.tpl'}
  <td class="wrap-tree-view">
  <div id="tree_view" class="tree-view">
  {if $org_id }
    {if $org_id == -1 && $search_org_id == ''}
        {capture name='grn_address_GRN_ADDR_172'}{cb_msg module='grn.address' key='GRN_ADDR-172' replace='true'}{/capture}{grn_link page='address/popup_user_email_select' top=1 caption=$smarty.capture.grn_address_GRN_ADDR_172 class='tree-select-current' select_func='browse' selected_tab=0 params=$url_params}
    {else}
        {capture name='grn_address_GRN_ADDR_173'}{cb_msg module='grn.address' key='GRN_ADDR-173' replace='true'}{/capture}{grn_link page='address/popup_user_email_select' top=1 caption=$smarty.capture.grn_address_GRN_ADDR_173 select_func='browse' selected_tab=0 params=$url_params}
    {/if}
  
  {else}
  {capture name='grn_address_GRN_ADDR_174'}{cb_msg module='grn.address' key='GRN_ADDR-174' replace='true'}{/capture}{grn_link page='address/popup_user_email_select' top=1 caption=$smarty.capture.grn_address_GRN_ADDR_174 class='tree-select-current' select_func='browse' selected_tab=0 params=$url_params}
  {/if}
    <div id="org_tree"></div>
  </div>
  
  </td>
  <!-- Tree emd-->

  <td id="tree_view_right" class="wrap-tree-view-right" width="70%">

   <!-- search start -->
   <div class="popup_content_search_grn">
    <table>
    <tr>
    <td nowrap>
    <input type="hidden" name="search_org_id" value="{$search_org_id}">
    <input type="text" name="searchword" size=22 maxlength="45" value="{if $search_org_id}{$url_params.searchword|escape}{/if}" onKeyPress="if (event.keyCode == 13) search(this.form);">
    <input type="button" value="{cb_msg module='grn.address' key='GRN_ADDR-175' replace='true'}" onClick="search(this.form);"{if $selected_tab && $extension_items} disabled{/if}>
    </td>
    </tr>
    </table>
   </div>
   <!-- search end -->

  <small style="margin-bottom:0.5em;">{cb_msg module='grn.address' key='GRN_ADDR-176' replace='true'}</small>

   {if $url_params.no_multiple}{** 単数選択の場合 **}
  <select name="s_id[]" size=12 style="width:100%">
     {foreach from=$candidate item=item}
      {if $item.type == 'group'}
  <option value="{$item.id}">[{$item.name|escape}]</option>
      {else}
  <option value="{$item.id}">{$item.name|escape} {$item.email|escape}</option>
      {/if}
     {/foreach}
  </select>
   {else}{** 複数選択の場合 **}
  <select name="c_id[]" size=10 style="width:100%" multiple>
     {foreach from=$candidate item=item}
      {if $item.type == 'group'}
  <option value="{$item.id}">[{$item.name|escape}]</option>
      {else}
  <option value="{$item.id}">{$item.name|escape} {$item.email|escape}</option>
      {/if}
     {/foreach}
  </select>

  <div class="margin_vert">
  <input type="button" value="{cb_msg module='grn.address' key='GRN_ADDR-177' replace='true'}" onClick="this.form.select_func.value='add';this.form.submit();">&nbsp; 
  <input type="button" value="{cb_msg module='grn.address' key='GRN_ADDR-178' replace='true'}" onClick="this.form.select_func.value='remove';this.form.submit();">
  </div>

  <select name="s_id[]" size=10 style="width:100%" multiple>
     {foreach from=$selected item=item}
      {if $item.type == 'group'}
  <option value="{$item.id}">[{$item.name|escape}]</option>
      {else}
  <option value="{$item.id}">{$item.name|escape} {$item.email|escape}</option>
      {/if}
     {/foreach}
  </select>
   {/if}
   {if ! $url_params.no_multiple}
  <div class="adjust_link">{cb_msg module='grn.address' key='GRN_ADDR-179' replace='true'}</div>
   {/if}
  {strip}
      <div class="mTop15 mBottom15">
          {capture name='grn_address_GRN_ADDR_180'}{cb_msg module='grn.address' key='GRN_ADDR-180' replace='true'}{/capture}
          {grn_button id='address_book_button_apply' ui='main' auto_disable=true spacing='normal' caption=$smarty.capture.grn_address_GRN_ADDR_180
          onclick="document.forms['list'].select_func.value='apply'; document.forms['list'].submit();"}
          {grn_button id='address_book_button_cancel' action='cancel' onclick="window.close();"}
      </div>
  {/strip}

  </td>
  </tr>
  </table>

 {else}{* 追加アイテム選択時 *}

  <div class="margin_vert">
  <span class="bold">{$extension_items.caption|escape}{cb_msg module='grn.address' key='GRN_ADDR-182' replace='true'}</span>
  </div>

   {if $url_params.no_multiple}{** 単数選択の場合 **}
  <select name="s_id[]" size=10 style="width:80%">
     {foreach from=$candidate item=item}
      {if $item.type == 'group'}
  <option value="{$item.id}">[{$item.name|escape}]</option>
      {else}
  <option value="{$item.id}">{$item.name|escape} {$item.email|escape}</option>
      {/if}
     {/foreach}
  </select>
   {else}{** 複数選択の場合 **}
  <select name="c_id[]" size=10 style="width:80%" multiple>
     {foreach from=$candidate item=item}
      {if $item.type == 'group'}
  <option value="{$item.id}">[{$item.name|escape}]</option>
      {else}
  <option value="{$item.id}">{$item.name|escape} {$item.email|escape}</option>
      {/if}
     {/foreach}
  </select>

  <div class="margin_vert">
  <input type="button" value="{cb_msg module='grn.address' key='GRN_ADDR-183' replace='true'}" onClick="this.form.select_func.value='add';this.form.submit();">&nbsp; 
  <input type="button" value="{cb_msg module='grn.address' key='GRN_ADDR-184' replace='true'}" onClick="this.form.select_func.value='remove';this.form.submit();">
  </div>

  <select name="s_id[]" size=10 style="width:80%" multiple>
     {foreach from=$selected item=item}
      {if $item.type == 'group'}
  <option value="{$item.id}">[{$item.name|escape}]</option>
      {else}
  <option value="{$item.id}">{$item.name|escape} {$item.email|escape}</option>
      {/if}
     {/foreach}
  </select>
   {/if}
 {strip}
     <div class="mTop15 mBottom15">
         {capture name='grn_address_GRN_ADDR_185'}{cb_msg module='grn.address' key='GRN_ADDR-185' replace='true'}{/capture}
         {grn_button id='address_book_button_apply' ui='main' auto_disable=true spacing='normal' caption=$smarty.capture.grn_address_GRN_ADDR_185
         onclick="document.forms['list'].select_func.value='apply'; document.forms['list'].submit();"}
         {grn_button id='address_book_button_cancel' action='cancel' onclick="window.close();"}
     </div>
 {/strip}

 {/if}
  </form>
  </div>
  
  <script language="JavaScript">
<!--

var treeName = 'org_tree';
var asyncURL = '{grn_pageurl page='address/popup_user_email_select_json'}';
var pageName = '{$page_name|escape:"url"}';
var linkURL = '{grn_pageurl page='address/popup_user_email_select' select_func='browse' selected_tab=0 params=$url_params}';

{if $s_oid}
    {if $s_oid != -1}
        var selectedOID = '{$s_oid|escape:javascript}';
    {else} 
        {literal}
        if (document.forms['list'].search_org_id.value){
            var selectedOID = document.forms['list'].search_org_id.value;
            if(document.forms['list'].search_org_id.value == -1)
            {
                var selectedOID = -2;
            }
        }else{
            var selectedOID = 0;
        }
        {/literal}
    {/if}   
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
    
    orgTree.createNode(root, -2, '{/literal}{cb_msg module='grn.address' key='GRN_ADDR-187' replace='true'}{literal}', 0);
    
    tree.draw();
    
}

YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));
YAHOO.util.Event.addListener(window, "load", createExternalNodes());

{/literal}
  //-->
</script>

</div><!--body_end-->
{/if}
