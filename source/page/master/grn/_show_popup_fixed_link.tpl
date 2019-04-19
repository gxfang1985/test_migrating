{literal}
<script type="text/javascript">
    var fixed_link = null;
    var id_fixed_link = null;
    jQuery(window).resize(function()
    {
        setTimeout(function(){
            if(fixed_link !== null)
            {
                var pos = YAHOO.util.Dom.getXY(fixed_link);
                pos[0] = pos[0] - 200;
                pos[1] = pos[1] - 105;

                pos[0] = pos[0] < 0 ? 0 : pos[0];
                pos[1] = pos[1] < 0 ? 0 : pos[1];

                YAHOO.util.Dom.setXY(jQuery('#PermanentLinkBox'), pos,true);
            }
        },1)
    });

    jQuery(window.document).on("click", function(e)
    {
        var plinkbox = jQuery('#PermanentLinkBox');
        if(plinkbox.length <= 0 || !plinkbox.is(":visible")) return;
        var target = jQuery(e.target);
        var str = target.parents().prop("id");

        var prefix_id = "#thread_comment_";
        var comment_id = id_fixed_link.substr(11);
        var comment_id_element = prefix_id + comment_id;
        var element = jQuery(comment_id_element);

        if (element.length == 0) {
            prefix_id = "#todo_comment_";
            comment_id_element = prefix_id + comment_id;
            element = jQuery(comment_id_element);
        }

        if (!target.is("#PermanentLinkBox") && !target.is("#thread-urlTip-description-grn")
            && !target.is("#PermanentLinkUrl")
            && !target.is("#thread-urlTip-label-grn")
            && !target.is("#thread-urlTip-inner-grn")
            && str.substr(0, 10) !== "fixed_link") {

            plinkbox.hide();
            fixed_link = null;

            if (element.length > 0) {
                if (!element.has(e.target).length && !target.is(comment_id_element)) {
                    element.removeClass("selected-comment-grn");
                    element.find(".js_permalink").css("opacity", 0);
                }
            }
        }

        if (str.substr(0, 10) === "fixed_link") {
            var comment_id_data = plinkbox.data("comment_id");
            var history_comment_id_data = plinkbox.data("comment_id_history");

            if (comment_id_data == history_comment_id_data) {
                return;
            }

            var history_element = jQuery(prefix_id + history_comment_id_data);
            if (history_element.length > 0) {
                history_element.find(".js_permalink").css("opacity", 0);
            }
        }
    });

    function mouseClick(app, e)
    {
        var plinkbox = jQuery('#PermanentLinkBox');
        if(plinkbox.length <= 0 || !plinkbox.is(":visible")) return;

        if(app=='space_discussion')
        {
            var id_before_click = id_fixed_link.substr(11);
            var target = jQuery(e.target);
            if(target.is('#'+id_before_click)) return;

            var elm_before_click = jQuery('#thread_comment_' + id_before_click);
            elm_before_click.removeClass('selected-comment-grn');

            var elm_click = jQuery('#thread_comment_' + e);
            elm_click.addClass('selected-comment-grn');
        }
        else if(app=='space_todo')
        {
            var id_before_click = id_fixed_link.substr(11);
            var target = jQuery(e.target);
            if(target.is('#'+id_before_click)) return;

            var elm_before_click = jQuery('#todo_comment_' + id_before_click);
            elm_before_click.removeClass('selected-comment-grn');

            var elm_click = jQuery('#todo_comment_' + e);
            elm_click.addClass('selected-comment-grn');
        }
        else
        {
            jQuery("#" + id_fixed_link).hide();
            var temp = jQuery('#fixed_link_' + e);
            temp.show();
        }
    }

    function showFixedLink(button, url)
    {
        var plinkbox = jQuery('#PermanentLinkBox');
        var plinkUrl = jQuery('#PermanentLinkUrl');
        if(plinkbox.length <= 0 || plinkUrl.length <= 0) return;
        //save id fixed_link
        fixed_link = jQuery(button);
        id_fixed_link = fixed_link.parents().prop('id');

        var comment_id_history = plinkbox.data("comment_id");
        plinkbox.data("comment_id_history", comment_id_history);

        var comment_id = id_fixed_link.substr(11);
        plinkbox.data("comment_id", comment_id);

        plinkUrl.val(url);

        var pos = YAHOO.util.Dom.getXY(button);
        pos[0] = pos[0] - 200;
        pos[1] = pos[1] - 105;

        pos[0] = pos[0] < 0 ? 0 : pos[0];
        pos[1] = pos[1] < 0 ? 0 : pos[1];

        plinkbox.show();
        YAHOO.util.Dom.setXY(plinkbox, pos);

        plinkUrl.focus();
        plinkUrl.select();
        plinkUrl.click(function(){ this.select(); });
    }
</script>
{/literal}
{capture name='grn_fixed_link'}{cb_msg module='grn.message' key='GRN_MSG-410' replace='true'}{/capture}
{capture name='grn_fixed_link_description_1'}{cb_msg module='grn.message' key='GRN_MSG-412' replace='true'}{/capture}
<div class="PermanentLinkBox" id="PermanentLinkBox" width="100%" style="display:none" >
<div class="thread-urlTip-inner-grn" id="thread-urlTip-inner-grn">
      <span class="thread-urlTip-label-grn" id="thread-urlTip-label-grn">{$smarty.capture.grn_fixed_link}</span>
      <input type="textbox" id="PermanentLinkUrl" readonly="readonly"/>
      <div class="thread-urlTip-description-grn" id="thread-urlTip-description-grn">
        {$smarty.capture.grn_fixed_link_description_1}<br/>
      </div>
</div>
</div>
<canvas id="canvas" width="100" height="100" style="display:none"></canvas>
