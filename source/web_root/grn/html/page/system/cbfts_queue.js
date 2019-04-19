grn.base.namespace("grn.page.system.cbfts_queue");

(function () {
    var G = grn.page.system.cbfts_queue;
    G.url = null;
    G.no_queue_message_ = jQuery("#no_queue_message");
    G.queue_table_area_ = jQuery("#queue_table_display_area");
    G.spinner_image_ = jQuery("#spinner_for_ajax");
    G.error_area_ = jQuery("#queue_monitor_error_area");

    /**
     * @param {String} url
     */
    G.init = function(url){
        G.url = url;
        setInterval("grn.page.system.cbfts_queue.autoUpdateQueueRecord()", 30000);
    };

    /**
     * @param {String} message
     * @param {String} title
     * @param {String} type
     * @param {Object} options
     */
    G.showPopupDeleteQueueConfirm = function(message, title, type, options){
        var msgBox = GRN_MsgBox;
        msgBox.show(message, title, type, options);
    };

    G.autoUpdateQueueRecord = function(){
        G.displaySpinner();
        G.ajaxGetQueueRecord();
    };

    G.displaySpinner = function() {
        G.spinner_image_.show();
    };

    G.ajaxGetQueueRecord = function(){
        var ajax_request = new grn.component.ajax.request({
            url: G.url,
            method: "post",
        });

        ajax_request.on(grn.component.ajax.request.EVENT.BEFORE_SHOW_ERROR, function(e, jqXHR){
            e.preventDefault();
            grn.page.system.cbfts_queue.showErrorMessage(jqXHR.responseText);
        });

        ajax_request.send().done(function (data, textStatus, jqXHR) {
            G.error_area_.hide();
            G.updateHTML(data);
        }).always(function(){
            G.spinner_image_.hide();
        });
    };

    /**
     * @param {Object} data
     */
    G.updateHTML = function(data){
        if (data.count > 0) {
            jQuery("#id_content").html(data.id);
            jQuery("#ctime_content").html(data.ctime);
            jQuery("#jobName_content").html(data.jobName);
            jQuery("#message_content").html(jQuery("<div></div>").text(data.message).html());
            jQuery("#remaining_queue_number").html(data.count);
            G.no_queue_message_.hide();
            G.queue_table_area_.show();
        } else {
            G.queue_table_area_.hide();
            G.no_queue_message_.show();
        }
    };

    /**
     * @param {String} responseText
     */
    G.showErrorMessage = function(responseText){
        var html;
        G.no_queue_message_.hide();
        G.queue_table_area_.hide();
        try {
            var errorObj = JSON.parse(responseText);
            html = "<div style='font-weight: bold;'>" + jQuery("<div></div>").text(errorObj.code).html() + "</div>"
                + "<div>" + jQuery("<div></div>").text(errorObj.diagnosis).html() + "</div>"
                + "<div>" + jQuery("<div></div>").text(errorObj.cause).html() + "</div>"
                + "<div>" + jQuery("<div></div>").text(errorObj.counter_measure).html() + "</div>";
        } catch (e) {
            html = responseText; // response text is not json
        } finally {
            jQuery("#queue_monitor_response_error_text").html(html);
        }

        G.error_area_.show();
    };

    jQuery("#queue_delete_button").on("click", function(){
        G.showPopupDeleteQueueConfirm(grn.msg.msgBoxContent, grn.msg.msgBoxTitle, GRN_MsgBoxButtons.yesno, {
            ui       : {},
            caption  : {
                yes: grn.msg.YES,
                no: grn.msg.NO
            },
            callback : function(result){
                if(result == GRN_MsgBoxResult.yes){
                    document.getElementById("delete_queue_form").submit();
                }
            }
        });
    });
})();

