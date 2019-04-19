<script language="JavaScript" type="text/javascript">
aeid = "";
msg_conflict = "{cb_msg module='grn.schedule' key='conflict' replace='true'}";
//GTM-1625
msgAttendanceCheckNotAnswer = "{cb_msg module='grn.schedule' key='GRN_SCH-1036' replace='true'}";
span_confict = "<span class='attention'><img src='{$app_path}/grn/image/cybozu/attention16.gif?{$build_date}' border='0' title='" + msg_conflict + "' alt='" + msg_conflict + "' align='absmiddle'></span>";
view_detail_url = "{grn_pageurl page='schedule/view'}";
private_icon = "<img src='{$app_path}/grn/image/cybozu/image-common/privateMark_sub16.png?{$build_date}' border='0' align='absmiddle'>";
repeat_icon = "<img src='{$app_path}/grn/image/cybozu/repeat16.gif?{$build_date}' border='0' align='absmiddle'>";
report_icon = "<img src='{$app_path}/grn/image/cybozu/report16.gif?{$build_date}' border='0' align='absmiddle'>";
allday_icon = "<img src='{$app_path}/grn/image/cybozu/allday.gif?{$build_date}' border='0'>";
banner_icon = "<img src='{$app_path}/grn/image/cybozu/banner16.gif?{$build_date}' border='0'>";
//GTM-1625
attendanceCheckNotAnswerIcon = "<img class='unanswered_icon_base_grn' title='" + msgAttendanceCheckNotAnswer + "' src='{$app_path}/grn/image/cybozu/image-app-schedule/event_unanswered16.png?{$build_date}' border='0'>";
referer_key = "{$referer_key}";
csrf_ticket= "{$csrf_ticket}";
add_quick_url = "{grn_pageurl page='schedule/simple_add'}";
detail_modify_url = "{grn_pageurl page='schedule/modify'}";
detail_repeat_modify_url = "{grn_pageurl page='schedule/repeat_modify'}";
_url_ajax_checking = "{grn_pageurl page='schedule/drag_drop_checking'}";
btn_yes_stt = "{cb_msg module='grn.schedule' key='GRN_SCH-924' replace='true'}";
btn_cancel_stt = "{cb_msg module='grn.schedule' key='cancel_button' replace='true'}";
detail_modify_stt = "{cb_msg module='grn.schedule' key='GRN_SCH-926' replace='true'}";
loading_stt = "{cb_msg module='grn.schedule' key='GRN_SCH-923' replace='true'}";
browser_type = "{$browser.type}";
browser_ver_major = "{$browser.ver_major}";
short_date_format = "{$short_date_format|grn_noescape}";
locale = "{$html_tag_lang}";
enable_dragdrop = "{$enable_dragdrop}";
</script>
