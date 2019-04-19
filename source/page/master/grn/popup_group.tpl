{include file="grn/popup_head.tpl"}
{include file="grn/popup_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page=$page_info.all}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="ss" value="1">
{include file='grn/org_tree.tpl'} 
 <table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
 <tbody>
  <tr valign="top">
  <td class="wrap-tree-view">
  <span class="tree-view-label">{cb_msg module='grn.grn' key='GRN_GRN-1187' replace='true'}</span>
  <div id="tree_view" class="tree-view">
{if $org_id}
{capture name='grn_grn_GRN_GRN_1188'}{cb_msg module='grn.grn' key='GRN_GRN-1188' replace='true'}{/capture}{grn_link page='grn/popup_group' top=1 caption=$smarty.capture.grn_grn_GRN_GRN_1188}
{else}
{capture name='grn_grn_GRN_GRN_1189'}{cb_msg module='grn.grn' key='GRN_GRN-1189' replace='true'}{/capture}{grn_link page='grn/popup_group' top=1 caption=$smarty.capture.grn_grn_GRN_GRN_1189 class='tree-select-current'}
{/if}
    <div id="org_tree"></div>
  </div>  
  </td>
  <td width="90%" id="tree_view_right" class="wrap-tree-view-right">
   {if $no_group}
       <br/>
       <div class="m_small">{cb_msg module='grn.grn' key='GRN_GRN-1190' replace='true'}</div>   
       <select id="uid" name="uid[]" size="10" multiple="multiple" style="width:100%">
        {foreach from=$user_list item=user key=key}
            <option value="{$key}">{$user}</option>
        {/foreach}
       </select>
       <div class="margin_vert">
        <input class="margin" type="submit" id="add" name="add" value="{cb_msg module='grn.grn' key='GRN_GRN-1191' replace='true'}"/>
        <input class="margin" type="submit" id="remove" name="remove" value="{cb_msg module='grn.grn' key='GRN_GRN-1192' replace='true'}"/>
       </div>
       <select id="rid" name="rid[]" size="10" multiple="multiple" style="width:100%">
        {foreach from=$selected_list item=user key=key}
            <option value="{$key}">{$user.display_name}</option>
        {/foreach}    
       </select>
       <input type="button" value="{if $app_name}{$app_name}{cb_msg module='grn.grn' key='GRN_GRN-1193' replace='true'}{elseif $return_url== 'phonemessage/index'}{cb_msg module='grn.grn' key='GRN_GRN-1194' replace='true'}{else}{cb_msg module='grn.grn' key='GRN_GRN-1195' replace='true'}{/if}" onClick="popup_apply( this.form,{$org_id})">
       <input type="button" value="{cb_msg module='grn.grn' key='GRN_GRN-1196' replace='true'}" onClick="window.close();">
    {/if}   
  </td>
  </tr>
  </tbody>
 </table>
 <script language="JavaScript">
<!--

var treeName = 'org_tree';
var asyncURL = '{grn_pageurl page='system/user/org_json'}';
var pageName = '{$page_name|escape:"url"}';
var linkURL = '{grn_pageurl page='grn/popup_group'}';

{if $org_id}
var selectedOID = '{$org_id|escape:javascript}';
{else}
var selectedOID = 0;
{/if}

var orgTree = new YAHOO.grn.orgTree(treeName, asyncURL, pageName, linkURL, selectedOID);
orgTree.createNode = function(parent, oid, name, count) {literal}{
        var html = '';
        {/literal}
        html += "<a href='" + this._linkURL +"gid=" + oid + "&oid=" + oid + "&return_url={$return_url}&tp={$tp}&ppid={$ppid}"+"'>" + name;
        if (count > 0 ) html += "&nbsp;(" + count + ")";
        html += "</a>";
        html = this.setNodeStyle(oid, html);
        {literal}
        
        return new YAHOO.widget.HTMLNode(html, parent, false, true);
}{/literal}
var treeData = {include org=$org file='grn/org_json.tpl'};

setTreeHeight('tree_view', 'tree_view_right');

{literal}

YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));

{/literal}
//-->
</script>




{if $no_group}
    <input type="hidden" name="bdate" value="{$bdate|escape}">
    <input type="hidden" name="return_url" value="{$return_url}">
    <input type="hidden" name="page" value="{$return_url}">
    <input type="hidden" name="tp" value="{$tp}">
    <input type="hidden" name="ppid" value="{$ppid}">

    <script language="JavaScript" type="text/javascript">
    <!--
    {literal}
    function popup_apply( form,org_id )
    {
        var parent_form = window.parent.opener.document.forms['{/literal}{if $tp == "s"}personal_day{$ppid}{elseif $tp == "au"}user_list{$ppid}{elseif $tp == "pm"}phonemessage{$ppid}{else}{$return_url}{/if}{literal}'];
        if (! parent_form)
        {
            window.parent.close();
            return false;
        }
        var parent_options = parent_form.elements['gid'].options;
        var lsUser = $('rid');
        var lsUserOptions = lsUser.options;
        var users = [], guid = org_id;
        for(i = 0; i <lsUserOptions.length; i++)
        {
            users.push(lsUserOptions[i].value);        
        }
        if(users.length > 0)
        {
            guid = guid + "," + users.join(',');
        }
        else
        {
             guid = guid + ",0";
        }
        parent_options[0].value = guid;
        parent_options[0].selected = true;
        for (i = 1;i < parent_options.length;i++)
        {
            parent_options[i].selected = false;
        }
        parent_form.submit();
        window.parent.close();
    }
    {/literal}
    //-->
    </script>
{/if}    
</form>
{include file="grn/popup_footer.tpl"}
