grn.base.namespace("grn.page.mail._title_3pane");

(function () {
    var G = grn.page.mail._title_3pane;

    G.show_balloon = function (target) {
        var balloon = jQuery("#mail-amountDetaiDaialog-grn");
        var switchOffset = cumulativeOffset(target),
            left = switchOffset.left + 20,
            top = switchOffset.top + 16;

        var balloon_left = left - balloon.outerWidth() + "px",
            balloon_top = top + "px";
        balloon.css({left: balloon_left, top: balloon_top});
        balloon.toggle();

        var narrow_mail = jQuery('#narrow_top_mail');
        narrow_mail.css("left", balloon.outerWidth() - 25 + "px");
    };

    function setPositionBalloon() {
        var balloon = jQuery('#mail-amountDetaiDaialog-grn');
        var narrow_mail = jQuery('#narrow_top_mail');

        if (balloon.length > 0 && balloon.is(":visible")) {
            var target = jQuery("#mail-CapacityInfomation-grn");
            var switchOffset = cumulativeOffset(target.get(0)),
                left = switchOffset.left + 22,
                top = switchOffset.top + 16;

            var balloon_left = left - balloon.outerWidth() + "px",
                balloon_top = top + "px";
            balloon.css({left: balloon_left, top: balloon_top});
            //alert(balloon.style.left);
            if (!grn.browser.msie) {
                narrow_mail.css("left", balloon.outerWidth() - 25 + "px");
            }
        }
    }


    jQuery(function () {
        jQuery(window).on("resize", function () {
            setTimeout(setPositionBalloon, 0);
        });

        jQuery(document).on("click", function (e) {
            var target = e.target;
            var capacity_infomation = jQuery("#mail-CapacityInfomation-grn"),
                capacity_bar_base = jQuery("#mail-CapacityBarBase-grn");

            var not_click = !capacity_infomation.is(target) && !capacity_bar_base.is(target);
            if (not_click) {
                var balloon = jQuery("#mail-amountDetaiDaialog-grn");
                if (balloon.length > 0 && balloon.is(":visible")) {
                    balloon.hide();
                }
            }
        });
    });
})();
