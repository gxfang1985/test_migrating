{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<div id="main_menu_part">

<span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_357'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-357' replace='true'}{/capture}{grn_link page='report/operation/filter_modify' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_357 image='modify20.gif' fid=$filter._id  disabled=$is_not_manage}</span>


{if !$filter.col_active}
    <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_358'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-358' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_358 page=report/operation/filter_activate cid=$filter.col_category fid=$filter._id image='open20.gif' disabled=$is_not_manage}</span>
{else}
  <span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_359'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-359' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_359 page=report/operation/filter_activate cid=$filter.col_category fid=$filter._id image='open20.gif' disabled=$is_not_manage}</span>
{/if}

<span class="menu_item">{capture name='grn_report_operation_GRN_RPRT_OP_360'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-360' replace='true'}{/capture}{grn_link page='report/operation/filter_delete' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_360 image='delete20.gif' fid=$filter._id cid=$filter.col_category disabled=$is_not_manage}</span>
</div>
 <p>
 <table class="view_table" width="80%">
  <colgroup>
   <col width="20%">
   <col width="80%">
  </colgroup>
  <tr>
   <th>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-362' replace='true'}</th>
   <td>{$filter.col_name|escape:"html"}</td>
  </tr>
  <tr>
      <th>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-363' replace='true'}</th>
      <td>
         {if $filter.col_active}
             <span class="font_green">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-364' replace='true'}</span>
        {else}
             <span class="font_red">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-365' replace='true'}</span>
        {/if}
      </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.report' key='form' replace='true'}</th>
   <td>
        {if $filter.col_formtype == 0}
            {cb_msg module='grn.report' key='all.form' replace='true'}
        {elseif $filter.col_formtype == 1}
            {cb_msg module='grn.report' key='match.form' replace='true'}{$filter.form_condition.col_text}
        {elseif $filter.col_formtype == 2}
            {$form_name|escape}
        {/if}
   </td>
  </tr>
  <tr>
      <th>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-366' replace='true'}</th>
      <td>
           {if $filter.col_or == 0}
            {cb_msg module='grn.report.operation' key='GRN_RPRT_OP-367' replace='true'}
           {else}
               {cb_msg module='grn.report.operation' key='GRN_RPRT_OP-368' replace='true'}
           {/if}
           
        {include file="report/_condition_view.tpl" conditions=$conditions}
      </td>
  </tr>
  <tr>
      <th>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-371' replace='true'}</th>
      <td>
        {grn_report_member members=$users}
      </td>
  </tr>
  <tr>
    <th>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-153' replace='true'}</th>
    <td>
      {grn_user_name uid=$filter.col_creator name=$filter.col_creator_name}
      {grn_date_format format='DateTimeMiddle_YMDW_HM' date=$filter.ctime}
    </td>
  </tr>
  <tr>
    <th>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-154' replace='true'}</th>
    <td>
      {grn_user_name uid=$filter.col_modifier name=$filter.col_modifier_name}
      {grn_date_format format='DateTimeMiddle_YMDW_HM' date=$filter.mtime}
    </td>
  </tr>
 </table>

{include file="grn/footer.tpl"}
