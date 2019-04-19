// namespace
grn.base.namespace("grn.component.ajax_submit");

(function () {
    var G = grn.component.ajax_submit;

    var check_submit = false;
    G.ajax_submit = function (f, submit_page, before_submit, after_submit) {
        if (check_submit || typeof(f) == 'undefined' || typeof(submit_page) == 'undefined') {
            return false;
        }

        // set ajax flag element
        if (!G._setAjaxElement(f)) {
            return false;
        }

        check_submit = true;
        jQuery('#show_validation_errors').hide();

        if (before_submit) {
            before_submit();
        }

        var request = new grn.component.ajax.request(
            {
                url: submit_page,
                method: "post",
                dataType: "json",
                data: jQuery(f).serialize()
            }
        );

        request.on('beforeShowError', function (e, jqXHR) {
            if (typeof jqXHR.responseJSON !== "undefined") {
                var json_obj = jqXHR.responseJSON;
                if (typeof json_obj.validation != "undefined" && json_obj.validation == false) {
                    e.preventDefault();
                    jQuery('#show_validation_errors').html(json_obj.error_message).show();
                    window.scrollTo(0, 0);
                }
            }
        });

        request.send().done(
            function (json_obj) {
                var link = json_obj.link;
                window.location = link;
            }
        )
            .always(
                function (xhr) {
                    G._removeAjaxElement(f);
                    check_submit = false;
                    if (after_submit) {
                        after_submit(xhr);
                    }
                }
            );
    };

    G._setAjaxElement = function (f) {
        if( document.getElementById('use_ajax') ) return false;

        var element = document.createElement("input");
        element.setAttribute("type", "hidden");
        element.setAttribute("id", "use_ajax");
        element.setAttribute("name", "use_ajax");
        element.setAttribute("value", "1");
        f.appendChild(element);
        return true;
    };

    G._removeAjaxElement = function (f) {
        var use_ajax = jQuery("#use_ajax");
        if (use_ajax) {
            use_ajax.remove();
        }
    };
})();
