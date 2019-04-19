{grn_load_css file="grn/html/mobile_favour.css"}
{grn_load_javascript file="grn/html/page/favour/mobile/favour.js"}
{grn_load_javascript file="grn/html/component/mobile_list_more_view.js"}

{literal}
<script language="JavaScript" text="text/javascript">
    (function()
    {
        var G = grn.page.favour.mobile.favour;
        G.spinner_image = grn.component.url.image("cybozu/spinner.gif");
        G.favour_url = grn.component.url.page("favour/mobile/ajax/command_favour");
        G.csrf_ticket = {/literal}'{$csrf_ticket}'{literal};
        G.get_favour_list_url = grn.component.url.page("favour/mobile/ajax/user_list_popup");
    })();
</script>
{/literal}

{capture name='list_title'}{cb_msg module="grn.favour" key="GRN_FAV-4" replace='true'}{grn_favour_app_name}{cb_msg module='grn.favour' key='GRN_FAV-7' replace='true'}{/capture}
<div data-role="popup" id="favour_user_list" data-position-to="#positionPopup" data-corners="false"
     data-overlay-theme="b" data-shadow="false">
  <div class="mobile_select_menu_titlebar_div_grn">
    <div class="mobile_titlebar_grn">
      <span class="mobile_text_grn">{$smarty.capture.list_title}</span>
        <a href="#" data-rel="back" class="mobile_titlebar_right_grn mobile_colse_icon_grn"></a>
    </div>
    <ul id="favour_list_popup" data-role="listview" data-theme="{$data_theme}"
      class="mobile-top-listview-member-grn mobile-bottom-listview-member-grn mobile_ul_grn mobile_attendance_userListUl_grn">
    </ul>
    <div class="mobile_select_button_area_grn">
      <div class="mobile_cancel_grn">
        <input class="cancel_button" type="reset"
         value="{cb_msg module='grn.mobile' key='GRN_MOBILE-14' replace='true'}" data-inline="true"
         data-theme="{$data_theme}"/>
      </div>
    </div>
  </div>
</div>
<div id="positionPopup" style="position:fixed;top:0px;display=none"></div>