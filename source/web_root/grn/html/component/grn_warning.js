(function()
{
    "use strict";

    grn.base.namespace("grn.component.grn_unsupported_warning");

    var G = grn.component.grn_unsupported_warning;

    G.params = null;
    G.display = false;
    G.hideAnimation = null;
    G.warningHtml = document.getElementById("box-warning-grn");
    G.warningDuration       = 5000;
    G.animationInterval     = 50;
    G.opacityGraduallyValue = 0.2;
    G.minSupportVersion     = 11;

    G.isUnsupportedIE_Browser = function ()
    {
        if (grn.browser.msie && grn.browser.version < G.minSupportVersion) return true;
        return false;
    };

    G.hideWarningHtml = function()
    {
        if (G.warningHtml.style.display !== "none")
        {
            G.warningHtml.style.opacity = 1;
            G.hideAnimation = setInterval(G.hideHtmlAnimation, G.animationInterval);
        }
    };

    /**
     * The warning element gradually change to a transparent element.
     * Util the element opacity attribute less than 0, it will be hided.
     *
     * @variable G.opacityGraduallyValue set 0.2
     * @variable G.animationInterval_ms set 50
     * Every 50 milliseconds , the opacity value be decreases 0.2 .
     */
    G.hideHtmlAnimation = function()
    {
        if (G.warningHtml.style.opacity <= 0)
        {
            G.warningHtml.style.display = "none";
            clearInterval(G.hideAnimation);
        }
        else
        {
            G.warningHtml.style.opacity -= G.opacityGraduallyValue;
        }
    };

    G.showIE_Message = function()
    {
        var ie_warning_element = document.createElement('div');
        ie_warning_element.innerHTML = grn.component.i18n.cbMsg('grn', 'GRN_GRN-209');
        G.warningHtml.appendChild(ie_warning_element);
    };

    G.showTLSMessage = function()
    {
        var tls_warning_element = document.createElement('div');
        tls_warning_element.innerHTML = grn.component.i18n.cbMsg('grn.grn', 'GRN_GRN-1582');
        G.warningHtml.appendChild(tls_warning_element);
    };

    G.run = function()
    {
        if (G.isUnsupportedIE_Browser() && G.params.invalid_ie && G.params.is_show)
        {
            G.showIE_Message();
            G.display = true;
        }

        if (G.params.invalid_tls && G.params.is_show)
        {
            G.showTLSMessage();
            G.display = true;
        }

        if (G.display)
        {
            G.warningHtml.style.display = "block";
            setTimeout(G.hideWarningHtml, G.warningDuration);
        }
    };
})();