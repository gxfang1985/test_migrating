$(document).ready(function(){
    var attachBtn = $("div.mobile-selectAttachment-grn");
    if (attachBtn.hasClass("ui-disabled")) {
        $("#comment_data").val("");
        attachBtn.removeClass("ui-disabled");
        $(".mobile-uppedAttachment-grn").remove();
    }
});