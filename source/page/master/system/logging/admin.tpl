{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<div id="main_menu_part">
<span class="menu_item">{capture name='grn_system_logging_GRN_SY_LO_88'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-88' replace='true'}{/capture}{grn_link page='system/logging/config_category' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_88 priority=$selected.priority category=$selected.category image='adminbasic20.gif'}</span>
<span class="menu_item">{capture name='grn_system_logging_GRN_SY_LO_128'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-128' replace='true'}{/capture}{grn_link page='system/logging/export' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_128 priority=$selected.priority category=$selected.category image='export20.gif'}</span>
<span class="menu_item">{capture name='grn_system_logging_GRN_SY_LO_135'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-135' replace='true'}{/capture}{grn_link page='system/logging/confirm_log' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_135 image='search20.gif'}</span>
<span style="float:right" class="menu_item">{capture name='grn_system_logging_GRN_SY_LO_89'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-89' replace='true'}{/capture}{grn_link page='system/logging/log_delete_all' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_89 priority=$selected.priority category=$selected.category image='delete20.gif'}</span>
</div>
<table class="std_form" width="100%">
 <tr>
  <th nowrap width="15%">{capture name='grn_system_logging_GRN_SY_LO_90'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-90' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_logging_GRN_SY_LO_90}</th>
  <td width="85%">
    {assign var='selected_category' value=$selected.category|escape}
    {grn_select name='priority' options=$priorities onchange="v=this.options[this.selectedIndex].value;location.href='?priority='+v+'&category=`$selected_category`';"}
  </td>
  <td nowrap align="right">
   <div id="path_part">
    {capture name='grn_system_logging_GRN_SY_LO_91'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-91' replace='true'}{/capture}{grn_simple_search caption=$smarty.capture.grn_system_logging_GRN_SY_LO_91 action='system/logging/search' page='system/logging/search' name='search_text' priority=$selected.priority|escape category=$selected.category|escape}
   </div>
  </td>
 </tr>
</table>


<form name="{$form_name}" method="post" action="{grn_pageurl page='system/logging/log_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>
<table width="100%">
<tr valign="top">
<td id="tree_part" width="30%">

<div class="tree_item">
{if ! $selected.category}
<div class="hilight"><span class="bold">
 {capture name='grn_system_logging_GRN_SY_LO_92'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-92' replace='true'}{/capture}{grn_link page=$page_info.all priority=$selected.priority caption=$smarty.capture.grn_system_logging_GRN_SY_LO_92}
</span></div>
{else}
 {capture name='grn_system_logging_GRN_SY_LO_93'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-93' replace='true'}{/capture}{grn_link page=$page_info.all priority=$selected.priority caption=$smarty.capture.grn_system_logging_GRN_SY_LO_93}
{/if}
</div>
{foreach from=$target.siblings item=item}
<div class="tree_item">
{if $selected.category == $item.category}
<div class="hilight"><span class="bold">
 {grn_link image='category20.gif' page=$page_info.all priority=$selected.priority category=$item.category caption=$item.title}
</span></div>
{else}
 {grn_link image='category20.gif' page=$page_info.all priority=$selected.priority category=$item.category caption=$item.title}
{/if}
</div>
{/foreach}

</td>
<td id="view_part" width="70%">


   <div class="sub_title">{cb_msg module='grn.system.logging' key='GRN_SY_LO-94' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_for_view.start_count end_num=$navi_for_view.end_count all_num=$navi_for_view.count}</div>
   <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
    <colgroup>
     <col width="5%">
     <col width="20%">
     <col width="15%">
     <col width="15%">
     <col width="45%">
    </colgroup>
    <tr>
     <th nowrap>{include file="grn/checkall.tpl" elem_name='eid[]'}</th>
     {if $sort == 'du'}
     <th nowrap>{capture name='grn_system_logging_GRN_SY_LO_97'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-97' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_system_logging_GRN_SY_LO_97 page=$page_info.all priority=$selected.priority category=$selected.category sort='dd' sp=0 sf=1 reverse=1}</th>
     {else}
      {if $sort == 'dd'}
     <th nowrap>{capture name='grn_system_logging_GRN_SY_LO_98'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-98' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_system_logging_GRN_SY_LO_98 page=$page_info.all priority=$selected.priority category=$selected.category sort='du' sp=0 sf=1}</th>
      {else}
     <th nowrap>{capture name='grn_system_logging_GRN_SY_LO_99'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-99' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_system_logging_GRN_SY_LO_99 page=$page_info.all priority=$selected.priority category=$selected.category sort='dd' sp=0 sf=1 disable=1}</th>
      {/if}
     {/if}
     <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-100' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-101' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-102' replace='true'}</th>
    </tr>
{foreach from=$list.logs key=id item=log}
    <tr valign="top">
     <td><input type="checkbox" name="eid[]" value="{$id}"></td>
     <td>{$log.date|escape}</td>
     <td>{$log.category|escape}</td>
     <td>
     {if $log.priority == 10}{cb_msg module='grn.system.logging' key='GRN_SY_LO-103' replace='true'}{/if}
	 {if $log.priority == 9}{cb_msg module='grn.system.logging' key='GRN_SY_LO-104' replace='true'}{/if}
     {if $log.priority == 8}<b>{cb_msg module='grn.system.logging' key='GRN_SY_LO-105' replace='true'}</b>{/if}
     {if $log.priority == 6}<span class="font_green">{cb_msg module='grn.system.logging' key='GRN_SY_LO-106' replace='true'}</span>{/if}
     {if $log.priority == 4}<span class="font_red">{cb_msg module='grn.system.logging' key='GRN_SY_LO-107' replace='true'}</font>{/if}
     {if $log.priority == 2}<strong><span class="font_red">{cb_msg module='grn.system.logging' key='GRN_SY_LO-108' replace='true'}</span></strong>{/if}
     </td>
     {capture name=_msg}{$log.msg|cb_mb_truncate:50}{/capture}
     <td>{grn_link page='system/logging/view' caption=$smarty.capture._msg priority=$selected.priority category=$selected.category lid=$id}</td>
    </tr>
{/foreach}
   </table>
     <div class="contents_navi">
{* N件ナビゲーション *}
      {include file="grn/word_navi.tpl" navi=$navi_for_view.navi}
     </div>
    {cb_msg module='grn.system.logging' key='GRN_SY_LO-109' replace='true'}{capture name='grn_system_logging_GRN_SY_LO_110'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-110' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_system_logging_GRN_SY_LO_110 onclick="if( ! grn_is_checked( this.form, 'eid[]' ) ) return false;"}

</td>
</tr>
</table>

<input type="hidden" name="priority" value="{$selected.priority|escape}">
<input type="hidden" name="category" value="{$selected.category|escape}">
</form>

{include file='grn/system_footer.tpl'}
