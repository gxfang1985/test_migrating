(function()
{
    "use strict";

    if (grn.base.isNamespaceDefined("grn.component.mobile_group_select"))
    {
        return;
    }

    grn.base.namespace("grn.component.mobile_group_select");
    grn.component.mobile_group_select = (function(){
        function GroupSelect(settings){
            this._construct(settings);
        }

        GroupSelect.prototype = {
            _construct : function(settings)
            {
                this.initParams(settings);
                this.container = $('#' + settings.container);
                this.associate_value_element_back = $('#' + settings.associate_value_element_back);
                this.associate_title_element_back = $('#' + settings.associate_title_element_back);

                this.bindEventHandler();
                this.adjustOrientationChange();

                var me = this;
                $(document).on( "pagechange", function( event )
                {
                    me.adjustTextOverflow();
                });
                $(window).on( "resize", function( event )
                {
                    me.adjustTextOverflow();
                });
            },
            initParams : function(settings)
            {
                this.asyncUrl       = settings.asyncUrl;
                this.paramName      = settings.paramName;
                this.treeName       = settings.treeName;
                this.pageName       = settings.pageName;
                this.previousPage   = settings.previousPage;
                this.radioName      = settings.radio_name;
                this.prefixId       = settings.prefix_id;
                this.prefixBeforeValue = settings.prefix_before_value;
                this.openClass      = "mobile_folderlist_icon_arrowopen_grn";
                this.closeClass     = "mobile_folderlist_icon_arrowclose_grn";
                this.checkOnClass   = "mobile_groupselect_icon_radiobuttonon_grn";
                this.checkOffClass  = "mobile_groupselect_icon_radiobuttonoff_grn";
                this.spinnerClass   = "mobile_icon_spinner_grn";
            },
            bindEventHandler : function()
            {
                this.container.on("tap", 'li', $.proxy(this.handleTouch, this) );

                this.container.on("touchstart", '.mobile_ok_grn' , $.proxy(this.applyHandler, this) );
                this.container.on("touchstart", '.mobile_cancel_grn' , $.proxy(this.closeHandler, this) );
            },
            adjustOrientationChange : function(event)
            {
                // fix problem for position of button apply and cancel in ios 6
                var agent = window.navigator.userAgent,
                    start = agent.indexOf( 'OS ' );

                if ( /(iPod|iPhone|iPad)/.test( agent ) && start > -1 ) {
                    var version = window.Number( agent.substr( start + 3, 1 ).replace( '_', '.' ) );
                    
                    if(version < 7)
                    {
                        var me = this;
                        $( window ).on( "orientationchange", function( event ) {
                            if(me.container.is(":visible"))
                            {
                                $(this).scrollTop(0);
                            }
                        });
                    }
                }
            },
            adjustTextOverflow : function()
            {
                $("#"+this.treeName).find("li[id^='" + this.prefixId + "parent_child_']").each(function(i){
                    var divH = $(this).height();
                    var aLink = $(this).children("a");
                    var text = aLink.children().eq(0);

                    var ellipsisDiv = aLink.find("div.mobile_ellipsis_mark_grn");
                    if (text.outerHeight() > divH + 1)
                    {
                        if (ellipsisDiv.length === 0)
                        {
                            aLink.append("<div class=\"mobile_ellipsis_mark_grn\">...</div>");
                        }
                    }
                    else
                    {
                        if (ellipsisDiv.length > 0)
                        {
                            ellipsisDiv.remove();
                        }
                    }
                });
            },
            handleTouch : function(event)
            {
                var item = event.target;
                var itemObj = $(item);
                
                if(itemObj.hasClass(this.openClass))
                {
                    this.collapseHandler(event);
                }
                else
                {
                    if(itemObj.hasClass(this.closeClass))
                    {
                        this.expandHandler(event);
                    }
                    else
                    {
                        if(itemObj.closest('li').find('span.mobile_groupselect_icon_radiobuttonon_grn').length > 0)
                        {
                            return;
                        }
                        this.selectHandler(event);
                    }
                }
                
            },
            collapseHandler : function(event)
            {
                var element = event.target;
                var parentId = element.id;

                this.collapse(parentId);

                var parent = $('#' + parentId);
                if (parent.hasClass(this.openClass))
                {
                    parent.removeClass(this.openClass);
                    parent.addClass(this.closeClass);
                }
            },
            collapse : function(parentId)
            {
                parentId = parentId.replace( this.prefixId, '' );
                var child = $("#"+this.treeName).find("li[id^='" + this.prefixId + "parent_child_"+ parentId +"']");
                var me = this;
                $.each(child, function()
                {
                    var childIdInfo = $(this).attr("id").split(me.prefixId + "parent_child_" + parentId+ "_");
                    var childId = childIdInfo[1];
                    if (typeof childId !== "undefined")
                    {
                        me.collapse(childId);
                    }
                });
                child.remove();
            },
            expandHandler : function(event)
            {
                var item = event.target;
                var itemObj = $(item);
                var paramName = this.paramName;
                var paramId = item.id;
                var id_substr_len = this.prefixId.length + 1;
                if(isNaN(parseInt(paramId.substr(0, id_substr_len))))
                {
                    paramId = paramId.substr(id_substr_len);
                }
                var pageName = this.pageName;

                var deepInfo= itemObj.next().children().first().attr("id").split("_");
                var deep = parseInt(deepInfo[1], 0);

                var requestData = paramName + "=" + paramId + "&page=" + pageName;

                $(item).removeClass(this.closeClass).addClass(this.spinnerClass);
                var me = this;
                $.ajax(
                {
                    url : me.asyncUrl,
                    dataType : "json",
                    data : requestData,
                    type : "post",
                    success : function(jsonObj, textStatus, transport)
                    {
                        if (grn.component.mobile_error_handler.hasCybozuError(transport))
                        {
                            grn.component.mobile_error_handler.show(transport);
                        }
                        else
                        {
                            if(jsonObj.count > 0)
                            {
                                var frag = document.createDocumentFragment();
                                var subFolderList = $.map(jsonObj.subFolderList, function(value, index) {
                                    return [value];
                                });
                                subFolderList.sort(function compare(a,b) {
                                    return parseFloat(a.list_index) - parseFloat(b.list_index);
                                });
                                $.each( subFolderList, function( key, value ) {
                                    var subGroup = me.buildSubGroup(value, deep + 1);
                                    frag.appendChild(subGroup[0]);
                                });
                                itemObj.parent().after(frag);
                                $("#"+me.treeName).listview("refresh");
                                me.adjustTextOverflow();
                                if ($(item).hasClass(me.spinnerClass))
                                {
                                    $(item).removeClass(me.spinnerClass);
                                    $(item).addClass(me.openClass);
                                }
                            }
                            else
                            {
                                $(item).removeClass(me.spinnerClass).removeClass(me.openClass);
                            }
                        }
                    },
                    error : function(transport, textStatus)
                    {
                        if (textStatus !== "abort")
                        {
                            me.showErrorMessage(transport);
                        }
                    },
                    complete : function()
                    {
                        $(item).removeClass(me.spinnerClass);
                    }
                });
            },
            showErrorMessage : function(request)
            {
                var s = request.responseText;
                if (s !== undefined)
                {
                    document.write(s);
                    document.close();
                }
            },
            buildSubGroup : function(subGroup, deep)
            {
                var pixel = deep * 8;
                var liTag = $('<li id="' + this.prefixId + 'parent_child_' + this.prefixBeforeValue + subGroup.parent + '_' + this.prefixBeforeValue + subGroup.oid + '" style="padding-left:' + pixel + 'px !important" data-icon="false"></li>');
                if(parseInt(subGroup.count) > 0)
                {
                    var divIcon = $('<div id="' + this.prefixId + this.prefixBeforeValue + subGroup.oid + '" style="margin-left:' + pixel + 'px !important;" class="mobile_folderlist_icon_arrowclose_grn mobile_folderlist_icon_grn mobile_folderlist_icon_size_grn"></div>');
                    liTag.append(divIcon);
                }
                
                var tagA = $('<a href="#" class="mobile_folderlist_list_text_grn">');
                var spanTitle = $('<span id="' + this.prefixId + 'deepth_' + deep + '_' + subGroup.oid +'" class="mobile_folderlist_text_overflow_grn"></span>');
                spanTitle.text(subGroup.name);
                tagA.append(spanTitle);
                liTag.append(tagA);
                
                var iconRadio = $('<div><span class="mobile_groupselect_icon_radiobuttonoff_grn"></span><span class="mobile_groupselect_radiobutton_grn"><input name="' + this.radioName + '" type="radio" value="' + this.prefixBeforeValue + subGroup.oid + '"></span></div>');
                liTag.append(iconRadio);
                
                return liTag;
            },
            selectHandler : function(event)
            {
                this.uncheckAllRadio();

                var item = event.target;
                var itemObj = $(item);
                if(!itemObj.hasClass('mobile_groupselect_icon_radiobuttonoff_grn'))
                {
                    itemObj = itemObj.closest('li').find('span.mobile_groupselect_icon_radiobuttonoff_grn');
                }
                
                itemObj.removeClass(this.checkOffClass);
                itemObj.addClass(this.checkOnClass);
                itemObj.siblings('.mobile_groupselect_radiobutton_grn').find('input[type="radio"]').each(function(){
                    $(this).prop('check','checked');
                });
            },
            uncheckAllRadio : function()
            {
                this.container.find('input[type="radio"]').each(function(){
                    $(this).prop('check',false);
                });
                var me = this;
                this.container.find('.' + this.checkOnClass).each(function(){
                    $(this).removeClass(me.checkOnClass);
                    $(this).addClass(me.checkOffClass);
                });
            },
            closeHandler : function()
            {
                this.uncheckAllRadio();
                event.preventDefault();
                event.stopPropagation();
                this.returnPreviousScreen();
            },
            applyHandler : function()
            {
                var selectedItem = this.container.find('.' + this.checkOnClass);
                if(selectedItem.length > 0)
                {
                    var selectedRadio = selectedItem.siblings('.mobile_groupselect_radiobutton_grn').find('input[type="radio"]');
                    var selectedValue = $(selectedRadio).val();
                    this.associate_value_element_back.val(selectedValue).triggerHandler('change');

                    var selectedCaption = selectedItem.parent().siblings().find('.mobile_folderlist_text_overflow_grn');
                    var selectedTilte = $(selectedCaption).html();
                    this.associate_title_element_back.val(selectedTilte).triggerHandler('change');
                }
                this.container.find('input[type="submit"]').button("refresh");
                this.closeHandler();
            },
            returnPreviousScreen : function()
            {
                if(this.previousPage == '_' || this.previousPage.length == 0)
                {
                    location.href = '#';
                }
                else
                {
                    var strCurrentURL = location.href;
                    var URL = strCurrentURL.split("#");
                    var baseURL = URL[0];
                    var previousURL = baseURL + '#' + this.previousPage;
                    location.href = previousURL;
                }
            }
        };

        return GroupSelect;
    })();
})();
