/**
 * Drag n' Drop library for ListView and TreeView
 * created: 2013/03/06(Copied from grn/dragdrop_list2tree.js)
 */

/////////////////// GRN_DDList2Tree ///////////////////

GRN_DDList2Tree = function(options){
    var o = options;
    this._list = document.getElementById(o.list_id);
    this._item = document.getElementById(o.item_id);
    this._item_name = o.item_name;
    this._move_item = o.move_item;
    this._drag_handle = o.drag_handle;
    this._high_light = o.high_light;
    this._unread_color = o.unread_color;
    this._delete_function = o.delete_function;
    this._async_url = o.async_url;
    this._source = o.source || null;
    this._csrf_ticket = o.csrf_ticket;
    this._target_oid_key = o.target_oid_key || 'cid';
    this._drag_msg = o.drag_msg || {singular: 'Move &num_of_items& item', plural: 'Move &num_of_items& items'};
    this._moving_notice = o.moving_notice;
    this._trash_id = o.trash_id;

    this._current_target = null;
    this._drag_enter_num = 0;

    var dd_group = 'default';
    var dd_config = {dragElId: 'dragMsg', resizeFrame: false};
    GRN_DDList2Tree.superclass.constructor.call(this, o.item_id, dd_group, dd_config);
};

YAHOO.extend(GRN_DDList2Tree, YAHOO.util.DDProxy, {
    // overrides YAHOO.util.DDProxy
    b4MouseDown: function(e) {
        this.setStartPosition();
        var dragEl = this.getDragEl();
        var p = YAHOO.util.Dom.getXY(this.getEl());
        this.autoOffset(p[0], p[1]+dragEl.offsetHeight);
    },

    startDrag: function(x, y) {
        _log('startDrag');
        // force dragging check box to 'checked'
        this.getEl().checked = true;
        // highlight row
        var row_id = this._list.id+'-row_'+ this.getEl().value.replace(/,/g,'_');
        var row = jQuery("#" + row_id);
        if(row.length > 0)
        {
            row.addClass(this._high_light);
        }

        var num_of_items = this._getSelectedItems().length;
        
        var proxy = jQuery(this.getDragEl());
        if( num_of_items == 0 ) {
            proxy.css("visibility", "hidden");
            return;
        }
        
        jQuery("body").addClass("drag_cursor");
        grn.page.mail.mail_list.clickCheckBox();
        // hide drag tool tip
        //proxy.setStyle({visibility: 'hidden'});
        proxy.find("span").eq(0).html(this._getDragMessage(num_of_items));
    },
    endDrag: function(e) {
        // do nothing ;-)
        jQuery("body").removeClass("drag_cursor");
        grn.page.mail.mail_list.clickCheckBox();
        _log('endDrag');
    },
    onDragEnter: function(e, id) {
        _log('onDragEnter:'+id);
        // show drag tool tip
        var proxy = jQuery(this.getDragEl());
        var target = document.getElementById(id);
        if( target.type == "checkbox" )
        {
            proxy.css("visibility", "hidden");
            return;
        }
        proxy.css("visibility", "");
        // highlight target folder
        jQuery(target).addClass("node_dragenter_grn");
        this._drag_enter_num++;
    },
    onDragOut: function(e, id) {
        _log('onDragOut:'+id);
        var target = document.getElementById(id);
        if( target.type == "checkbox" )
        {
            return;
        }
        // remove highlight target folder
        jQuery(target).removeClass("node_dragenter_grn");
        // hide drag tool tip
        var proxy = jQuery(this.getDragEl());
        this._drag_enter_num--;
        if (this._drag_enter_num <= 0)
        {
            proxy.css("visibility", "hidden");
        }
    },
    onDragDrop: function(e, id) {
        _log('onDragDrop:'+id);

        // get target
        var target = document.getElementById(id);
        if( target.type == "checkbox")
            return;
        jQuery(target).removeClass("node_dragenter_grn");
        
        this._current_target = target;
        // extract target folder ID
        var target_id = this._getTargetId(target);

        // check moving to trash --> show popup delete
        if( this._trash_id != null && this._trash_id == target_id)
        {
            if(typeof(this._delete_function) == "function")
            {
                this._delete_function();
                return;
            }
        }

        // get selected items
        var selected_items = this._getSelectedItems();
        
        // do command on drop
        this._doDropCommand(selected_items, target_id);
    },
    _getSelectedItems: function(){
        var selector = "input[name='" + this._item_name + "']";
        var all_items = jQuery(this._list).find(selector);
        var retval = jQuery.grep(all_items, function (elm) {
            return jQuery(elm).is(":checked");
        }) ;

        return retval;
    },
    _getDragMessage: function(num_of_items){
        var retval = null;
        var drag_msg = this._drag_msg;
        if(typeof drag_msg == 'string' ){
            retval = drag_msg;
        }
        else{
            if(num_of_items == 1){
                retval = drag_msg.singular;
            }
            else{
                retval = drag_msg.plural;
            }
        }
        
        retval = retval.replace(/&&num_of_items&&/gi, num_of_items);
        
        return retval;
    },
    _getTargetId: function(target){
        // parse ID
        var target_id = jQuery(target).find("a").get(0).id;
        if (target_id)
        {
            var retval = target_id.split("-")[2] || ""; // empty string is ROOT folder
        }
        else
        {
            var retval = jQuery(target).find("a").get(1).id.split("-")[2] || ""; // empty string is ROOT folder
        }
        return retval;
    },
    _doDropCommand: function(selected_items, target_id){
        var me = this;
        var selected_items_id = new Array();
        jQuery.each(selected_items, function(idx, elm) {
            selected_items_id.push(me._item_name + "=" + elm.value);
        });

        var post_data = this._target_oid_key+'='+target_id
                         +'&'+selected_items_id.join('&')
                         +'&csrf_ticket='+this._csrf_ticket
                         +'&cmd=move'
                         +'&use_ajax=1';

        if(this._source)
        {
            post_data = this._source.name+'='+this._source.value+'&'+post_data;
        }
        post_data = this._setPostData(post_data);
        _log('POST data: '+ post_data);
        _log(this._async_url);
        
        // for undo action
        var post_data_undo = this._source.name+'='+target_id +'&'+
                             this._target_oid_key+'='+this._source.value+'&'+
                             selected_items_id.join('&')+
                             '&csrf_ticket='+this._csrf_ticket+
                             '&cmd=move'+
                             '&use_ajax=1';
        if(this._list.move_item && this._list.move_item.rows)
        {
            jQuery.each(this._list.move_item.rows, function(idx, row) {
                jQuery(row).remove();
            });
        }
        this._list.move_item = null;
        this._list.move_item = {};
        this._list.move_item.url = this._async_url;
        this._list.move_item.data_undo = post_data_undo;
        this._list.move_item.source_folder = {};
        this._list.move_item.des_folder = {};
        
        this._doDropCommand_Ajax(this._async_url, post_data, selected_items);
    },
    _doDropCommand_Ajax: function(url, post_data, selected_items){
        //send ajax request
        var me = this;
        YAHOO.util.Connect.asyncRequest( 'POST',
            url,
            {
                success: me._doDropCommand_Success,
                failure: me._checkAjaxResponse,
                argument: { 'dd_object': me, 'selected_items': selected_items }
            },
            post_data );
    },
    _doDropCommand_Success: function(obj){
        var me = obj.argument.dd_object;
        if (!me._checkAjaxResponse(obj)) return;

        me._removeItem(obj.argument.selected_items);
        // show message undo
        var moving_box = jQuery("#moving_box");
        if(moving_box.length > 0)
        {
            if (moving_box.is(":hidden"))
            {
                jQuery("#list_area_scroll").height(jQuery("#list_area_scroll").height() - jQuery("#moving_box").outerHeight(true));
            }
            moving_box.show();
            var moving_notice = me._moving_notice.replace(/&&num_of_items&&/gi, obj.argument.selected_items.length);
            var target_name = jQuery(me._current_target).find("a").get(0).innerHTML;
            moving_notice = moving_notice.replace(/&&moving_place&&/gi, target_name);
            jQuery("#moving_notice").html(moving_notice);
        }

        // update folder unread
        var move_item = me._list.move_item;
        // source
        var source_folder = document.getElementById("folder_tree-selected_node");
        move_item.source_folder.target = source_folder;
        move_item.source_folder.target_id = me._getTargetId(source_folder);
        var updater = grn.component.mail.MailPartsUpdater;
        var responseJSON = YAHOO.lang.JSON.parse(obj.responseText);
        updater.updateEachFolderNumOfUnreadMail(responseJSON.numOfUnreadMails);
        obj_folder_tree.initDrapDropTarget(move_item.source_folder.target_id);

        //disable button after moving
        grn.page.mail.mail_list.blankMailView();
    },
    _setPostData: function(post_data){
        // override this method to add more parameters for your ajax request
        return post_data;
    },
    _removeItem: function(selected_items){
        var me = this;
        var rows = new Array();
        var unread_count = 0;
        jQuery.each(selected_items, function(idx, item) {
            var row_id = me._list.id + "-row_" + item.value.replace(/,/g,"_");
            var row = document.getElementById(row_id);
            if(row)
            {
                if( row.className.indexOf(me._unread_color) > -1 )
                    unread_count++;
                rows.push(row);
                fadeOut = new YAHOO.util.Anim(row_id, { opacity: { to: 0 } }, 0.5);
                fadeOut.onComplete.subscribe(function(){
                    item.checked = false;
                    var row_jQuery_obj = jQuery(row);
                    if(row_jQuery_obj.hasClass(me._unread_color))
                    {
                        row.unread = 1;
                    }
                    row_jQuery_obj.removeClass(me._high_light);
                    jQuery(item).hide();

                    row_jQuery_obj.hide();
                });
                fadeOut.animate();
            }
        });
        me._list.move_item.rows = rows;
        me._list.move_item.unread = unread_count;
    },
    _checkAjaxResponse: function(req){
        var headers = req.getAllResponseHeaders;
        var regex = new RegExp( /X-Cybozu-Error/i );

        // server error
        if( headers.match( regex ) )
        {
            grn.component.error_handler.show(req);
            return false;
        }

        return true;
    }
});

