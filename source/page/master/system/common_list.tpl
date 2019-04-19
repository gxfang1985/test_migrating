{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
<div class="tab_menu">
 {if $smarty.const.ON_FOREST!==1}
 <div class="tab">
  <span class="tab_left_off"></span>
  <span class="tab_off">{capture name='grn_system_GRN_SY_10'}{cb_msg module='grn.system' key='GRN_SY-10' replace='true'}{/capture}{grn_link image='inform20.gif' page='system/index' caption=$smarty.capture.grn_system_GRN_SY_10 element_id="system-index"}</span>
  <span class="tab_right_off"></span>
 </div>
 {/if}
 <div class="tab">
  <span class="tab_left_on"></span>
  <span class="tab_on">{capture name='grn_system_GRN_SY_11'}{cb_msg module='grn.system' key='GRN_SY-11' replace='true'}{/capture}{grn_link  image='adminbasic20.gif' page='system/common_list' caption=$smarty.capture.grn_system_GRN_SY_11 disabled=yes element_id="system-common-list"}</span>
  <span class="tab_right_on"></span>
 </div>
 <div class="tab">
  <span class="tab_left_off"></span>
  <span class="tab_off">{capture name='grn_system_GRN_SY_12'}{cb_msg module='grn.system' key='GRN_SY-12' replace='true'}{/capture}{grn_link image='function20.gif' page='system/application_list' app_id='' caption=$smarty.capture.grn_system_GRN_SY_12 element_id="system-application-list"}</span>
  <span class="tab_right_off"></span>
 </div>
</div>
<div class="tab_menu_end"><div class="tab_menu_end_bg">&nbsp;</div></div>
<table class="multicol" width="100%">
 <tr valign="top">
  <td class="naviColumn" width="30%">
   <ul class="naviColumn_item_area_grn">
{foreach from=$logic_list item=logic}
 {if $logic.selected}
    <li><span id="{$logic.id|escape}" class="hilight bold_grn">{$logic.name|escape}</span></li>
 {else}
    <li><a id="{$logic.id|escape}" href="{grn_pageurl page='system/common_list' id=$logic.id}">{$logic.name|escape}</a></li>
 {/if}
{/foreach}
   </ul>
  </td>
  <td>&nbsp;</td>
  <td width="70%">
{if ! $logic_list}
   <div class="explanation">{cb_msg module='grn.system' key='GRN_SY-13' replace='true'}</div>
{elseif ! $selected}
   <div class="explanation">{cb_msg module='grn.system' key='GRN_SY-14' replace='true'}</div>
{else}
 {foreach from=$config_data item=category}
  {if $category.name}
   <div class="entry_on">
    <div class="subtitle">{$category.name|escape}</div>
  {else}
   <div class="entry_off">
  {/if}
    <div class="admin_icons">
     <ul>
  {foreach from=$category.items item=item}
      <li><a href="{grn_pageurl page=$item.page}" id="{$item.page|escape}" title="{$item.name|escape}">{grn_image image="`$item.icon`.gif"}<br>{$item.name|escape}</a></li>
  {/foreach}
     </ul>
    </div>
   </div>
 {/foreach}
{/if}
  </td>
 </tr>
</table>
{include file="grn/system_footer.tpl"}
