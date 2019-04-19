{grn_load_javascript file="fw/yui/build/dragdrop/dragdrop-min.js"}
<div class="subWindowBase-grn" id="status_dialog" style="width: auto; max-width:800px; display:none;">
  <form id="attendance_status" name="form_attendance_status" method="post" action="{grn_pageurl page='schedule/command_attendance_status_update'}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" id="event_id" name="event">
    <div class="subwindow_title_grn" id="status_dialog_header">
      <div class="subWindowTitleText-grn float_left">{cb_msg module='grn.schedule' key='GRN_SCH-1021' replace='true'}</div>
      <a onclick="GRN_ScheduleAttendanceStatus.closeStatusDialog();" href="javascript:;"><div class="subWindowClose-grn" title="{cb_msg module='grn.grn' key='GRN_GRN-44' replace='true'}"></div></a>
      <div class="clear_both_0px"></div>
    </div>
    <div class="subWindowContent-grn">
    <div class="content" style="min-height: 120px;">
      <table class="form_table01_grn">
        <tbody>
          <tr valign="top">
            <th>{cb_msg module='grn.schedule' key='GRN_SCH-42' replace='true'}</th>
            <td id="schedule_title"></td>
          </tr>
          <tr valign="top">
            <th>{cb_msg module='grn.schedule' key='GRN_SCH-1027' replace='true'}</th>
            <td>
              {strip}
              <span class="radiobutton_base_grn">
                <input type="radio" onclick="" value="attendant" id="status_attend" name="status">
                <label onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'" for="status_attend" style="">{cb_msg module='grn.schedule' key='GRN_SCH-1006' replace='true'}</label>
              </span>
              <span class="radiobutton_base_grn">
                <input type="radio" onclick="" value="absent" id="status_absent" name="status">
                <label onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'" for="status_absent" style="">{cb_msg module='grn.schedule' key='GRN_SCH-1007' replace='true'}</label>
              </span>
              {/strip}
            </td>
          </tr>
          <tr valign="top">
            <th>{cb_msg module='grn.schedule' key='GRN_SCH-1031' replace='true'}</th>
            <td>
              <div class="form_text_base_grn">
                <textarea wrap="virtual" id="status_comment_text" name="message" class="autoexpand textarea_sub_grn form_textarea_grn"></textarea>
                <textarea id="dummy_textarea_status_comment_text" style="display: none;"></textarea>
              </div>
              <div id="conflict_msg" style="display:none;" class="mTop10"><span class="icon_attention_grn">{cb_msg module='grn.schedule' key='GRN_SCH-1005' replace='true'}</span></div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div class="buttonArea-grn">{strip}
      {capture name="grn_grn_GRN_GRN_321"}{cb_msg module='grn.grn' key='GRN_GRN-321' replace='true'}{/capture}
      {capture name="grn_schedule_GRN_SCH_739"}{cb_msg module='grn.schedule' key='GRN_SCH-739' replace='true'}{/capture}
      {grn_button ui="main" spacing="normal" caption=$smarty.capture.grn_grn_GRN_GRN_321 onclick="GRN_ScheduleAttendanceStatus.updateScheduleAttendanceStatus()"}
      {grn_button caption=$smarty.capture.grn_schedule_GRN_SCH_739 onclick="GRN_ScheduleAttendanceStatus.closeStatusDialog()"}
    {/strip}</div>
    </div>
  </form>