/////////////////// GRN_ListView_Util ///////////////////

GRN_ListView_Util = {
    list_id:null,
    dd_class:null,
    options:null
};
GRN_ListView_Util.InitDragDrop = function( dd_class, options ){
    this.list_id = options.list_id;
    this.dd_class = dd_class;
    this.options = options;
};

GRN_ListView_Util.initDrapDropItem = function(item_id){
    if( !this.dd_class )
        return;
 
    var item = document.getElementById(item_id);
    // checked init dragdrop
    if(item.initDragDrop)
        return;
    item.initDragDrop = true;

    var item_options = {item_id: item.id};
    jQuery.extend(item_options, this.options);

    var obj = new this.dd_class(item_options);
    obj.setOuterHandleElId(item.id);
    obj.setOuterHandleElId( item_options.drag_handle + item.value.replace(/,/g,'_'));
};

GRN_ListView_Util.UndoDrapDrop = function(list_id){
    var moved = document.getElementById(list_id).move_item;
    var me = this;
    YAHOO.util.Connect.asyncRequest( 'POST',
        moved.url,
        {
            success: me.SendAjaxSuccess,
            failure: GRN_ListView_Util.CheckError,
            argument: { 'rows': moved.rows, 'list_id': list_id }
        },
        moved.data_undo);
};

