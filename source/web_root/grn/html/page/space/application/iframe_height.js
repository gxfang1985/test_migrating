(function() {
    "use strict";
    var kintone_app_iframe = document.getElementById("external-app-iframe");
    var DELAY_TIME_MS = 100;
    var MARGIN = 48;

    jQuery(kintone_app_iframe).on("load", function () {
        setInterval(resizeIframe, DELAY_TIME_MS);
    });

    function resizeIframe() {
        var kintone_content_element = kintone_app_iframe.contentDocument.getElementsByClassName("container-gaia")[0];
        if (!kintone_content_element) {
            return;
        }
        var iframe_height = kintone_content_element.scrollHeight;
        iframe_height += MARGIN;
        iframe_height += getScrollBarHeight();
        setIframeHeight(iframe_height);
    }

    /**
     *
     * @returns {number}
     */
    function getScrollBarHeight() {
        var iframe_document_element = kintone_app_iframe.contentDocument.documentElement;
        if (kintone_app_iframe.offsetHeight > iframe_document_element.clientHeight) {
            return kintone_app_iframe.offsetHeight - iframe_document_element.clientHeight;
        }
        return 0;
    }

    function setIframeHeight(height) {
        kintone_app_iframe.style.height = height + "px";
    }
})();