</div>
{literal}
<script language="JavaScript" type="text/javascript">
GRN_ScheduleAttendanceStatus = {
    openStatusDialog: function(position_elm){
        this.disableOnKeyDown(GRN_ScheduleAttendanceStatus.closeStatusDialog);
        var dialog = jQuery('#status_dialog');
        dialog.show();
        var body = ((document.documentElement.clientHeight==0)? document.getElementsByTagName('body')[0] : document.documentElement);
        if (typeof window.pageYOffset != 'undefined')
        {
            var scrollTop = window.pageYOffset;
        }
        else
        {
            var scrollTop = body.scrollTop;
        }

        var top = (body.clientHeight - dialog.height())/2 + scrollTop + 'px';

        if ( typeof position_elm != "undefined" && position_elm != null )
        {
            var button = jQuery(position_elm);
            if ( button.length )
            {
                var position = button.position();
                top = position.top + button.height() + 10 + 'px';
            }
        }
        var left = (body.clientWidth - dialog.width())/2 + 'px';

        dialog.css({"top": top, "left": left, "zIndex":120});
        jQuery('#status_comment_text').focus();
    },
    old_onkeydown_handler:null,
    disableOnKeyDown: function( closeHandler )
    {
        if( ! GRN_ScheduleAttendanceStatus.old_onkeydown_handler )
        {
            GRN_ScheduleAttendanceStatus.old_onkeydown_handler = document.onkeydown;
        }
        document.onkeydown = function(e){
            e = (e == undefined) ? event : e;
            if( GRN_Event.keyCode(e) == 27 ) //ESC key
                return closeHandler();
        };
    },
    enableOnKeyDown: function()
    {
        document.onkeydown = GRN_ScheduleAttendanceStatus.old_onkeydown_handler;
        GRN_ScheduleAttendanceStatus.old_onkeydown_handler = null;
    },
    closeStatusDialog: function()
    {
        var dialog = jQuery('#status_dialog');
        dialog.hide();
        GRN_ScheduleAttendanceStatus.enableOnKeyDown();
    },
    getScheduleAttendanceStatus : function( eventId, position_elm )
    {
        var params = new Object();
        params.event = eventId;
        pageurl = "{/literal}{grn_pageurl page='schedule/get_schedule_attendance_status'}{literal}";

        jQuery("#status_comment_text").val("");

        var ajaxRequest = new grn.component.ajax.request({
          url: pageurl,
          method: "post",
          dataType: "json",
          grnRedirectOnLoginError: true,
          data:   params
        });

        ajaxRequest.send().done(function (data, textStatus, jqXHR) {
            //title
            jQuery("#schedule_title").text(data.title).html();
            //status
            if (data.status === "0")
            {
                jQuery("#status_absent").prop('checked', true);
            }
            else
            {
                jQuery("#status_attend").prop('checked', true);
            }
            //message
            if (data.message.length != 0){
                jQuery("#status_comment_text").val(data.message);
            }
            //event
            jQuery("#event_id").val(data.event_id);
            //conflict
            if (data.conflict === true){
                jQuery("#conflict_msg").css("display", "block");
            }
            else
            {
                jQuery("#conflict_msg").css("display", "none");
            }

            GRN_ScheduleAttendanceStatus.openStatusDialog(position_elm);
        });
    },
    checkSubmit:false,
    updateScheduleAttendanceStatus : function()
    {
        if (GRN_ScheduleAttendanceStatus.checkSubmit)
        {
            return false;
        }

        var form = jQuery( "#attendance_status" );
        var submitPage = form.attr("action");
        if (typeof submitPage === "undefined")
        {
            return;
        }

        var ajaxRequest = new grn.component.ajax.request({
            url: submitPage,
            method: "post",
            dataType: "json",
            data:   form.serialize(),
            beforeSend: function()
            {
                GRN_ScheduleAttendanceStatus.checkSubmit = true;
                GRN_ScheduleAttendanceStatus.togglePostingLoading(true);
            }
        });

        ajaxRequest.on("beforeShowError", function(e, jqXHR){
            GRN_ScheduleAttendanceStatus.closeStatusDialog();
        });

        ajaxRequest.send().done(function ( data, textStatus, jqXHR ){
            if (typeof updateHtmlFn === "function")
            {
                updateHtmlFn(data);
            }
            GRN_ScheduleAttendanceStatus.closeStatusDialog();
        }).always( function(response){
            GRN_ScheduleAttendanceStatus.checkSubmit = false;
            GRN_ScheduleAttendanceStatus.togglePostingLoading(false);
        });
    },
    togglePostingLoading: function( loading )
    {
        var $button = jQuery("#attendance_status_button");

        if (!loading) {
            $button.removeClass('button_standard_disable_grn').addClass('aButtonStandard-grn aButtonMain-grn');
        }
        else
        {
            $button.removeClass('aButtonStandard-grn aButtonMain-grn').addClass('button_standard_disable_grn');
        }
    },
    handlerClick : function( evt ) {
        var target = evt.target || evt.srcElement;
        if( !( YAHOO.util.Dom.isAncestor( 'status_dialog', target) ) ) {
            GRN_ScheduleAttendanceStatus.closeStatusDialog();
        }
    }
};

(function() {
    YAHOO.util.Event.onDOMReady(function()
    {
        var dd = new YAHOO.util.DD('status_dialog');
        dd.setHandleElId('status_dialog_header');

        var dialog = document.getElementById('status_dialog');
        var body = document.getElementsByTagName('body')[0];
        dialog.parentNode.removeChild(dialog);
        body.appendChild(dialog);
    });
})();

Event.observe( window.document, "click", GRN_ScheduleAttendanceStatus.handlerClick.bind(this) );
</script>
{/literal}
