{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}

<!--menubar-->
<div id="main_menu_part">
    <span class="float_left nowrap-grn">
        <span class="menu_item">{capture name='grn_system_user_GRN_SY_US_193'}{cb_msg module='grn.system.user' key='GRN_SY_US-193' replace='true'}{/capture}{grn_link class='menu_item' image='modify20.gif' page="$dir_name/org_modify" caption=$smarty.capture.grn_system_user_GRN_SY_US_193 oid=$org_id disabled=$is_root disabled=$is_sandbox_status_not_initial alt=''}</span>
        {if $privileged_root}
            {assign var='poid' value=''}
        {else}
            {assign var='poid' value=$org.parent.oid}
        {/if}
        <span class="menu_item">{capture name='grn_system_user_GRN_SY_US_194'}{cb_msg module='grn.system.user' key='GRN_SY_US-194' replace='true'}{/capture}{grn_link class='menu_item' image='organize20.gif' page="$dir_name/org_parent_modify" caption=$smarty.capture.grn_system_user_GRN_SY_US_194 oid=$org_id poid=$poid disabled=$is_root disabled=$is_sandbox_status_not_initial alt=''}</span>
        <span class="menu_item">{capture name='grn_system_user_GRN_SY_US_195'}{cb_msg module='grn.system.user' key='GRN_SY_US-195' replace='true'}{/capture}{grn_link class='menu_item' image='delete20.gif' page="$dir_name/org_delete" caption=$smarty.capture.grn_system_user_GRN_SY_US_195 oid=$org_id disabled=$is_root element_id="system-org-delete" disabled=$is_sandbox_status_not_initial alt=''}</span>
    </span>
    <span class="float_right nowrap-grn mBottom2">
        <div class="moveButtonBlock-grn">
            {grn_previous_next_navi previous=$navi_params.previous next=$navi_params.next}
        </div>
    </span>
    <div class="clear_both_0px"></div>
</div>
<!--menubar_end-->

{grn_title title=$org.name class=$page_info.parts[0]|cat:' inline_block_grn mBottom10' no_style=1}
{if $is_sandbox_page}{include file="system/user/sandbox/_sandbox_title_label.tpl"}{/if}

<table class="view_table">
 <tr>
  <th>{cb_msg module='grn.system.user' key='GRN_SY_US-196' replace='true'}</th>
  <td id="org-name">{if $is_root}{cb_msg module='grn.system.user' key='GRN_SY_US-197' replace='true'}{else}{$org.name|escape}{/if}</td>
 </tr>
 <tr>
  <th>{cb_msg module='grn.system.user' key='GRN_SY_US-198' replace='true'}</th>
  <td id="org-code">{$org.foreign_key|escape}</td>
 </tr>
 <tr>
  <th>{cb_msg module='grn.system.user' key='GRN_SY_US-199' replace='true'}</th>
  <td id="org-parent">{if ! $is_root && ! $org.parent}{cb_msg module='grn.system.user' key='GRN_SY_US-200' replace='true'}{elseif ! $is_root}{cb_msg module='grn.system.user' key='GRN_SY_US-201' replace='true'} > {$org.parent.path|replace:'>':' > '|escape}{/if}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.system.user' key='GRN_SY_US-202' replace='true'}</th>
  <td id="org-memo">{grn_format body=$org.description}</td>
 </tr>
{if ! $is_root}
 <tr>
  <th>{cb_msg module='grn.system.user' key='GRN_SY_US-203' replace='true'}</th>
  <td id="org-user-count">{$org.user_count|escape}</td>
 </tr>
{/if}
 <tr valign="top">
  <th>{cb_msg module='grn.system.user' key='GRN_SY_US-204' replace='true'}</th>
  <td id="org-child">
{foreach from=$org.children key=key item=item}
  {$item.name|escape}<br>
{/foreach}
  </td>
 </tr>
{if (! $is_root) && (! $is_sandbox_page)}
 <tr>
  <th>{cb_msg module='grn.system.user' key='GRN_SY_US-205' replace='true'}</th>
  <td>
   {grn_user_name uid=$org.creator_uid name=$org.creator_name deleted_off=TRUE}
   {grn_date_format date=$org.ctime format="DateTimeMiddle_YMDW_HM"}

  </td>
 </tr>
 <tr>
  <th>{cb_msg module='grn.system.user' key='GRN_SY_US-206' replace='true'}</th>
  <td>
   {grn_user_name uid=$org.modifier_uid name=$org.modifier_name deleted_off=TRUE}
   {grn_date_format date=$org.mtime format="DateTimeMiddle_YMDW_HM"}
  </td>
 </tr>
{/if}
</table>

{include file="grn/system_footer.tpl"}
