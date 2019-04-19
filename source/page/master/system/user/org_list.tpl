{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$title_of_grn_title class=$page_info.parts[0]}
{if $is_sandbox_page}{include file="system/user/sandbox/_sandbox_title_label.tpl"}{/if}
{include file="system/user/sandbox/_sandbox_note_of_caution.tpl" prefix_script_name=$dir_name sandbox_view=$sandbox_view is_admin=$is_admin is_sandbox_page=$is_sandbox_page}

 <p>
 <table width="100%" cellpadding="5" cellspacing="0" style="border-collapse: collapse;" bgcolor="#ffffff">
 <tbody>
  <tr valign="top">
  <td class="wrap-tree-view">
      {if $is_sandbox_page}
          {strip}
              <div class="sandbox_pulldown_base_grn">
                  <span>
                      <a class="sandbox_pulldown_grn sandbox_pulldown_delete_grn" href="javascript:void(0)">
                          <span class="">{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-1' replace='true'}</span>
                          <span class="arrow_down_small_icon_grn"></span>
                      </a>
                  </span>
                  <span>
                      <a class="sandbox_pulldown_grn sandbox_pulldown_update_grn" href="javascript:void(0)">
                          <span class="">{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-4' replace='true'}</span>
                          <span class="arrow_down_small_icon_grn"></span>
                      </a>
                  </span>
                  <span>
                      <a class="sandbox_pulldown_grn sandbox_pulldown_new_grn" href="javascript:void(0)">
                          <span class="">{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-7' replace='true'}</span>
                          <span class="arrow_down_small_icon_grn"></span>
                      </a>
                  </span>
              </div>

              <div style="display: block; visibility:hidden;" class="bubble has-top-prong balloon_sub_dialog_grn">
                  <div style="display: true;"></div>
                  <div class="balloon_sub_dialog_base_grn balloon_sandbox_target_grn">
                      <div class="sub_title">{* Departments to Be Deleted : 2 *}</div>
                      <div class="common_list_grn mLeft5">
                          <ul>
                              {* <li>group1 / group2</li> *}
                          </ul>
                      </div>
                      <div class="top-prong" style="left: 20px;">
                          <div class="prong-dk"></div>
                          <div class="prong-lt"></div>
                      </div>
                  </div>
              </div>
          {/strip}
      {/if}

  <span class="tree-view-label">{cb_msg module='grn.system.user' key='GRN_SY_US-421' replace='true'}</span>
  {include file='grn/org_tree_26.tpl'}
  
  </td>
  <td width="90%" id="tree_view_right" class="wrap-tree-view-right">

   <!-- search start -->
   <div style="padding:0.2em 0.5em;margin:0.2em;border:1px solid #dddddd;">
    <table>
    <tr>
    <td nowrap>
 <form name="search" method="get" action="{grn_pageurl page="$dir_name/org_list"}">
 <input type="hidden" name="oid" value="{$org_id|escape}">
 <input type="text" name="search_text" size="20" value="{$search_text|escape}" maxlength="100">
 <input class="small" type="submit" name="submit" value="{cb_msg module='grn.system.user' key='GRN_SY_US-424' replace='true'}">
 </form>
    </td>
    </tr>
    </table>
   </div>
   <!-- search end -->
{if $is_root && ! $is_search}
{include file='system/user/_org_list_menu.tpl'}
 {if $is_admin}
  <div class="sub_title">{cb_msg module='grn.system.user' key='GRN_SY_US-425' replace='true'}</div>
  <blockquote>
  <table>
   <tr><td nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-426' replace='true'}</td><td>{cb_msg module='grn.system.user' key='GRN_SY_US-427' replace='true'}</td><td align="right" nowrap><span class="bold">{$group_count}</span> {cb_msg module='grn.system.user' key='GRN_SY_US-428' replace='true'}</td></tr>
   <tr><td><br></td></tr>
   <tr><td nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-429' replace='true'}</td><td>{cb_msg module='grn.system.user' key='GRN_SY_US-430' replace='true'}</td><td align="right" nowrap><span class="bold">{$user_count}</span> {cb_msg module='grn.system.user' key='GRN_SY_US-431' replace='true'}</td></tr>
   <tr><td nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-432' replace='true'}</td><td>{cb_msg module='grn.system.user' key='GRN_SY_US-433' replace='true'}</td><td align="right" nowrap><span class="bold">{$user_count-$active_count}</span> {cb_msg module='grn.system.user' key='GRN_SY_US-434' replace='true'}</td></tr>
   <tr><td nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-435' replace='true'}</td><td>{cb_msg module='grn.system.user' key='GRN_SY_US-436' replace='true'}</td><td align="right" nowrap><span class="bold">{$active_count-1}</span> {cb_msg module='grn.system.user' key='GRN_SY_US-437' replace='true'}</td></tr>
{if $smarty.const.ON_SAAS===1}
   <tr><td nowrap><span class="attention">{cb_msg module='grn.saas' key='GRN_SAAS-7' replace='true'}</span></td><td><span class="attention">{cb_msg module='grn.saas' key='GRN_SAAS-8' replace='true'}</span></td><td align="right" nowrap><span class="bold attention">{$saas_license_user|escape}</span> <span class="attention">{cb_msg module='grn.saas' key='GRN_SAAS-9' replace='true'}</span></td></tr>
{/if}
  </table>
  </blockquote>
 {else}
  <br><br>
 {/if}
  <div class="sub_explanation">
 {if $is_admin}
   {cb_msg module='grn.system.user' key='GRN_SY_US-438' replace='true'} {cb_msg module='grn.system.user' key='GRN_SY_US-439' replace='true'}<br>
 {else}
   {cb_msg module='grn.system.user' key='GRN_SY_US-440' replace='true'}<span class="bold">{grn_image image='organize20.gif'}{cb_msg module='grn.system.user' key='GRN_SY_US-441' replace='true'}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-442' replace='true'}
   {cb_msg module='grn.system.user' key='GRN_SY_US-443' replace='true'}<br>
 {/if}
 {if !$is_sandbox_page}
   {cb_msg module='grn.system.user' key='GRN_SY_US-444' replace='true'}<span class="bold">{grn_image image='organize20.gif'}{cb_msg module='grn.system.user' key='GRN_SY_US-445' replace='true'}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-446' replace='true'}
   {cb_msg module='grn.system.user' key='GRN_SY_US-447' replace='true'}<br>
 {/if}
   </div>
  
{else}
  {if !$is_root && !$is_nogroups && !$is_deactive && !$is_updated}
  <small style="margin-top:0.5em;">{cb_msg module='grn.system.user' key='GRN_SY_US-448' replace='true'}</small>
  <div style="padding-bottom:2px;border-bottom:2px dashed #dddddd;margin-bottom:0.5em;">
    <b>{grn_organize_name gid=$org_id is_sandbox_page=$is_sandbox_page}</b>&nbsp;{capture name='grn_system_user_GRN_SY_US_449'}{cb_msg module='grn.system.user' key='GRN_SY_US-449' replace='true'}{/capture}{grn_link image='detail20.gif' page="$dir_name/org_view" oid=$org_id caption=$smarty.capture.grn_system_user_GRN_SY_US_449 element_id="system-org-detail"}
  </div>
  {/if}
  {if !$is_updated}
      {include file='system/user/_org_list_menu.tpl'}
  {/if}
 {if $is_root && $is_search}
  <div class="sub_title">{cb_msg module='grn.system.user' key='GRN_SY_US-450' replace='true'}{include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {elseif $is_nogroups && $is_search}
  <div class="sub_title">{cb_msg module='grn.system.user' key='GRN_SY_US-453' replace='true'}{include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {elseif $is_deactive && $is_search}
  <div class="sub_title">{cb_msg module='grn.system.user' key='GRN_SY_US-456' replace='true'}{include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {elseif $is_updated && $is_search}
  <div class="sub_title">{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-20' replace='true'}{include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {elseif $is_search}
  <div class="sub_title">{cb_msg module='grn.system.user' key='GRN_SY_US-459' replace='true'}{include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {elseif $is_nogroups}
  <div class="sub_title">{cb_msg module='grn.system.user' key='GRN_SY_US-462' replace='true'}{include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {elseif $is_deactive}
  <div class="sub_title">{cb_msg module='grn.system.user' key='GRN_SY_US-465' replace='true'}{include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {elseif $is_updated}
  <div class="sub_title">{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-19' replace='true'}{include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {else}
  <div class="sub_title">{cb_msg module='grn.system.user' key='GRN_SY_US-468' replace='true'}{include file="grn/smart_data_count.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}</div>
 {/if}
  <div class="list">
   <p class="item">
    <div class="contents_navi">
     {include file="grn/word_navi.tpl" navi=$navi_info.navi}
    </div>
   </p>
  </div>
<form name="{$form_name}" method="post" action="{grn_pageurl page="$dir_name/command_org_list"}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="oid" value="{$org_id|escape}">
  <table class="list_column">
   <colgroup>
 {if !$is_nogroups && !$is_updated}
    <col width="1%">
 {/if}
    <col width="32%">
    <col width="32%">
    <col width="5%">
    <col width="15%">
    <col width="15%">
   </colgroup>
   <tr>
 {if !$is_nogroups && !$is_updated}
    <th nowrap>{include file='grn/checkall.tpl' elem_name='eid[]'}</th>
 {/if}
    <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-471' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-472' replace='true'}</th>
    <th>{cb_msg module='grn.system.user' key='GRN_SY_US-473' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-474' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.system.user' key='GRN_SY_US-475' replace='true'}</th>
   </tr>
 {foreach from=$user_list key=key item=item}
   <tr>
 {if !$is_nogroups && !$is_updated}
    <td nowrap>{grn_checkbox name='eid[]' id="eid_`$key`" value=$key}</td>
 {/if}
    {strip}
    <td class="nowrap-grn">
        {if $item.valid}
            {assign var=user_icon value='user20.gif'}
        {else}
            {assign var=user_icon value='invaliduser20.gif'}
        {/if}
        {grn_link image=$user_icon page="$dir_name/org_user_view" oid=$org_id uid=$key search_text=$search_text caption=$item.display_name}
        {if $is_sandbox_page && $item.updated}
        <span class="mLeft5 sandbox_label_update_grn">
            {cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-4' replace='true'}
        </span>
        {/if}
    </td>
    {/strip}
    <td>{$item.foreign_key|escape}</td>
    <td>{if $item.position == GRN_UUM_USER_MAX_POSITION}{cb_msg module='grn.system.user' key='GRN_SY_US-476' replace='true'}{else}{$item.position|escape}{/if}</td>
    <td>{if $item.valid}<span class="font_green">{cb_msg module='grn.system.user' key='GRN_SY_US-477' replace='true'}</span>{else}<span class="font_red">{cb_msg module='grn.system.user' key='GRN_SY_US-478' replace='true'}</span>{/if}</td>
    <td nowrap>
  {if $item.privileged}
    {capture name='grn_system_user_GRN_SY_US_479'}{cb_msg module='grn.system.user' key='GRN_SY_US-479' replace='true'}{/capture}{grn_link page="$dir_name/org_user_modify" caption=$smarty.capture.grn_system_user_GRN_SY_US_479 oid=$org_id uid=$key element_id='modify-'|cat:$item.foreign_key|escape}
  {else}
    {capture name='grn_system_user_GRN_SY_US_480'}{cb_msg module='grn.system.user' key='GRN_SY_US-480' replace='true'}{/capture}{grn_link page="$dir_name/org_user_modify" caption=$smarty.capture.grn_system_user_GRN_SY_US_480 oid=$org_id uid=$key disabled=TRUE element_id='modify-'|cat:$item.foreign_key|escape}
  {/if}
  {if $is_sandbox_page}
      {* don't display delete link *}
  {elseif $item.privileged && $key ne $admin_user_id}
    {capture name='grn_system_user_GRN_SY_US_481'}{cb_msg module='grn.system.user' key='GRN_SY_US-481' replace='true'}{/capture}{grn_link page="$dir_name/org_user_delete" caption=$smarty.capture.grn_system_user_GRN_SY_US_481 oid=$org_id uid=$key element_id='delete-'|cat:$item.foreign_key|escape}
  {else}
    {capture name='grn_system_user_GRN_SY_US_482'}{cb_msg module='grn.system.user' key='GRN_SY_US-482' replace='true'}{/capture}{grn_link page="$dir_name/org_user_delete" caption=$smarty.capture.grn_system_user_GRN_SY_US_482 oid=$org_id uid=$key disabled=TRUE}
  {/if}
    </td>
   </tr>
 {/foreach}
 {if !$license_deny && !$is_updated}
   <tr>
    <td colspan="6" style="padding:0.5em;">
    {if $is_admin || !$is_root}
    	{assign var='disabled' value=false}
    {else}
    	{assign var='disabled' value=true}
    {/if}
    {if !$is_sandbox_page}
    <div>{capture name='grn_system_user_GRN_SY_US_483'}{cb_msg module='grn.system.user' key='GRN_SY_US-483' replace='true'}{/capture}{grn_link image='user20.gif' page="$dir_name/org_user_add" oid=$org_id caption=$smarty.capture.grn_system_user_GRN_SY_US_483 disabled=$disabled}</div>
    {/if}
    <div>{capture name='grn_system_user_GRN_SY_US_484'}{cb_msg module='grn.system.user' key='GRN_SY_US-484' replace='true'}{/capture}{grn_link image='modify20.gif' page="$dir_name/org_user_assign" oid=$org_id reset=1 caption=$smarty.capture.grn_system_user_GRN_SY_US_484 disabled=$is_root}</div>
    </td>
   </tr>
 {/if}
  </table>
  <div class="list">
   <p class="item">
    <div class="contents_navi">
     {include file="grn/word_navi.tpl" navi=$navi_info.navi}
    </div>
   </p>
   {if !$is_updated}
   <p class="item">
    {if $is_root || $is_nogroups}<span style="visibility:hidden">{else}<span>{/if}
    {if $is_deactive}
     {cb_msg module='grn.system.user' key='GRN_SY_US-485' replace='true'}<input type="submit" name="active" value="{cb_msg module='grn.system.user' key='GRN_SY_US-486' replace='true'}" onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false;">&nbsp;&nbsp; 
    {else}
     {cb_msg module='grn.system.user' key='GRN_SY_US-487' replace='true'}<input type="submit" name="remove" value="{cb_msg module='grn.system.user' key='GRN_SY_US-488' replace='true'}" onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false;">&nbsp;&nbsp; 
    {/if}
    </span>
   </p>
   {/if}
  </div>
{/if}

  </td>
  </tr>
  </tbody>
  </table>
  </form>

{grn_load_javascript file="grn/html/page/system/user/sandbox/org_list.js"}
<script language="JavaScript">
<!--
//setTreeHeight('tree_view', 'tree_view_right');

{if $is_admin}
{literal}
function createExternalNodes() {
    {/literal}
    {if $org_id}
      var selectedOID = '{$org_id|escape:javascript}';
    {else}
      var selectedOID = 0;
    {/if}
    {literal}

    var tree = obj_folder_tree.getTree();
    var root = tree.getRoot();

    obj_folder_tree.createNode({
        "parent": root,
        "oid": "-1",
        "name": '{/literal}{cb_msg module='grn.system.user' key='GRN_SY_US-489' replace='true'}{literal}',
        "selected": "-1" == selectedOID
    });

    obj_folder_tree.createNode({
        "parent": root,
        "oid": "-2",
        "name": '{/literal}{cb_msg module='grn.system.user' key='GRN_SY_US-490' replace='true'}{literal}',
        "selected": "-2" == selectedOID
    });

    {/literal}{if $is_sandbox_page}{literal}
    obj_folder_tree.createNode({
        "parent": root,
        "oid": "-3",
        "name": '{/literal}{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-11' replace='true'}{literal}',
        "selected": "-3" == selectedOID,
        "update_group" : "1"
    });
    {/literal}{/if}{literal}
    tree.draw();
    
}
{/literal}
YAHOO.util.Event.onDOMReady(createExternalNodes);
{/if}

{if $is_sandbox_page}
{literal}
var orgList = grn.page.system.user.sandbox.org_list;
orgList.ajaxUrl = "{/literal}{grn_pageurl page="$dir_name/ajax_get_sandbox_organization_summary"}{literal}";

orgList.resources = {
    "delete": {
        "title": "{/literal}{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-2' replace='true'}{cb_msg module='grn' key='colon' replace='true'}{literal}",
        "emptyLabel": "{/literal}{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-3' replace='true'}{literal}"
    },
    "modify": {
        "title": "{/literal}{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-5' replace='true'}{cb_msg module='grn' key='colon' replace='true'}{literal}",
        "emptyLabel": "{/literal}{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-6' replace='true'}{literal}"
    },
    "add": {
        "title": "{/literal}{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-8' replace='true'}{cb_msg module='grn' key='colon' replace='true'}{literal}",
        "emptyLabel": "{/literal}{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-9' replace='true'}{literal}"
    },
    "unit" : "{/literal}{cb_msg module='grn.system.user.sandbox' key='GRN_SY_SANDBOX-ORG-LIST-10' replace='true'}{literal}"
};
{/literal}
{/if}

//-->
</script>

{include file="grn/error_handler.tpl"}

{include file="grn/system_footer.tpl"}
