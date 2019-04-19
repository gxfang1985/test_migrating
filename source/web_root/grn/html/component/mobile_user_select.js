if (!grn.base.isNamespaceDefined("grn.component.mobile_user_select"))
{
    grn.base.namespace("grn.component.mobile_user_select");
    grn.component.mobile_user_select = grn.base.extendClass(grn.component.mobile_item_select, 'MobileUserSelect', {
        initAttribute : function(settings)
        {
            this.classItem = 'id_user_';
            this.classItemGroup = 'id_user_g';
            this.classItemRole = 'id_user_r';
            this.selected_groups = this.container.find('#selected_groups_' + settings.element_id);
            this.selected_items = this.container.find('#selected_users_' + settings.element_id);
        },
        handleRemoveItem : function(event)
        {
            var element = $(event.target);
            var parent = element.closest('li');
            var type = parent.data('type');

            if(type == 'user')
            {
                var id = parent.data('id');
                this.enableItem(id);
            }
            else if(type == 'group')
            {
                var gid = parent.data('gid');
                this.enableGroup(gid);
            }
            else if(type == 'static_role')
            {
                var gid = parent.data('gid');
                this.enableRole(gid);
            }

            element.closest('li.mobile_selected_grn').remove();
            this.doAfterLoadDesList();
        },
        removeGroupFromList : function( gid )
        {
            var className = 'li.' + this.classItemGroup + gid;
            var removed_group = this.dom.dest_item.find(className);
            removed_group.remove();
        },
        enableGroup : function( gid )
        {
            var className = 'li.' + this.classItemGroup + gid;
            var enabled_group = this.dom.source_item.find(className);
            enabled_group.removeClass('mobile_base_disable_grn');
        },
        enableRole : function( gid )
        {
            var className = 'li.' + this.classItemRole + gid;
            var enabled_role = this.dom.source_item.find(className);
            enabled_role.removeClass('mobile_base_disable_grn');
        },
        add : function()
        {
            if(!this.initFlag)
            {
                grn.component.mobile_loading.show();
            }
            this.adding = true;
            var me = this;

            var list_selected = me.dom.dest_item.find("li.mobile_selected_grn");
            if(list_selected.length > 0)
            {
                me.associateElement.find('.mobile-font-warp-grn').remove();
                me.associateElement.find('.totalNumber-grn').show();
                var list_selected_groups = '';
                var list_selected_items = '';
                var countUser = 0;
                var index = 0;
                list_selected.each(function(event){
                    var thisObj = $(this);
                    thisObj.removeClass('mobile_selected_user_grn');
                    var gid = thisObj.data('gid') ? thisObj.data('gid') : '';
                    var id = thisObj.data('id') ? thisObj.data('id') : '';
                    var type = thisObj.data('type') ? thisObj.data('type') : '';
                    if(type != '' && type == me.type_item)
                    {
                        list_selected_groups = list_selected_groups ? list_selected_groups + ':' + gid : gid;
                        list_selected_items = list_selected_items ? list_selected_items + ':' + id : id;
                    }
                    else
                    {
                        if(type != '' && type == 'group')
                        {
                            list_selected_groups = list_selected_groups ? list_selected_groups + ':' + gid : gid;
                            list_selected_items = list_selected_items ? list_selected_items + ':' + 'g' + gid : 'g' + gid;
                        }
                        else if(type != '' && type == 'static_role')
                        {
                            list_selected_items = list_selected_items ? list_selected_items + ':' + 'r' + gid : 'r' + gid;
                        }
                    }
                    if(index < 3)
                    {
                        attendee = $('<div class="mobile-font-warp-grn"></div>');
                        name = thisObj.find('.mobile_user_grn').html();
                        attendee.html(name);
                        me.associateElement.find('.mobile_for_totalnumber_grn').append(attendee);
                        index++;
                    }
                    countUser++;
                });
                me.associateElement.find('.totalNumber-grn').text(countUser);
                me.selected_groups.val(list_selected_groups);
                me.selected_items.val(list_selected_items);
            }
            else
            {
                me.associateElement.find('.mobile-font-warp-grn').remove();
                me.associateElement.find('.totalNumber-grn').text('').hide();
                me.selected_groups.val('');
                me.selected_items.val('');
            }
            this.checkShowClearSelection();
            if(!this.initFlag)
            {
                setTimeout(function(){
                    grn.component.mobile_loading.remove();
                    location.href='#';
                },500);
            }
        },
        getClassItem : function(type, id, gid)
        {
            var typeClassItem;
            if(type == 'user')
            {
                typeClassItem = this.classItem + id;
            }
            else if(type == 'group')
            {
                typeClassItem = this.classItemGroup + gid;
            }
            else if(type == 'static_role')
            {
                typeClassItem = this.classItemRole + gid;
            }
            return typeClassItem;
        }
    });
}
