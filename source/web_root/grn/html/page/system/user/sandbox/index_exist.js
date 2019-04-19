(function($){
    "use strict";
    grn.base.namespace("grn.page.system.user.sandbox.index_exist");

    var page = grn.page.system.user.sandbox.index_exist;

    /**
     * @constructor
     */
    page.ApplyNowFormContent = function ApplyNowFormContent() {
        $("div.set_part_frame_grn").hide();
        $("input[name=command]").val("apply");
        $("#system_user_sandbox_submit").val(page.resources.messageApplyNowButton);
    };

    /**
     * @returns {string}
     */
    page.ApplyNowFormContent.prototype.getMessage = function() {
        return page.resources.messageApplyNow;
    };

    /**
     * @constructor
     */
    page.SetTimeFormContent = function SetTimeFormContent() {
        $("div.set_part_frame_grn").show();
        $("input[name=command]").val("set_preset");
        $("#system_user_sandbox_submit").val(page.resources.messageSetTimeButton);
    };

    /**
     * See also
     *  function.grn_date_format_js.php and index_exist.tpl
     * @returns {string}
     */
    page.SetTimeFormContent.prototype.getMessage = function(){
        var year = $("#sandbox_year").find(":selected").val();
        var month = $("#sandbox_month").find(":selected").val();
        var day = $("#sandbox_day").find(":selected").val();
        var hour = $("#sandbox_hour").find(":selected").val();
        var minute = $("#sandbox_minute").find(":selected").val();

        var dateParams = sandbox_date_params(new Date(year, month - 1, day,hour, minute));
        var dateString =
            page.resources.dateFormat.replace("&&year&&", dateParams.year)
                .replace("&&mon&&", dateParams.mon)
                .replace("&&mday&&", dateParams.mday)
                .replace("&&wdayshort&&", dateParams.wdayshort)
                .replace("&&hours&&", dateParams.hours)
                .replace("&&minutes00&&", dateParams.minutes00);

        var safeDateString = $("<span></span>").text(dateString).html();
        return page.resources.messageSetTime.replace("%S%", safeDateString);
    };

    /**
     *
     * @param {SetTimeFormContent|ApplyNowFormContent} formContent
     * @constructor
     */
    page.SettingActionButton = function SettingActionButton(formContent) {
        this.formContent = formContent;
    };

    /**
     * @param {SetTimeFormContent|ApplyNowFormContent} formContent
     */
    page.SettingActionButton.prototype.setFormContent = function(formContent) {
        this.formContent = formContent;
    };

    page.SettingActionButton.prototype.onClickApplyNowRadioButton = function() {
        this.setFormContent(new page.ApplyNowFormContent());
    };

    page.SettingActionButton.prototype.onClickSetTimeRadioButton = function() {
        this.setFormContent(new page.SetTimeFormContent());
    };

    page.SettingActionButton.prototype.onClick = function() {
        GRN_MsgBox.show(
            this.formContent.getMessage(),
            page.resources.messageBox.title,
            GRN_MsgBoxButtons.yesno,
            {
                ui : [],
                caption : {
                    yes : page.resources.messageBox.yes,
                    no :  page.resources.messageBox.no
                },
                callback : function(clickButton)
                {
                    if (clickButton === GRN_MsgBoxResult.yes)
                    {
                        $("#sandbox_form").submit();
                    }
                }
            }
        );
    };

    page.RemovePresetEventButton = function RemovePresetEventButton(){
    };

    page.onRemovePresetEventButtonClicked = function() {
        GRN_MsgBox.show(
            page.resources.removePresetMessageBox.message,
            page.resources.removePresetMessageBox.title,
            GRN_MsgBoxButtons.yesno,
            {
                ui : [],
                caption : {
                    yes : page.resources.messageBox.yes,
                    no :  page.resources.messageBox.no
                },
                callback : function(clickButton)
                {
                    if (clickButton === GRN_MsgBoxResult.yes)
                    {
                        $("input[name=command]").val("delete_preset");
                        $("#sandbox_form").submit();
                    }
                }
            }
        );
    };

    page.onUpdatePresetEventButtonClicked = function() {
        $("input[name=command]").val("set_preset");
        $("#system_user_sandbox_submit")
            .val(page.resources.updateSetTimeButton)
            .addClass("bold_grn")
            .css({"visibility": "visible"});

        $("#system_user_sandbox_cancel").css({"visibility": "visible"});
        $("#sandbox_preset_date_select").show();
        $("#sandbox_set_time").hide();
        $("#preset_setting_update_item").hide();
    };

    /**
     * ページの各種イベントのセットアップを行う
     *
     * presetExistが真、すなわち時限設定の時刻設定が行われているケースでは以下の処理を追加で行う
     * - 今すぐ反映する or 日時を指定する ための登録ボタンを隠す
     * @param {int} presetExist 時限設定の時刻設定が行われているケース = 1
     */
    page.setupIndexExists = function(presetExist) {
        var initialFormContent = presetExist ? new page.SetTimeFormContent() : new page.ApplyNowFormContent();
        var settingActionButton = new page.SettingActionButton(initialFormContent);

        var submitButton = $("#system_user_sandbox_submit");
        submitButton.bind("click", settingActionButton.onClick.bind(settingActionButton));

        $("#system_user_sandbox_cancel").css({"visibility": "hidden"});
        
        if(presetExist)
        {
            submitButton.css({"visibility": "hidden"});
            $("a.icon_cancel_b_grn").bind("click", page.onRemovePresetEventButtonClicked.bind());
            $("a.update_sandbox_preset_date").bind("click", page.onUpdatePresetEventButtonClicked.bind());
        }
        else
        {
            var setTimeRadioButton = $("#system_user_sandbox_set_time");
            setTimeRadioButton.bind("click", settingActionButton.onClickSetTimeRadioButton.bind(settingActionButton));
            if( setTimeRadioButton.prop("checked") )
            {
                settingActionButton.onClickSetTimeRadioButton();
            }

            var applyNowRadioButton = $("#system_user_sandbox_apply_now");
            applyNowRadioButton.bind("click", settingActionButton.onClickApplyNowRadioButton.bind(settingActionButton));
        }
    };

})(jQuery);
