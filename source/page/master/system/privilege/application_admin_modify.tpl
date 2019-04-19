{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

{assign var="form_name" value="column_privileges"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/privilege/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="poid" value="{$poid}">
<input type="hidden" name="itype" value="{$itype}">
<input type="hidden" name="itid" value="{$itid}">

<div class="explanation">
{if 'user' == $itype}
{cb_msg module='grn.system.privilege' key='GRN_SY_PR-27' replace='true'}<span class="bold">{grn_user_name uid=$itid nolink=TRUE}</span>{cb_msg module='grn.system.privilege' key='GRN_SY_PR-28' replace='true'}
{elseif 'group' == $itype}
{cb_msg module='grn.system.privilege' key='GRN_SY_PR-29' replace='true'}<span class="bold">{grn_organize_name gid=$itid}</span>{cb_msg module='grn.system.privilege' key='GRN_SY_PR-30' replace='true'}
{elseif 'static_role' == $itype}
{cb_msg module='grn.system.privilege' key='GRN_SY_PR-31' replace='true'}<span class="bold">{grn_image image='role20.gif'}{grn_role_name rid=$itid}</span>{cb_msg module='grn.system.privilege' key='GRN_SY_PR-32' replace='true'}
{elseif 'dynamic_role' == $itype}
{cb_msg module='grn.system.privilege' key='GRN_SY_PR-33' replace='true'}<span class="bold">{grn_image image='role20.gif'}{$itid|escape}</span>{cb_msg module='grn.system.privilege' key='GRN_SY_PR-34' replace='true'}
{/if}
{cb_msg module='grn.system.privilege' key='GRN_SY_PR-35' replace='true'}
</div>

<div id="onr_parts">
 <!--action-->
 <div class="action">
   <p>
   <!--builtin_items-->
   <div class="word">
    {grn_image image='check16.gif'}&nbsp;{cb_msg module='grn.system.privilege' key='GRN_SY_PR-36' replace='true'}
   </div>
{foreach from=$privileges key=id item=item_obj}
   <div class="word">
     {grn_checkbox name="privileges[$id][enable]" id="enable_$id" value=1 checked=$item_obj.enable caption=$item_obj.name}
   </div>
{/foreach}
   <!--extended_items_end-->
  <p class="item">
   <div class="contents_button">
    <div classs="word">
    <input class="margin" type="submit" value="{cb_msg module='grn.system.privilege' key='GRN_SY_PR-37' replace='true'}">
    {grn_button_cancel page='system/privilege/application_admin_list'}
    </div>
   </div>
  </p>
 </div>
 <!--action_end-->
</div>
</form>

{include file='grn/system_footer.tpl'}
