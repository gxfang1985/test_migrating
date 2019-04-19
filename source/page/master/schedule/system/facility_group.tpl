{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{include file='grn/org_tree.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
<p></p>

 {if ! $is_search_facilitygroup}
 <table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
 <tbody>
  <tr valign="top">
  <td class="wrap-tree-view">
  <span class="tree-view-label">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-216' replace='true'}</span>
  <div id="tree_view" class="tree-view">
{if $org_id && !$top}
{capture name='grn_schedule_system_GRN_SCH_SY_217'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-217' replace='true'}{/capture}{grn_link page='schedule/system/facility_group' top=1 caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_217}
{else}
{capture name='grn_schedule_system_GRN_SCH_SY_218'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-218' replace='true'}{/capture}{grn_link page='schedule/system/facility_group' top=1 caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_218 class='tree-select-current'}
{/if}
    
    <div id="org_tree"></div>
  </div>
  
  </td>
  <td width="90%" id="tree_view_right" class="wrap-tree-view-right">

   <!-- search start -->
   <div style="padding:0.2em 0.5em;margin:0.2em;border:1px solid #dddddd;">
    <table>
    <tr>
    <td nowrap>
 <form name="search" method="get" action="{grn_pageurl page='schedule/system/facility_group'}">
 <input type="hidden" name="cmd" />
 {if $top}
 <input type="hidden" name="top" value="1" />
 {else}
 <input type="hidden" name="oid" value="{$org_id|escape}" />
 {/if}
 <input type="text" name="search_text" size="20" value="{$search_text|escape}" maxlength="100" />
 <input class="small" type="button" value="{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-219' replace='true'}" OnClick="cmd.value='facility'; submit(this.form);" />
 <input class="small" type="button" value="{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-220' replace='true'}" OnClick="document.forms.search.action='{grn_pageurl page='schedule/system/facility_group_search'}'; submit( this );" />
 </form>
    </td>
    </tr>
    </table>
   </div>
   <!-- search end -->
  {if $enable_facility_group_detail}
  <small style="margin-top:0.5em;">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-221' replace='true'}</small>
  <div style="padding-bottom:2px;border-bottom:2px dashed #dddddd;margin-bottom:0.5em;">
    <b>{$org_name}</b>&nbsp;
      {capture name='grn_schedule_system_GRN_SCH_SY_222'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-222' replace='true'}{/capture}{grn_link image='detail20.gif' page='schedule/system/facility_group_view' fagid=$org_id caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_222}
  </div>
  {/if}
{if $show_menu}
{include file='schedule/system/_list_menu.tpl'}
{/if}
{if (! $top || $is_search ) }
  {if $top || $org_id == -2}
  <div class="sub_title">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-223' replace='true'}{if $is_search_facility}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-224' replace='true'}{/if}{include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
  {elseif $org_id == -1}
  <div class="sub_title">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-228' replace='true'}{if $is_search_facility}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-229' replace='true'}{/if}{include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
  {else}
  <div class="sub_title">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-233' replace='true'}{if $is_search_facility}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-234' replace='true'}{/if}{include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
  {/if}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_facility_group'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="oid" value="{$org_id|escape}">
  <div class="list">
   <p class="item">
    <div class="contents_navi">
     {include file="grn/word_navi.tpl" navi=$navi_info.navi}
    </div>
   </p>
   {if $org_id > 0}
   <p class="item">
    <span>{include file='grn/checkall.tpl' elem_name='fid[]'}</span>
    <span>
     <input type="submit" name="remove" value="{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-249' replace='true'}" onclick="if( ! grn_is_checked( this.form, 'fid[]' ) ) return false;">&nbsp;&nbsp; 
    </span>
   </p>
   {/if}
  </div>
  <table class="list_column">
   <colgroup>
 {if $org_id > 0}
    <col width="1%">
 {/if}
    <col width="43%">
    <col width="42%">
    <col width="15%">
   </colgroup>
   <tr>
 {if $org_id > 0}
    <th nowrap></th>
 {/if}
    <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-238' replace='true'}</th>
    {if $org_id == -2 || ($top && $is_search )}
    <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-239' replace='true'}</th>
    {else}
    <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-240' replace='true'}</th>
    {/if}
    <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-241' replace='true'}</th>
   </tr>
 {if $org_id == -2 || ( $top && $is_search )}
 {foreach from=$facility_list key=key item=item}
   <tr>
    <td>{grn_link image='facility20.gif' page='schedule/system/facility_view' oid=$org_id faid=$item._id search_text=$search_text caption=$item.col_name}</td>
    <td>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-242' replace='true'}{foreach from=$item.ancestors item=ancestors} &gt; {$ancestors.col_name|escape}{/foreach}</td>
    <td nowrap>
    {capture name='grn_schedule_system_GRN_SCH_SY_243'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-243' replace='true'}{/capture}{grn_link page='schedule/system/facility_modify' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_243 faid=$item._id}
    {capture name='grn_schedule_system_GRN_SCH_SY_244'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-244' replace='true'}{/capture}{grn_link page='schedule/system/facility_delete' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_244 faid=$item._id}
    </td>
   </tr>
 {/foreach}

   {else}

 {foreach from=$facility_list key=key item=item}
   <tr>
 {if $org_id > 0}
    <td nowrap>{grn_checkbox name='fid[]' id="fid_`$key`" value=$key}</td>
 {/if}
    <td>{grn_link image='facility20.gif' page='schedule/system/facility_view' oid=$org_id faid=$key search_text=$search_text caption=$item.col_name}</td>
    <td>{$item.col_foreign_key|escape}</td>
    <td nowrap>
    {capture name='grn_schedule_system_GRN_SCH_SY_245'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-245' replace='true'}{/capture}{grn_link page='schedule/system/facility_modify' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_245 faid=$key}
    {capture name='grn_schedule_system_GRN_SCH_SY_246'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-246' replace='true'}{/capture}{grn_link page='schedule/system/facility_delete' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_246 faid=$key}
    </td>
   </tr>
 {/foreach}
{/if}
  </table>
  <div class="list">
   {if $org_id > 0}
   <p class="item">
    <span>{include file='grn/checkall.tpl' elem_name='fid[]'}</span>
    <span>
     <input type="submit" name="remove" value="{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-249' replace='true'}" onclick="if( ! grn_is_checked( this.form, 'fid[]' ) ) return false;">&nbsp;&nbsp; 
    </span>
   </p>
   {/if}
   <p class="item">
    <div class="contents_navi">
     {include file="grn/word_navi.tpl" navi=$navi_info.navi}
    </div>
   </p>
  </div>
  {/if}

  </td>
  </tr>
  </tbody>
  </table>
  </form>
{/if}



<script language="JavaScript">
<!--

var treeName = 'org_tree';
var asyncURL = '{grn_pageurl page=$ftree_async_page}';
var pageName = '{$page_name|escape:"url"}';
var linkURL = '{grn_pageurl page='schedule/system/facility_group'}';

{if $org_id && !$top}
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
    
    orgTree.createNode(root, -1, '{/literal}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-250' replace='true'}{literal}', 0);
{/literal}
{if $allow_all_facilities}
    orgTree.createNode(root, -2, '{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-251' replace='true'}', 0);
{/if}
{literal}
    tree.draw();
}
{/literal}

YAHOO.util.Event.addListener(window, "load", orgTree.init(treeData));
YAHOO.util.Event.addListener(window, "load", createExternalNodes());

//-->
</script>

{include file="grn/system_footer.tpl"}
