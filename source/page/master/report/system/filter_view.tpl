{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<div id="main_menu_part">

<span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_430'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-430' replace='true'}{/capture}{grn_link page='report/system/filter_modify' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_430 image='modify20.gif' fid=$filter._id}</span>

{if !$filter.col_active}
    <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_431'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-431' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_431 page=report/system/filter_activate cid=$category_id fid=$filter._id image='open20.gif'}</span>
{else}
    <span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_432'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-432' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_432 page=report/system/filter_activate cid=$category_id fid=$filter._id image='open20.gif'}</span>
{/if}

<span class="menu_item">{capture name='grn_report_system_GRN_RPRT_SY_433'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-433' replace='true'}{/capture}{grn_link page='report/system/filter_delete' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_433 image='delete20.gif' fid=$filter._id cid=$category_id}</span>
</div>
 <p>
 <table class="view_table" width="80%">
  <colgroup>
   <col width="20%">
   <col width="80%">
  </colgroup>
  <tr>
   <th>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-435' replace='true'}</th>
   <td>{$filter.col_name|escape:"html"}</td>
  </tr>
  <tr>
      <th>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-436' replace='true'}</th>
      <td>
         {if $filter.col_active}
             <span class="font_green">{cb_msg module='grn.report.system' key='GRN_RPRT_SY-437' replace='true'}</span>
        {else}
             <span class="font_red">{cb_msg module='grn.report.system' key='GRN_RPRT_SY-438' replace='true'}</span>
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
      <th>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-439' replace='true'}</th>
      <td>
          {if $filter.col_or == 0}
           {cb_msg module='grn.report.system' key='GRN_RPRT_SY-440' replace='true'}
          {else}
              {cb_msg module='grn.report.system' key='GRN_RPRT_SY-441' replace='true'}
          {/if}
          {include file="report/_condition_view.tpl" conditions=$conditions}
      </td>
  </tr>
  <tr>
      <th>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-444' replace='true'}</th>
      <td>
        {grn_report_member members=$users}
      </td>
  </tr>
  <tr>
      <th>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-167' replace='true'}</th>
      <td>
        {grn_user_name uid=$filter.col_creator name=$filter.col_creator_name}
        {grn_date_format format='DateTimeMiddle_YMDW_HM' date=$filter.ctime}
      </td>
  </tr>
  <tr>
      <th>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-168' replace='true'}</th>
      <td>
        {grn_user_name uid=$filter.col_modifier name=$filter.col_modifier_name}
        {grn_date_format format='DateTimeMiddle_YMDW_HM' date=$filter.mtime}
      </td>
  </tr>
 </table>

{include file="grn/system_footer.tpl"}
