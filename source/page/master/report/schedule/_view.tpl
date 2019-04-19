    {grn_load_css file="grn/html/report.css"}
    {grn_load_javascript file="grn/html/report.js"}
    <div class="cover" style="display:none;" id="background"></div>
    {literal}
    <script language="JavaScript" type="text/javascript">
    <!--
        var eid = "{/literal}{$schedule_event.event_id}{literal}";
        var date = "{/literal}{$bdate}{literal}";
        var selectReportListUrl = "{/literal}{grn_pageurl page='report/ajax/select_report_list'}{literal}";
        var categoryListUrl = "{/literal}{grn_pageurl page='report/ajax/category_list'}{literal}";
        var plusImage = '{/literal}{$app_path}{literal}/grn/image/cybozu/plus.gif';
        var minusImage = '{/literal}{$app_path}{literal}/grn/image/cybozu/minus.gif';    

        var formListUrl = "{/literal}{grn_pageurl page='report/ajax/send_form_list'}{literal}";
        var userType = "{/literal}{$page_info.parts[1]}{literal}";
        var csrf_ticket = "{/literal}{$csrf_ticket}{literal}";

        function disableButtons(form){
            jQuery("#reportRelationForm input[type='button']").each(function(){jQuery(this).prop("disabled",true);});
            jQuery("#reportRelationForm input[type='radio']").each(function(){jQuery(this).prop("disabled",true);});
            jQuery("#reportRelationForm input[type='text']").each(function(){jQuery(this).prop("disabled",true);});
            reportRelationNaviCallBack = function(){};
            document.onkeydown = function(){};
            document.getElementById("closeRelationDialog").onclick = function(){};
            document.body.style.cursor = 'progress';
        }
        //-->
    </script>
    {/literal}
     <div style="display:none;">
             <input type="submit" value="{cb_msg module='grn.report.schedule' key='GRN_RPRT_SCH-6' replace='true'}"/>
             <input type="button" value="{cb_msg module='grn.report.schedule' key='GRN_RPRT_SCH-7' replace='true'}" onclick="closeReportRelationConfirmWindow();" />
     </div>
     <div id="reportRelationWindow" class="msgbox" style="display:none;">
         <div class="title">
             {cb_msg module='grn.report.schedule' key='GRN_RPRT_SCH-8' replace='true'}
            <a id="closeRelationDialog" style="position: absolute; right: 5px;top:5px;text-decoration:none;" onclick="closeReportRelationWindow();" href="javascript:;">{grn_image image="close20.gif"}</a>
         </div>
        <form method="post" id="reportRelationForm" action="{grn_pageurl page='report/command_report_schedule_relation'}">
             <div class="content" style="position:relative;">
                 <div style="position:absolute;right:20px;top:5px;">
                     <span style="width:20px;">
                         <img border="0" align="top" id="reportLoadingImage" src="{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}" />
                     </span>
                    <input type="text" id="searchReportText" onkeypress="return redirectEnterkey(event.keyCode,'selectReportSearch');"/>&nbsp;<input type="button" id="selectReportSearch" value="{cb_msg module='grn.report.schedule' key='GRN_RPRT_SCH-10' replace='true'}" onclick="showReportRelationWindow(0);" />&nbsp;
                </div>
                 <div id="reportRelationContent">
                 </div>
                {if $schedule_event.type == 'repeat' || $schedule_event.type == 'share_repeat'}
                    <br /><span class="sub_explanation">{cb_msg module='grn.report.schedule' key='GRN_RPRT_SCH-11' replace='true'}</span>
                {/if}
                {strip}
                    <div class="mTop10 tAlignCenter-grn">
                        {capture name='grn_report_schedule_relation'}{cb_msg module='grn.report.schedule' key='grn.report.schedule.relation' replace='true'}{/capture}
                        {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_report_schedule_relation id='reportRelationSubmit' disabled=true}

                        {grn_button action="cancel" id="report_button_cancel" onclick="closeReportRelationWindow();"}
                    </div>
                {/strip}
            </div>
            <input type="hidden" name="addFlg" value="1"/>
            <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
            <input type="hidden" name="eid" value="{$schedule_event.event_id}"/>
            <input type="hidden" name="date" value="{$bdate|escape}" />
            <input type="hidden" name="from" value="schedule" />
        </form>
     </div>
     <script type="text/javascript" src="{$app_path}/fw/yui/build/yahoo/yahoo-min.js?{$build_date}" ></script>
     <script type="text/javascript" src="{$app_path}/fw/yui/build/treeview/treeview.js?{$build_date}" ></script>

     <div id="categoryFormListWindow" class="msgbox" style="display:none;">
        <div class="title">
            <a class="categoryFormListWindow_close" onclick="closeFormSelectWindow();" href="javascript:;">{grn_image image="close20.gif"}</a>
            {cb_msg module='grn.report.schedule' key='GRN_RPRT_SCH-13' replace='true'}
        </div>
        <div id="categoryFormListWindow_inner" class="content">
                <table class="categoryFormListWindow_table">
                    <tr valign="top">
                        <td style="width:50%;">
                            <div id="tree_part" class="categoryFormListWindow_tree_part">
                                {include file='grn/org_tree_26.tpl'}
                            </div>
                        </td>
                              {* window.onload では、ツリーの初期化前に onSelectCategory が実行されてしまうため初期化イベントの設定後に設定 *}
                        <script type="text/javascript" src="{$app_path}/fw/yui/build/yahoo/yahoo-min.js?{$build_date}" ></script>
                        {literal}
                        <script language="javascript">
                        <!--
                            YAHOO.util.Event.onDOMReady(function()
                            {
                                onSelectCategory(1);
                                jQuery(window).resize(function(){
                                    var body = document.body;
                                    jQuery('#background').width(Math.max(body.clientWidth,body.scrollWidth)).height(Math.max(body.clientHeight,body.scrollHeight));
                                });
                            });
                        //-->
                        </script>
                        {/literal}
                        <td width="50%">
                            <div id="view_part" class="categoryFormListWindow_contents">
                              <img border="0" align="top" id="reportLoadingImage" src="{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}"/>
                              </div>
                        </td>
                    </tr>
                </table>

            {if $schedule_event.type == 'repeat' || $schedule_event.type == 'share_repeat'}
                &nbsp;&nbsp;<span class="sub_explanation">{cb_msg module='grn.report.schedule' key='GRN_RPRT_SCH-16' replace='true'}</span>
            {/if}
        </div>
     </div>
