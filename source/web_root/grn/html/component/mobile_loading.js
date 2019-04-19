(function()
{
    grn.base.namespace("grn.component.mobile_loading");
    var G = grn.component.mobile_loading;

    $(document).ready(function()
    {
        $(window).resize(function()
        {
            setSpinnerPosition();
            setOverlayHeight();
        });
    });

    var overlay = null;

    function setOverlayHeight()
    {
        if (overlay !== null)
        {
            overlay.height($(".ui-page-active[data-role='page']").outerHeight(true));
        }
    }

    var spinner = null;

    function setSpinnerPosition()
    {
        if (spinner !== null)
        {
            var offset = $(window).scrollTop();
            var top = (offset + ($(window).height() - spinner.innerHeight()) / 2) + "px";
            spinner.css({top : top});
        }
    }

    G.show = function()
    {
        overlay = $("div.mobile_spinner_grn");
        spinner = $("div.mobile_spinner_grn span");
        spinner.css({marginTop : 0});
        setSpinnerPosition();
        setOverlayHeight();
        overlay.show();
    };

    G.remove = function()
    {
        overlay.hide();
        overlay = null;
        spinner = null;
    };

    G.showOverlay = function()
    {
        overlay = $("div.mobile_spinner_grn");
        $("div.mobile_spinner_grn span").hide();
        setOverlayHeight();
        overlay.show();
    };
})();
