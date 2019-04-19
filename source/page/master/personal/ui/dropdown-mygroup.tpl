<div class="margin_top explanation">{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-171' replace='true'}</div>

<form method="POST" action="{grn_pageurl page='personal/ui/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="tab" value="{$tab}" />

<table class="margin_top std_form">
  <tr>
    <th nowrap>{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-172' replace='true'}</th>
    <td>
      <table>
    <tbody>
      <tr>
        <td>
          {capture name='grn_personal_ui_GRN_PRS_UI_173'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-173' replace='true'}{/capture}{grn_radio name="position" id="upper" value="upper" caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_173 checked=$radio_button.upper}
        </td>
    </tr>
      <tr>
        <td>
          {capture name='grn_personal_ui_GRN_PRS_UI_174'}{cb_msg module='grn.personal.ui' key='GRN_PRS_UI-174' replace='true'}{/capture}{grn_radio name="position" id="lower" value="lower" caption=$smarty.capture.grn_personal_ui_GRN_PRS_UI_174 checked=$radio_button.lower}
        </td>
      </tr>
    </tbody>
      </table>
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
        jQuery.each([jQuery("#upper"), jQuery("#lower")], function (idx, elm) {
            elm.on("change", function () {
                confirm_on();
            });
        });
    });
</script>
{/literal}
