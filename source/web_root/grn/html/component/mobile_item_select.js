if (!grn.base.isNamespaceDefined("grn.component.mobile_item_select"))
{
    // base class for user / facility selection
    grn.base.namespace("grn.component.mobile_item_select");
    grn.component.mobile_item_select = (function(){
        /**
         * Initialize 
         * @param settings Settings for module.
         * @param settings.element_id The container element id.
         * @param settings.src_item The source item template id
         * @param settings.dest_item The destination item template id
         * @param settings.type_item type of item - user of facility
         * @param settings.empty_list The caption when source item is empty
         * @param settings.none_selected The caption when destination is empty
         * @param settings.ajaxGetItemURL The URL for ajax request to get item list.
         * @param settings.ajaxSearchItemURL The URL for ajax request to search item.
         * @param settings.args addition param for ajax request (optional)
         * @param settings.include_org list item contain group or not (optional)
         * @param settings.isCalendar set in the case of  organization plan (optional)
         * @param settings.isAllowedRole role permission to use the user (optional)
         */
        function ItemSelection(settings){
            this._construct(settings);
        }

        ItemSelection.prototype = {
            _construct : function(settings)
            {
                this.processing = false;
                this.bindAgain = false;
                this.adding = false;
                this.isAjax = false; // flag checking ajax process
                this.sp = 0; // use for load ajax list by offset
                this.lastestCounter = 0; // use for determine load ajax or not
                this.classBelongGroup = 'belong_group_';
                this.keyword = ''; // store lastest keyword for loading more item when scroll to bottom 

                this.type_item = settings.type_item;
                this.page_name = settings.page_name;
                // params for calling ajax
                this.args = (typeof settings.args != 'undefined') ? settings.args : '';
                this.ajaxGetItemURL = (typeof settings.ajaxGetItemURL != 'undefined') ? settings.ajaxGetItemURL : '';
                this.ajaxSearchItemURL = (typeof settings.ajaxSearchItemURL != 'undefined') ? settings.ajaxSearchItemURL : '';
                this.include_org = (typeof settings.include_org != 'undefined') ? settings.include_org : '';
                this.isCalendar = (typeof settings.isCalendar != 'undefined') ? settings.isCalendar : '';
                this.show_group_role = (typeof settings.show_group_role != 'undefined') ? settings.show_group_role : '';
                this.isAllowedRole = (typeof settings.isAllowedRole != 'undefined') ? settings.isAllowedRole : '';

                this.container = $('#_'+settings.element_id);
                this.associateElement = $('#'+settings.associate_id);
                this.option_search = settings.search_caption;
                this.selectedItem = settings.selectedItem;
                this.default_title_group_select = settings.default_title_group_select;

                this.initDomElement(settings);
                this.initTemplate(settings);
                this.initAttribute(settings);
                this.bindEventHandler();
            },
            initDomElement : function(settings)
            {
                this.dom = {
                    source_item : this.container.find('.source_items'),
                    dest_item : this.container.find('.selected_items'),
                    orderControl : this.container.find('.order_selected_list'),
                    addAllToSelectedList : this.container.find('.add_all_to_selected_list'),
                    removeAllFromSelectedList : this.container.find('.remove_all_from_selected_list'),
                    categorySelect : this.container.find('#'+settings.group_select_menu_id),
                    categorySelectUI : this.container.find('#'+settings.categorySelectUI),
                    categorySelectValue : this.container.find('#'+settings.categorySelectValue),
                    popupItemCategory : this.container.find('#'+settings.popupItemCategory),
                    buttonOK: this.container.find('.mobile_ok_grn'),
                    buttonCancel: this.container.find('.mobile_cancel_grn'),
                    lastestDestList : this.container.find('.selected_items').clone(), // this item use to store lastest state of selected item
                    breadcrumLink : this.container.find('.mobile_breadcrumbtitle_left_grn'),
                    div_loading : $('<div class="mobile_spinner_block_grn"><span class="mobile_icon_spinner_grn"></span></div>'), // spinner when load ajax
                    empty_list : $('<li data-icon="false" class="mobile-user-none-grn ui-li ui-li-static ui-btn-up-c ui-first-child ui-last-child"></li>').html(settings.empty_list), // element is shown when source list empty
                    none_selected : $('<li data-icon="false" class="mobile-user-none-grn ui-li ui-li-static ui-btn-up-c ui-first-child ui-last-child"></li>').html(settings.none_selected), // element is shown when none selected item
                    lastest_item : $('<li data-icon="false" class="mobile-list-last-grn ui-li ui-li-static ui-btn-up-c ui-last-child"></li>') // the lastest item of list
                };
            },
            initTemplate : function(settings)
            {
                this.template = {
                    src_item : $(settings.src_item).html(),
                    dest_item : $(settings.dest_item).html()
                };
            },
            initAttribute : function(settings)
            {
            },
            bindEventHandler : function()
            {
                var dom = this.dom;
                var source_item = dom.source_item;
                source_item.on("touchstart", '.mobile_add_grn', $.proxy(this.handleAddItem, this) );
                source_item.on("touchstart", 'li', $.proxy(this.handleBlurInputSearch, this) );
                source_item.scroll( $.proxy(this.getMoreItems, this));

                var dest_item = this.dom.dest_item;
                dest_item.on("touchstart", '.mobile_delete_grn', $.proxy(this.handleRemoveItem, this) );
                dest_item.on("tap", '.selection_item', $.proxy(this.handleSelectItem, this) );

                dom.orderControl.on("touchstart", '.mobile_order_control_grn', $.proxy(this.handleOrder, this) );

                dom.addAllToSelectedList.on("touchstart", $.proxy(this.addAllItemFromGroup, this) );

                dom.removeAllFromSelectedList.on("touchstart", $.proxy(this.removeAllTick, this) );

                dom.categorySelect.change( $.proxy(this.changeGroup, this) );

                dom.buttonOK.on("touchstart", $.proxy(this.add, this) );

                dom.buttonCancel.on("touchstart", $.proxy(this.cancel, this) );

                dom.breadcrumLink.on("click",  $.proxy(this.cancel, this) );

                // fix problem when list view have scrollbar, its scrollbar display over popup select category
                $(document).on("popupbeforeposition",this.dom.popupItemCategory,function(event){
                    source_item.css('overflow','hidden');
                    dest_item.css('overflow','hidden');
                });

                $(document).on("popupafterclose",this.dom.popupItemCategory,function(event){
                    source_item.css('overflow','auto');
                    dest_item.css('overflow','auto');
                });

            },
            bindEventBeforePageShow : function(event)
            {
                // using for element that need to bind again because of jquery mobile loading DOM
                if(!this.bindAgain)
                {
                    var dom = this.dom;
                    dom.inputSearch = this.container.find('.search_item');
                    dom.inputSearch.data('holder',dom.inputSearch.attr('placeholder'));
                    dom.deleteInput = this.container.find('.delete_input');
                    dom.iconSearch = this.container.find('.search_item_icon');

                    dom.iconSearch.on("click", $.proxy(this.searchItemByTap, this) );
                    dom.deleteInput.on("click", $.proxy(this.clearInput, this) );

                    dom.inputSearch.keypress( $.proxy(this.searchItemByKeyPress, this) );
                    dom.inputSearch.keyup( $.proxy(this.handleBackspace, this) );
                    dom.inputSearch.focus( $.proxy(this.focusSearchInput, this) );
                    dom.inputSearch.blur( $.proxy(this.blurSearchInput, this) );

                    this.bindAgain = true;
                }
            },
            searchItemByKeyPress : function(event)
            {
                var keycode = (event.keyCode ? event.keyCode : event.which);
                if(keycode == '13')
                {
                    this.handleSearchItem(event);
                }
            },
            searchItemByTap : function(event)
            {
                this.handleSearchItem(event);
            },
            handleBackspace : function(event)
            {
                this.toggleCloseIcon();
            },
            toggleCloseIcon : function(event)
            {
                if(this.dom.inputSearch.val().length > 0)
                {
                    this.dom.deleteInput.show();
                }
                else
                {
                    this.dom.deleteInput.hide();
                }
            },
            handleSearchItem : function(event)
            {
                this.sp = 0;
                this.keyword = this.dom.inputSearch.val();
                this.ajaxSettings = {
                     keyword : this.keyword,
                     element : this.dom.source_item,
                     type_list : 'src_item',
                     reload_list : true,
                     type : 'search'
                };
                this.ajaxGetItems();
                this.container.find('.mobile_event_menu_content_grn').html(this.option_search);
                this.dom.categorySelect.val('search');
                this.dom.popupItemCategory.find('.mobile_check_grn').removeClass('mobile_check_grn');
                event.preventDefault();
                event.stopPropagation();
                return false;
            },
            handleBlurInputSearch : function()
            {
                this.dom.inputSearch.blur();
            },
            clearInput : function(event)
            {
                this.dom.inputSearch.val("");
                this.dom.deleteInput.hide();
            },
            focusSearchInput : function(event)
            {
                this.dom.inputSearch.closest(".mobile_user_search_grn").addClass("mobile_user_search_focus_grn");
                this.dom.inputSearch.attr('placeholder','');
                this.toggleCloseIcon();
            },
            blurSearchInput : function(event)
            {
                this.dom.inputSearch.closest(".mobile_user_search_grn").removeClass("mobile_user_search_focus_grn");
                this.dom.inputSearch.attr('placeholder',this.dom.inputSearch.data('holder'));
                var me = this;
                setTimeout(function(){
                    me.dom.deleteInput.hide();
                },200);
            },
            handleAddItem : function(event)
            {
                var element = $(event.target);
                var parent = element.closest('li');
                var id = parent.data('id');
                var gid = parent.data('gid');
                var type = parent.data('type');
                if(parent.hasClass('mobile_base_disable_grn'))
                {
                }
                else
                {
                    if(!element.hasClass('selection_item'))
                    {
                        element = element.closest('a');
                    }

                    var display_name = element.find("div.mobile_user_grn").text();
                    var group_name = element.find("div.mobile_text_grn").text();
                    var img = element.find('.mobile_user_photo_grn').clone();

                    var dest_item = $($.parseHTML(this.template.dest_item)).filter("*").clone();
                    var dom_dest_item = this.dom.dest_item;
                    var last_item_list = dom_dest_item.find('li.mobile-list-last-grn');
                    if(last_item_list.length > 0)
                    {
                        last_item_list.remove();
                    }
                    else
                    {
                        dom_dest_item.empty();
                        last_item_list = this.dom.lastest_item.clone();
                    }

                    var frag = document.createDocumentFragment();
                    var classItem = this.getClassItem(type, id, gid);
                    if(type == this.type_item)
                    {
                        dest_item.find('div.mobile_text_grn').text(group_name);
                        dest_item.addClass(this.classBelongGroup + gid );
                        dest_item.data('id',id);
                    }

                    dest_item.addClass(classItem);
                    dest_item.find('div.mobile_user_grn').text(display_name);
                    dest_item.data('gid',gid);
                    dest_item.data('type',type);
                    if(type == 'facility')
                    {
                        dest_item.data('checkrepeat',parent.data('checkrepeat'));
                        dest_item.data('approval',parent.data('approval'));
                    }
                    dest_item.find('.mobile_user_photo_grn').remove();
                    dest_item.find('.selection_item').prepend(img);

                    frag.appendChild( dest_item[0] );
                    dom_dest_item.append(frag);
                    dom_dest_item.append(last_item_list);

                    parent.addClass("mobile_base_disable_grn");
                }
                event.preventDefault();
                event.stopPropagation();
            },
            handleRemoveItem : function(event)
            {
            },
            handleSelectItem : function(event)
            {
                var element = $(event.target);
                element.closest('.mobile_selected_grn').toggleClass("mobile_selected_user_grn");
                this.checkShowClearSelection();
                event.preventDefault();
                event.stopPropagation();
            },
            handleOrder : function(event)
            {
                var $target = $(event.target);
                if(!$target.hasClass('mobile_order_control_grn'))
                {
                    $target = $target.closest('div.mobile_order_control_grn');
                }
                if ($target.hasClass('order_top')) this.orderTop(event);
                if ($target.hasClass('order_up')) this.orderUp(event);
                if ($target.hasClass('order_down')) this.orderDown(event);
                if ($target.hasClass('order_bottom')) this.orderBottom(event);
                event.preventDefault();
                event.stopPropagation();
            },
            orderTop : function(event)
            {
                var dest_item = this.dom.dest_item;
                var list_selected = dest_item.find("li.mobile_selected_user_grn");
                if(list_selected.length > 0)
                {
                    var frag = document.createDocumentFragment();
                    list_selected.each(function(){
                        frag.appendChild( this );
                    });
                    dest_item.prepend(frag);
                }
            },
            orderUp : function(event)
            {
                var list_selected = this.dom.dest_item.find("li.mobile_selected_user_grn");
                if(list_selected.length > 0 && $(list_selected[0]).prev().length > 0)
                {
                    list_selected.each(function(){
                        var thisObj = $(this);
                        var prev = thisObj.prev();

                        if(prev.length > 0 && !prev.hasClass('mobile_selected_user_grn'))
                        {
                            thisObj.after(prev);
                        }
                    });
                }
            },
            orderDown : function(event)
            {
                // get reverse order object selected item
                var list_selected = $(this.dom.dest_item.find("li.mobile_selected_user_grn").get().reverse());
                if(list_selected.length > 0 && !$(list_selected[0]).next().hasClass('mobile-list-last-grn'))
                {
                    list_selected.each(function(){
                        var thisObj = $(this);
                        var next = thisObj.next();
                        if(next.length > 0 && !next.hasClass('mobile_selected_user_grn') && !next.hasClass('mobile-list-last-grn'))
                        {
                            thisObj.before(next);
                        }
                    });
                }
            },
            orderBottom : function(event)
            {
                var dest_item = this.dom.dest_item;
                var last_item_list = dest_item.find('li.mobile-list-last-grn');
                last_item_list.remove();

                var list_selected = dest_item.find("li.mobile_selected_user_grn");
                if(list_selected.length > 0)
                {
                    var frag = document.createDocumentFragment();
                    list_selected.each(function(){
                        frag.appendChild( this );
                    });
                    dest_item.append(frag);
                    dest_item.append(last_item_list);
                }
            },
            changeGroup : function()
            {
                this.sp = 0;
                this.lastestCounter = 0;
                var selected_group = this.dom.categorySelect.val();
                if(selected_group.length > 0)
                {
                    if(selected_group == 'search')
                    {
                        this.keyword = this.dom.inputSearch.val();
                        this.ajaxSettings = {
                            keyword : this.keyword,
                            element : this.dom.source_item,
                            type_list : 'src_item',
                            reload_list : true,
                            type : 'search'
                        };
                    }
                    else
                    {
                        this.ajaxSettings = {
                            groupSelected : this.dom.categorySelect.val(),
                            element : this.dom.source_item,
                            type_list : 'src_item',
                            reload_list : true,
                            include_org : true,
                            type : 'get'
                        };
                    }
                    this.ajaxGetItems();
                }
                else
                {
                    this.resetSourceItemList();
                }
            },
            ajaxGetItems : function()
            {
                var ajaxURL = '';
                if(this.ajaxSettings.type == 'get')
                {
                    ajaxURL = this.ajaxGetItemURL;
                }
                else
                {
                    if(this.ajaxSettings.type == 'search')
                    {
                        ajaxURL = this.ajaxSearchItemURL;
                    }
                }
                if (ajaxURL.length > 0 && this.isAjax == false)
                {
                    this.isAjax = true;

                    var data_send = '';
                    if(this.args != '')
                    {
                        data_send += this.args;
                    }

                    if(this.ajaxSettings.type == 'get')
                    {
                        var groupSelected = this.ajaxSettings.groupSelected;
                        if( groupSelected.substr(0, 1) == 'x' ) {
                            groupSelected = groupSelected.substr( 1 );
                        }
                        data_send += '&gid=' + groupSelected;

                        if(this.ajaxSettings.include_org && this.include_org != '')
                        {
                            data_send += '&include_org=' + this.include_org;
                        }

                        if (this.show_group_role != '') {
                            data_send += '&show_group_role=' + this.show_group_role;
                        }
                    }
                    else
                    {
                        if(this.ajaxSettings.type == 'search')
                        {
                            data_send += '&keyword=' + this.ajaxSettings.keyword;
                        }
                    }

                    if(this.type_item == 'facility')
                    {
                        data_send += '&page_name=' + this.page_name;
                    }

                    var type_list = this.ajaxSettings.type_list;
                    if(type_list == 'src_item')
                    {
                        data_send += '&sp=' + this.sp;
                    }

                    var element = this.ajaxSettings.element;
                    var reload_list = this.ajaxSettings.reload_list;

                    this.last_item_list = element.find('li.mobile-list-last-grn');
                    var me = this;
                    $.ajax(
                    {
                        url : ajaxURL,
                        dataType : 'json',
                        data: data_send,
                        type : 'post',
                        beforeSend : function()
                        {
                            if(reload_list)
                            {
                                element.empty();
                            }
                            else
                            {
                                if(me.last_item_list.length > 0)
                                {
                                    me.last_item_list.remove();
                                }
                                else
                                {
                                    element.empty();
                                }
                            }
                            if(type_list == 'dest_item')
                            {
                                grn.component.mobile_loading.show();
                            }
                            else
                            {
                                element.append(me.dom.div_loading);
                            }
                        },
                        success : function(json_obj, text_status, transport)
                        {
                            if (grn.component.mobile_error_handler.hasCybozuError(transport))
                            {
                                grn.component.mobile_error_handler.show(json_obj);
                            }
                            else
                            {
                                if( type_list == 'src_item' )
                                {
                                    me.sp = json_obj.offset;
                                    me.lastestCounter = json_obj.total;
                                    me.addItemsToSourceList(json_obj);
                                    me.doAfterLoadSrcList();
                                }
                                else
                                {
                                    me.addItemsToDestList(json_obj);
                                    me.doAfterLoadDesList();
                                }
                            }
                        },
                        error : function(transport)
                        {
                            if (grn.component.mobile_error_handler.hasCybozuLogin(transport))
                            {
                            }
                            else
                            {
                                document.write(transport.responseText);
                                document.close();
                            }
                            if(type_list == 'dest_item')
                            {
                                grn.component.mobile_loading.remove();
                            }
                        },
                        complete : function()
                        {
                            if(type_list == 'dest_item')
                            {
                                grn.component.mobile_loading.remove();
                            }
                            me.isAjax = false;
                        }
                    });
                }
            },
            addItemsToSourceList : function(json_obj)
            {
                this.frag = document.createDocumentFragment();
                var me = this;
                $.each( json_obj.list, function( key, value ) {
                    me.addElementItemToSourceList(key, value);
                });
                this.dom.div_loading.remove();
                if(this.last_item_list.length > 0)
                {
                    this.frag.appendChild(this.last_item_list[0]);
                }
                else
                {
                    var last_item_list = this.dom.lastest_item.clone();
                    this.frag.appendChild(last_item_list[0]);
                }
                this.dom.source_item.append(this.frag);
            },
            addElementItemToSourceList : function(key, value)
            {
                var is_add = true;
                var id = (typeof value.id !='undefined') ? value.id : '';
                var gid = (typeof value.gid !='undefined') ? value.gid : '';

                var classItem = this.getClassItem(value.type, id, gid);

                if(!this.ajaxSettings.reload_list)
                {
                    var temp = this.classItem + id;
                    var selected_item = this.dom.source_item.find('li.'+temp);
                    if(selected_item.length > 0)
                    {
                        is_add = false;
                    }
                }
                if(is_add)
                {
                    template = $($.parseHTML(this.template.src_item)).filter("*").clone();
                    if(value.type == this.type_item) // case of user
                    {
                        template.find('div.mobile_text_grn').text(value.primaryGroupName);
                        template.addClass(this.classBelongGroup + gid );
                        template.data('id',id);
                    }

                    template.addClass(classItem);
                    template.data('type',value.type);
                    template.data('gid',gid);
                    if(value.type == 'facility')
                    {
                        template.data('checkrepeat',value.checkrepeat);
                        template.data('approval',value.approval);
                    }

                    this.addClassImgToElement(value, template);

                    if( value.type == 'group' && this.isCalendar != '' )
                    {
                        template.find('div.mobile_user_grn').text("["+value.displayName+"]");
                    }
                    else
                    {
                        template.find('div.mobile_user_grn').text(value.displayName);
                    }

                    var item = this.dom.dest_item.find('li.'+classItem);
                    if(item.length > 0)
                    {
                        template.addClass("mobile_base_disable_grn");
                    }
                    this.frag.appendChild( template[0] );
                }
            },
            addItemsToDestList : function(json_obj)
            {
                this.frag = document.createDocumentFragment();
                var me = this;
                $.each( json_obj.list, function( key, value ) {
                    me.addElementItemToDestList(key, value);
                });
                
                if(this.last_item_list.length > 0)
                {
                    this.frag.appendChild(this.last_item_list[0]);
                }
                else
                {
                    var last_item_list = this.dom.lastest_item.clone();
                    this.frag.appendChild(last_item_list[0]);
                }
                this.dom.dest_item.append(this.frag);
            },
            addElementItemToDestList : function(key, value)
            {
                var is_add = true;
                var id = (typeof value.id !='undefined') ? value.id : '';
                var gid = (typeof value.gid !='undefined') ? value.gid : '';
                var classItem = this.getClassItem(value.type, id, gid);

                var selected_item = this.ajaxSettings.element.find('li.'+classItem);
                if(selected_item.length > 0)
                {
                    is_add = false;
                }

                if(is_add)
                {
                    template = $($.parseHTML(this.template.dest_item)).filter("*").clone();
                    if(value.type == this.type_item)
                    {
                        template.find('div.mobile_text_grn').text(value.primaryGroupName);
                        template.addClass(this.classItem + id );
                        template.data('id',id);
                    }

                    template.addClass(classItem);
                    template.data('type',value.type);
                    template.data('gid',gid);
                    if(value.type == 'facility')
                    {
                        template.data('checkrepeat',value.checkrepeat);
                        template.data('approval',value.approval);
                    }

                    if( value.type == 'group' && this.isCalendar != '' )
                    {
                        template.find('div.mobile_user_grn').text("["+value.displayName+"]");
                    }
                    else
                    {
                        template.find('div.mobile_user_grn').text(value.displayName);
                    }

                    this.addClassImgToElement(value, template);

                    this.frag.appendChild( template[0] );
                }
            },
            removeItemFromList : function( id )
            {
                var className = '.' + this.classItem + id;
                var removed_item = this.dom.dest_item.find(className);
                removed_item.remove();
            },
            removeGroupFromList : function( gid )
            {
            },
            getMoreItems : function(event)
            {
                if(this.lastestCounter <= this.sp)
                {
                    return;
                }
                var target = event.target;
                var element = $(target);
                // grab the scroll amount and the window height
                var scrollAmount = $(element).scrollTop();
                var documentHeight = target.scrollHeight;

                if(documentHeight - scrollAmount < 1000) {
                    // run a function 
                    var groupSelected = this.dom.categorySelect.val();
                    if(groupSelected == 'search')
                    {
                        this.ajaxSettings = {
                            keyword : this.keyword,
                            element : this.dom.source_item,
                            type_list : 'src_item',
                            reload_list : false,
                            type : 'search'
                        };
                    }
                    else
                    {
                        this.ajaxSettings = {
                            groupSelected : groupSelected,
                            element : this.dom.source_item,
                            type_list : 'src_item',
                            reload_list : false,
                            include_org : false,
                            type : 'get'
                        };
                    }
                    this.ajaxGetItems();
                }
            },
            enableItem : function( id )
            {
                var className = 'li.' + this.classItem + id;
                var enabled_item = this.dom.source_item.find(className);
                enabled_item.removeClass('mobile_base_disable_grn');
            },
            enableGroup : function( gid )
            {
            },
            enableRole : function( gid )
            {
            },
            addAllItemFromGroup : function()
            {
                var selected_group = this.dom.categorySelect.val();
                if(selected_group.length > 0)
                {
                    if(selected_group == 'search')
                    {
                        this.keyword = this.dom.inputSearch.val();
                        this.ajaxSettings = {
                            keyword : this.keyword,
                            element : this.dom.dest_item,
                            type_list : 'dest_item',
                            reload_list : false,
                            type : 'search'
                        };
                    }
                    else
                    {
                        this.ajaxSettings = {
                            groupSelected : this.dom.categorySelect.val(),
                            element : this.dom.dest_item,
                            type_list : 'dest_item',
                            reload_list : false,
                            include_org : true,
                            type : 'get'
                        };
                    }
                    this.ajaxGetItems();

                    // disabled all item in source item
                    this.dom.source_item.find("li").addClass('mobile_base_disable_grn');
                    this.checkShowClearSelection();
                }
            },
            removeAllTick : function()
            {
                var dest_item = this.dom.dest_item;
                var me = this;
                dest_item.find("li.mobile_selected_user_grn").each(function()
                {
                    $(this).removeClass("mobile_selected_user_grn");
                });

                this.doAfterLoadDesList();
            },
            add : function()
            {

            },
            cancel : function()
            {
                if(this.processing)
                {
                    return;
                }
                this.processing = true;
                grn.component.mobile_loading.show();
                var me = this;
                // reinit dest list
                this.dom.dest_item.empty();
                var frag = document.createDocumentFragment();
                this.dom.lastestDestList.find('li').each(function(){
                    frag.appendChild(this);
                });
                this.dom.dest_item.append(frag);
                this.checkShowClearSelection();

                setTimeout(function(){
                    grn.component.mobile_loading.remove();
                    location.href='#';
                },500);
                event.preventDefault();
                event.stopPropagation();
            },
            getClassItem : function(type, id, gid)
            {
            },
            saveLastState : function(list)
            {
                this.dom.lastestDestList = this.dom.dest_item.clone(true);
            },
            doAfterLoadSrcList : function()
            {
                var count = this.dom.source_item.find("li").length;
                if(count <= 1)
                {
                    this.dom.source_item.empty();
                    this.dom.source_item.append(this.dom.empty_list.clone());
                    this.dom.source_item.closest('.mobile_user_list_scroll_grn').addClass('mobile-user-list-none-grn');
                }
                else
                {
                    this.dom.source_item.closest('.mobile_user_list_scroll_grn').removeClass('mobile-user-list-none-grn');
                }
            },
            doAfterLoadDesList : function()
            {
                var count = this.dom.dest_item.find("li").length;
                if(count <= 1)
                {
                    this.dom.dest_item.empty();
                    this.dom.dest_item.append(this.dom.none_selected.clone());

                    this.dom.removeAllFromSelectedList.hide();
                }
                else
                {
                    this.checkShowClearSelection();
                }
            },
            addClassImgToElement : function(value, template)
            {
                var classImg;
                var ariaLabel;
                if(value.type == 'user')
                {
                    if( value.isLoginUser )
                    {
                        classImg = 'mobile_img_userLoginPlofile_grn';
                        ariaLabel = grn.component.i18n.cbMsg('grn.grn', 'GRN_GRN-LOGIN_USER');
                    }
                    else if( value.isInvalidUser )
                    {
                        classImg = 'mobile_img_userInvalidPlofile_grn';
                        ariaLabel = grn.component.i18n.cbMsg('grn.grn', 'GRN_GRN-INACTIVE_USER');
                    }
                    else if( value.isNotUsingApp )
                    {
                        classImg = 'mobile_img_userInvalidAppPlofile_grn';
                        ariaLabel = grn.component.i18n.cbMsg('grn.grn', 'GRN_GRN-NOT_APPLICATION_USER');
                    }
                    else
                    {
                        classImg = 'mobile_img_userPlofile_grn';
                        ariaLabel = grn.component.i18n.cbMsg('grn.grn', 'GRN_GRN-1571');
                    }
                }
                else if(value.type == 'group')
                {
                    if( this.isCalendar != '' )
                    {
                        classImg = 'mobile_img_cal_group_profile_grn';
                        ariaLabel = grn.component.i18n.cbMsg('grn.grn', 'GRN_GRN-ORGANIZATION_PLAN');
                    }
                    else
                    {
                        classImg = 'mobile_img_groupPlofile_grn';
                        ariaLabel = grn.component.i18n.cbMsg('grn.grn', 'GRN_GRN-ORGANIZATION');
                    }
                }
                else if(value.type == 'static_role')
                {
                    classImg = 'mobile_img_role_profile_grn';
                    ariaLabel = grn.component.i18n.cbMsg('grn.grn', 'GRN_GRN-ROLE');
                }
                template.find('.mobile_user_photo_grn').addClass(classImg);
                template.find('.mobile_user_photo_grn').prop('aria-label',ariaLabel);
            },
            initSelectedItem : function()
            {
                this.initFlag = true;
                if(typeof this.selectedItem !== 'undefined' && this.selectedItem.hasOwnProperty("list") && this.selectedItem.list !== null )
                {
                    this.ajaxSettings = {
                        element : this.dom.dest_item,
                        type_list : 'dest_item',
                        reload_list : false,
                        include_org : true,
                        type : 'get'
                    };
                    this.last_item_list = this.dom.dest_item.find('li.mobile-list-last-grn');
                    this.addItemsToDestList(this.selectedItem);
                }
                this.doAfterLoadDesList();
                this.add();
                this.initFlag = false;
            },
            checkShowClearSelection : function()
            {
                var count_selected = this.dom.dest_item.find(".mobile_selected_user_grn").length;
                    
                if(count_selected > 0)
                {
                    this.dom.removeAllFromSelectedList.show();
                }
                else
                {
                    this.dom.removeAllFromSelectedList.hide();
                }
            },
            scrollToSelectedItemList : function()
            {
                var count_selected = this.dom.dest_item.find("li").length;
                if(count_selected > 1)
                {
                    $(window).scrollTop(this.dom.dest_item.offset().top);
                    
                }
            },
            resetSourceItemList : function()
            {
                this.dom.source_item.empty();
                this.dom.source_item.append(this.dom.empty_list.clone());
                this.dom.source_item.closest('.mobile_user_list_scroll_grn').addClass('mobile-user-list-none-grn');
            },
            resetCategorySelect : function()
            {
                var content = $('<span class="mobile_event_menu_content_grn">' + this.default_title_group_select + '</span>');
                this.dom.categorySelectUI.empty();
                this.dom.categorySelectUI.append(content);
                var arrowIcon = $("<span class='mobile_select_icon_grn'></span>");
                this.dom.categorySelectUI.append(arrowIcon);

                this.dom.popupItemCategory.find('.mobile_check_grn').removeClass('mobile_check_grn');
                this.dom.inputSearch.val('');
                this.dom.categorySelect.val('');

                this.sp = 0;
                this.lastestCounter = 0;
            }
        };

        return ItemSelection;
    })();
}
