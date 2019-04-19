{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

{assign var='work_hours_list_count' value=$user_base_setting.work_hours_list|@count}
{include file='system/calendar/base/_base_work_hours_script.tpl' next_number=$work_hours_list_count+1}
<form name="{$form_name}" method="post" action="{grn_pageurl page='personal/calendar/command_base'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}"><p></p>
  <table id="form1" class="std_form" style="margin-bottom: 20px;">
    <colgroup width="100px" />
    <tbody>
      <tr>
        <th>{cb_msg module='grn.personal.i18n' key='base_setting' replace='true'}</th>
        <td>
          <select name="base" id="base">
            {if $user_modified && $user_base_setting.base.id}
                <option class="user-modified-base" value="{$user_base_setting.base.id}" selected>{$user_base_setting.base.local_name}{cb_msg module='grn.personal.i18n' key='modified_base' replace='true'}</option>
            {/if}
            {foreach from=$bases item=base}
                <option value="{$base.id}" {if $base.id == $user_base_setting.base.id && !$user_modified}selected{/if}>{if strlen($base.local_name)}{$base.local_name}{else}{$base.name}{/if}</option>
            {/foreach}
            <option id="blank-base" value="" {if !$user_base_setting || !$user_base_setting.base.id}selected{/if}>{cb_msg module='grn.personal.i18n' key='GRN_PE_I18N-5' replace='true'}</option>
          </select>
        </td>
      </tr>
    </tbody>
  </table>

  <div id="caption-specific" class="sub_title margin_top">{cb_msg module='grn.personal.i18n' key='GRN_PE_I18N-6' replace='true'}</div>
  <table id="form2" class="std_form">
    <colgroup width="100px" />
    <tbody>
{include file='system/calendar/base/_base_input_optional.tpl' base=$user_base_setting calendars=$calendars minute_interval=$minute_interval}
      <tr>
        <td></td>
        <td>
          <input type="submit" style="" onclick="grn_onsubmit_common(this.form)" value="{cb_msg module='grn.personal.i18n' key='GRN_PE_I18N-2' replace='true'}" class="margin">
          <input type="button" onclick="history.back()" value="{cb_msg module='grn.personal.i18n' key='GRN_PE_I18N-16' replace='true'}" class="">
        </td>
      </tr>
    </tbody>
  </table>
</form>
<script type="text/javascript">{literal}
jQuery(function(){
    var bases = {
        {/literal}{foreach from=$bases item=base name='base_list'}
        "{$base.id}": {literal}{{/literal}
            "name": "{$base.local_name}",
            "workday_sunday": {if $base.workday_sunday}true{else}false{/if},
            "workday_monday": {if $base.workday_monday}true{else}false{/if},
            "workday_tuesday": {if $base.workday_tuesday}true{else}false{/if},
            "workday_wednesday": {if $base.workday_wednesday}true{else}false{/if},
            "workday_thursday": {if $base.workday_thursday}true{else}false{/if},
            "workday_friday": {if $base.workday_friday}true{else}false{/if},
            "workday_saturday": {if $base.workday_saturday}true{else}false{/if},
            "apply_calendar": {if $base.apply_calendar}true{else}false{/if},
            "work_hours": {literal}[{/literal}
                {foreach from=$base.work_hours_list item=work_hours name='work_hours_list'}
                    {literal}{{/literal}
                    "start": {literal}{{/literal}
                        "hour":{$work_hours.start->hour},
                        "minute":{$work_hours.start->minute}
                        {literal}}{/literal},
                    "end": {literal}{{/literal}
                        "hour":{$work_hours.end->hour},
                        "minute":{$work_hours.end->minute}
                        {literal}}{/literal}
                    {literal}}{/literal}{if !$smarty.foreach.work_hours_list.last},{/if}
                {/foreach}
                {literal}]{/literal},
            "calendar": "{$base.calendar.id}"
            {literal}}{/literal}{if !$smarty.foreach.base_list.last},{/if}
        {/foreach}{literal}
    };

    {/literal}
    {if $user_base_setting && !$user_base_setting.base.id}
    bases.blank_base = {literal}{{/literal}
        "name": "{$user_base_setting.local_name}",
        "workday_sunday": {if $user_base_setting.workday_sunday}true{else}false{/if},
        "workday_monday": {if $user_base_setting.workday_monday}true{else}false{/if},
        "workday_tuesday": {if $user_base_setting.workday_tuesday}true{else}false{/if},
        "workday_wednesday": {if $user_base_setting.workday_wednesday}true{else}false{/if},
        "workday_thursday": {if $user_base_setting.workday_thursday}true{else}false{/if},
        "workday_friday": {if $user_base_setting.workday_friday}true{else}false{/if},
        "workday_saturday": {if $user_base_setting.workday_saturday}true{else}false{/if},
        "apply_calendar": {if $user_base_setting.apply_calendar}true{else}false{/if},
        "work_hours": {literal}[{/literal}
            {foreach from=$user_base_setting.work_hours_list item=work_hours name='work_hours_list'}
                {literal}{{/literal}
                "start": {literal}{{/literal}
                    "hour":{$work_hours.start->hour},
                    "minute":{$work_hours.start->minute}
                    {literal}}{/literal},
                "end": {literal}{{/literal}
                    "hour":{$work_hours.end->hour},
                    "minute":{$work_hours.end->minute}
                    {literal}}{/literal}
                {literal}}{/literal}{if !$smarty.foreach.work_hours_list.last},{/if}
            {/foreach}
            {literal}]{/literal},
        "calendar": "{$user_base_setting.calendar.id}"
        {literal}};{/literal}
    {/if}
    {literal}

    function setWorkHoursChangedEvent() {
        var i = 1;
        while (true) {
            if (!(jQuery("#work_hours_" + i).length > 0)) {
                break;
            }

            var start_end_time_elms = [jQuery("#start_work_hours_" + i + "_hour"), jQuery("#start_work_hours_" + i + "_minute"), jQuery("#end_work_hours_" + i + "_hour"), jQuery("#end_work_hours_" + i + "_minute")];
            jQuery.each(start_end_time_elms, function (idx, elm) {
                if (!(elm.length > 0)) {
                    return;
                }
                elm.on("change", onModified);
            });

            jQuery("#remove_work_hours_" + i).each(function (idx, elm) {
                if (!elm) {
                    return;
                }
                jQuery(elm).on("click", onModified);
            });
            i++;
        }
    }

    jQuery("#base").on("change", function () {
        var oldNextNumber = GRN_BaseWorkHours.nextNumber;
        var selected_base = null;
        var base_elm = jQuery("#base");
        if (base_elm.find("option:selected").attr("id") == "blank-base") {
            selected_base = "blank_base";
        } else {
            selected_base = base_elm.val();
        }

        jQuery(".user-modified-base").each(function (idx, elm) {
            jQuery(elm).remove();
        });

        if (!(selected_base in bases)) {
            return;
        }

        var sunday_elm = jQuery("#sunday");
        if (sunday_elm.length > 0) {
            sunday_elm.prop("checked", bases[selected_base].workday_sunday);
        }

        var monday_elm = jQuery("#monday");
        if (monday_elm.length > 0) {
            monday_elm.prop("checked", bases[selected_base].workday_monday);
        }

        var tuesday_elm = jQuery("#tuesday");
        if (tuesday_elm.length > 0) {
            tuesday_elm.prop("checked", bases[selected_base].workday_tuesday);
        }

        var wednesday_elm = jQuery("#wednesday");
        if (wednesday_elm.length > 0) {
            wednesday_elm.prop("checked", bases[selected_base].workday_wednesday);
        }

        var thursday_elm = jQuery("#thursday");
        if (thursday_elm.length > 0) {
            thursday_elm.prop("checked", bases[selected_base].workday_thursday);
        }

        var friday_elm = jQuery("#friday");
        if (friday_elm.length > 0) {
            friday_elm.prop("checked", bases[selected_base].workday_friday);
        }

        var saturday_elm = jQuery("#saturday");
        if (saturday_elm.length > 0) {
            saturday_elm.prop("checked", bases[selected_base].workday_saturday);
        }

        var apply_calendar_elm = jQuery("#apply_calendar");
        if (apply_calendar_elm.length > 0) {
            apply_calendar_elm.prop("checked", bases[selected_base].apply_calendar);
        }

        function updateSelectBox(element_jquery_obj, value) {
            element_jquery_obj.find("option").each(function (idx, elm) {
                if (elm.value == value) {
                    element_jquery_obj.val(elm.value);
                }
            });
        }

        var workHoursNum = bases[selected_base].work_hours.length;
        for (var i = 0; i < workHoursNum; i++) {
            var elementNum = i + 1;
            var work_hours = bases[selected_base].work_hours[i];

            if (!(jQuery("#work_hours_" + elementNum).length > 0) && GRN_BaseWorkHours.count() < 10) {
                GRN_BaseWorkHours.nextNumber = elementNum;
                GRN_BaseWorkHours.copy();
            }

            updateSelectBox(jQuery("#start_work_hours_" + elementNum + "_hour"), work_hours.start.hour);
            updateSelectBox(jQuery("#start_work_hours_" + elementNum + "_minute"), work_hours.start.minute);
            updateSelectBox(jQuery("#end_work_hours_" + elementNum + "_hour"), work_hours.end.hour);
            updateSelectBox(jQuery("#end_work_hours_" + elementNum + "_minute"), work_hours.end.minute);
        }

        var removeNum = workHoursNum + 1;
        while (removeNum <= oldNextNumber) {
            var work_hours_elm = jQuery("#work_hours_" + removeNum);
            if (work_hours_elm.length > 0) {
                work_hours_elm.remove();
            }

            removeNum++;
        }
        GRN_BaseWorkHours.nextNumber = workHoursNum + 1;
        GRN_BaseWorkHours.check();

        updateSelectBox(jQuery("#calendar"), bases[selected_base].calendar);

        setWorkHoursChangedEvent();

        jQuery("#add_work_hours_button").each(function (idx, elm) {
            if (!elm) {
                return;
            }

            jQuery(elm).on("click", onModified);
        })
    });

    function onModified() {
        var base_jquery_obj = jQuery("#base");
        var old_base_value = base_jquery_obj.val();

        if (old_base_value !== "") {
            var modifiedBaseNode = base_jquery_obj.find(".user-modified-base");
            if (modifiedBaseNode.length > 0) {
                modifiedBaseNode = modifiedBaseNode.get(0);
            } else {
                modifiedBaseNode = document.createElement("option");
                modifiedBaseNode.setAttribute("class", "user-modified-base");
                modifiedBaseNode.setAttribute("value", old_base_value);
                modifiedBaseNode.text = bases[old_base_value].name + "{/literal}{cb_msg module='grn.personal.i18n' key='modified_base' replace='true'}{literal}";
                if (grn.browser.msie) {
                    base_jquery_obj.prepend(modifiedBaseNode);
                } else {
                    jQuery(modifiedBaseNode).insertBefore(base_jquery_obj.find("option").get(0));
                }
            }

            base_jquery_obj.find("option").each(function (idx, elm) {
                elm.selected = false;
            });

            modifiedBaseNode.selected = true;
        } else {
            updateBlankBaseData();
        }
    }

    function updateBlankBaseData() {
        blankBaseData = new Object();
        jQuery.each(['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday'], function (idx, week) {
            blankBaseData['workday_' + week] = document.getElementById(week).checked;
        });

        blankBaseData['work_hours'] = new Array();
        jQuery(".work_hours").each(function (idx, node) {
            work_hour_data = new Object();
            work_hour_data["start"] = new Object();
            work_hour_data["end"] = new Object();
            work_hour_data["start"]["hour"] = jQuery("#start_" + node.id + "_hour").val();
            work_hour_data["start"]["minute"] = jQuery("#start_" + node.id + "_minute").val();
            work_hour_data["end"]["hour"] = jQuery("#end_" + node.id + "_hour").val();
            work_hour_data["end"]["minute"] = jQuery("#end_" + node.id + "_minute").val();
            blankBaseData["work_hours"][idx] = work_hour_data;
        });
        blankBaseData["calendar"] = jQuery("#calendar").val();
        blankBaseData["apply_calendar"] = jQuery("#apply_calendar").val();

        bases["blank_base"] = blankBaseData;
    }

    setWorkHoursChangedEvent();

    jQuery("#calendar").each(function (idx, elm) {
        if (!elm) {
            return;
        }
        jQuery(elm).on("change", onModified);
    });

    var observed_elms_array = [jQuery("#sunday"), jQuery("#monday"), jQuery("#tuesday"), jQuery("#wednesday"),
        jQuery("#thursday"), jQuery("#friday"), jQuery("#saturday"), jQuery("#apply_calendar"),
        jQuery("#add_work_hours_button")];
    jQuery.each(observed_elms_array, function (idx, elm) {
        if (!(elm.length > 0)) {
            return;
        }
        elm.on("click", onModified);
    });
});
{/literal}</script>

{include file='grn/personal_footer.tpl'}
