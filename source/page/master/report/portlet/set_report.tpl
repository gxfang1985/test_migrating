{assign var='form_name' value='data_list'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/'|cat:$page_info.parts[1]|cat:'/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<table class="std_form" width="100%">
 <colgroup>
  <col width="15%">
  <col width="85%">
 </colgroup>

 <tr>
  <th nowrap>
      {cb_msg module='grn.report.portlet' key='GRN_RPRT_PO-7' replace='true'}
  </th>
  <td>
{literal}
<script language="JavaScript" type="text/javascript">
<!--
function _AddOption( select, id, text, selected )
{
    select[select.length] = new Option( text, id, false, selected );    
}

function ChangeOption( form )
{
    var a = form.elements["type"].options;
    for(i = a.length-1; i >= 0; i--) a[i] = null;
    var nGID = form.option_type.value;
{/literal}{foreach from=$filters key=type item=items}
    if( nGID == "{$type}" )
{literal}    {{/literal}
 {assign var=selected value=true}
 {foreach from=$items key=key item=item}
   {if $selected}
        _AddOption(a,"{$item.id}","{$item.name|escape:"javascript"}",true);
        {assign var=selected value=false}
   {else}
        _AddOption(a,"{$item.id}","{$item.name|escape:"javascript"}",false);
   {/if}
 {/foreach}
{literal}   }{/literal}
{/foreach}
{literal}
    return;
}
//-->
</script>{/literal}
       <div>{grn_select name='option_type' id='option_type' onchange='ChangeOption(this.form)' options=$filter_options}</div>
       <div>
         <select name="type" size="10" style="width:200px;" class="select_multiple_display_grn">
          {foreach from=$selected_list item=display_item}
           <option value="{$display_item.id}"{if $display_item.selected} selected{/if}>{$display_item.name|escape}</option>
          {/foreach}
         </select>
       </div>
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.report.portlet' key='GRN_RPRT_PO-8' replace='true'}
  </th>
  <td>
      {grn_select name='font_size' options=$font_options}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.report.portlet' key='GRN_RPRT_PO-9' replace='true'}
  </th>
  <td>
     {grn_image image='check16.gif'}{cb_msg module='grn.report.portlet' key='GRN_RPRT_PO-10' replace='true'}{cb_msg module='grn.report.portlet' key='GRN_RPRT_PO-11' replace='true'}
     {capture name='grn_report_portlet_GRN_RPRT_PO_12'}{cb_msg module='grn.report.portlet' key='GRN_RPRT_PO-12' replace='true'}{/capture}{grn_checkbox name="creator"  id="creator"  value="1" checked=$creator  caption=$smarty.capture.grn_report_portlet_GRN_RPRT_PO_12}
     {capture name='grn_report_portlet_GRN_RPRT_PO_13'}{cb_msg module='grn.report.portlet' key='GRN_RPRT_PO-13' replace='true'}{/capture}{grn_checkbox name="mtime"    id="mtime"    value="1" checked=$mtime    caption=$smarty.capture.grn_report_portlet_GRN_RPRT_PO_13}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.report.portlet' key='GRN_RPRT_PO-14' replace='true'}
  </th>
  <td>
     {grn_select_numbers select_name=$select1.name options=$select1.options selected=$settings.rows padding=$select1.padding}
  </td>
 </tr>
 <tr>
  <td><br></td>
  <td></td>
 </tr>
 <tr>
  <td></td>
  <td>
     {capture name='grn_report_portlet_GRN_RPRT_PO_15'}{cb_msg module='grn.report.portlet' key='GRN_RPRT_PO-15' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_report_portlet_GRN_RPRT_PO_15}
{if $display == 'set-system'}
     {capture name='grn_report_portlet_GRN_RPRT_PO_16'}{cb_msg module='grn.report.portlet' key='GRN_RPRT_PO-16' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_report_portlet_GRN_RPRT_PO_16 page='portal/system/view' pid=$portlet.pid}
{elseif $display == 'set-operation'}
     {capture name='grn_report_portlet_GRN_RPRT_PO_17'}{cb_msg module='grn.report.portlet' key='GRN_RPRT_PO-17' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_report_portlet_GRN_RPRT_PO_17 page='portal/operation/view' pid=$portlet.pid}
{else}
     {capture name='grn_report_portlet_GRN_RPRT_PO_18'}{cb_msg module='grn.report.portlet' key='GRN_RPRT_PO-18' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_report_portlet_GRN_RPRT_PO_18 page='portal/personal/view' pid=$portlet.pid}
{/if}
  </td>
 </tr>
</table>

<input type="hidden" name="pid" value="{$portlet.pid}">
<input type="hidden" name="plid" value="{$portlet.plid}">
<input type="hidden" name="ppid" value="{$portlet.ppid}">
<input type="hidden" name="display" value="{$display}">
<input type="hidden" name="display_type" value="{$display_type}">
<input type="hidden" name="fid" value="{$filter_id}">
</form>
