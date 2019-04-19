{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<!--menubar-->
<div id="menu_part">
    <div id="smart_main_menu_part">
        <span class="menu_item">
        {if $navi.count < 1}{assign var='export_disabled' value='true'}{/if}{capture name='grn_report_operation_r_output_CSV'}{cb_msg module='grn.report' key='r_output_CSV' replace='true'}{/capture}{grn_link page='report/operation/export' caption=$smarty.capture.grn_report_operation_r_output_CSV image='export20.gif' cid=$category_id fid=$form_id disabled=$export_disabled}
        </span>
        <span class="menu_item">
            {include file='report/operation/_display_options.tpl'}
        </span>
    </div>
    <div id="smart_rare_menu_part">
        {if !$form_id}
            {assign var='search_disabled' value='true'}
        {/if}
        {capture name='grn_report_GRN_RPRT_324'}{cb_msg module='grn.report' key='GRN_RPRT-324' replace='true'}{/capture}
        {grn_simple_search caption=$smarty.capture.grn_report_GRN_RPRT_324 name='text' action='report/operation/report_search' page='report/operation/report_search' cid=$category_id|escape fid=$form_id|escape init=1 disabled=$search_disabled}
    </div>
</div>
<!--menubar_end-->

<!--category_path-->

{capture name='grn_report_operation_GRN_RPRT_OP_306'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-306' replace='true'}{/capture}{include file="report/_category_path.tpl" app_name=$smarty.capture.grn_report_operation_GRN_RPRT_OP_306 no_search='true'}
<!--category_path_end-->

<!--category_tree-->
<table width="100%">
    <tr valign="top">
       <td id="tree_part" width="30%">
           {include file="report/_category_structure.tpl" no_extra=1}
<!--category_tree_end-->
<!--form_list-->
           <div class="border-partition-common-grn"></div>
           <div class="sub_title">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-307' replace='true'}</div>
               {foreach from=$form_list item=form}
                   <div class="tree_item">
                       {capture name='suffix'}
                           {if $form.deleted == 1}
                               {cb_msg module='grn.report' key='[deleted]'}
                           {elseif $form.active == 0}
                               {cb_msg module='grn.report' key='[deactive]'}
                           {/if}
                       {/capture}
                       {if $form.fid == $form_id}
                           <nobr>
                               {grn_image image='report20.gif'}
                               <span style="background:#bbbbff">
                                   <span class="bold">
                                       {grn_sentence caption=$form.name|cat:$smarty.capture.suffix}
                                   </span>
                               </span>
                           </nobr>
                       {else}
                       {if $form.type == 0}
                           <nobr>{grn_link page='report/operation/report_list' caption=$form.name|cat:$smarty.capture.suffix image='report20.gif' cid=$category_id fid=$form.fid}</nobr>
                       {/if}
                   {/if}
                   </div>
               {/foreach}
       </td>
<!--form_list_end-->

<!--report_list-->
       <td id="view_part" width="70%">
           {assign var="current_form" value=$form_list.$form_id}
           {if $current_form}
               <div class="bold">{grn_image image='report20.gif'}{grn_sentence caption=$current_form.name}</div>
           {/if}
           <div class="margin_vert">
               <form name="{$form_name}_list_item" method="get" action="{grn_pageurl page='report/operation/report_list'}">
                   <input type="hidden" name="cid" value="{$category_id|escape}">
                   <input type="hidden" name="fid" value="{$form_id|escape}">
                   <span class="sub_title">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-308' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}</span>
               </form>
           </div>

           <div class="contents_navi">{include file="grn/word_navi.tpl" navi=$navi.navi}</div>
           <form name="{$form_name}" method="post" action="{grn_pageurl page='report/operation/report_delete_multi'}">
               <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
               <div class="rp_list">
               <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
                   <colgroup>
                       <col width="1%">
                       <col width="1%">
                       <col width="25%">
                       <col width="40%">
                       <col width="25%">
                   </colgroup>
                   <tr>
                       <th>{include file='report/checkall.tpl' form_name=$form_name elem_name='ids[]'}</th>
                       <th>
                           {grn_image image='access16.gif' alt=$smarty.capture.grn_report_ajax_GRN_RPRT_AJAX_8}
                        </th>
                       <th nowrap>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-311' replace='true'}</th>
                       {if $sort == 'unu'}
                           <th nowrap>{capture name='grn_report_operation_GRN_RPRT_OP_312'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-312' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_report_operation_GRN_RPRT_OP_312 page=$page_info.all cid=$category_id fid=$form_id sort='und' sp=0 sf=2 reverse=1}</th>
                       {elseif $sort == 'und'}
                           <th nowrap>{capture name='grn_report_operation_GRN_RPRT_OP_313'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-313' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_report_operation_GRN_RPRT_OP_313 page=$page_info.all cid=$category_id fid=$form_id sort='unu' sp=0 sf=2}</th>
                       {else}
                           <th nowrap>{capture name='grn_report_operation_GRN_RPRT_OP_314'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-314' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_report_operation_GRN_RPRT_OP_314 page=$page_info.all cid=$category_id fid=$form_id sort='und' sp=0 sf=2 disable=1}</th>
                       {/if}
                       {if $sort == 'mtu'}
                           <th nowrap>{capture name='grn_report_operation_GRN_RPRT_OP_315'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-315' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_report_operation_GRN_RPRT_OP_315 page=$page_info.all cid=$category_id fid=$form_id sort='mtd' sp=0 sf=2 reverse=1}</th>
                       {elseif $sort == 'mtd'}
                           <th nowrap>{capture name='grn_report_operation_GRN_RPRT_OP_316'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-316' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_report_operation_GRN_RPRT_OP_316 page=$page_info.all cid=$category_id fid=$form_id sort='mtu' sp=0 sf=2}</th>
                       {else}
                           <th nowrap>{capture name='grn_report_operation_GRN_RPRT_OP_317'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-317' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_report_operation_GRN_RPRT_OP_317 page=$page_info.all cid=$category_id fid=$form_id sort='mtd' sp=0 sf=2 disable=1}</th>
                       {/if}
                   </tr>
                   {foreach from=$report_list item=report}
                      <tr valign="top">
                          <td nowrap>{grn_checkbox name='ids[]' id="ids_`$report.rid`" value=$report.rid}</td>
                              <td nowrap="" style="width: 1%; text-align: center;">
                                {if $report.private}
                                  {grn_image image='access16.gif' alt=$smarty.capture.grn_report_ajax_GRN_RPRT_AJAX_8}
                                {/if}
                              </td>
                          <td nowrap>
                            {grn_link page='report/operation/report_view' image='report20.gif' caption=$report.name truncated_caption=$subject_width cid=$category_id fid=$form_id rid=$report.rid}
                          </td>
                          <td nowrap>{grn_user_name uid=$report.creator name=$report.creator_name truncated=$name_width users_info=$creators_info}</td>
                          <td nowrap>{grn_date_format date=$report.mtime}</td>
                      </tr>
                  {/foreach}
               </table>
               </div>
               <div class="contents_navi">{include file="grn/word_navi.tpl" navi=$navi.navi}</div>
               {cb_msg module='grn.report.operation' key='GRN_RPRT_OP-318' replace='true'}{capture name='grn_report_operation_GRN_RPRT_OP_319'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-319' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_319 onclick="if(!grn_is_checked(this.form,'ids[]')) return false;"}
               <input type="hidden" name="cid" value="{$category_id|escape}">
               <input type="hidden" name="fid" value="{$form_id|escape}">
           </form>
       </td>
    </tr>
</table>

{include file="grn/footer.tpl"}
