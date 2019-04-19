// namespace
grn.base.namespace("grn.page.space.mobile.todo.todo_edit");
(function () {
    var G = grn.page.space.mobile.todo.todo_edit;
    var CK = grn.component.checkbox_mobile;
    if (G.is_loaded)
    {
        return;
    }
    $(document).on("click", "#content_button", function(){
        var $cButton = $(this);
        $("#content_text").slideToggle(50, function(){
            if ( $(this).is(':hidden') )
            {
                $cButton.attr("data-icon", "arrow-u");
                $cButton.addClass("ui-icon-arrow-d").removeClass("ui-icon-arrow-u");
                $cButton.text(G.SHOW_CONTENT);
            }
            else
            {
                $cButton.attr("data-icon", "arrow-d");
                $cButton.addClass("ui-icon-arrow-u").removeClass("ui-icon-arrow-d");
                $cButton.text(G.HIDE_CONTENT);
            }
            
         });
    });
    G.memberSelect = function( form )
    {
        var ids = ''; names = '';
        $checkboxs = $('input:checked[name="todoMember[]"]');
        $.each( $checkboxs, function(index){
            if ( $($checkboxs[index]).val() )
            {
                ids   = ids ? ids + ',' + $($checkboxs[index]).val() : $($checkboxs[index]).val();
            }
        });
        $checkboxsText = $('input:checked[name="todoMember[]"]').next('span');
        $.each( $checkboxsText, function(index){
            if ( $($checkboxsText[index]).text() )
            {
                names = names ? names + ', ' + $($checkboxsText[index]).text() : $($checkboxsText[index]).text();
            }
        });
        $("#user_ids").val(ids);
        $(".mobile-font-warp-grn").text(names);
        location.href='#';
    };

    G.initialize = function()
    {
        var uid = '';
        var ids = $("#user_ids").val().split(",");
        var str = 'input:checkbox[name="todoMember[]"]';
        $checkboxsLink = $(str).prev("a");
        $.each( $checkboxsLink, function(index){
            CK.check($checkboxsLink[index], false);
        });
        while( uid = ids.pop() )
        {
            str_v = str + '[value=' + uid + ']';
            if ( $ck = $(str_v).prev("a").get(0) )
            {
                CK.check($ck, true);
            }
        }
        location.href='#';
    };

    G.validate = function(e, form)
    {
        if (G.click) {
            return false;
        }
        G.click = true;

        var validators = new grn.component.validator_mobile(form, document.getElementById("FieldToShowErrorMessage"));
        validators.addValidator(new grn.component.validator_mobile.TextLengthLongerThan("title", G.ERRMSG_TITLE_IS_REQUIRED, 0) );
        validators.addValidator(new grn.component.validator_mobile.CustomValidate(
            function(form) {
                var start = grn.component.validator_mobile.util.getDate('start', form);
                var end = grn.component.validator_mobile.util.getDate('end', form);
                
                if (form.elements['start'].disabled || form.elements['end'].disabled) return true;
                if (!start || !end) return false;
                
                return (start.getTime() <= end.getTime());
            }, G.ERRMSG_INVALID_START_DATE) );
        validators.addValidator(new grn.component.validator_mobile.TodoEndDateAsync("space/ajax/command_validator_edit_todo"));

        validators.clearErrorMessage();

        e.preventDefault();
        e.stopPropagation();
        location.href = '#';

        validators.validateAllAsync().done(function () {
            form.submit();
            return true;
        }).fail(function () {
            return false;
        }).always(function () {
            G.click = false;
        });
    };
    G.is_loaded = true;
})();
