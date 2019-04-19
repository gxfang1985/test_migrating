<table class="view_table" width="100%">
 {if $event_id}
  <tr valign="top">
    <th align="left">{cb_msg module='grn.report' key='GRN_RPRT-89' replace='true'}</th>
    <td nowrap>
     {if $event}
      <a href="{grn_pageurl page='schedule/view' event=$event_id bdate=$event_date}">{$event->getTitle()}</a>
      {if $system}
      <input type="button" onclick="javascript:document.schedule_relation.submit();" value="{cb_msg module='grn.report.system' key='GRN_RPRT_SY-223' replace='true'}" />
      <form name="schedule_relation" method="post" action="{grn_pageurl page=$page_prefix|cat:'/delete_relation'}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}" />
         <input type="hidden" name="rid" value="{$report_id}" />
         <input type="hidden" name="cid" value="{$category_id}" />
         <input type="hidden" name="fid" value="{$form_id}" />
         <input type="hidden" name="eid" value="{$event_id}" />
         <input type="hidden" name="date" value="{$event_date}" />
         <input type="hidden" name="title" value="{$event->getTitle()}"/>
      </form>
      {elseif $operation}
      <input type="button" onclick="javascript:void(0);" id="schedule_relation" value="{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-203' replace='true'}" />
      {grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
      {elseif $is_creator}
      <input type="button" onclick="javascript:document.schedule_relation.submit();" value="{cb_msg module='grn.report' key='GRN_RPRT-117' replace='true'}" />
      <form name="schedule_relation" method="post" action="{grn_pageurl page='report/command_report_schedule_relation'}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}" />
        <input type="hidden" name="rid" value="{$report.rid}" />
        <input type="hidden" name="eid" value="{$event_id}" />
        <input type="hidden" name="date" value="{$event_date}" />
        <input type="hidden" name="addFlg" value="0" />
        <input type="hidden" name="from" value="{$from}" />
      </form>
      {/if}
     {else}
      {if $draft}
      <div style="color:red;font-weight:bold;">
        {cb_msg module='grn.report' key='GRN_RPRT-342' replace='true'}<br />
        {cb_msg module='grn.report' key='GRN_RPRT-343' replace='true'}         
      </div>
      {else}
      <span>{cb_msg module='grn.report' key='relation.access.deny' replace='true'}</span>
      {/if}
     {/if}
    </td>
  </tr>    
 {/if}
 {if $report.enable_member}
  <tr valign="top">
    <th rowspan="1" align="left">{cb_msg module='grn.report' key='GRN_RPRT-90' replace='true'}</th>
    <td>
      {grn_report_member members=$members}
    </td>
  </tr>
 {/if}
 {if $report.enable_partner}
  <tr valign="top">
    <th id="report_partner_header" rowspan="1" align="left">{cb_msg module='grn.report' key='outside_parties' replace='true'}</th>
    <td id="report_partner_list">
        {include file='report/_view_partner.tpl' partners=$partners address_available=$address_available address_available_for_external=$address_available_for_external}
    </td>
  </tr>
 {/if}
 {foreach from=$item_data_list item=item_data_line}
  {if $item_data_line.type == 2}
</table>
<table width="100%">
 <tr valign="top">
  <td>
   <div class="rp_empty_row"></div>
  </td>
 </tr>
</table>
<table class="view_table" width="100%">
  {elseif $item_data_line.type != 1}
  <tr valign="top">
    <th rowspan="1" align="left">
      {$item_data_line.display_name|escape}
    </th>
    {if $system}
        {grn_report_include_item report_id=$report.rid iid=$item_data_line.iid item=$item_data_line display="view-system"}
    {elseif $operation}
        {grn_report_include_item report_id=$report.rid iid=$item_data_line.iid item=$item_data_line display="view-operation"}
    {else}
        {grn_report_include_item report_id=$report.rid iid=$item_data_line.iid item=$item_data_line display="view"}
    {/if}
  </tr>
  {/if}
 {/foreach}
</table>
