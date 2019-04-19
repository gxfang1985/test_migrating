{if $deny_access || $deactivateDragDrop}
    <div class="dialog_base_grn">
        <div class="daialog_mainarea_grn">
        <form method="post" action="">
            <div class="mBottom10 tAlignCenter-grn">
                <div><span class="icon_attention_grn attentionMessage-grn">{if $deny_access}{cb_msg module='grn.schedule' key='GRN_SCH-940' replace='true'}{else}{cb_msg module='grn.schedule' key='GRN_SCH-941' replace='true'}{/if}</span></div>
            </div>
            <div class="tAlignCenter-grn">
                <div class="mTop20 nowrap-grn buttonArea-grn">
                    <span id="schedule_submit_button_loading"></span>
                    <span class="aButtonStandard-grn mRight15"><a class="btn_cancel" onclick="ddpopup_cancel()" href="javascript:void(0);"><span>{cb_msg module='grn.schedule' key='GRN_SCH-925' replace='true'}</span></a></span>
                </div>
            </div>
        </form>
        </div>
    </div>
{else}
    {if $type == 'RP'}
        {assign var="detail_url" value='schedule/repeat_modify'}
    {else}
        {assign var="detail_url" value='schedule/modify'}
    {/if}

    <div class="dialog_base_grn">
    <div class="daialog_mainarea_grn">
    <form id="ddpopup_form" method="post" action="{grn_pageurl page='schedule/command_drag_drop'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="bdate" value="{$bdate}">
    <input type="hidden" name="referer_key" value="{$referer_key}">
    <input type="hidden" name="event_id" value="{$event_id}">
    <input type="hidden" name="start_date" value="{$start_date}">
    <input type="hidden" name="end_date" value="{$end_date}">
    <input type="hidden" name="start_hour" value="{$start_hour}">
    <input type="hidden" name="start_minute" value="{$start_minute}">
    <input type="hidden" name="end_hour" value="{$end_hour}">
    <input type="hidden" name="end_minute" value="{$end_minute}">
    <input type="hidden" name="uid" value="{$uid}">
    <input type="hidden" name="gid" value="{$gid}">
    <input type="hidden" name="conflict_fids" value="{$conflict_fids}">
    
    {if $type == 'RP'}
        <div class="mBottom15"><span class="icon_information_grn">{cb_msg module='grn.schedule' key='GRN_SCH-938' replace='true'}<br>{cb_msg module='grn.schedule' key='GRN_SCH-939' replace='true'}</span></div>
    {/if}
    {if $has_facility_need_approval}
        <div class="mBottom15"><span class="icon_information_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1105' replace='true'}</span></div>
    {/if}
    {if $facility eq TRUE}
        {foreach from=$fdata key=k item=v name=fdata}
        <div class="dialog_facility_duplication_grn mBottom10">
        <div><span class="icon_attention_grn attentionMessage-grn">{cb_msg module='grn.schedule' key='GRN_SCH-928' replace='true'}<span class="bold mLeft3 mRight3">
        {assign var="comma" value=0}
        {foreach from=$v.conflict key=k2 item=v2}

        {if $comma eq 1}
            {cb_msg module='grn.schedule' key='GRN_SCH-931' replace='true'}
        {else}
            {assign var="comma" value=1}
        {/if}
        {cb_msg module='grn.schedule' key='GRN_SCH-929' replace='true'}{$v2.facility_name}{cb_msg module='grn.schedule' key='GRN_SCH-930' replace='true'}

        {/foreach}
        </span></span></div>
        <div class="candidacy_grn">
            <div class="sub_information_grn">
            {if $v.alter|@count gt 0}
                {cb_msg module='grn.schedule' key='GRN_SCH-932' facility_group=$v.group_name}
            {else}
                {cb_msg module='grn.schedule' key='GRN_SCH-936' facility_group=$v.group_name}
            {/if}
            </div>

            {foreach from=$v.alter key=k3 item=v3 name=alter_facility}
                <div {if $smarty.foreach.alter_facility.iteration>3} class="hidden_facility"{/if}><span class="checkbox_base_grn"><input type="checkbox" class="alter_fid {if $v3.approval}approval_facility_item{/if}" onclick="" value="{$k3}" id="" name="" class="mRight5"><span class="vAlignMiddle-grn">{grn_facility_name faid=$v3.facility_id noimage=TRUE blank=TRUE}</span></span></div>
            {/foreach}

            {if $v.alter|@count gt 3}
                <div class="more_grn"><a href="javascript:void(0);">{cb_msg module='grn.schedule' key='GRN_SCH-935' replace='true'}</a></div>
            {/if}
        </div>
        {if $smarty.foreach.fdata.last}
        <div class="mBottom10 using_purpose_element" style="display: none;">
            <div class="daialog_indent_grn">
                <div class="textSub-grn">{cb_msg module='grn.schedule' key='GRN_SCH-1100' replace='true'}<span class="attention">*</span>:</div>
                <div class="attention using_purpose_error" style="display: none;"><span class="bold"><span class="nowrap-grn"><span class="subnotify16">{cb_msg module='grn.schedule' key='GRN_SCH-1104' replace='true'}</span></span></span></div>
                <div class="form_text_base_grn">{grn_textarea id="using_purpose" name="using_purpose" class="textarea_sub_grn form_textarea_grn" value=$usingPurposeValue}</div>
            </div>
        </div>
        {/if}
    </div>
    {/foreach}
    <div class="mBottom10">
        <div class="daialog_indent_grn">
            <div class="border_partition_common_dashed_grn"></div>
            <div>
                <span class="checkbox_base_grn"><input type="checkbox" onclick="" value="1" id="chk_not" name="chk_not" class="mRight5"><span class="vAlignMiddle-grn">{cb_msg module='grn.schedule' key='GRN_SCH-934' replace='true'}</span></span>
            </div>
        </div>
        {if $use_attendance_check}
            <div class="border-partition-common-grn"></div>
            <div class="daialog_indent_grn">
                {capture name='grn_schedule_system_GRN_SCH_1001'}{cb_msg module='grn.schedule' key='GRN_SCH-1001' replace='true'}{/capture}{grn_checkbox name='refresh_status' id='refresh_status' value='1' caption=$smarty.capture.grn_schedule_system_GRN_SCH_1001 span_cover="1"}
            </div>
        {/if}
    </div>
    <div class="daialog_indent_grn">
        <div class="mTop20 nowrap-grn buttonArea-grn">
            <span id="schedule_submit_button_loading"></span>
            <span id="span_update" class="mRight15 aButtonStandardDisable-grn aButtonMain-grn"><a class="btn_yes" onclick="" href="javascript:void(0);"><span class="buttonSpacePlus-grn">{cb_msg module='grn.schedule' key='GRN_SCH-924' replace='true'}</span></a></span><span class="aButtonStandard-grn mRight15"><a class="btn_cancel" onclick="ddpopup_cancel()" href="javascript:void(0);"><span>{cb_msg module='grn.schedule' key='GRN_SCH-925' replace='true'}</span></a></span><span class="nowrap-grn mLeft15"><a href="{grn_pageurl page=$detail_url bdate=$bdate uid=$uid gid=$gid referer_key=$referer_key event=$event_id start_date=$start_date end_date=$end_date start_hour=$start_hour start_minute=$start_minute end_hour=$end_hour end_minute=$end_minute}" class="icon-advance-grn" referer="">{cb_msg module='grn.schedule' key='GRN_SCH-926' replace='true'}</a></span>
        </div>
    </div>
    </form>
    </div>
    </div>

    {*success popup*}
    {else}
        {if $type == ''}
            <div class="daialog_indent_grn">{cb_msg module='grn.schedule' key='GRN_SCH-927' replace='true'}
            {if $use_attendance_check}
                <div class="mTop10">
                    {capture name='grn_schedule_system_GRN_SCH_1001'}{cb_msg module='grn.schedule' key='GRN_SCH-1001' replace='true'}{/capture}{grn_checkbox name='refresh_status' id='refresh_status' value='1' caption=$smarty.capture.grn_schedule_system_GRN_SCH_1001 span_cover="1"}
                </div>
            {/if}
            </div>
        {/if}

        <div class="daialog_indent_grn">
            <div class="mTop20 nowrap-grn buttonArea-grn">
                <span id="schedule_submit_button_loading"></span>
                <span class="mRight15 aButtonStandard-grn aButtonMain-grn"><a class="btn_yes" onclick="" href="javascript:void(0);"><span class="buttonSpacePlus-grn">{cb_msg module='grn.schedule' key='GRN_SCH-924' replace='true'}</span></a></span><span class="aButtonStandard-grn mRight15"><a class="btn_cancel" onclick="ddpopup_cancel()" href="javascript:void(0);"><span>{cb_msg module='grn.schedule' key='GRN_SCH-925' replace='true'}</span></a></span><span class="nowrap-grn mLeft15"><a href="{grn_pageurl page=$detail_url bdate=$bdate uid=$uid gid=$gid referer_key=$referer_key event=$event_id start_date=$start_date end_date=$end_date start_hour=$start_hour start_minute=$start_minute end_hour=$end_hour end_minute=$end_minute}" class="icon-advance-grn">{cb_msg module='grn.schedule' key='GRN_SCH-926' replace='true'}</a></span>
            </div>
        </div>
    </form>
    </div>
    </div>
    {/if}
{/if}

