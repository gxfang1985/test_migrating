{grn_load_javascript file="fw/yui/build/dragdrop/dragdrop-min.js"}
<div id="overlay" class="overlay" style="display:none"></div>
<div id="approval_status_dialog" class="msgbox msgbox_grn" style="width: auto; max-width:800px; display:none;">
<form name="change_approval_status" id="change_approval_status" method="post" enctype="multipart/form-data" action="{grn_pageurl page='schedule/operation/ajax/command_facility_approve'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}"/>
    <input type="hidden" name="event" id="approval_status_dialog_eid"/>
    <input type="hidden" name="faid" id="approval_status_dialog_faid"/>
    <div class="title" id="approval_status_title">
    <div class="msgbox_title_grn float_left">{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-202' replace='true'}</div>
    <a onclick="GRN_ApprovalFacilityStatusDialog.closeDialog();" title="{cb_msg module='grn.grn' key='GRN_GRN-44' replace='true'}" id="approval_status_cancelImg" href="javascript:void(0);"><div class="subWindowClose-grn"></div></a>
    <div class="clear_both_0px"></div>
  </div>
  <div class="content" style="min-height: 120px;">
    <table class="form_table01_grn">
      <tbody>
        <tr valign="top">
          <th>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-191' replace='true'}</th>
          <td id="approval_status_dialog_using_time"></td>
        </tr>
        <tr valign="top">
          <th>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-192' replace='true'}</th>
          <td>
            <span class="facility-grn">
              <a id="approval_status_dialog_faciliay_link">
                {grn_image image="facility20.gif"}
              </a>
            </span>
          </td>
        </tr>
        <tr valign="top">
          <th>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-198' replace='true'}</th>
          <td id="approval_status_dialog_using_purpose"></td>
        </tr>
        <tr valign="top">
          <th>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-225' replace='true'}</th>
          <td>
            <span class="user-grn" id="approval_status_dialog_applicant"></span>
            <span class="viewTableSubInfo-grn" id="approval_status_dialog_applying_time"></span>
          </td>
        </tr>
        <tr valign="top">
          <th></th>
          <td></td>
        </tr>
        <tr valign="top">
          <th>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-204' replace='true'}</th>
          <td>
            <div class="form_text_base_grn">
              <textarea wrap="virtual" name="data" id="approval_dialog_coment" class="autoexpand textarea_sub_grn form_textarea_grn" ></textarea>
              <textarea id="dummy_textarea_approval_dialog_coment" style="display: none;"></textarea>
            </div>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
  <div class="buttonArea-grn">
    <div class="mTop3">
    {strip}
      <span class="buttonPostMain-grn button_r_margin3_grn">
        <a onclick="javascript:GRN_ApprovalFacilityStatusDialog.doAjaxApprove()" href="javascript:void(0);" class="button_min_width2_grn" id="approval_status_OKBtn">{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-205' replace='true'}</a>
        <span id="approve_status_dialog_spinner"></span>
      </span>
      <span class="button_attention_grn">
        <a onclick="javascript:GRN_ApprovalFacilityStatusDialog.doAjaxReject()" href="javascript:void(0);" class="button_min_width2_grn" id="approval_status_cancelBtn">{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-206' replace='true'}</a>
        <span id="reject_status_dialog_spinner"></span>
      </span>
    {/strip}
    </div>
  </div>
</form>
</div>

{literal}
<script language="JavaScript" type="text/javascript">
GRN_ApprovalFacilityStatusDialog = {
    eventId : null,
    facilityId : null,
    facility_detail_url : "{/literal}{grn_pageurl page='schedule/facility_info'}{literal}",
    approve_word : "{/literal}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-196' replace='true'}{literal}",
    openDialog: function(eventId, facilityId, facilityName, applyingTime, position_elm){
        GRN_ApprovalFacilityStatusDialog.closeDialog();

        var dialog = jQuery("#approval_status_dialog");
        var overlay = jQuery("#overlay");
        var event_id_elm = jQuery("#approval_status_dialog_eid");
        var faid_elm = jQuery("#approval_status_dialog_faid");
        var textarea_elm = jQuery("#approval_dialog_coment");
        var using_time_elm = jQuery("#approval_status_dialog_using_time");
        var facility_link_elm = jQuery("#approval_status_dialog_faciliay_link");
        var facility_icon_elm = facility_link_elm.children(":first-child").clone();
        var using_purpose_elm = jQuery("#approval_status_dialog_using_purpose");
        var applicant_elm = jQuery("#approval_status_dialog_applicant");
        var applying_time_elm = jQuery("#approval_status_dialog_applying_time");

        GRN_ApprovalFacilityStatusDialog.eventId = eventId;
        GRN_ApprovalFacilityStatusDialog.facilityId = facilityId;
        event_id_elm.val( eventId );
        faid_elm.val( facilityId );
        textarea_elm.val("");

        var using_time = position_elm.parent().parent().parent().children().eq(0).children(":last-child").clone();
        using_time_elm.html( using_time.html() );
        var facility_link_script = "javascript:popupWin('" + GRN_ApprovalFacilityStatusDialog.facility_detail_url + "faid=" + facilityId + "','help',500,480,0,0,0,1,0,1)";
        facility_link_elm.attr( "href", facility_link_script);
        facility_icon_elm.children().remove();
        facility_link_elm.text( facilityName );
        facility_link_elm.prepend( facility_icon_elm );

        var using_purpose = position_elm.parent().parent().parent().children().eq(4).children(":first-child").clone();
        using_purpose_elm.children().remove();
        using_purpose_elm.append( using_purpose );

        var applicant = position_elm.parent().parent().parent().children().eq(5).children(":last-child").children().clone();
        applicant_elm.children().remove();
        applicant_elm.append( applicant );

        applying_time_elm.html("&nbsp;" + applyingTime);

        overlay.show();
        dialog.show();
        if( GRN_ApprovalFacilityStatusDialog.isMobileView())
        {
            GRN_ApprovalFacilityStatusDialog.mobileViewResizeDialog(dialog,overlay,position_elm);
        }
        else
        {
            GRN_ApprovalFacilityStatusDialog.resizeDialog(dialog, overlay);
            GRN_ApprovalFacilityStatusDialog.setBrowserResizeON(dialog, overlay);
        }
        GRN_ApprovalFacilityStatusDialog.setKeyDownHandle(dialog);
    },
    isMobileView: function(){
        if( navigator.userAgent.match(/Android/i)
                || navigator.userAgent.match(/webOS/i)
                || navigator.userAgent.match(/iPhone/i)
                || navigator.userAgent.match(/iPad/i)
                || navigator.userAgent.match(/iPod/i)
                )
        {
            return true;
        }
        else
        {
            return false;
        }
    },
    mobileViewResizeDialog: function(dialog,overlay,position_elm){
        var bodyHeight = document.body.clientHeight;
        var bodyWidth = document.body.clientWidth;
        var bodyScrollHeight = Math.max(document.documentElement.scrollHeight,document.body.scrollHeight);
        var bodyScrollWidth = Math.max(document.documentElement.scrollWidth,document.body.scrollWidth);

        overlay.css("width", Math.max(bodyWidth,bodyScrollWidth));
        overlay.css("height", Math.max(bodyHeight,bodyScrollHeight));

        var hrefDialogWidth = dialog.outerWidth(true) / 2;
        var hrefDialogHeight = dialog.outerHeight(true) / 2;
        var button = jQuery(position_elm);

        dialog.css("left", jQuery(window).width() / 2 - hrefDialogWidth)
        dialog.css("top",button.position().top + button.height() + 10 +'px');
    },
    resizeDialog: function( dialog, overlay ){
        var bodyHeight = document.body.clientHeight;
        var bodyWidth = document.body.clientWidth;
        var bodyScrollHeight = Math.max(document.documentElement.scrollHeight,document.body.scrollHeight);
        var bodyScrollWidth = Math.max(document.documentElement.scrollWidth,document.body.scrollWidth);

        overlay.css("width", Math.max(bodyWidth,bodyScrollWidth));
        overlay.css("height", Math.max(bodyHeight,bodyScrollHeight));

        var hrefDialogWidth = dialog.outerWidth(true) / 2;
        var hrefDialogHeight = dialog.outerHeight(true) / 2;

        var scrollTop = Math.max(document.documentElement.scrollTop,document.body.scrollTop);
        var scrollLeft = Math.max(document.documentElement.scrollLeft,document.body.scrollLeft);

        dialog.css("left", jQuery(window).width() / 2 - hrefDialogWidth + scrollLeft);
        dialog.css("top", jQuery(window).height() / 2 - hrefDialogHeight + scrollTop);
    },
    setBrowserResizeON: function( dialog, overlay){
        jQuery(window).resize(function () {
            GRN_ApprovalFacilityStatusDialog.resizeDialog(dialog, overlay);
        });
    },
    setKeyDownHandle: function( dialog ){
        jQuery(document).keydown(function(event){
        switch(event.keyCode) {
            case 27:
                GRN_ApprovalFacilityStatusDialog.closeDialog();
                break;
            default:
                break;
            }

        });
    },
    closeDialog: function(){
        var dialog = jQuery("#approval_status_dialog");
        var overlay = jQuery("#overlay");

        jQuery("#approve_status_dialog_spinner").removeClass('spinner_s_button_post2_grn');
        jQuery("#reject_status_dialog_spinner").removeClass('spinner_s_button_post2_grn');
        dialog.hide();
        overlay.hide();
        GRN_ApprovalFacilityStatusDialog.doingAjax = false;
        if( !GRN_ApprovalFacilityStatusDialog.isMobileView() )
        {
            jQuery(window).off("resize");
            jQuery(window).off("keydown");
        }
    },
    doingAjax : false,
    doAjaxApprove: function(){
        var form_elm = jQuery("#change_approval_status").eq(0);
        var post_data = form_elm.serialize() + "&approve=1";

        var loading_elm = jQuery("#approve_status_dialog_spinner");
        if(GRN_ApprovalFacilityStatusDialog.doingAjax)
        {
            return false;
        }

        var ajaxRequest = new grn.component.ajax.request(
        {
            url:form_elm.attr("action"),
            method: "post",
            dataType: "json",
            data: post_data,
            beforeSend: function()
            {
                loading_elm.addClass('spinner_s_button_post2_grn');
                GRN_ApprovalFacilityStatusDialog.doingAjax = true;
            }
        });

        ajaxRequest.on("beforeShowError", function()
        {
            GRN_ApprovalFacilityStatusDialog.closeDialog();
        });

        ajaxRequest.send().done(function(jsonObj, textStatus, jqXHR)
        {
            GRN_ApprovalFacilityStatusDialog.changeElement(jsonObj,"approve");
        });
    },
    doAjaxReject: function(){
        var form_elm = jQuery("#change_approval_status").eq(0);
        var post_data = form_elm.serialize() + "&approve=0";

        var loading_elm = jQuery("#reject_status_dialog_spinner");
        if(GRN_ApprovalFacilityStatusDialog.doingAjax)
        {
            return false;
        }

        var ajaxRequest = new grn.component.ajax.request(
        {
            url: form_elm.attr("action"),
            method: "post",
            dataType: "json",
            data: post_data,
            beforeSend: function()
            {
                loading_elm.addClass('spinner_s_button_post2_grn');
                GRN_ApprovalFacilityStatusDialog.doingAjax = true;
            }
        });

        ajaxRequest.on("beforeShowError", function()
        {
           GRN_ApprovalFacilityStatusDialog.closeDialog();
        });

        ajaxRequest.send().done(function(jsonObj, textStatus, jqXHR)
        {
            GRN_ApprovalFacilityStatusDialog.changeElement(jsonObj,"reject");
        });
    },
    changeElement : function(json_obj,action)
    {
        var using_time_elms     = jQuery("a[name='using_time_" + GRN_ApprovalFacilityStatusDialog.eventId +"']");
        var approval_status_elm = jQuery("#approval_status_" + GRN_ApprovalFacilityStatusDialog.eventId + "_" + GRN_ApprovalFacilityStatusDialog.facilityId);
        var handle_btn          = jQuery("#approval_handle_btn_" + GRN_ApprovalFacilityStatusDialog.eventId + "_" + GRN_ApprovalFacilityStatusDialog.facilityId);
        var record_elm          = jQuery("#approval_record_" + GRN_ApprovalFacilityStatusDialog.eventId + "_" + GRN_ApprovalFacilityStatusDialog.facilityId);

        using_time_elms.each( function(){
            jQuery(this).html(json_obj.using_time);
            jQuery(this).next().html(json_obj.using_time_html);
        });
        switch (action)
        {
            case "approve":
                var filter_btn_val  = jQuery("#approval_filter_status").val();
                if( filter_btn_val == "1" )
                {
                    record_elm.fadeOut("slow",function(){
                        record_elm.remove();
                    });
                }
                else
                {
                    approval_status_elm.html(GRN_ApprovalFacilityStatusDialog.approve_word);
                    approval_status_elm.removeClass();
                    approval_status_elm.addClass("facility_status_approval_grn");
                    handle_btn.remove();
                }
                break;
            case "reject":
                record_elm.fadeOut("slow",function(){
                    record_elm.remove();
                });
                break;
            default:
                break;
        }

        GRN_ApprovalFacilityStatusDialog.closeDialog();
    }
};

(function(){
    YAHOO.util.Event.onDOMReady(function()
    {
        var dd = new YAHOO.util.DD("approval_status_dialog");
        dd.setHandleElId("approval_status_title");

        var dialog = document.getElementById("approval_status_dialog");
        var body = document.getElementsByTagName("body")[0];
        dialog.parentNode.removeChild(dialog);
        body.appendChild(dialog);

        var overlay = document.getElementById("overlay");
        overlay.parentNode.removeChild(overlay);
        body.appendChild(overlay);
    });
})();
</script>
{/literal}