if (!grn.base.isNamespaceDefined("grn.component.mobile_facility_select"))
{
    grn.base.namespace("grn.component.mobile_facility_select");
    grn.component.mobile_facility_select = grn.base.extendClass(grn.component.mobile_item_select, 'MobileFacilitySelect', {
        initAttribute : function(settings)
        {
            this.classItem = 'id_facility_';
            this.defaultUsingPurpose = settings.defaultUsingPurpose;
            this.keepUsingPurpose = settings.keepUsingPurpose;
            this.isUsingPurposeShown  = false;
            this.selected_items = this.container.find('#sITEM');
            this.checkrepeat_items = this.container.find('#checkrepeat');
            this.approval_items = this.container.find('#approval');
        },
        handleRemoveItem : function(event)
        {
            var element = $(event.target);
            var parent = element.closest('li');
            var type = parent.data('type');
            var id = parent.data('id');

            this.enableItem(id);
            element.closest('li.mobile_selected_grn').remove();
            this.doAfterLoadDesList();
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
                var checkrepeat_items = '';
                var approval_items = '';
                var list_selected_items = '';
                var countFacilities = 0;
                var index = 0;
                list_selected.each(function(event){
                    var thisObj = $(this);
                    thisObj.removeClass('mobile_selected_user_grn');
                    var id = thisObj.data('id') ? thisObj.data('id') : '';
                    var type = thisObj.data('type') ? thisObj.data('type') : '';
                    var checkrepeat = thisObj.data('checkrepeat') + '';
                    var approval = thisObj.data('approval') + '';
                    if(type != '' && type == me.type_item)
                    {
                        list_selected_items = list_selected_items ? list_selected_items + ':' + id : id;
                        checkrepeat_items = checkrepeat_items ? checkrepeat_items + ':' + checkrepeat : checkrepeat;
                        approval_items = approval_items ? approval_items + ':' + approval : approval;
                    }
                    if(index < 3)
                    {
                        facility = $('<div class="mobile-font-warp-grn"></div>');
                        name = thisObj.find('.mobile_user_grn').html();
                        facility.html(name);
                        me.associateElement.find('.mobile_for_totalnumber_grn').append(facility);
                        index++;
                    }
                    countFacilities++;
                });
                me.associateElement.find('.totalNumber-grn').text(countFacilities);
                me.selected_items.val(list_selected_items);
                me.checkrepeat_items.val(checkrepeat_items);
                me.approval_items.val(approval_items);
            }
            else
            {
                me.associateElement.find('.mobile-font-warp-grn').remove();
                me.associateElement.find('.totalNumber-grn').text('').hide();
                me.selected_items.val('');
                me.checkrepeat_items.val('');
                me.approval_items.val('');
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
        getClassItem : function(type, id)
        {
            return this.classItem + id;
        },
        toggleUsingPurposeElement : function()
        {
            var usingPurposeElement = $('#using_purpose_element');
            var usingPurpose = $('#using_purpose');
            var approvalItems = $('#approval').val().split(':');
            if(approvalItems.indexOf('1') >= 0)
            {
                if(!this.isUsingPurposeShown && this.keepUsingPurpose.length > 0)
                {
                    usingPurpose.val(this.defaultUsingPurpose);
                }
                usingPurposeElement.show();
                this.isUsingPurposeShown = true;
            }
            else
            {
                $('#require_using_purpose').hide();
                usingPurposeElement.hide();
                this.isUsingPurposeShown = false;
                usingPurpose.val('');
            }
        }
    });
}
