<script type="text/javascript" language="javascript">
<!--
{literal}
    jQuery(document).ready(
        function() {
            onClickFormSelectCheckbox({/literal}{if $select_form_check}true{else}false{/if}{literal});

            {/literal}
            {if $select_form_type1_checked}
                onClickSelectFormRadio("name");
            {elseif $select_form_type2_checked}
                onClickSelectFormRadio("select");
                onFormSelect({$filter.form_relation.col_form}, false);
            {/if}
            {literal}
        });
{/literal}
//-->
</script>
{capture name='grn_report_system_form_limit'}{cb_msg module='grn.report' key='form.limitation' replace='true'}{/capture}
{grn_checkbox name="select_form" id="select_form_checkbox" value="1" checked=$select_form_check caption=$smarty.capture.grn_report_system_form_limit onclick="onClickFormSelectCheckbox(this.checked);"}
<span id="select_form_validate" style="font-weight:bold; color:red;"></span>
<div id="select_form_name_div" style="margin:10px 10px 10px 15px;opacity:0.5;">
    {capture name='grn_report_system_form_name'}{cb_msg module='grn.report' key='input.form.name' replace='true'}{/capture}
    {grn_radio name='select_form_type' id='select_form_type_1' value='1' caption=$smarty.capture.grn_report_system_form_name onclick='onClickSelectFormRadio("name");' checked=$select_form_type1_checked}
    {if $select_form_type1_checked}
        <input type="text" id="select_form_name_input" name="select_form_name_input" value="{$filter.form_condition.col_text}"/>
    {else}
        <input type="text" id="select_form_name_input" name="select_form_name_input" />
    {/if}
    <span id="select_form_name_input_validate" style="font-weight:bold;color:red;"></span>
</div>
<div id="select_form_select_div" style="margin:10px 10px 10px 15px;opacity:0.5;">
    {capture name='grn_report_system_select_form'}{cb_msg module='grn.report' key='select.form' replace='true'}{/capture}
    {grn_radio name='select_form_type' id='select_form_type_2' value='2' caption=$smarty.capture.grn_report_system_select_form onclick='onClickSelectFormRadio("select")' checked=$select_form_type2_checked}
    <input type="button" id="select_form_button" value="{cb_msg module='grn.report' key='select' replace='true'}" onclick="showCategoryFormListWindow();"/>
    {if $select_form_type2_checked}
        <input type="hidden" name="selected_form_id" id="selected_form_id" value="{$filter.form_relation.col_form}"/>
    {else}
        <input type="hidden" name="selected_form_id" id="selected_form_id"/>
    {/if}
    <span id="select_form_select_validate" style="font-weight:bold; color:red;"></span>
    <br />
    <span id="selected_form_name" style="font-weight:bold;">{if $select_form_type2_checked}{$relation_form.name}{/if}</span>
</div>
