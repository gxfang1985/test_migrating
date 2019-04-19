(function()
{
    if (grn.base.isNamespaceDefined("grn.component.mobile_footer_for_multipage"))
    {
        return;
    }

    grn.base.namespace("grn.component.mobile_footer_for_multipage");
    var G = grn.component.mobile_footer_for_multipage;

    G.productTerm = "";
    G.copyright = "";
    $(document).ready(function()
    {
        G.footerCopyrightWidth = $(".footer_copyright_for_multipage").width();
        G.setCopyright();
        $(window).bind("resize", function()
        {
            G.setCopyright();
        });
    });

    G.setCopyright = function()
    {
        $("[data-role='footer']").each(function(){
            footerCopyright = $(this).children("h6");
            if(footerCopyright.length > 0)
            {
                if (G.footerCopyrightWidth && G.footerCopyrightWidth > ($(document.body).width() - 30))
                {
                    footerCopyright.html("<div>" + G.productTerm + "</div>" + G.copyright);
                }
                else
                {
                    footerCopyright.html(G.productTerm + "&nbsp;&nbsp;&nbsp;" + G.copyright);
                }
            }
        });
    };
})();
