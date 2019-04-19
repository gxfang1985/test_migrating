{include file='grn/popup_system_head.tpl'}
{grn_load_css file="grn/html/Design-admin.css"}
{include file='grn/org_tree.tpl'}
<div class="popup_title_grn">
    <div class="float_left">
        {grn_title title=$title_of_grn_title class=$page_info.parts[0]}
    </div>
    <a href="#" onclick="window.close();" role="button">
        <div title="{cb_msg module='grn.grn' key='GRN_GRN-840' replace='true'}" aria-label="{cb_msg module='grn.grn' key='GRN_GRN-840' replace='true'}" class="subWindowClose-grn"></div>
    </a>
    <div class="clear_both_0px"></div>
</div>
{if $is_sandbox_page}{include file="system/user/sandbox/_sandbox_title_label.tpl"}{/if}
{assign var='form_name' value=$form_name}
<form method="post" action="{grn_pageurl page="$dir_name/org_user_belong_add"}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="oid" value="{$org_id|escape}">
<input type="hidden" name="uid" value="{$user_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="session" value="{$session|escape}">
<input type="hidden" name="ss" value="1">

{if $user_id > 0}
<div class="explanation">
{cb_msg module='grn.system.user' key='GRN_SY_US-548' replace='true'}<span class="bold">{grn_user_name uid=$user_id nolink=true is_sandbox_page=$is_sandbox_page}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-549' replace='true'}
</div>
{/if}
  <p>
  <table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
 <tbody>
  <tr valign="top">
  <td class="wrap-tree-view">
  <span class="tree-view-label">{cb_msg module='grn.system.user' key='GRN_SY_US-550' replace='true'}</span>
  <div id="tree_view" class="tree-view">
{if $poid}
{capture name='grn_system_user_GRN_SY_US_551'}{cb_msg module='grn.system.user' key='GRN_SY_US-551' replace='true'}{/capture}{grn_link page="$dir_name/org_user_belong_add" oid=$org_id poid='0' session=$session top=1 caption=$smarty.capture.grn_system_user_GRN_SY_US_551}
{else}
{capture name='grn_system_user_GRN_SY_US_552'}{cb_msg module='grn.system.user' key='GRN_SY_US-552' replace='true'}{/capture}{grn_link page="$dir_name/org_user_belong_add" oid=$org_id poid='0' session=$session top=1 caption=$smarty.capture.grn_system_user_GRN_SY_US_552 class='tree-select-current'}
{/if}
    <div id="org_tree"></div>
  </div>
  </td>
  <td width="90%" id="tree_view_right" class="wrap-tree-view-right">
  
   {if $poid}
  <small style="margin-top:0.5em;">{cb_msg module='grn.system.user' key='GRN_SY_US-553' replace='true'}</small>
  <div class="bold" style="padding-bottom:2px;border-bottom:2px dashed #dddddd;margin-bottom:0.5em;">{grn_organize_name gid=$poid is_sandbox_page=$is_sandbox_page}</div>
   {/if}

  <div class="margin_vert">
  <input class="margin" type="submit" name="add" value="{cb_msg module='grn.system.user' key='GRN_SY_US-554' replace='true'}"{if ! $poid} disabled{/if}>
  <input class="margin" type="submit" name="remove" value="{cb_msg module='grn.system.user' key='GRN_SY_US-555' replace='true'}">
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

<div class="adjust_link">{cb_msg module='grn.system.user' key='GRN_SY_US-556' replace='true'}</div>

<script language="JavaScript" type="text/javascript">

var treeName = 'org_tree';
var asyncURL = '{grn_pageurl page="$dir_name/org_json"}';
var pageName = '{$page_name|escape:"url"}';
var linkURL = '{grn_pageurl page="$dir_name/org_user_belong_add" oid=$org_id session=$session}';

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

function select_org()
{
    if( ! opener.closed )
    {
        opener.add_user_org();
    }
    return true;
}
{/literal}
</script>

<p>
<input type=button value="{cb_msg module='grn.system.user' key='GRN_SY_US-557' replace='true'}" onClick="select_org();">
 <input type="button" value="{cb_msg module='grn.system.user' key='GRN_SY_US-558' replace='true'}" onClick="window.close();">
</p>

  </td>
  </tr>
  </tbody>
  </table>
  </form>
<script language="JavaScript" type="text/javascript">
<!--
window.focus();
//-->
</script>

</div><!--body_end-->
