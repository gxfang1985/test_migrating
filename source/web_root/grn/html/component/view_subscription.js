grn.base.namespace("grn.component.view_subscription");

(function($)
{
    "use strict";

    var G = grn.component.view_subscription;
    G._checkSubmit = true;

    /**
     * @param settings
     *          submitPage: the post url
     *          postData: the post data
     */
    G.init = function (settings)
    {
        this._checkSubmit = false;
        this._submitPage = settings["submitPage"];
        this._postData = settings["postData"];
    };

    G.changeSubscriptionStatus = function()
    {
        if (this._checkSubmit || typeof(this._submitPage) == 'undefined')
        {
            return false;
        }
        this._checkSubmit = true;

        var $subscription_input = $("#subscription");
        var $subscription_button = $("#subscription_button");
        var $subscription_button_text = $("#subscription_button_text");
        var $spinner = $("#wait_image");
        var view_subscription = this;

        $subscription_button.addClass("button_disable_filter_grn");
        $spinner.css("display", "");

        var ajax_request = new grn.component.ajax.request({
            grnUrl: this._submitPage,
            method: "post",
            data: "subs=" + $subscription_input.val() + "&" + this._postData + "&csrf_ticket=" + grn.data["CSRF_TICKET"]
        });

        ajax_request.send().done(function( data ) {
            var values = data.getElementsByTagName( "data" );
            if( values && values.length > 0 )
            {
                var result = values.item(0).getElementsByTagName( "result" ).item(0).firstChild.nodeValue;
                if( result == "true" )
                {
                    var subs = values.item(0).getElementsByTagName( "subscription" ).item(0).firstChild.nodeValue;
                    if( subs == "on" )
                    {
                        $subscription_input.val(0);

                        var subscription_on_msg = grn.component.i18n.cbMsg( "grn.common", "subscription_stop" );
                        $subscription_button_text.text(subscription_on_msg);
                    }
                    else
                    {
                        $subscription_input.val(1);

                        var subscription_off_msg = grn.component.i18n.cbMsg( "grn.common", "subscription_start" );
                        $subscription_button_text.text(subscription_off_msg);
                    }
                }
            }
        }).always(function () {
            view_subscription._checkSubmit = false;
            $subscription_button.removeClass("button_disable_filter_grn");
            $spinner.hide();
        });
    };
})(jQuery);
