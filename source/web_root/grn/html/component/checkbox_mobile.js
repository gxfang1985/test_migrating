grn.base.namespace('grn.component.checkbox_mobile');
(function()
{
    var G = grn.component.checkbox_mobile;
    if (G.is_loaded) {
        return;
    }
    $(document).on("click", "label", function(){
        var lcheckbox = $(this).find(":checkbox").get(0);
        var link = $(this).children()[0];
        if ($(link).hasClass("mobile-checkbox-normal-grn")) {
            $(link).removeClass("mobile-checkbox-normal-grn");
            $(link).addClass("mobile-checkboxOff-todo-grn");
            lcheckbox.checked = false;
        }
        else if ($(link).hasClass("mobile-checkboxOff-todo-grn")) {
            $(link).removeClass("mobile-checkboxOff-todo-grn");
            $(link).addClass("mobile-checkbox-normal-grn");
            lcheckbox.checked = true;
        }
    });

    G.check = function (link, flag) {
        var lcheckbox = $(link).parent().find(':checkbox');
        if (flag) {
            if ($(link).hasClass("mobile-checkboxOff-todo-grn")) {
                $(link).removeClass("mobile-checkboxOff-todo-grn");
                $(link).addClass("mobile-checkbox-normal-grn");
                lcheckbox.prop('checked','checked');
            }
        }
        else {
            if ($(link).hasClass("mobile-checkbox-normal-grn")) {
                $(link).removeClass("mobile-checkbox-normal-grn");
                $(link).addClass("mobile-checkboxOff-todo-grn");
                lcheckbox.removeAttr('checked');
            }
        }
    };

    G.is_loaded = true;
})();
