<table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
  <tbody>
    <tr valign="top">

      <td class="wrap-tree-view">
	    <span class="tree-view-label">{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-142' replace='true'}</span>
	    <div id="tree_view" class="tree-view" >

          {if $poid}
          {capture name='grn_personal_ui_GRN_PRS_UI_148'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-148' replace='true'}{/capture}{grn_link page='personal/ui/dropdown' tab=0 poid='0' uid=$user_id top=1 caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_148}
          {else}
          {capture name='grn_personal_ui_GRN_PRS_UI_149'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-149' replace='true'}{/capture}{grn_link page='personal/ui/dropdown' tab=0 poid='0' uid=$user_id top=1 caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_149 class='tree-select-current'}
          {/if}

	      <div id="org_tree"></div>
	    </div>
      </td>

      <td width="90%" id="tree_view_right" class="wrap-tree-view-right">

	    {if $poid}

	    <form id="form-edit" method="post" action="{grn_pageurl page='personal/ui/dropdown}" name="personal/ui/dropdown"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
	      <small style="margin-top:0.5em;">{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-143' replace='true'}</small>
	      <div class="bold" style="padding-bottom:2px;border-bottom:2px dashed #dddddd;margin-bottom:0.5em;">{grn_organize_name gid=$poid}</div>
	      
	      <div class="margin_vert">
	        <input class="margin" type="submit" name="add" value="{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-144' replace='true'}">
	        <input class="margin" type="submit" name="remove" value="{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-145' replace='true'}">
	      </div>

	      <table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
	        <tbody>
	          <tr>
		        <td>
		          <a href="javascript:OrderTop('personal/ui/dropdown', 'sid[]')">{grn_image image='order_top20.gif' alt=''}</a><br><br>
		          <a href="javascript:OrderUp('personal/ui/dropdown', 'sid[]')">{grn_image image='order_up20.gif' alt=''}</a><br><br>
		          <a href="javascript:OrderDown('personal/ui/dropdown', 'sid[]')">{grn_image image='order_down20.gif' alt=''}</a><br><br>
		          <a href="javascript:OrderBottom('personal/ui/dropdown', 'sid[]')">{grn_image image='order_bottom20.gif' alt=''}</a>
		        </td>
		        <td width="99%">
		          <select id="sid" name="sid[]" size="7" multiple style="width:100%">
		            {foreach from=$org_list key=key item=item}
		            {if $add && $poid == $key}
		            <option value="{$key|escape}" selected>{$item.path|replace:'>':' > '|escape}</option>
		            {else}
		            <option value="{$key|escape}">{$item.path|replace:'>':' > '|escape}</option>
		            {/if}
		            {/foreach}
		            <option value="">&nbsp;</option>
		          </select>
		        </td>
	          </tr>
	        </tbody>
	      </table>
	    </form>

	    <div class="adjust_link">{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-150' replace='true'}</div>	

	    <p>
	      <form id="form-submit" name="" method="post" action="{grn_pageurl page='personal/ui/command_dropdown}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
	        <input type="hidden" name="tab" value="{$tab}" />

            {capture name='grn_personal_ui_GRN_PRS_UI_146'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-146' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_146 onclick="onSubmit();"}
	        {grn_button_cancel class="margin" page="personal/common_list" id="ui"}

	      </form>
	    </p>
      </td>

      {/if}
    </tr>
  </tbody>
</table>

{include file='grn/org_tree.tpl'}
<script language="JavaScript" type="text/javascript">

var treeName = 'org_tree';
var asyncURL = '{grn_pageurl page='grn/popup_user_select_json'}';
var pageName = '{$page_name|escape:"url"}';
var linkURL = '{grn_pageurl page='personal/ui/dropdown'}';

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

function onSubmit() {
    var form_submit = document.getElementById("form-submit");

    var select_elm_main = document.getElementById("sid");
    var new_input_elm = document.createElement("input");
    new_input_elm.setAttribute("type", "text");
    new_input_elm.setAttribute("name", "order");
    new_input_elm.setAttribute("style", "visibility:hidden;");
    jQuery(form_submit).append(new_input_elm);
    var input_values = new Array();

    for (var i = 0; i < select_elm_main.options.length; i++) {
        input_values.push(select_elm_main.options[i].value);
    }
    new_input_elm.value = input_values.join(':');
}



{/literal}
</script>
