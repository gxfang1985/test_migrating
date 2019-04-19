{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{capture name="date"}
    {grn_report_select_date prefix="date_value_%NUM%_" form_name=$form_name}
{/capture}

{include file='report/_filter_item.tpl'}
{literal}
<style type="text/css">
div.filter_item_odd
{
    background-color:#E6E6EE;
}
</style>
<script language="Javascript" type="text/javascript">
<!--
    searchReportUrl = {/literal}'{grn_pageurl page="report/ajax/search_report_list"}'{literal};
    spinnerImage = {/literal}'{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}'{literal};
    
    {/literal}{if $autoSearch}{literal}
        jQuery(document).ready(
                function() {
                    document.getElementById('report_button_search').click();
                });
    {/literal}{/if}{literal}


    function changeUseFilter( checked )
    {
        if( checked )
        {
            //$('search_filter_div').style.opacity = "1";
            document.getElementById('search_filter_div').style.display = "block";
            document.getElementById('form_select_message').style.display = "block";
            document.getElementById('form_select_div').style.display = "none";
            document.getElementById('filter_id').disabled = false;
            document.getElementById('select_form_checkbox').checked = false;
            onClickFormSelectCheckbox(document.getElementById('select_form_checkbox').checked);
        }
        else
        {
            //$('search_filter_div').style.opacity = "0.5";
            document.getElementById('search_filter_div').style.display = "none";
            document.getElementById('form_select_message').style.display = "none";
            document.getElementById('form_select_div').style.display = "block";
            document.getElementById('filter_id').disabled = true;
        }
    }
-->
</script>
{/literal}
<form name="{$form_name}" id="searchConditionForm" method="post" action="{grn_pageurl page='report/search'}">
    <input type="hidden" name="current_sp" value="" id="current_sp" />
    <input type="hidden" name="current_sort" value=""  id="current_sort" />
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="cid" value="{$category_id}">
    <input type="hidden" name="filter_id" value="{$filter._id}" id="filter_id">
    <input type="hidden" name="search" value="1">
    <div class="explanation">{cb_msg module='grn.report' key='GRN_RPRT-51' replace='true'}</div>

    {include file="grn/show_validation_errors.tpl"}
    <table class="std_form">
        <tr valign="top">
            <th nowrap>{cb_msg module='grn.report' key='GRN_RPRT-52' replace='true'}</th>
            <td>
                <div style="margin-bottom:5px;">
                    {grn_select name="target" options=$targetList }<br />
                </div>
            </td>
        </tr>
            {if $filter}
                <tr>
                    <th nowrap>{cb_msg module='grn.report' key='search.target.filter'}</th>
                    <td>
                        <div style="margin:10px 0px 10px 0px;" class="search_filter">
                            <input type="checkbox" name="usr_filter" onclick="changeUseFilter( this.checked );" checked="true" />{cb_msg module='grn.report' key='GRN_RPRT-367' replace='true'} "{$filter.col_name|escape:"html"}" {cb_msg module='grn.report' key='GRN_RPRT-368' replace='true'}
                            <div id="search_filter_div">
                                {include file="report/_filter_view.tpl" viewtableWidth="100%" form_name=$report_form_name}
                            </div>
                        </div>
                    </td>
                </tr>
            {/if}
        <tr>
            <th nowrap>{cb_msg module='grn.report' key='form' replace='true'}</th>
                <td>
                    {if $filter}
                        <div id="form_select_message" style="margin:10px 0px 10px 0px;" class="not_available">
                            {cb_msg module='grn.report' key='form.not.available' replace='true'}
                        </div>
                        <div id="form_select_div" style="display:none;margin:10px 0px 10px 0px;">
                            {include file='report/_filter_formselect.tpl'}
                        </div>
                    {else}
                        <div id="form_select_div" style="margin:10px 0px 10px 0px;">
                            {include file='report/_filter_formselect.tpl'}
                        </div>
                    {/if}
                </td>
        </tr>
        <tr valign="top">
            <th nowrap>{capture name='grn_report_GRN_RPRT_53'}{cb_msg module='grn.report' key='GRN_RPRT-53' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_GRN_RPRT_53}</th>
            <td>{include file='report/_filter_conditions.tpl' inputs=$inputs}</td>
        </tr>
        <tr>
            <td></td>
            <td>
                {strip}
                    <div class="mTop10">
                        {capture name="grn_report_GRN_RPRT_60"}{cb_msg module='grn.report' key='GRN_RPRT-60' replace='true'}{/capture}
                        {grn_button id="report_button_search" ui="main" spacing="normal" caption=$smarty.capture.grn_report_GRN_RPRT_60 onclick="searchReport(document.forms['$form_name'])"}
                        {grn_button id="report_button_cancel" action="cancel" page="report/index" page_param_cid=$category_id page_param_sf=1}
                    </div>
                {/strip}
            </td>
        </tr>
    </table>
</form>

<table class="maincontents_list">
	<tbody>
		<tr>
			<td class="maincontents_list_td">
    			<div id="result"></div>
			</td>
		</tr>
	</tbody>
</table>

{include file='grn/footer.tpl'}

