// namespace
grn.base.namespace("grn.page.schedule.add");
(function ($) {
    var G = grn.page.schedule.add;
    if (G.is_loaded)
    {
        return;
    }

    G.init = function()
    {
        G.usingPurposeError    = $("#using_purpose_error");
        G.usingPurposeField    = $("#using_purpose_element");
        G.usingPurposeTextArea = $("#using_purpose");
        G.note                 = $("#textarea_id");
        G.minHeightUsingPurpose = 90; // min-height of using purpose 90px
        G.totalBackStep = 1;
        G.checkCancel = false;
    };

    G.displayRequireUsingPurpose = function()
    {
        if( G.usingPurposeError.length )
        {
            G.usingPurposeError.show();
            check_add = false;
        }
    };

    G.hideRequireUsingPurpose = function()
    {
        if( G.usingPurposeError.length )
        {
            G.usingPurposeError.hide();
        }
    };

    G.checkUsingPurposeNotEmpty = function()
    {
        if( G.usingPurposeField.length && G.usingPurposeField.is(":visible") )
        {
            if( G.trim( G.usingPurposeTextArea.val() ).length == 0 )
            {
                G.usingPurposeError.show();
                $(document).scrollTop(G.usingPurposeField.offset().top - 27);
                return false;
            }
            else
            {
                G.usingPurposeError.hide();
                return true;
            }
        }
        return true;
    };

    G.resetUsingPurposeHeight = function()
    {
        if( G.usingPurposeTextArea.length && G.usingPurposeTextArea.val() == '' )
        {
            G.usingPurposeTextArea.css({"height":G.minHeightUsingPurpose});
            G.usingPurposeTextArea.css({"min-height":G.minHeightUsingPurpose});
        }
    };

    G.trim = function( str )
    {
        return str.replace(/^\s+|\s+$/g, "");
    };

    // because textarea component using Prototype so when set height for textarea, also using Prototype
    Event.observe( window, "load", function(){
        G.init();
        G.resetUsingPurposeHeight();
        if( G.usingPurposeTextArea.val() != '' )
        {
            G.defaultHeightPurpose = G.usingPurposeTextArea.css('height');
        }
    });

    /**
     *
     * @param {string|HTMLElement} form
     * @param url
     */
    G.schedule_submit = function (form, url) {
        // GTM-1676 check content of using purpose
        if (!G.checkUsingPurposeNotEmpty()) {
            return;
        }
        // end GTM-1676
        if (typeof form === "string") {
            form = document.getElementById(form);
        }
        _schedule_submit(form, url);
    };

    G.schedule_cancel = function (url) {
        if (G.checkCancel) {
            return;
        }
        G.checkCancel = true;
        if (url == 'back') {
            if (history.length > 1) {
                if (G.totalBackStep > 1) {
                    history.go(-G.totalBackStep);
                }
                else {
                    history.back();
                }
            }
            else {
                location.href = grn.component.url.page('schedule/index');
            }
        }
        else {
            location.href = url;
        }
    };

    G.update_back_step = function () {
        G.totalBackStep++;
    };

    G.grn_onsubmit_common = function (f) {
        if (grn.base.isNamespaceDefined("grn.component.member_add")) {
            var private_select = grn.component.member_add.get_instance("private_select");
            if (private_select) {
                private_select.prepareSubmit();
            }
            var member_select = grn.component.member_add.get_instance("member_select");
            if (member_select) {
                member_select.prepareSubmit();
            }
        }
        if (grn.base.isNamespaceDefined("grn.component.facility_add")) {
            var facility_select = grn.component.facility_add.get_instance("facility_select");
            if (facility_select) {
                facility_select.prepareSubmit();
            }
        }
    };

    function _schedule_submit(f, url) {
        if (check_add) {
            return;
        }
        if (!setAjaxElement(f)) {
            return;
        }
        check_add = true;
        // set refresh status dialog flag element
        setShowRefreshDialogFlag(f);

        G.grn_onsubmit_common(f);
        _submit(f, url);
    }


    G.is_loaded = true;
})(jQuery);
