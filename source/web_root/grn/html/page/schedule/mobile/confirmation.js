/**
 * This js file is used to control the client event of delete/leave/participate confirmation
 * @author: tuyen-truong(Cybozu Vietnam)
 * @date: 2014/03/04(Tue)
 */
 
// namespace
grn.base.namespace("grn.page.schedule.mobile.confirmation");
var G = grn.page.schedule.mobile.confirmation;
G.ERRMSG_PARTICIPANT_SELECT_IS_REQUIRED = '';
G.ERRMSG_SCOPE_SELECT_IS_REQUIRED = '';
G.ERRMSG_DATETIME_CANDIDATE_IS_REQUIRED = '';
G.validate = function(form)
{
    var candidates = [
        {'name':'member', 'errmsg': G.ERRMSG_PARTICIPANT_SELECT_IS_REQUIRED},
        {'name': 'apply', 'errmsg': G.ERRMSG_SCOPE_SELECT_IS_REQUIRED},
        {'name': 'did', 'errmsg': G.ERRMSG_DATETIME_CANDIDATE_IS_REQUIRED}
    ];
    var validators = new grn.component.validator_mobile(form, document.getElementById("FieldToShowErrorMessage"));
    for(var i = 0; i < candidates.length; i++) {
        var candidate = candidates[i];
        if (form[candidate.name] != undefined) {
        
            validators.addValidator(new grn.component.validator_mobile.CheckedOnlyOne(candidate.name, candidate.errmsg));
        }
    }
    validators.clearErrorMessage();
    if (validators.validateAll())
    {
        return true;
    }
    else
    {
        location.href = '#';
        return false;
    }
};

(function($)
{
    $(document).on("pageinit", function(event) {
        function radioBtnOnOff($target, $parent) {
            var $icon = $target.find("span[class*=mobile_icon_radiobutton_grn]");
            if ($icon.hasClass("mobile_icon_radiobuttonoff_grn")) {
                // reset
                $parent.find(".mobile_icon_radiobuttonon_grn").removeClass("mobile_icon_radiobuttonon_grn").addClass("mobile_icon_radiobuttonoff_grn");
                // add new setting
                $icon.removeClass("mobile_icon_radiobuttonoff_grn").addClass("mobile_icon_radiobuttonon_grn");
                $icon.next().find("input[type=radio]").prop("checked", true);
            }
        }
        var $member = $("#member");
        $member.on("tap", "li", function(event) {
            var $target = $(this);// li element
            radioBtnOnOff($target, $member);
        });
        
        var $apply = $("#apply");
        $apply.on("tap", "li" , function(event) {
            var $target = $(this);
            radioBtnOnOff($target, $apply);
        });
        /**
         * Attach event handler temporary event list(if exist)
         */
        var $temporary = $("#temporary");
        var selector = "li";
        if ($temporary.find("ul li").length > 0)
        {
            selector = "ul " + selector;
        }
        $temporary.on("tap", selector , function(event) {    // bundle up to first ul tag
            var $target = $(this);
            radioBtnOnOff($target, $temporary);
        });
        /**
         * Attach event handler to 「はい」 button
         */
        $("input[type=submit]").on("tap", function(event) {
            var theform = document.getElementsByName(G.formName);
            if (theform)
            {
                if (!G.validate(theform[0]))
                {
                    $("#FieldToShowErrorMessage").find("span[class*=mobile-icon-error-grn]").remove();
                    return _preventDefault(event);
                }
            }
            this.click();
            
            return _preventDefault(event);
            
            function _preventDefault(evnt) {
                evnt.preventDefault();
                evnt.stopPropagation();
                return false;
            }
        });
        
        /**
         * Attach event handler to 「いいえ」  button
         */
        $("input[type=reset]").on("tap", function(event) {
            var decodedUrl = G.backUrl;
            decodedUrl = decodedUrl.replace(/&amp;/g, '&');
            location.href=decodedUrl;
        });
    });
})(jQuery);