{assign var="main_area_class" value="mainarea_portal_base_grn"}
{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_load_javascript file="js/dist/notification.js"}
<script language="javascript" type="text/javascript">
<!--
{foreach from=$javascript_identifier_value_list key=name item=value}
    var {$name} = {$value|grn_noescape};
{/foreach}
//-->
</script>
{if $is_portal_manager || $is_portlet_group_manager || $is_my_portal_manager || $is_my_portal_evaluate}
    {grn_load_javascript file="grn/html/page/portal/index.js"}
{/if}
{literal}
<style type="text/css">
    .portal_frame {
        position: relative;
    }

    .schedule_display_options {
        position: relative;
    }

    .schedule_display_options_dialog {
        right: 0;
    }
</style>
{/literal}
    <script type="text/javascript">
      var browser_type = "{$browser.type}";
      var browser_ver_major = "{$browser.ver_major}";
    </script>
<!-- GTM-101 -->
<!-- Drag drop schedule -->
{if not ( $browser.type == 'msie' ) && $enable_dragdrop && false}
<script type="text/javascript">
    var _url_ajax_checking = "{grn_pageurl page='schedule/drag_drop_checking'}";
    var _popup_loading = '<div class="dialog_base_grn"><div class="daialog_mainarea_grn"><form method="post" action=""><div class="mBottom15 tAlignCenter-grn"><div class="bold">{cb_msg module="grn.schedule" key="GRN_SCH-923" replace="true"}</div><div class="spinnerBoxBase-grn mTop15"><div class="spinnerBox-grn"></div></div></div><div class="daialog_indent_grn"><div class="mTop20 nowrap-grn buttonArea-grn"><span id="schedule_submit_button_loading"></span><span id="span_update" class="mRight15 aButtonStandardDisable-grn aButtonMain-grn"><a class="btn_yes" onclick="" href="javascript:void(0);"><span class="buttonSpacePlus-grn">{cb_msg module="grn.schedule" key="GRN_SCH-924" replace="true"}</span></a></span><span class="aButtonStandard-grn mRight15"><a class="btn_cancel" onclick="ddpopup_cancel()" href="javascript:void(0);"><span>{cb_msg module="grn.schedule" key="GRN_SCH-925" replace="true"}</span></a></span><span class="nowrap-grn mLeft15"><a href="{grn_pageurl page=$detail_url bdate=$bdate uid=$uid gid=$gid referer_key=$referer_key event=$event_id start_date=$start_date end_date=$end_date start_hour=$start_hour start_minute=$start_minute end_hour=$end_hour end_minute=$end_minute}" class="icon-advance-grn" referer="">{cb_msg module="grn.schedule" key="GRN_SCH-926" replace="true"}</a></span></div></div></form></div></div>';
    
    var disable_tooltip = 0;
    var resizing = 0;
    var moving = 0;
    var showing = 0;
    var pid = "";
    {literal}
    var plid_list = [];
    var window_obj = jQuery(window);
    var document_obj = jQuery(document);
    window_obj.on( "load", function(){
        setTimeout(function(){
            for(var i = 0;i < plid_list.length; i++)
            {
                dd_init("",plid_list[i]);
                dd_handle(plid_list[i]);
                
                jQuery("#user-popup"+plid_list[i]+"-div").css("z-index",31);
                jQuery("#user-popup"+plid_list[i]+"-if").css("z-index",30);
                jQuery("#facility-popup"+plid_list[i]+"-div").css("z-index",31);
                jQuery("#facility-popup"+plid_list[i]+"-if").css("z-index",30);
            }
        },1000);
        
        jQuery("#showIcon-grn").click(function(){
            for(var i = 0;i < plid_list.length; i++)
            {
                dd_remove(plid_list[i]);
            }
            setTimeout(function(){
                for(var i = 0;i < plid_list.length; i++)
                {
                    dd_init("",plid_list[i]);
                    dd_handle(plid_list[i]);
                }
            },1000);
        });

        var schedule_calendar = jQuery("#schedule_calendar");
        schedule_calendar.find("td > a").click(function(){
            for(var i = 0;i < plid_list.length; i++)
            {
                dd_remove(plid_list[i]);
            }
            setTimeout(function(){
                for(var i = 0;i < plid_list.length; i++)
                {
                    dd_init("",plid_list[i]);
                    dd_handle(plid_list[i]);
                }
            },1000);
        });
        
        schedule_calendar.find("td > select").change(function(){
            for(var i = 0;i < plid_list.length; i++)
            {
                dd_remove(plid_list[i]);
            }
            setTimeout(function(){
                for(var i = 0;i < plid_list.length; i++)
                {
                    dd_init("",plid_list[i]);
                    dd_handle(plid_list[i]);
                }
            },1000);
        });
        
        jQuery("div.appmenuToggleWrapper").click(function(){
            for(var i = 0;i < plid_list.length; i++)
            {
                dd_remove(plid_list[i]);
            }
            setTimeout(function(){
                for(var i = 0;i < plid_list.length; i++)
                {
                    dd_init("",plid_list[i]);
                    dd_handle(plid_list[i]);
                }
            },1000);
        });
        
        jQuery("#show_todosgroup_day").change(function(){
            for(var i = 0;i < plid_list.length; i++)
            {
                dd_remove(plid_list[i]);
            }
            setTimeout(function(){
                for(var i = 0;i < plid_list.length; i++)
                {
                    dd_init("",plid_list[i]);
                    dd_handle(plid_list[i]);
                }
            },1000);
        });
        var width_org = window_obj.width();
        var height_org = window_obj.height();
        window_obj.resize(function(){
            if( width_org == window_obj.width() && height_org == window_obj.height() )
            {
                return;
            }
            width_org = window_obj.width();
            height_org = window_obj.height();
            if((!resizing) && (!moving) && (!showing))
            {
                for(var i = 0;i < plid_list.length; i++)
                {
                    dd_remove(plid_list[i]);
                    dd_init("",plid_list[i]);
                    dd_handle(plid_list[i]);
                }
            }
            if(showing)
            {
                for(var j = 0;j < plid_list.length; j++)
                {
                    dd_zoom_display(plid_list[j]);
                }
                jQuery("#overlay").css({"width":document_obj.width()+'px','height':document_obj.height()+'px'});
            }
        });
    });
    {/literal}
