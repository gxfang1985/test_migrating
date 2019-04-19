/**
 * Drag n' Drop library for ListView and TreeView
 * author: Huy Nguyen and Tuyen Nguyen
 * created: 2010/05
 */

/////////////////// GRN_DDList2Tree ///////////////////

GRN_DDList2Tree = function(options){
    var o = options;
    this._list = document.getElementById(o.list_id);
    this._item = document.getElementById(o.item_id);
    this._item_name = o.item_name;
    this._async_url = o.async_url;
    this._source = o.source || null;
    this._csrf_ticket = o.csrf_ticket;
    this._target_oid_key = o.target_oid_key || 'cid';
    this._drag_msg = o.drag_msg || {singular: 'Move &num_of_items& item', plural: 'Move &num_of_items& items'};
    this._moving_notice = o.moving_notice;
    
    this._current_target = null;
    
    var dd_group = 'default';
    var dd_config = {dragElId: 'dragMsg', resizeFrame: false};
    GRN_DDList2Tree.superclass.constructor.call(this, o.item_id, dd_group, dd_config);
};

YAHOO.extend(GRN_DDList2Tree, YAHOO.util.DDProxy, {
    startDrag: function(x, y) {
        _log('startDrag');
        // force dragging check box to 'checked'
        this.getEl().checked = true;
        // highlight row
        var row_id = this._list.id+'-row_'+ this.getEl().value.replace(/,/g,'_');
        var row = jQuery("#" + row_id);
        if(row.length > 0)
        {
            row.addClass("row_highlight");
        }

        var num_of_items = this._getSelectedItems().length;

        var proxy = jQuery(this.getDragEl());
        if( num_of_items == 0 ) {
            proxy.css("visibility", "hidden");
            return;
        }

        jQuery("body").addClass("drag_cursor");
        // hide drag tool tip
        //proxy.setStyle({visibility: 'hidden'});
        proxy.find("span").eq(0).html(this._getDragMessage(num_of_items));

    },
    endDrag: function(e) {
        // do nothing ;-)
        jQuery("body").removeClass("drag_cursor");
        _log('endDrag');
    },
    onDragEnter: function(e, id) {
        _log('onDragEnter:'+id);
        // show drag tool tip
        var proxy = jQuery(this.getDragEl());
        var target = document.getElementById(id);

        if( target.type == "checkbox")
        {
            proxy.css("visibility", "hidden");
            return;
        }
        proxy.css("visibility", "");
        // highlight target folder
        jQuery(target).addClass("node_dragenter");
    },
    onDragOut: function(e, id) {
        _log('onDragOut:'+id);
        // remove highlight target folder
        jQuery("#" + id).removeClass("node_dragenter");
        // hide drag tool tip
        var proxy = jQuery(this.getDragEl());
        proxy.css("visibility", "hidden");
    },
    onDragDrop: function(e, id) {
        _log('onDragDrop:'+id);
        // get target
        var target = document.getElementById(id);
        if( target.type == "checkbox")
            return;
        jQuery(target).removeClass("node_dragenter");
        
        this._current_target = target;
        // extract target folder ID
        var target_id = this._getTargetId(target);

        // check moving to trash --> show popup delete
        if( trash_id != null && trash_id == target_id)
        {
            $btn_delete = jQuery("#btn_delete_multi1");

            try
            {
                if($btn_delete.length > 0)
                {
                    $btn_delete.trigger("click");
                    return;
                }
            }
            catch(err)
            {
                btn_delete = jQuery("#btn_delete");
                btn_delete.trigger("click");
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
        });

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
        var retval = jQuery(target).find("a").get(0).id.split('-')[2] || ''; // empty string is ROOT folder
        return retval;
    },
    _doDropCommand: function(selected_items, target_id){
        var me = this;
        var selected_items_id = new Array();
        jQuery.each(selected_items, function(idx, elm){
            selected_items_id.push(me._item_name+'='+elm.value);
        });

        var post_data = this._target_oid_key+'='+target_id
                         +'&'+selected_items_id.join('&')
                         +'&csrf_ticket='+this._csrf_ticket
                         +'&cmd=move';

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
                             '&cmd=move';

        if(this._list.move_item)
        {
            jQuery.each(this._list.move_item.rows, function (idx, row) {
                jQuery(row).remove();
            });
        }
        this._list.move_item = null;
        this._list.move_item = {};
        this._list.move_item.url = this._async_url;
        this._list.move_item.data_undo = post_data_undo;
        this._list.move_item.navi_number_old = {};
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
        move_item.source_folder.unread = calFolderUnread(source_folder, -move_item.unread);
        obj_folder_tree.setUnreadNumForFolder(move_item.source_folder.target_id, move_item.source_folder.unread.current);
        // des
        var des_folder = me._current_target;
        move_item.des_folder.target = des_folder;
        move_item.des_folder.target_id = me._getTargetId(des_folder);
        move_item.des_folder.unread = calFolderUnread(des_folder, move_item.unread);
        obj_folder_tree.setUnreadNumForFolder(move_item.des_folder.target_id, move_item.des_folder.unread.current);
        obj_folder_tree.draw();
        obj_folder_tree.initDrapDropTarget();
        
        // update navi number
        move_item.navi_number_old = updateNaviNumber(obj.argument.selected_items.length);
        updateNaviDownNumber();
        
        //disable button after moving
        if(window.disable_button)
        {
            disable_button();
        }
    },
    _setPostData: function(post_data){
        // override this method to add more parameters for your ajax request
        return post_data;
    },
    _removeItem: function(selected_items){
        var me = this;
        var rows = new Array();
        var unread_count = 0;
        jQuery.each(selected_items, function(idx, item){
            var row_id = me._list.id + "-row_" + item.value.replace(/,/g,"_");
            var summary_row = document.getElementById("summary_row_" + item.value.replace(/,/g,"_"));
            var row = document.getElementById(row_id);
            if(row)
            {
                if( row.className.indexOf("unread_color") > -1 )
                    unread_count++;
                rows.push(row);
                fadeOut = new YAHOO.util.Anim(row_id, { opacity: { to: 0 } }, 0.5);
                fadeOut.onComplete.subscribe(function(){
                    item.checked = false;
                    var row_jQuery_obj = jQuery(row);
                    if(row_jQuery_obj.hasClass("unread_color"))
                    {
                        row_jQuery_obj.removeClass("unread_color");
                        row.unread = 1;
                    }
                    row_jQuery_obj.removeClass("row_highlight");
                    jQuery(item).hide();

                    row_jQuery_obj.hide();
                    jQuery(summary_row).hide();
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
            document.write( req.responseText );
            document.close();
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
    //GRN_ListView_Util.ApplyShiftClick(list_id);
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
    obj.setOuterHandleElId('draghandle_' + item.value.replace(/,/g,'_'));
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
    jQuery.each(rows, function(idx, row){
            fadeIn = new YAHOO.util.Anim(row.id, { opacity: { to: 1 } }, 0);
            fadeIn.animate();

            var row_jquery_obj = jQuery(row);
            if(row.unread == 1 )
            {
                row_jquery_obj.addClass("unread_color");
            }
            row_jquery_obj.show();
            // show checkbox
            var chkbox = row_jquery_obj.find("input[type='checkbox']").eq(0);
            if(chkbox.length > 0) {
                chkbox.show();
            }
            var mail_id = row.id.substr(row.id.length-1,1);
            var toggle_link = document.getElementById('toggle_link_' + mail_id);
            if(toggle_link != null)
            {
                var status = toggle_link.attributes['status'].nodeValue;
                if(status == 'on')
                {
                    var summary_row = jQuery("#summary_row_" + mail_id);
                    summary_row.show();
                }
            }
        }
    );
    
    // undo folder unread
    var list = document.getElementById(obj.argument.list_id);
    var move_item = list.move_item;
    obj_folder_tree.setUnreadNumForFolder(move_item.source_folder.target_id, move_item.source_folder.unread.old);
    if(move_item.des_folder.unread != undefined)
    {
        obj_folder_tree.setUnreadNumForFolder(move_item.des_folder.target_id, move_item.des_folder.unread.old);
    }
    else
    {
        if (document.getElementById("folder_tree-node-" + move_item.des_folder.target_id) != undefined)
        {
            var des_folder = jQuery("#folder_tree-node-" + move_item.des_folder.target_id).parents().get(0);
            if(des_folder)
            {
                
                move_item.des_folder.target = des_folder;
                move_item.des_folder.unread = calFolderUnread(des_folder, -move_item.unread);
                obj_folder_tree.setUnreadNumForFolder(move_item.des_folder.target_id, move_item.des_folder.unread.current);
            }
        }
    }
    obj_folder_tree.draw();
    obj_folder_tree.initDrapDropTarget();
    
    // undo navi number
    var start_num_obj = document.getElementById("start_num");
    if(start_num_obj)
    {
        start_num_obj.innerHTML = move_item.navi_number_old.start_num;
        jQuery("#end_num").html(move_item.navi_number_old.end_num);
        jQuery("#all_num").html(move_item.navi_number_old.all_num);
    }
    updateNaviDownNumber();
    // clear undo data
    list.move_item = null;
    
    // hide moving undo
    var moving_box = jQuery("#moving_box");
    if(moving_box.length > 0)
        moving_box.hide();

};

GRN_ListView_Util.CheckError= function(req){
        var headers = req.getAllResponseHeaders;
        var regex = new RegExp( /X-Cybozu-Error/i );
        
        // server error
        if( headers.match( regex ) )
        {
            document.write( req.responseText );
            document.close();
            return false;
        }
        
        return true;
};

GRN_ListView_Util.ApplyShiftClick = function(list_id){
    var list = document.getElementById(list_id);
    var rows = jQuery(list).find("tr");
    var i=0;
    jQuery.each(rows, function(idx, row){
        var chkbox = jQuery(row).find("input[type='checkbox']").get(0);
        if ( !chkbox ) return;
        
        // create index for each check box
        chkbox.index = i;

        jQuery(chkbox).on("click", function(e){
            if(this.checked)
                jQuery(row).addClass("row_highlight");
            else
                jQuery(row).removeClass("row_highlight");

            // handle Shift click
            var last_click = list.last_click;
            var last_click_index = last_click ? last_click.index : 0;
            var current = this;
            var current_index = this.index;
            var low = Math.min(last_click_index, current_index);
            var high = Math.max(last_click_index, current_index);

            if(e.shiftKey){
                var rows2 = jQuery(list).find("tr");
                jQuery.each(rows2, function(idx, row){
                    var item = jQuery(row).find("input[type='checkbox']").get(0);
                    if ( !item ) return;

                    if(item.index >= low && item.index <= high){
                        item.checked = current.checked;
                    }

                    if(item.checked)
                        jQuery(row).addClass("row_highlight");
                    else
                        jQuery(rrow).removeClass("row_highlight");
                });
            }
            list.last_click = e.target;
        });
        i++;
    });
};
///////////////////

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

function updateNaviNumber( move_count )
{
    var start_num_obj = document.getElementById("start_num");
    if(!start_num_obj){
        return null;
    }
    
    var end_num_obj = document.getElementById("end_num");
    var all_num_obj = document.getElementById("all_num");
    start_num_count = parseInt(start_num_obj.innerHTML);
    end_num_count = parseInt(end_num_obj.innerHTML);
    all_num_count = parseInt(all_num_obj.innerHTML);
    var total_item = end_num_count - start_num_count + 1;
    // all num
    jQuery(all_num_obj).html(all_num_count - move_count);
    if(move_count < total_item)
    {
        jQuery(end_num_obj).html(end_num_count - move_count);
    }
    else // equal
    {
        jQuery(start_num_obj).html(0);
        jQuery(end_num_obj).html(0);
    }
    var ret = {'start_num':start_num_count,'end_num':end_num_count,'all_num':all_num_count};
    return ret;
}

function updateNaviDownNumber()
{
    var start_num_obj = document.getElementById("start_num_down");
    var end_num_obj = document.getElementById("end_num_down");
    if(start_num_obj)
    {
        jQuery(start_num_obj).html(parseInt(document.getElementById("start_num").innerHTML));
        jQuery(end_num_obj).html(parseInt(document.getElementById("end_num").innerHTML));
    }
}

jQuery(function(){
    refreshCheckedList();
});

function refreshCheckedList()
{
    var list_column = document.getElementById(GRN_ListView_Util.list_id);
    var row = null;
    if(list_column)
    {
        var chkboxs = fastGetElementsByName(list_column, 'input', GRN_ListView_Util.options.item_name);
        jQuery.each(chkboxs, function (idx, chkbox) {
            if (chkbox.checked) {
                row = jQuery(chkbox).parents("tr").eq(0);
                row.addClass("row_highlight");
            }
        });
    }
    row = null;
}
