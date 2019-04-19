<input type=hidden name="bid" value="{$book_id}">
<input type=hidden name="func" value="">
<input type=hidden name="s_oid" value="{$select_organization_id}">
<input type=hidden name="selected_users_c_uid[]" value="">
{if $selectType eq 'default'}
<input type=hidden name="selected_users_s_uid_to[]" value="">
<input type=hidden name="selected_users_s_uid_cc[]" value="">
<input type=hidden name="selected_users_s_uid_bcc[]" value="">
{elseif $selectType eq 'automaticForward'}
    <input type=hidden name="selected_users_s_uid_forwardTo[]" value="">
{/if}
<div class="tab_menu">
{**//////////////////////////////**}
 {if $address_mygroups}
 <table class="tab" border="0" cellspacing="0" cellpadding="0">
  <tr height="24" style="cursor:default" nowrap>
   <td>&nbsp;</td>
 {if $book_id == -3}
   <td class="tab_left_on">&nbsp;</td>
   <td class="tab_on" style="font-size:11pt" nowrap>
    {cb_msg module='grn.address' key='GRN_ADDR-144' replace='true'}
   </td>
   <td class="tab_right_on" nowrap></td>
 {else}
   <td class="tab_left_off">&nbsp;</td>
   <td class="tab_off" style="font-size:11pt" nowrap>
    <a href="{grn_pageurl page='address/mail_address_index' form_name=$form_name tag_name=$tag_name bid=-3 selectType=$selectType}">{cb_msg module='grn.address' key='GRN_ADDR-145' replace='true'}</a>
   </td>
   <td class="tab_right_off" nowrap></td>   
 {/if}
   <td>&nbsp;</td>
  </tr>
 </table>
{/if}
{**//////////////////////////////**}
 <table class="tab" border="0" cellspacing="0" cellpadding="0">
  <tr height="24" style="cursor:default" nowrap>
   <td>&nbsp;</td>
{if !$book_id }
   <td class="tab_left_on">&nbsp;</td>
   <td class="tab_on" style="font-size:11pt" nowrap>
    {cb_msg module='grn.address' key='GRN_ADDR-146' replace='true'}
   </td>
   <td class="tab_right_on" nowrap></td>
{else}
    <td class="tab_left_off">&nbsp;</td>
   <td class="tab_off" style="font-size:11pt" nowrap>
    <a href="{grn_pageurl page='address/mail_address_index' form_name=$form_name tag_name=$tag_name tab='userlist' selectType=$selectType}">{cb_msg module='grn.address' key='GRN_ADDR-147' replace='true'}</a>
   </td>
   <td class="tab_right_off" nowrap></td>
{/if}
   <td>&nbsp;</td>
  </tr>
 </table>
{if $mygroups}
 <table class="tab" border="0" cellspacing="0" cellpadding="0">
  <tr height="24" style="cursor:default" nowrap>
   <td>&nbsp;</td>
 {if $book_id == -2}
   <td class="tab_left_on">&nbsp;</td>
   <td class="tab_on" style="font-size:11pt" nowrap>
    {cb_msg module='grn.address' key='GRN_ADDR-148' replace='true'}
   </td>
   <td class="tab_right_on" nowrap></td>
 {else}
   <td class="tab_left_off">&nbsp;</td>
   <td class="tab_off" style="font-size:11pt" nowrap>
    <a href="{grn_pageurl page='address/mail_address_index' form_name=$form_name tag_name=$tag_name bid=-2 selectType=$selectType}">{cb_msg module='grn.address' key='GRN_ADDR-149' replace='true'}</a>
   </td>
   <td class="tab_right_off" nowrap></td>
 {/if}
   <td>&nbsp;</td>
  </tr>
 </table>
{/if}
{if $access.private_address}
 <table class="tab" border="0" cellspacing="0" cellpadding="0">
  <tr height="24" style="cursor:default" nowrap>
   <td>&nbsp;</td>
    {if $book_id == -1}
   <td class="tab_left_on">&nbsp;</td>
   <td class="tab_on" style="font-size:11pt" nowrap>
    {cb_msg module='grn.address' key='GRN_ADDR-150' replace='true'}
   </td>
   <td class="tab_right_on" nowrap></td>
    {else}
   <td class="tab_left_off">&nbsp;</td>
   <td class="tab_off" style="font-size:11pt" nowrap>
    <a href="{grn_pageurl page='address/mail_address_index' form_name=$form_name tag_name=$tag_name bid=-1 selectType=$selectType}">{cb_msg module='grn.address' key='GRN_ADDR-151' replace='true'}</a>
   </td>
   <td class="tab_right_off" nowrap></td>
    {/if}
   <td>&nbsp;</td>
  </tr>
 </table>
{/if}
{if $access.shared_address}
 {foreach from=$books item=book}
 <table class="tab" border="0" cellspacing="0" cellpadding="0">
  <tr height="24" style="cursor:default" nowrap>
   <td>&nbsp;</td>
        {if $book.oid == $book_id}
   <td class="tab_left_on">&nbsp;</td>
   <td class="tab_on" style="font-size:11pt" nowrap>
    {$book.display_name|escape}
   </td>
   <td class="tab_right_on" nowrap></td>
        {else}
   <td class="tab_left_off">&nbsp;</td>
   <td class="tab_off" style="font-size:11pt" nowrap>
    <a href="{grn_pageurl page='address/mail_address_index' form_name=$form_name tag_name=$tag_name bid=$book.oid selectType=$selectType}">{$book.display_name|escape}</a>
   </td>
   <td class="tab_right_off" nowrap></td>
        {/if}
   <td>&nbsp;</td>
  </tr>
 </table>
 {/foreach}
{/if}
</div>
<div class="tab_menu_end">&nbsp;</div>
<!--menubar-->
<div id="menu_part">
    <div id="smart_rare_menu_part" style="white-space:nowrap;" >
        <input type="text" name="st" size="20" maxlength="45" value="{$search_text}" onKeyPress="{literal}if(13 == event.keyCode){this.form.func.value='search'; submit();}{/literal}">&nbsp;
        <input class="small" type="submit" value="&nbsp;{cb_msg module='grn.address' key='GRN_ADDR-47' replace='true'}&nbsp;" onclick="this.form.func.value='search'; submit();">&nbsp;
        {if 'search' == $func}
        <input class="small" type="submit" value="&nbsp;{cb_msg module='grn.address' key='GRN_ADDR-48' replace='true'}&nbsp;" onclick="this.form.func.value='browse'; submit();">
        {/if}
    </div>
</div>
<!--menubar_end-->
<div>
{if $builtin_items.personal_sort_key.use && $book_id != -3}
<!-- readind name index -->
<div class="sub_explanation">&nbsp;{cb_msg module='grn.address' key='GRN_ADDR-253' replace='true'}</div>
<table border="0" class="margin_bottom">
<tr>
    <td>
        <span>[<a href="{grn_pageurl page='address/mail_address_index' form_name=$form_name tag_name=$tag_name bid=$book_id selectType=$selectType}"">{cb_msg module='grn.address' key='GRN_ADDR-152' replace='true'}</a>]</span>
    </td>
    <td><div id="char_container">&nbsp;</div></td>
</tr>
<tr>
    <td></td>
    <td><div id="subchar_container">&nbsp;</div></td>
</tr>
</table>

{include file='address/_char_map.tpl'}

<script language="javascript">
    url = "{grn_pageurl page='address/mail_address_index' form_name=$form_name tag_name=$tag_name bid=$book_id  selectType=$selectType cidx=''}";

    nameIndex = new CharMap('char_container', 'subchar_container', ''+url+'');
    nameIndex.writeMasterIndex();
    
    {if $selected_char}
    CharMap.showSubIndex( '{$selected_char}', 'subchar_container', ''+url+'');
    {/if}
</script>
<!-- reading name index end -->
{/if}
</div>
{if $book_id == -2}{** Myグループ **}

<table width="100%">
<tr valign="top">
<td id="tree_part" width="30%">
 <div class="sub_title">{cb_msg module='grn.address' key='GRN_ADDR-153' replace='true'}</div>
 {foreach from=$mygroups item=mygroup}
 <div class="tree_item">
  {if $select_organization_id == $mygroup._id}
   {grn_structure_link image='mygroup20.gif' page=$page_info.all s_oid=$mygroup._id form_name=$form_name tag_name=$tag_name caption=$mygroup.col_name bid=-2 focus=TRUE selectType=$selectType}
  {else}
   {grn_structure_link image='mygroup20.gif' page=$page_info.all s_oid=$mygroup._id form_name=$form_name tag_name=$tag_name caption=$mygroup.col_name bid=-2 selectType=$selectType}
  {/if}
 </div>
 {/foreach}

</td>
<td width="70%" lign="top">
<table cellpadding="0" cellspacing="0">
<td id="view_part" rowspan="3">
{cb_msg module='grn.address' key='GRN_ADDR-154' replace='true'}<br>

{elseif $book_id == -3}{** Myアドレスグループ **}

 {if $address_mygroups}
<table width="100%">
<tr valign="top">
<td id="tree_part" width="30%">
 <div class="sub_title">{cb_msg module='grn.address' key='GRN_ADDR-155' replace='true'}</div>
 {foreach from=$address_mygroups item=address_mygroup}
 <div class="tree_item">
  {if $select_organization_id == $address_mygroup.id}
   {grn_structure_link image='myaddressgroup20.gif' page=$page_info.all s_oid=$address_mygroup.id form_name=$form_name tag_name=$tag_name caption=$address_mygroup.name bid=-3 focus=TRUE selectType=$selectType}
  {else}
   {grn_structure_link image='myaddressgroup20.gif' page=$page_info.all s_oid=$address_mygroup.id form_name=$form_name tag_name=$tag_name caption=$address_mygroup.name bid=-3 selectType=$selectType}
  {/if}
 </div>
 {/foreach}

</td>
<td width="70%" lign="top">
<table cellpadding="0" cellspacing="0">
<td id="view_part" rowspan="3">
{cb_msg module='grn.address' key='GRN_ADDR-156' replace='true'}<br>
    {/if}

{elseif $book_id }{** アドレスブック **}
<table>
<tr valign="top">
<td id="view_part" rowspan="3">
<div class="contents_navi">
{include file="grn/word_navi.tpl" navi=$view_set.navi}
</div>

{else}{** ユーザー名簿 **}

{include file='grn/org_tree.tpl'} 
<table width="100%" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
 <tr valign="top">
    <td class="wrap-tree-view">
    <span class="tree-view-label">{cb_msg module='grn.address' key='GRN_ADDR-157' replace='true'}</span>
    <div id="tree_view" class="tree-view">
        {if $org_id}
        {capture name='grn_address_GRN_ADDR_158'}{cb_msg module='grn.address' key='GRN_ADDR-158' replace='true'}{/capture}{grn_link page='address/mail_address_index' top=1 form_name=$form_name tag_name=$tag_name tab='userlist' caption=$smarty.capture.grn_address_GRN_ADDR_158 selectType=$selectType}
        {else}
        {capture name='grn_address_GRN_ADDR_159'}{cb_msg module='grn.address' key='GRN_ADDR-159' replace='true'}{/capture}{grn_link page='address/mail_address_index' top=1 form_name=$form_name tag_name=$tag_name tab='userlist' caption=$smarty.capture.grn_address_GRN_ADDR_159 class='tree-select-current' selectType=$selectType}
        {/if}
        <div id="org_tree"></div>
    </div>  
    </td>
    <td width="90%" id="tree_view_right" class="wrap-tree-view-right">
    <table cellpadding="0" cellspacing="0">
    <td id="view_part" rowspan="3">
    {cb_msg module='grn.address' key='GRN_ADDR-160' replace='true'}<br>   
    
{/if}

   <select name="c_uid[]" size="15" multiple>
{foreach from=$candidate_users item=user}
 {if $user.company_name}
    <option value="{$user.uid}">{$user.display_name|escape}({$user.company_name|escape})&nbsp;{$user.email_address|escape}</option>
 {else}
    <option value="{$user.uid}">{$user.display_name|escape}&nbsp;{$user.email_address|escape}</option>
 {/if}
{/foreach}
    <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
   </select><br>
   <div class="list">
    <div class="item">
     <!--
     <div class="contents_navi">{include file="grn/word_navi.tpl"}</div>
     -->
    </div>
   </div>
<div class="margin_top">
{if 'search' == $func}
 {assign var='add_users' value='add_search_users'}
 {assign var='remove_users' value='remove_search_users'}
{else}
 {assign var='add_users' value='add_users'}
 {assign var='remove_users' value='remove_users'}
{/if}

</td>
  {if $selectType eq 'default'}
      {include file="address/_mail_address_select_to_cc_bcc.tpl"}
  {elseif $selectType eq 'automaticForward'}
      {include file="address/_mail_address_select_forward_to.tpl"}
  {/if}
<tr>
<td  id="view_part"  colspan="3">
    <div class="mTop10 mBottom10">
        {strip}
            {capture name='grn_address_GRN_ADDR_167'}{cb_msg module='grn.address' key='GRN_ADDR-167' replace='true'}{/capture}
            {grn_button id='address_book_button_apply' ui='main' action='submit' spacing='normal' caption=$smarty.capture.grn_address_GRN_ADDR_167 onclick="submit_in(document.forms['list']);"}
            {grn_button id='address_book_button_cancel' action='cancel' onclick="window.parent.close();"}
        {/strip}
    </div>
</td>
</tr>
</table>
</table>

{if !$book_id}
<script language="JavaScript">
<!--

var treeName = 'org_tree';
var asyncURL = '{grn_pageurl page='address/popup_user_email_select_json'}';
var pageName = '{$page_name|escape:"url"}';
var linkURL = '{grn_pageurl page='address/mail_address_index' form_name=$form_name tag_name=$tag_name tab='userlist' selectType=$selectType}';

{if $org_id}
var selectedOID = '{$org_id|escape:javascript}';
{else}
var selectedOID = 0;
{/if}

var orgTree = new YAHOO.grn.orgTree(treeName, asyncURL, pageName, linkURL, selectedOID);
orgTree.setOidKey( 's_oid');

var treeData = {include org=$org file='grn/org_json.tpl'};

{literal}
function createExternalNodes() {
    var tree = orgTree.getTree();
    var root = tree.getRoot();
    
    orgTree.createNode(root, -1, '{/literal}{cb_msg module='grn.address' key='GRN_ADDR-169' replace='true'}{literal}', 0);    
    tree.draw();    
}
{/literal}

setTreeHeight('tree_view', 'tree_view_right');
YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));
YAHOO.util.Event.addListener(window, "load", createExternalNodes());

//-->
</script>
{/if}