GRN_ListView_Util.SendAjaxSuccess= function(obj){
    var rows = obj.argument.rows;
    if(!GRN_ListView_Util.CheckError(obj))
        return;

    // show row
    jQuery.each(rows, function(idx, row) {
        fadeIn = new YAHOO.util.Anim(row.id, { opacity: { to: 1 } }, 0);
        fadeIn.animate();

        var row_jQuery_obj = jQuery(row);
        if(row.unread == 1 )
        {
            row_jQuery_obj.addClass(GRN_ListView_Util.options.unread_color);
        }
        row_jQuery_obj.show();
        // show checkbox
        var chkbox = row_jQuery_obj.find("input[type='checkbox']").eq(0);
        if(chkbox.length > 0){
            chkbox.show();
        }
        var mail_id = row.id.substr(row.id.length-1,1);
    });

    // undo folder unread
    var list = document.getElementById(obj.argument.list_id);
    var move_item = list.move_item;
    var updater = grn.component.mail.MailPartsUpdater;
    var responseJSON = YAHOO.lang.JSON.parse(obj.responseText);
    updater.updateEachFolderNumOfUnreadMail(responseJSON.numOfUnreadMails);
    obj_folder_tree.initDrapDropTarget(move_item.source_folder.target_id);

    // clear undo data
    list.move_item = null;
    
    // hide moving undo
    var moving_box = jQuery("#moving_box");
    if(moving_box.length > 0 )
    {
        if (!moving_box.is(":hidden"))
        {
            jQuery("#list_area_scroll").height(jQuery("#list_area_scroll").height() + jQuery("#moving_box").outerHeight(true));
        }
        moving_box.hide();
    }
};

GRN_ListView_Util.CheckError= function(req){
        var headers = req.getAllResponseHeaders;
        var regex = new RegExp( /X-Cybozu-Error/i );
        
        // server error
        if( headers.match( regex ) )
        {
            grn.component.error_handler.show(req);
            return false;
        }

        return true;
};

function _log(s)
{
    //try{console.log(s);}catch(e){}
}

function calFolderUnread( folder, unread_move )
{
    var ret = null;
    var obj_unread = jQuery(folder).find("span").get(0);
    if( obj_unread )
    {
        var unread_old = isNaN(obj_unread.innerHTML) ? 0 : parseInt(obj_unread.innerHTML);
        var unread_new = unread_old + unread_move;
        ret = {'old':unread_old,'current':unread_new};
    }
    
    return ret;
}

jQuery(function() {
    refreshCheckedList();
});

function refreshCheckedList()
{
    var list_column = document.getElementById(GRN_ListView_Util.list_id);
    var row = null;
    if(list_column)
    {
        var chkboxs = fastGetElementsByName(list_column, 'input', GRN_ListView_Util.options.item_name);
        jQuery.each(chkboxs, function(idx, chkbox) {
            if( chkbox.checked )
            {
                row = jQuery(chkbox).parents(GRN_ListView_Util.options.move_item).eq(0);
                row.addClass(GRN_ListView_Util.options.high_light);
            }
        });
    }
    row = null;
}
