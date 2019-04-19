(function ($) {
    "use strict";

    grn.base.namespace("grn.component.schedule.multi_view.event_tooltip");

    var multi_view = grn.component.schedule.multi_view;
    var G = grn.component.schedule.multi_view.event_tooltip;

    var IMAGES = {
        "USER" : grn.component.url.image("cybozu/user20.gif"),
        "USER_LOGIN" : grn.component.url.image("cybozu/loginuser20.gif"),
        "USER_INACTIVE" : grn.component.url.image("cybozu/invaliduser20.gif"),
        "FACILITY" : grn.component.url.image("cybozu/facility20.gif"),
        "ORGANIZATION" : grn.component.url.image("cybozu/cal_group20.png")
    };

    G.init = function(settings) {
        this.settings = settings;

        this._$view = $(settings.container.view);
        this._active = true;

        this._bindEvents();
    };

    G.activate = function() {
        this._active = true;
    };

    G.deactivate = function() {
        this._active = false;
    };

    G._bindEvents = function() {

        // the calendar view might be re-rendered many times,
        // so to prevent duplicate binding, unbind the old event handlers before binding new the new ones

       var selector = ".event_content, .js_without_time_event_content, .js_banner_event_content";

        this._$view.off("mouseenter", selector, $.proxy(this._showTooltip, this));
        this._$view.on("mouseenter", selector, $.proxy(this._showTooltip, this));

        this._$view.off("mouseover", selector, $.proxy(this._abortRemovingTooltip, this));
        this._$view.on("mouseover", selector, $.proxy(this._abortRemovingTooltip, this));

        this._$view.off("mouseleave", selector, $.proxy(this._removeTooltip, this));
        this._$view.on("mouseleave", selector, $.proxy(this._removeTooltip, this));
    };

    G._showTooltip = function(e) {

        if (!this._active) {
            return;
        }

        if (this._$tooltip) {
            this._$tooltip.remove();
        }

        this._$tooltip = this._createTooltip(e);
    };

    G._createTooltip = function(e) {
        var event_content_element = e.currentTarget;
        var $event_container = $(event_content_element.parentNode);

        // do not display tooltip when dragging, resizing the event block
        if ($event_container.hasClass("dragging_schedule") ||
            $event_container.hasClass("resizing_schedule") ||
            $event_container.hasClass("original_schedule")) {
            return;
        }

        var event = $event_container.data("event");
        
        var $content = null;
        
        var $event_content_element = $(event_content_element);

        if($event_content_element.hasClass("js_without_time_event_content") ||
            $event_content_element.hasClass("js_banner_event_content")){

            $content = this._createContentWithoutTimeAndBannerEvent(event);
        }
        else{
            $content = this._createContentNormalEvent(event,$event_content_element);
        }

        if($content == null){
            return $content;
        }

        // tooltip container
        var $tooltip = $(document.createElement("div"));

        $tooltip.addClass("tooltipEventContainer")
            .hide()
            .append($content)
            .appendTo(document.body)
            .fadeIn("fast");

        // set position
        var position = {
            top: e.pageY + 10,
            left: e.pageX
        };

        this._setPosition($tooltip, position);

        // bind events
        $tooltip.mouseenter($.proxy(this._abortRemovingTooltip, this));
        $tooltip.mouseleave($.proxy(this._removeTooltip, this));

        return $tooltip;
    };

    G._createContentWithoutTimeAndBannerEvent = function (event) {

        var $content = $("<font size='-1' class='tooltipEvent'></font>");

        var member = multi_view.util.getMemberFromEvent(event);
        member = this.settings.memberList.getById(member.id, member.type);

        if(!event.relatedEvents){
            var member_color_css = multi_view.util
                .createEventBlockColorCss(member.id, member.type, this.settings.memberList);

            $content.addClass(member_color_css);
            $content.append(this._createMemberElement(member));

            return $content;
        }

        $content.addClass('event_block_color_share_grn');
        $content.append(this._createMemberElement(member));

        for(var i = 0; i < event.relatedEvents.length; i++){
            var related_member = multi_view.util.getMemberFromEvent(event.relatedEvents[i]);
            related_member = this.settings.memberList.getById(related_member.id, related_member.type);

            $content.append(this._createMemberElement(related_member));
        }

        return $content;
    };

    G._createContentNormalEvent = function (event, $event_content_element) {

        var member = multi_view.util.getMemberFromEvent(event);
        member = this.settings.memberList.getById(member.id, member.type);

        // member info
        var $member_info = this._createMemberElement(member);

        // tooltip content
        var member_color_css = multi_view.util
            .createEventBlockColorCss(member.id, member.type, this.settings.memberList);

        var $content = $event_content_element.find("font")
            .clone()
            .prepend($member_info)
            .addClass("tooltipEvent " + member_color_css);

        return $content;
    };

    G._setPosition = function ($tooltip, position) {
        var window_with = $(document).width();
        var tooltip_width = $tooltip.width();

        $tooltip.css(position);

        // revert position of tooltip if it overflows the view port

        if (position.left + tooltip_width > window_with) {
            $tooltip.css({
                left: position.left - tooltip_width,
                top: position.top
            });
        }
    };

    G._removeTooltip = function() {
        var self = this;
        this._tooltipIntervalId = setTimeout(function(){
            if(self._$tooltip) {
                self._$tooltip.remove();
            }
        }, 300);
    };

    G._abortRemovingTooltip = function() {
        clearTimeout(this._tooltipIntervalId);
    };

    G._createMemberElement = function(member) {
        var MEMBER_TYPE = multi_view.member_list.MEMBER_TYPE;

        var $member_element = $(document.createElement("div"));

        $member_element.addClass("tooltip_target_grn");

        var img_src = "";

        if (member.type === MEMBER_TYPE.USER) {
            var is_login_user = member.id === this.settings.loginUser.id;

            if(is_login_user){
                img_src = is_login_user ? IMAGES.USER_LOGIN : IMAGES.USER;
            }else if(member.user_status === "active"){
                img_src = IMAGES.USER;
            }else if(member.user_status === "inactive"){
                img_src = IMAGES.USER_INACTIVE ;
            }
        }

        if (member.type === MEMBER_TYPE.FACILITY) {
            img_src = IMAGES.FACILITY;
        }

        if(member.type === MEMBER_TYPE.ORGANIZATION){
            img_src = IMAGES.ORGANIZATION;
        }

        var $image = $("<img border='0' src='" + img_src + "'>");

        if(member.url){
            var $link = $("<a></a>")
                .text(member.name)
                .attr("href", member.url)
                .prepend($image);

            if (!member.url.match(/^javascript/)) {
                $link.attr("target", "_blank");
            }
            $member_element.html($link);
        } else {
            $member_element.text(member.name).prepend($image);
        }

        return $member_element;
    };

})(jQuery);
