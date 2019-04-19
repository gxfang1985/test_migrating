<div class="margin_top explanation">
{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-160' replace='true'}

<form method="POST" id="set_form" action="{grn_pageurl page='personal/ui/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="tab" value="{$tab}" />

<input type="hidden" id="clear_id" name="clear" value="none" />

<table class="margin_top std_form">
  <tr>
    <th nowrap>
      {cb_msg module='grn.personal.ui' key='GRN_PRS_UI-181' replace='true'}
    </th>
    <td>
      <table class="std_form">
        <tr>
          <th nowrap>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-162' replace='true'}</th>
          <td>
            {grn_select_numbers select_name=$config.group.name options=$config.group.options selected=$config.group.selected}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-177' replace='true'}
          </td>
        </tr>
        <tr>
          <th nowrap>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-163' replace='true'}</th>
          <td>
            {grn_select_numbers select_name=$config.user.name options=$config.user.options selected=$config.user.selected}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-177' replace='true'}
          </td>
        </tr>
        {if $is_schedule_available}
        <tr>
          <th nowrap>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-164' replace='true'}</th>
          <td>
            {grn_select_numbers select_name=$config.facilitygroup.name options=$config.facilitygroup.options selected=$config.facilitygroup.selected}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-177' replace='true'}
          </td>
        </tr>
        <tr>
          <th nowrap>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-165' replace='true'}</th>
          <td>
            {grn_select_numbers select_name=$config.facility.name options=$config.facility.options selected=$config.facility.selected}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-177' replace='true'}
          </td>
        </tr>
        {/if}
      </table>
    </td>
  </tr>
  <tr>
    <th valign="top" nowrap>
      {cb_msg module='grn.personal.ui' key='GRN_PRS_UI-182' replace='true'}
    </th>
    <td>
      {capture name='grn_personal_ui_GRN_PRS_UI_162'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-162' replace='true'}{/capture}{grn_checkbox id="clear-group" name="clear-group" value="1" caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_162}<br>
      {capture name='grn_personal_ui_GRN_PRS_UI_163'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-163' replace='true'}{/capture}{grn_checkbox id="clear-user" name="clear-user" value="1" caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_163}<br>
      {if $is_schedule_available}
      {capture name='grn_personal_ui_GRN_PRS_UI_164'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-164' replace='true'}{/capture}{grn_checkbox id="clear-facilitygroup" name="clear-facilitygroup" value="1" caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_164}<br>
      {capture name='grn_personal_ui_GRN_PRS_UI_165'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-165' replace='true'}{/capture}{grn_checkbox id="clear-facility" name="clear-facility" value="1" caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_165}<br>
      {/if}
    </td>
  </tr>
  <tr>
    <td nowrap></td>
    <td>
      {capture name='grn_personal_ui_GRN_PRS_UI_166'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-166' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_166}
      {grn_button_cancel class="margin" page="personal/common_list" id="ui"}
    </td>
  </tr>
</table>
</form>

{literal}
<script type="text/javascript" language="JavaScript">
    jQuery(function () {
        var select_elms = [
            jQuery("select[name='{/literal}{$config.group.name}{literal}']"),
            jQuery("select[name='{/literal}{$config.user.name}{literal}']"),
            jQuery("select[name='{/literal}{$config.facilitygroup.name}{literal}']"),
            jQuery("select[name='{/literal}{$config.facility.name}{literal}']")
        ];
        jQuery.each(select_elms, function (idx, elm) {
            elm.on("change", function () {
                confirm_on();
            })
        });
    });
</script>
{/literal}
