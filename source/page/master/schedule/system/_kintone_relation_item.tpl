{include file="grn/error_handler.tpl"}
{grn_load_javascript file="grn/html/page/schedule/system/kintone_relation_item.js"}
{grn_load_javascript file="fw/yui/build/dragdrop/dragdrop-min.js"}
<script language="JavaScript" text="text/javascript">
    var __itemJS = grn.page.schedule.system.kintone_relation_item;

    var __kintoneRecord = new __itemJS.KintoneRecord(
            "{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-596' replace='true'}",
            "{cb_msg module='grn.system.ui' key='GRN_SY_UI-29' replace='true'}",
            "{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-597' replace='true'}",
            "{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-598' replace='true'}",
            "{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-599' replace='true'}");

    __itemJS.get_k_dialog_data_url = "{grn_pageurl page='schedule/system/ajax/ajax_get_kintone_form'}";
    __itemJS.parent_url = "{grn_pageurl page='schedule/system/kintone_relation'}";

    __itemJS.delete_word = "{cb_msg module='grn.system.ui' key='GRN_SY_UI-29' replace='true'}";
    __itemJS.k_app_error_part_one = "{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-604' replace='true'}";
    __itemJS.k_app_error_part_two = "{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-605' replace='true'}";
</script>
<p></p>
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}">
  <input type="hidden" name="krid" value="{$krid}"/>
  <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}"/>
  <div>
    {cb_msg module='grn.grn' key='GRN_GRN-1265' replace='true'}
    <span class="attention">*</span>
    {cb_msg module='grn.grn' key='GRN_GRN-1266' replace='true'}
  </div>
  <table class="std_form table_type2_grn">
    <tbody>
      <!-- item name-->
      <tr>
        <th>{capture name='grn_schedule_system_GRN_SCH_SY_448'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-448' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_system_GRN_SCH_SY_448 necessary=true}</th>
        <td>
          {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name values=$multiLanguageInfoArray.values input_style="kintone"}
        </td>
      </tr>

      <!-- appointment type-->
      <tr valign="top">
        <th>{capture name='grn_schedule_system_GRN_SCH_SY_591'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-591' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_system_GRN_SCH_SY_591 necessary=true}</th>
        <td>
          <div class="mBottom10">
            {capture name='grn_schedule_system_GRN_SCH_SY_592'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-592' replace='true'}{/capture}
            {grn_checkbox name="appointment_type_all" id="appointment_type_all" value="1" checked=$appointment_types.all caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_592}
          </div>

          <div id="types_area" {if $appointment_types.all}class="disable_filter_grn"{/if}>
            {foreach from=$appointment_types.menus item=type_name}
            <div class="item_list_base_grn">
              <input type="hidden" name="appointment_types[]" value="{$type_name|escape}"/>
              <span class="item_list_block_grn">
                <span class="nowrap-grn float_left">{$type_name|escape}</span>
                <a title="{cb_msg module='grn.system.ui' key='GRN_SY_UI-29' replace='true'}" href="javascript:void(0);" onclick="__itemJS.delectAppointmentTypeRecord(this)">
                  <span class="icon-close-sub-grn v-allign-middle mLeft10 float_right"></span>
                </a>
              </span>
            </div>
            {/foreach}
            <a id="show_type_dialog" href="javascript:void(0)" class="icon_add_grn" onclick="__typeDialog.show();">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-593' replace='true'}</a>
          </div>
        </td>
      <tr>

      <!-- Kintone params-->
      <tr valign="top">
        <th>{capture name='grn_schedule_system_GRN_SCH_SY_595'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-595' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_system_GRN_SCH_SY_595 necessary=true}</th>
        <td>
          {foreach from=$kintone_data key=key item=item name=kintone_item}
          <div name="k_record_items">
            <table class="setting_base_type1_grn" style="min-width:550px;">
            <tr>
              <td>
                <div class="mBottom5"><span class="sub_title">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-596' replace='true'}</span></div>
                <div class="mBottom15">
                  <input name="k_app_id_edit" value="{$item.app_id}" size="50" maxlength="100" type="text" style="width:305px;" {if $item.field_code|@count > 0}disabled="disabled"{/if}>
                  <input name="k_app_id_value[]" value="{$item.app_id}" type="hidden" />
                  <div class="icon_information_sub_grn mTop5"><span class="messageSub-grn text_color_sub_grn">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-597' replace='true'}</span></div>
                </div>
                <div>
                  <div class="mBottom5"><span class="sub_title">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-598' replace='true'}</span></div>
                  <!-- field code list-->
                  {foreach from=$item.field_code key=field_key item=field_item}
                  <div class="item_list_base_grn">
                    <input type="hidden" name="field_code{$item.app_id}[]" value="{$field_item|escape}"/>
                    <span class="item_list_block_grn">
                      <span class="nowrap-grn float_left">{$field_item|escape}</span>
                      <a onclick="__itemJS.deleteFieldCode(this);" title="{cb_msg module='grn.system.ui' key='GRN_SY_UI-29' replace='true'}" href="javascript:void(0);"><span class="icon-close-sub-grn v-allign-middle mLeft10 float_right"></span></a>
                    </span>
                  </div>
                  {/foreach}
                  <div {if $item.field_code|@count eq 10 || !$item.app_id}class="disable_filter_grn"{/if}><a href="javascript:void(0)" class="icon_add_grn" onclick="__kDialog.show(this);">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-599' replace='true'}</a></div>
                </div>
              </td>
              {if $smarty.foreach.kintone_item.first}
              <td></td>
              {else}
              <td class="setting_base_type1_action_grn">
                <a href="javascript:void(0)" class="icon-delete-grn" onclick="__kintoneRecord.deleteKintoneRecordElements(this);">{cb_msg module='grn.system.ui' key='GRN_SY_UI-29' replace='true'}</a>
              </td>
              {/if}
            </tr>
            </table>
          </div>
          {/foreach}
          <!--add new kintone application button-->
          <div name="add_k_app" class="setting_div_type1_grn {if $kintone_data|@count eq 10}disable_filter_grn{/if}">
            <a href="javascript:void(0)" class="icon_add_grn" onclick=" __kintoneRecord.addKintoneRecordElements(this);">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-600' replace='true'}</a>
          </div>
        </td>
      </tr>

      <!-- two button-->
      <tr>
        <td></td>
        <td>
          <input type="button" onclick="__itemJS.saveData('{$form_name}', __dialogOverlay)" value="{if $page_action eq 'modify'}{cb_msg module='grn.system.application' key='GRN_SY_AP-25' replace='true'}{else}{cb_msg module='grn.system.application' key='GRN_SY_AP-58' replace='true'}{/if}" class="margin button_width_grn">
          {grn_image id="save_spinner" image='spinner.gif' class='none'}
          <input type="button" onclick="__itemJS.toParentPage()" value="{cb_msg module='grn.system.application' key='GRN_SY_AP-52' replace='true'}" class="button_width_grn">
        </td>
      </tr>
    </tbody>
  </table>
</form>

<div id="kintone_overlay" style="display:none;"></div>
<!-- type_dialog -->
<div id="appointment_type_dialog" style="top: 50px; left: 50px; z-index:1001; min-width: 500px; max-width: 700px; display:none;" class="subWindowBase-grn">
  <div class="subwindow_title_grn" id="appointment_type_title">
    <div class="subWindowTitleText-grn float_left">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-594' replace='true'}</div>
      <a href="javascript:void(0);" id="appointment_type_cancelImg" title="{cb_msg module='grn.grn' key='GRN_GRN-44' replace='true'}"><div class="subWindowClose-grn"></div></a>
      <div class="clear_both_0px"></div>
  </div>
  <div id="" class="subWindowContent-grn">
    <div class="sub_window_content_scroll_grn">
      <ul>
        {foreach from=$appoiniment_menus key=menu_id item=menus name=menus_name}
            {if $smarty.foreach.menus_name.first}{assign var="menu_first" value=$menus|escape}{/if}
        <li><input type="radio" {if $smarty.foreach.menus_name.first}checked="true"{/if} value="{$menus|escape}" name="appointment_type_value" class="radiobutton_grn"><label name="appointment_type_value_label" onmouseout="this.style.color=''" onmouseover="this.style.color='#ff0000'" >{$menus|escape}</label></li>
        {/foreach}
      </ul>
    </div>
    <div id="appointment_type_dialog_error" class="icon_attention_grn mTop5" style="max-width: 450px;display:none;">
        <span class="messageSub-grn attentionMessage-grn">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-602' replace='true'} </span>
    </div>
    <div class="buttonArea-grn">
      <span class="mRight15 aButtonStandard-grn aButtonMain-grn aButtonSubmit-grn">
        <input type="hidden" id="type_select_value" value="{$menu_first}">
        <a onclick="__itemJS.SelectAppointmentType(__typeDialog);" href="javascript:void(0);" id=""><span class="buttonSpacePlus-grn">{cb_msg module='grn.system.application' key='GRN_SY_AP-58' replace='true'}</span></a>
      </span>
      <span class="aButtonStandard-grn">
        <a id="appointment_type_cancelBtn" href="javascript:void(0);"><span>{cb_msg module='grn.system.application' key='GRN_SY_AP-52' replace='true'}</span></a>
      </span>
    </div>
  </div>
</div>

<!-- field code dialog -->
<div id="k_dialog" style="top: 50px; left: 50px; z-index:1001; min-width: 500px; max-width: 448px; display:none" id="" class="subWindowBase-grn">
  <div id="k_dialog_title" class="subwindow_title_grn">
    <div class="subWindowTitleText-grn float_left">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-601' replace='true'}</div>
    <a href="javascript:;" id="k_dialog_cancelImg" title="{cb_msg module='grn.grn' key='GRN_GRN-44' replace='true'}"><div class="subWindowClose-grn"></div></a>
    <div class="clear_both_0px"></div>
  </div>
  <div id="" class="subWindowContent-grn">
    <div id="k_dialg_content_area" class="sub_window_content_scroll_grn">
      <!-- zhe part load by ajax -->

    </div>
    <div id="k_dialog_error" class="icon_attention_grn mTop5" style="max-width: 450px;">
        <span class="messageSub-grn attentionMessage-grn">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-603' replace='true'}</span>
    </div>
    <div class="buttonArea-grn">
      <span class="mRight15 aButtonStandard-grn aButtonMain-grn aButtonSubmit-grn">
        <input type="hidden" value="" id="k_dialog_selected_val"/>
        <a href="javascript:void(0);" id="k_dialog_ok"><span class="buttonSpacePlus-grn">{cb_msg module='grn.system.application' key='GRN_SY_AP-58' replace='true'}</span></a>
      </span>
      <span class="aButtonStandard-grn">
        <a id="k_dialog_cancelBtn" href="javascript:void(0);"><span>{cb_msg module='grn.system.application' key='GRN_SY_AP-52' replace='true'}</span></a>
      </span>
    </div>
  </div>
</div>

<script language="JavaScript" text="text/javascript">
    var __dialogOverlay = new __itemJS.DialogOverlay("kintone_overlay");
    (function(){literal}{
        YAHOO.util.Event.onDOMReady(function(){
            var dd = new YAHOO.util.DD('appointment_type_dialog');
            dd.setHandleElId('appointment_type_title');

            var dialog = $('appointment_type_dialog');
            var body = document.getElementsByTagName('body')[0];
            dialog.parentNode.removeChild(dialog);
            body.appendChild(dialog);

            var ddB = new YAHOO.util.DD('k_dialog');
            ddB.setHandleElId('k_dialog_title');
            var dialogB = $('k_dialog');
            dialogB.parentNode.removeChild(dialogB);
            body.appendChild(dialogB);

            var overlay = $('kintone_overlay');
            overlay.parentNode.removeChild(overlay);
            body.appendChild(overlay);
        });
    }{/literal})();

    var __typeDialog = new __itemJS.TypeDialog("appointment_type_dialog", "appointment_type_value","type_select_value", __dialogOverlay, "appointment_type_dialog_error", "appointment_type_value_label");
    __typeDialog.setCancelClick("appointment_type_cancelBtn");
    __typeDialog.setCancelClick("appointment_type_cancelImg");

    var __kDialog = new __itemJS.KintoneDialog("k_dialog", "k_dialg_content_area", __dialogOverlay,"k_dialog_ok","k_dialog_error");
    __kDialog.setCancelClick("k_dialog_cancelImg");
    __kDialog.setCancelClick("k_dialog_cancelBtn");
    __itemJS.kDialog = __kDialog;

</script>