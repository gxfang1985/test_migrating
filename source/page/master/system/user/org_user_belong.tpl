{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{include file='grn/org_tree.tpl'}
{grn_title title=$title_of_grn_title class=$page_info.parts[0]}
{if $is_sandbox_page}{include file="system/user/sandbox/_sandbox_title_label.tpl"}{/if}

{assign var='form_name' value=$form_name}
<form method="post" action="{grn_pageurl page="$dir_name/org_user_belong"}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="oid" value="{$org_id|escape}">
<input type="hidden" name="uid" value="{$user_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{cb_msg module='grn.system.user' key='GRN_SY_US-623' replace='true'}<span class="bold">{grn_user_name uid=$user_id nolink=true is_sandbox_page=$is_sandbox_page}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-624' replace='true'}
</div>
  <p>
  <table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
 <tbody>
  <tr valign="top">
  <td class="wrap-tree-view">
  <span class="tree-view-label">{cb_msg module='grn.system.user' key='GRN_SY_US-625' replace='true'}</span>
  <div id="tree_view" class="tree-view">
{if $poid}
{capture name='grn_system_user_GRN_SY_US_626'}{cb_msg module='grn.system.user' key='GRN_SY_US-626' replace='true'}{/capture}{grn_link page="$dir_name/org_user_belong" oid=$org_id poid='0' uid=$user_id top=1 caption=$smarty.capture.grn_system_user_GRN_SY_US_626}
{else}
{capture name='grn_system_user_GRN_SY_US_627'}{cb_msg module='grn.system.user' key='GRN_SY_US-627' replace='true'}{/capture}{grn_link page="$dir_name/org_user_belong" oid=$org_id poid='0' uid=$user_id top=1 caption=$smarty.capture.grn_system_user_GRN_SY_US_627 class='tree-select-current'}
{/if}
    <div id="org_tree"></div>
  </div>
  </td>
  <td width="90%" id="tree_view_right" class="wrap-tree-view-right">
  {if $poid}

  <small style="margin-top:0.5em;">{cb_msg module='grn.system.user' key='GRN_SY_US-628' replace='true'}</small>
  <div class="bold" style="padding-bottom:2px;border-bottom:2px dashed #dddddd;margin-bottom:0.5em;">{grn_organize_name gid=$poid is_sandbox_page=$is_sandbox_page}</div>

  <div class="margin_vert">
  <input class="margin" type="submit" name="add" value="{cb_msg module='grn.system.user' key='GRN_SY_US-629' replace='true'}">
  <input class="margin" type="submit" name="remove" value="{cb_msg module='grn.system.user' key='GRN_SY_US-630' replace='true'}">
  </div>

<select name="sid[]" size="7" multiple style="width:100%">
{foreach from=$org_list key=key item=item}
 {if $add && $poid == $key}
<option value="{$key|escape}" selected>{$item.path|replace:'>':' > '|escape}</option>
 {else}
<option value="{$key|escape}">{$item.path|replace:'>':' > '|escape}</option>
 {/if}
{/foreach}
<option value="">&nbsp;</option>
</select>
</div>
</form>

<div class="adjust_link">{cb_msg module='grn.system.user' key='GRN_SY_US-631' replace='true'}</div>

<p>
<form name="{$form_name}" method="post" action="{grn_pageurl page="$dir_name/command_org_user_belong"}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="oid" value="{$org_id|escape}">
<input type="hidden" name="uid" value="{$user_id|escape}">
{capture name='grn_system_user_GRN_SY_US_632'}{cb_msg module='grn.system.user' key='GRN_SY_US-632' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_632}
{grn_button_cancel class="margin" page="$dir_name/org_user_view" oid=$org_id uid=$user_id}
</form>
</p>
  {/if}

  </td>
  </tr>
  </tbody>
  </table>
  </form>

<script language="JavaScript" type="text/javascript">

var treeName = 'org_tree';
var asyncURL = '{grn_pageurl page="$dir_name/org_json"}';
var pageName = '{$page_name|escape:"url"}';
var linkURL = '{grn_pageurl page="$dir_name/org_user_belong" oid=$org_id uid=$user_id}';

{if $poid}
var selectedOID = '{$poid|escape:javascript}';
{else}
var selectedOID = 0;
{/if}

var orgTree = new YAHOO.grn.orgTree(treeName, asyncURL, pageName, linkURL, selectedOID);
orgTree.setOidKey( 'poid');
var treeData = {include org=$org file='grn/org_json.tpl'};

setTreeHeight('tree_view', 'tree_view_right');

{literal}

YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));

{/literal}
</script>

{include file="grn/system_footer.tpl"}
