{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{include file='grn/org_tree.tpl'}
{grn_title title=$page_title class=$page_info.parts[0] id="mail_user_account"}

<div id="main_menu_part">
    <div id="rare_menu_part">
        {capture name='grn_mail_system_GRN_MAIL_SY_407'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-407' replace='true'}{/capture}{grn_link class='menu_item' image='delete20.gif' page='mail/system/user_account_delete_all' oid=$org_id caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_407}
    </div>
</div>
<table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;">
 <tbody>
  <tr valign="top">
  <td class="wrap-tree-view">
  <span class="tree-view-label">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-408' replace='true'}</span>
  <div id="tree_view" class="tree-view">
{if $org_id}
{capture name='grn_mail_system_GRN_MAIL_SY_409'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-409' replace='true'}{/capture}{grn_link page='mail/system/user_account' top=1 caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_409}
{else}
{capture name='grn_mail_system_GRN_MAIL_SY_410'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-410' replace='true'}{/capture}{grn_link page='mail/system/user_account' top=1 caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_410 class='tree-select-current'}
{/if}
    <div id="org_tree"></div>
  </div>
  </td>
  <td width="90%" id="tree_view_right" class="wrap-tree-view-right">{*Start view part*}
<div>
    <div class="search_navi">
    <form name="search" method="get" action="{grn_pageurl page=$page_info.all}">
    <input type="hidden" name="oid" value="{$org_id|escape}">
    <input type="text" name="search_text" size="20" value="{$search_text|escape}" maxlength="100">
    <input class="small" type="submit" value="{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-411' replace='true'}">
    </form>
    </div>
</div>
{if $is_root && ! $is_search}
  <div class="explanation">
   {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-412' replace='true'}<br>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-413' replace='true'}
  </div>

{else}
 {if $is_root && $is_search}
  <div class="sub_title">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-414' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {elseif $is_nogroups && $is_search}
  <div class="sub_title">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-417' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {elseif $is_search}
  <div class="sub_title">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-420' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {elseif $is_nogroups}
  <div class="sub_title">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-423' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {else}
  <div class="sub_title">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-426' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {/if}
    <div class="contents_navi">
     {include file="grn/word_navi.tpl" navi=$navi_info.navi}
    </div>
  <table class="list_column">
   <colgroup>
    <col width="35%">
    <col width="15%">
    <col width="40%">
    <col width="10%">
   </colgroup>
   <tr>
    <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-429' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-430' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-431' replace='true'}</th>
    <th nowrap>{capture name='grn_mail_system_GRN_MAIL_SY_432'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-432' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_mail_system_GRN_MAIL_SY_432 page='mail/system/user_account' oid=$org_id sort=$sort.sort reverse=$sort.reverse disable=$sort.disabled search_text=$sort.search_text}</th>
   </tr>
 {foreach from=$user_list key=key item=item}
   <tr valign="top">
    <td>
    {if ! $item.valid}
        {assign var=user_icon value='invaliduser20.gif'}
    {elseif ! $item.col_using_app} {*GTM-529*}
        {assign var=user_icon value='invalid_app_user20.png'}
    {else}
        {assign var=user_icon value='user20.gif'}
    {/if}
    {grn_user_name page='mail/system/user_account_list' oid=$org_id uid=$key}</td>
    <td>{$item.foreign_key|escape}</td>
     <td>
  {foreach from=$item.account_list item=account}
      {grn_image image='mailaccount20.gif'}{$account.title|escape}<br>
      {* grn_link class='mailaccount20' caption=$account.title page='mail/system/user_account_modify' oid=$org_id uid=$key aid=$account.aid disabled=TRUE *}
  {/foreach}
     </td>
  {if ($item.mail_size eq '') and ($item.mail_size neq '0')}
     <td>&nbsp;</td>
  {else}
     <td>
        {if $item.mail_size >= 1048576 }
            {grn_format_filesize size=$item.mail_size unit="MB"}
        {else}
            {grn_format_filesize size=$item.mail_size unit="KB"}
        {/if}
     </td>
  {/if}
   </tr>
 {/foreach}
  </table>
    <div class="contents_navi">
     {include file="grn/word_navi.tpl" navi=$navi_info.navi sort='size'}
    </div>
{/if}
    </td>
   </tr>
  </table>
 </td>{*End View Part*}
 </tr>
 </tbody>
 </table>

<script language="JavaScript">
<!--

var treeName = 'org_tree';
var asyncURL = '{grn_pageurl page='system/org_json'}';
var pageName = '{$page_name|escape:"url"}';
var linkURL = '{grn_pageurl page='mail/system/user_account'}';

{if $org_id}
var selectedOID = '{$org_id|escape:javascript}';
{else}
var selectedOID = 0;
{/if}

var orgTree = new YAHOO.grn.orgTree(treeName, asyncURL, pageName, linkURL, selectedOID);
    
var treeData = {include org=$org file='grn/org_json.tpl'};

setTreeHeight('tree_view', 'tree_view_right');

{literal}

function createExternalNodes() {
    var tree = orgTree.getTree();
    var root = tree.getRoot();
    
    orgTree.createNode(root, -1, '{/literal}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-433' replace='true'}{literal}', 0);
    
    tree.draw();
    
}

YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));
YAHOO.util.Event.addListener(window, "load", createExternalNodes());

{/literal}
//-->
</script>
{include file="grn/system_footer.tpl"}
