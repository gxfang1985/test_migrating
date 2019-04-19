{grn_load_javascript file="grn/html/adjust.js"}

<input type="hidden" id="adjust0_display" name="adjust_display[0]" value="1">
<input type="hidden" id="adjust1_display" name="adjust_display[1]" value="0">
<input type="hidden" id="adjust2_display" name="adjust_display[2]" value="0">
<input type="hidden" id="adjust3_display" name="adjust_display[3]" value="0">
<input type="hidden" id="adjust4_display" name="adjust_display[4]" value="0">
<div class="adjust">{grn_select_date prefix='target_0_' date=$default_date0 form_name=$form_name no_delimiter=true}&nbsp;</div>
<div class="adjust" id="adjust1" style="display:none">
    {grn_select_date prefix='target_1_' date=$default_date1 form_name=$form_name no_delimiter=true}
    <span class="mLeft5 aButtonStandard-grn">
        <a href="javascript:void(0);" onclick="odf('1')">
            <span>{cb_msg module='grn.schedule' key='GRN_SCH-187' replace='true'}</span>
        </a>
    </span>
</div>
<div class="adjust" id="adjust2" style="display:none">
    {grn_select_date prefix='target_2_' date=$default_date2 form_name=$form_name no_delimiter=true}
    <span class="mLeft5 aButtonStandard-grn">
        <a href="javascript:void(0);" onclick="odf('2')">
            <span>{cb_msg module='grn.schedule' key='GRN_SCH-188' replace='true'}</span>
        </a>
    </span>
</div>
<div class="adjust" id="adjust3" style="display:none">
    {grn_select_date prefix='target_3_' date=$default_date3 form_name=$form_name no_delimiter=true}
    <span class="mLeft5 aButtonStandard-grn">
        <a href="javascript:void(0);" onclick="odf('3')">
            <span>{cb_msg module='grn.schedule' key='GRN_SCH-189' replace='true'}</span>
        </a>
    </span>
</div>
<div class="adjust" id="adjust4" style="display:none">
    {grn_select_date prefix='target_4_' date=$default_date4 form_name=$form_name no_delimiter=true}
    <span class="mLeft5 aButtonStandard-grn">
        <a href="javascript:void(0);" onclick="odf('4')">
            <span>{cb_msg module='grn.schedule' key='GRN_SCH-190' replace='true'}</span>
        </a>
    </span>
</div>
<div id="add_button">
    <span class="aButtonStandard-grn">
        <a href="javascript:void(0);" onclick="add();">
            <span>{cb_msg module='grn.grn' key='GRN_GRN-804' replace='true'}</span>
        </a>
    </span>
</div>
{literal}
<script language="Javascript" type="text/javascript">
<!--
grn_set_found_start_time(false);
grn_set_found_display(true);
{/literal}{section name=add loop=$sdate_list_count start=1}
{literal}
add();
{/literal}
{/section}{literal}
//-->
</script>
{/literal}