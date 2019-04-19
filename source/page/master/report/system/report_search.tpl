{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{if ! $page_prefix}{assign var='page_prefix' value='report/system'}{/if}
{capture name="date"}
    {grn_report_select_date prefix="date_value_%NUM%_" form_name=$form_name}
{/capture}

{include file='report/_filter_item.tpl'}

{literal}
<script language="Javascript" type="text/javascript">
<!--
    searchReportUrl = {/literal}'{grn_pageurl page="report/system/search_report_list"}'{literal};
    spinnerImage = {/literal}'{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}'{literal};

    {/literal}{if $autoSearch}{literal}
        jQuery(document).ready(
                function() {
                    document.getElementById('searchButton').click();
        });
    {/literal}{/if}{literal}
-->
</script>
{/literal}
<form name="{$form_name}" id="searchConditionForm" method="post" action="{grn_pageurl page=$page_prefix|cat:'/report_search'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="search" value="1">
    <input type="hidden" name="from" value="system">
    <input type="hidden" name="cid" value="{$category_id}">
    <input type="hidden" name="fid" value="{$form_id}">
    <input type="hidden" name="target" value="system">
    <input type="hidden" name="current_sp" value="" id="current_sp" />
    <input type="hidden" name="current_sort" value=""  id="current_sort" />
    <input type="hidden" name="tmp_key" value="{$tmp_key}"  id="tmp_key" />
    <div class="explanation">{cb_msg module='grn.report.system' key='GRN_RPRT_SY-290' replace='true'}</div>

    {include file="grn/show_validation_errors.tpl"}
    {include file='grn/indispensable.tpl'}
    <table class="std_form">
        <tr valign="top">
            <th nowrap>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-291' replace='true'}</th>
            <td>
                {capture name=suffix}
                    {if $form.deleted == 1}
                       {cb_msg module='grn.report' key='[deleted]'}
                    {elseif $form.active == 0}
                        {cb_msg module='grn.report' key='[deactive]'}
                    {/if}
                {/capture}
                {grn_image image='report20.gif'}<span class="bold">{grn_sentence caption=$form.name|cat:$smarty.capture.suffix}</span>
            </td>
        </tr>
        <tr valign="top">
            <th nowrap>{capture name='grn_report_system_GRN_RPRT_SY_292'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-292' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_system_GRN_RPRT_SY_292}</th>
            <td>{include file='report/_filter_conditions.tpl' inputs=$inputs}</td>
        </tr>
        <tr>
            <td></td>
            <td>
                <input type="button" value="{cb_msg module='grn.report.system' key='GRN_RPRT_SY-299' replace='true'}" onclick="searchReport(this.form);" id="searchButton"/>
                {grn_button_cancel page=$page_prefix|cat:'/report_list' cid=$category_id fid=$form_id sf=1}
            </td>
        </tr>
    </table>
</form>
<div id="result">
    <div id="menu_part">
        <div id="smart_main_menu_part">
            <span class="menu_item">
                {capture name='grn_report_system_r_output_CSV'}{cb_msg module='grn.report' key='r_output_CSV' replace='true'}{/capture}{grn_link page=$link caption=$smarty.capture.grn_report_system_r_output_CSV image='export20.gif' cid=$category_id fid=$form_id disabled=true}
            </span>
        </div>
    </div>
</div>
{grn_load_javascript file="fw/yui/build/yahoo/yahoo-min.js"}
{include file='grn/system_footer.tpl'}

