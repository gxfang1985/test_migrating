	<div class="margin_vert">
		<span class="sub_title">
			{include file="grn/smart_data_count.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}
		</span>
	</div>				
	<div class="navi">
		<div class="contents_navi">{include file="report/ajax/word_navi.tpl" navi=$navi.navi }</div>
	</div>
	<table class="list_column" style="width:100%;">
		<tbody
			<tr>
                <th width="1%" nowrap=""></TH>
				<th width="1%" nowrap="">{capture name='grn_report_ajax_GRN_RPRT_AJAX_21'}{cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-21' replace='true'}{/capture}{grn_image image='access16.gif' alt=$smarty.capture.grn_report_ajax_GRN_RPRT_AJAX_21}</TH>
				<th nowrap="" width="50%">{cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-22' replace='true'}</TH>
				<th nowrap="" width="30%">{cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-23' replace='true'}</TH>
				<th nowrap="" width="20%"></TH>
			</tr>
			{foreach from=$report_list item=report name=report_list}
                {assign var='radio_count' value=$smarty.foreach.report_list.iteration}
				<tr class="{cycle values='linetwo,lineone'}">
				    <td><input type="radio" name="rid" id="radio_{$radio_count}" value="{$report._id}" onclick="grn.component.button('#reportRelationSubmit').enable();"></td>

					<td nowrap="" style="width: 1%; text-align: center;">
						{if $report.col_private}
							{capture name='grn_report_ajax_GRN_RPRT_AJAX_24'}{cb_msg module='grn.report.ajax' key='GRN_RPRT_AJAX-24' replace='true'}{/capture}{grn_image image='access16.gif' alt=$smarty.capture.grn_report_ajax_GRN_RPRT_AJAX_24}
						{/if}
					</td>
					<td width="50%"><label for="radio_{$radio_count}" onmouseover="this.style.color='#ff0000'" onmouseout="this.style.color=''">{$report.col_name|escape}</label></td>
					<td nowrap="" width="30%">{$report.date}</TD>
					<td nowrap="" width="20%">
    					{capture name='grn_report_ajax_view'}{cb_msg module='grn.report.ajax' key='grn.report.ajax.view' replace='true'}{/capture}
                        {grn_link page='report/view' image="blank20.gif" caption=$smarty.capture.grn_report_ajax_view rid=$report._id target="_blank"}
					</td>
				</tr>	
			{/foreach}
		</tbody>
	</table>