</script>
{/if}
<!-- End GTM-101 -->

<!--tab_portal-->
<div class="mainarea_portal_grn">
    <div class="tab_portal">
        {if $portal_menu.portal}
            <div class="portal_tabgroup_grn">
                {foreach from=$portal_menu.portal key=pid item=portal}
                    {if $selected_pid == $pid}
                        {assign var='on_off' value='on'}
                    {elseif $selected_pid != $pid}
                        {assign var='on_off' value='off'}
                    {/if}
                    <table class="tab" border="0" cellspacing="0" cellpadding="0">
                        <tr height="24" style="cursor:default" nowrap>
                            <td class="tab_left_{$on_off}">&nbsp;</td>
                            <td class="tab_{$on_off}" style="font-size:11pt" nowrap>
                                <a href="{grn_pageurl page='portal/index' pid=$pid}">{$portal.title|escape}</a>
                            </td>
                            <td class="tab_right_{$on_off}" nowrap></td>
                        </tr>
                    </table>
                {/foreach}
            </div>
            {if $is_portal_manager || $is_portlet_group_manager || $is_my_portal_manager || $is_my_portal_evaluate}
                <div id="portal_operation_option_icon" class="tab_pulldown_menu_grn">
                    <span class="icon-showMenu-grn" title="{cb_msg module='grn.portal' key='GRN_POT-2' replace='true'}">
                        <div class="space-optionmenu-icon-grn">{grn_image image="image-common/menu_a16.png"}</div>
                    </span>
                    <div id="portal_operation_option_menu" class="pulldown_menu_grn" style="display: none;">{strip}
                        <ul>
                            {if $is_portal_manager || $is_my_portal_manager}
                                <li>
                                    <a href="{if $is_portal_manager}{grn_pageurl page='portal/operation/view' pid=$selected_pid}{else}{grn_pageurl page='portal/personal/view' pid=$selected_pid}{/if}">
                                        <span class="icon_inline_grn icon_setting_grn"></span>
                                        <span class="vAlignMiddle-grn">{$app_name|escape}{cb_msg module='grn.portal' key='GRN_POT-3' replace='true'}</span>
                                    </a>
                                </li>
                            {/if}
                            {if $is_portlet_group_manager}
                                <li>
                                    <a href="{grn_pageurl page='portal/operation/html_portlet_list' plid=$portlet.plid}">
                                        <span class="icon_inline_grn icon_setting_grn"></span>
                                        <span class="vAlignMiddle-grn">{cb_msg module='grn.portal' key='GRN_POT-4' replace='true'}</span>
                                    </a>
                                </li>
                            {/if}
                            {if $is_my_portal_evaluate}
                                <li>
                                    <a href="{grn_pageurl page='portal/personal/add'}">
                                        <span class="icon_inline_grn icon_add_grn"></span>
                                        <span class="vAlignMiddle-grn">{cb_msg module='grn.portal.personal' key='add' application_name=$app_name}</span>
                                    </a>
                                </li>
                            {/if}
                        </ul>
                    </div>{/strip}
                </div>
            {/if}
            <div class="tab_menu_end">&nbsp;</div>
        {/if}
    </div>
    <!--end of tab_portal-->
    <div{if $fixed} class="portal_fixed_grn"{/if}>
        {if $portlet_layout.layout_0}
        <table class="top_parts">
            <tr>
                <td class="portal_base_top_grn">
                    {foreach from=$portlet_layout.layout_0.portlet key=plid item=portlet}
                        <div class="portlet_base_grn">{grn_portal_include_portlet portlet=$portlet display="view"}</div>
                        <div class="portlet_margin_grn"></div>
                    {/foreach}
                </td>
            </tr>
        </table>
        {/if}
        <table class="top_parts portlet_main_table">
            <tr>
                {if $portlet_layout.layout_1}
                <td class="portal_base_left_grn"{if $fixed && $portal_layout[1]} style="width: {$portal_layout[1]}%;"{/if}>
                    {foreach from=$portlet_layout.layout_1.portlet key=plid item=portlet}
                        <div class="portlet_base_grn">{grn_portal_include_portlet portlet=$portlet display="view"}</div>
                        <div class="portlet_margin_grn"></div>
                    {/foreach}
                </td>
                {/if}
                {if $portlet_layout.layout_2}
                <td class="portal_base_center_grn"{if $fixed && $portal_layout[2]} style="width: {$portal_layout[2]}%;"{/if}>
                    {foreach from=$portlet_layout.layout_2.portlet key=plid item=portlet}
                        <div class="portlet_base_grn">{grn_portal_include_portlet portlet=$portlet display="view"}</div>
                        <div class="portlet_margin_grn"></div>
                    {/foreach}
                </td>
                {/if}
                {if $portlet_layout.layout_3}
                <td class="portal_base_right_grn"{if $fixed && $portal_layout[3]} style="width: {$portal_layout[3]}%;"{/if}>
                    {foreach from=$portlet_layout.layout_3.portlet key=plid item=portlet}
                        <div class="portlet_base_grn">{grn_portal_include_portlet portlet=$portlet display="view"}</div>
                        <div class="portlet_margin_grn"></div>
                    {/foreach}
                </td>
                {/if}
            </tr>
        </table>
    </div>
</div>
{grn_load_customization_js_css}
{include file="grn/footer.tpl"}