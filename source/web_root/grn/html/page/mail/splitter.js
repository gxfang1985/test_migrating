(function ($) {
    $.fn.splitter = function (options) {
        var defaults = {
            _axesElement : "#tree_part,#list_center,#view_part,2"
        };
        var G = grn.page.mail.mail_list;
        var MP = grn.page.mail.mail_3pane;
        var s = $.extend({}, defaults, options || {});

        function mouseHandler(e) {
            var body = document.getElementsByTagName('body')[0];
            body_object = ((document.documentElement.clientHeight == 0) ? body : document.documentElement);

            eventThat = e;
            that = $(this);

            var parentPage = Element_PageX();

            $(document).bind('mousemove', function (eMove){
                var divPos = eMove.pageX - parentPage.axes;
                if (parentPage.column == '1')
                {
                    var divLeft = parentPage.axesLeft + divPos;
                }
                else
                {
                    var divLeft = parentPage.axesCenter + divPos;
                 }
                ElementControl({divA:divLeft}, parentPage);
            });
                
            $(document).bind('mouseup', function (e){
                reMoveBind();
                G.saveSplitterPosition();
            });

            return false;
        }

        //bind event
        return this.bind('mousedown', mouseHandler);

        function ElementControl (_thisObj, parentPage)
        {
            var minBodyWidth = 750;
            var bodyWidth = (body_object.clientWidth < minBodyWidth) ? minBodyWidth : body_object.clientWidth;
            var minLeftWidth = 90;
            var minCenterWidth = 200;
            var minRightWidth = 250; // Plus border width

            if (parentPage.column == '1')
            {
                var centerWidth = parentPage.axesCenter;
                if ( parentPage.axesObjCenter.is(':hidden') )
                {
                    centerWidth = 0;
                    minRightWidth = minRightWidth + minCenterWidth ;
                }
                var maxLeftWidth = bodyWidth - centerWidth - minRightWidth;
                if (_thisObj.divA >= maxLeftWidth)
                {
                    MP.left_fixed = maxLeftWidth;
                    MP.right_fixed = minRightWidth;
                }
                else
                {
                    if (_thisObj.divA <= minLeftWidth)
                    {
                        MP.left_fixed = minLeftWidth;
                    }
                    else
                    {
                        MP.left_fixed = _thisObj.divA;
                    }
                    MP.right_fixed = bodyWidth - MP.left_fixed - centerWidth;
                }
                setElementWH(parentPage.axesObjLeft, MP.left_fixed);
                setElementWH(parentPage.axesObjRight, MP.right_fixed);
                $('#mail_content_scroll').width(MP.right_fixed);
                $('#mail_content_all').width(MP.right_fixed - 36);

                $('#tree_view').css('width', MP.left_fixed);
                $('#tree_container').css('width', MP.left_fixed - 15);
                if ( parentPage.axesObjCenter.is(':hidden') )
                {
                    var x = parentPage.axesObjRight.offset();
                }
                else
                {
                    var x = parentPage.axesObjCenter.offset();
                }
                setCSS(x.left);
                if ( ! parentPage.axesObjCenter.is(':hidden') )
                {
                    var x = parentPage.axesObjRight.offset();
                    $('#splitter2').css({left: x.left});
                }
            }
            else
            {
                leftWidth = parentPage.axesLeft;
                var maxCenterWidth = bodyWidth - leftWidth - minRightWidth;
                if (_thisObj.divA >= maxCenterWidth)
                {
                    MP.center_fixed = maxCenterWidth;
                }
                else
                {
                    if (_thisObj.divA <= minCenterWidth)
                    {
                        MP.center_fixed = minCenterWidth;
                    }
                    else
                    {
                        MP.center_fixed = _thisObj.divA;
                    }
                }
                MP.right_fixed = bodyWidth - leftWidth - MP.center_fixed;
                var extra_width = 58;// <li> width minus subject width.
                var attach_width = 20;
                MP.resetTextWidth();
                setElementWH(parentPage.axesObjCenter, MP.center_fixed);
                setElementWH(parentPage.axesObjRight, MP.right_fixed);
                $('#mail_content_scroll').width(MP.right_fixed);
                $('#mail_content_all').width(MP.right_fixed - 36);
                var x = parentPage.axesObjRight.offset();
                setCSS(x.left);
                MP.resetTextWidth(parentPage.axesObjCenter.outerWidth(true));
            }
        }

        function setElementWH (_this, _number)
        {
             _this.width(_number-2);
        }

        //Set fire element left value
        function setCSS (_number)
        {
            that.css({left:_number});
        }

        //page X
        function Element_PageX()
        {
            var PageX   = eventThat.pageX;
            var EleDIV  = s._axesElement.split(',');
            /*jshint -W093 */ /* Did you mean to return a conditional instead of an assignment?. */
            return pageObj = {
                axes : PageX,
                axesObjLeft : $(EleDIV[0]),//Left
                axesObjCenter : $(EleDIV[1]),//Center
                axesObjRight : $(EleDIV[2]),//Right
                axesLeft: $(EleDIV[0]).width(),
                axesCenter: $(EleDIV[1]).width(),
                axesRight: $(EleDIV[2]).width(),
                column : EleDIV[3]
            };
        }

        //unbind
        function reMoveBind() {
            $(document).unbind('mousemove').unbind('mouseup').unbind('mousedown');
            return false;
        }
    };
})(jQuery);