{if !$is_personal}
<script type="text/javascript">
var _url_ajax_command = "{grn_pageurl page='schedule/command_drag_drop'}";
var _csrf_ticket = "{$csrf_ticket}";
var _event = "{$event_id}";
var _bdate = "{$bdate}";
var _sdate = "{$start_date}";
var _edate = "{$end_date}";
var _start_hour = "{$start_hour}";
var _start_minute = "{$start_minute}";
var _end_hour = "{$end_hour}";
var _end_minute = "{$end_minute}";
var _conflict_fids = "{$conflict_fids}"
var _alter_fids = "";
var _json;

var _span_update = "{cb_msg module='grn.schedule' key='GRN_SCH-924' replace='true'}";

{literal}
    var dialog_obj = jQuery("div.dialog_base_grn");
    dialog_obj.find("#chk_not").change(function(){
        var chk_not = dialog_obj.find("#chk_not").is(':checked');
        enable_update_button(chk_not);
        if(chk_not)
        {
            dialog_obj.find("div.candidacy_grn").addClass("candidacy_disable_grn");
            dialog_obj.find("input.alter_fid").prop('checked', false);
            dialog_obj.find("input.alter_fid").prop('disabled', true);
        }
        else
        {
            dialog_obj.find("div.candidacy_grn").removeClass("candidacy_disable_grn");
            dialog_obj.find("input.alter_fid").prop('disabled', false);
        }
    });
    
    dialog_obj.find("input.alter_fid").change(function(){
        if(dialog_obj.find("input.alter_fid:checked").length)
        {
            enable_update_button(true);
        }
        else
        {
            enable_update_button(false);
        }
    });
    
    dialog_obj.find("a.btn_yes").click(function(){
        if(dialog_obj.find("span.aButtonStandardDisable-grn").length == 0)
        {
            ddpopup_form_submit();
        }
    });
    
    dialog_obj.find("span.vAlignMiddle-grn").find("a").click(function(ev){
        if(dialog_obj.find("input.alter_fid:disabled").length)
        {
            ev.preventDefault();
            ev.stopPropagation();
        }
    });
    
    dialog_obj.find("div.more_grn > a").click(function(){
        var flag = 0;
        var div_content_more_link = jQuery(this).parent().parent();
        div_content_more_link.find('div.hidden_facility').each(function(){
            if(flag == 5)
            {
                return;
            }
            flag++;
            jQuery(this).removeClass('hidden_facility').css({'display':''});
            if(div_content_more_link.find('div.hidden_facility').length < 1)
            {
                div_content_more_link.find("div.more_grn").remove();
                return;
            }
        });
        return false;
    });
{/literal}
</script>
{/if}
