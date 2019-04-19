jQuery(document).click(function (event) {
    grn.component.mail.DropDown.handleEvent(event);
    if (form_name == undefined) {
        return false;
    }
    if (!grn_is_checked(document.forms[form_name], "ids[]")) {
        disable_button();
    }
    else {
        var list_button_disable = jQuery("span.mail-listButtonDisable-grn");
        list_button_disable.each(function () {
            jQuery(this).removeClass("mail-listButtonDisable-grn");
            jQuery(this).addClass("mail-listButton-grn");
        });

        var arrow_down_disable = jQuery("span.mail-arrowDownDisable-grn");
        arrow_down_disable.each(function () {
            jQuery(this).removeClass("mail-arrowDownDisable-grn");
            jQuery(this).addClass("mail-arrowDown-grn");
        });

        var delete_multi_files_enable = jQuery("#lnk_delete_multi_files");
        var delete_multi_files_disable = jQuery("#lnk_delete_multi_files_disable");
        delete_multi_files_disable.hide();
        delete_multi_files_enable.show();
    }
});

jQuery(window).resize(function () {
    setTimeout(changePosition, 0);
    setTimeout(changeNaviBarSize, 0);
});

//GRN2-5663
jQuery(function () {
    setTimeout(changeNaviBarSize, 0);
});

function changeNaviBarSize() {
    if (grn.browser.msie) {
        var navi_bar = jQuery("#mail_navi_index");
        var footer = jQuery("#footer");
        if (footer.length > 0) {
            var width = footer.width();

            if (parseInt(width) < 850) {
                navi_bar.css({"width": "850px"});
            }
            else {
                navi_bar.css({"width": ""});
            }

            //hack for IE bug.
            setTimeout(function () {
                navi_bar.css({"zoom": "1"});
            }, 0);
        }
    }
}
//GRN2-5663

function changePosition() {
    var drop_down = jQuery("span.mail-dropdownContents-open");
    drop_down.each(function() {
        grn.component.mail.DropDown.displayDropDownListMenu(jQuery(this).children().eq(0));
    });
}

function submit_form(type) {
    if (!grn_is_checked(document.forms[form_name], "ids[]"))
        return false;
    var action = "";

    if (type == "read") {
        action = "read";
    }
    else if (type == "unread") {
        action = "unread";
    }

    if (action === "") {
        return;
    }

    document.getElementById("cmd_index").value = action;
    document.forms[form_name].submit();
}

function submit_change_status(csid)
{
    if( ! grn_is_checked( document.forms[form_name], "ids[]" ) )
        return false;
        
    document.getElementById("cmd_index").value = "change_status";
    document.getElementById("cs_value_index").value = csid;
    document.forms[form_name].submit();
}

function disable_button()
{
    var list_button = jQuery("span.mail-listButton-grn");
    list_button.each(function () {
        jQuery(this).removeClass("mail-listButton-grn");
        jQuery(this).addClass("mail-listButtonDisable-grn");
    });

    var arrow_down = jQuery("span.mail-arrowDown-grn");
    arrow_down.each(function () {
        jQuery(this).removeClass("mail-arrowDown-grn");
        jQuery(this).addClass("mail-arrowDownDisable-grn");
    });

    var arrow_up = jQuery("span.mail-arrowUp-grn");
    arrow_up.each(function () {
        jQuery(this).removeClass("mail-arrowUp-grn");
        jQuery(this).addClass("mail-arrowUpDisable-grn");
    });

    var delete_multi_files_enable = jQuery("#lnk_delete_multi_files");
    var delete_multi_files_disable = jQuery("#lnk_delete_multi_files_disable");
    delete_multi_files_enable.hide();
    delete_multi_files_disable.show();
}

/////////////////// GRN_MoveEmail_Util ///////////////////

GRN_MoveEmail_Util = {
    list_item:null
};

GRN_MoveEmail_Util.init = function(){
    this.list_item = document.getElementById("mail_list");
};

GRN_MoveEmail_Util.move_email = function (target_id){
    if(target_id == 'none')
    {
        return;
    }

    if(target_id == 'another')
    {
        if( ! grn_is_checked( document.forms[form_name], 'ids[]' ) )
            return false;
        
        document.getElementById('cmd_index').value = 'move';
        document.getElementById('move_value_index').value = 'another_account';
        document.forms[form_name].submit();
        return;
    }
    
    if(target_id == source_value)
    {
        return;
    }

    var selector = 'input[name="ids[]"]';
    var items = jQuery(this.list_item).find(selector);
    var selected_items = jQuery.map(items, function (i) {
        if (i.checked) {
            return i;
        }
    });

    var selected_items_id = new Array();
    jQuery(selected_items).each(function(index,element){
            selected_items_id.push("ids[]"+'='+element.value);
    });

     var post_data = target_oid_key+'='+target_id
                      +'&'+selected_items_id.join('&')
                      +'&csrf_ticket='+csrf_ticket;

    post_data = source_name+'='+source_value+'&'+post_data;

    //for undo action
    var post_data_undo = source_name+'='+target_id +'&'+
                         target_oid_key+'='+source_value+'&'+
                         selected_items_id.join('&')+
                         '&csrf_ticket='+csrf_ticket;
    if(this.list_item.move_item)
    {
        jQuery(this.list_item.move_item.rows).each(function(index,row){
                jQuery(row).remove();
            }
        );
    }
    this.list_item.move_item = null;
    this.list_item.move_item = {};
    this.list_item.move_item.url = url_ajax_move_email;
    this.list_item.move_item.data_undo = post_data_undo;
    this.list_item.move_item.navi_number_old = {};
    this.list_item.move_item.source_folder = {};
    this.list_item.move_item.des_folder = {};
    
    this.do_ajax_move_email(url_ajax_move_email, post_data,selected_items,target_id);
};


GRN_MoveEmail_Util.do_ajax_move_email = function (url, post_data,selected_items,target_id)
{
    var me = this;

    var request = new grn.component.ajax.request({
            url: url,
            dataType: "json",
            data: post_data,
            grnRedirectOnLoginError: true,
            method: "post"
        }
    );
    request.send().done(function (json_obj) {
        me.remove_item(selected_items);
        var moving_box = document.getElementById("moving_box");
        if (moving_box) {
            moving_box.style.display = "";
            var moving_notice = moving_notice_content.replace(/&&num_of_items&&/gi, json_obj.mail_move_count);
            jQuery("#moving_notice").html(moving_notice);
        }

        // update folder unread
        var move_item = me.list_item.move_item;
        // source
        var source_folder = document.getElementById("folder_tree-selected_node");
        move_item.source_folder.target = source_folder;
        move_item.source_folder.target_id = source_value;
        move_item.source_folder.unread = calFolderUnread(source_folder, -move_item.unread);
        obj_folder_tree.setUnreadNumForFolder(move_item.source_folder.target_id, move_item.source_folder.unread.current);
        // des
        move_item.des_folder.target_id = target_id;
        var folder_tree_node = jQuery("#folder_tree-node-" + target_id);
        if (folder_tree_node.length > 0) {
            var des_folder = folder_tree_node.parents().get(0);
            if (des_folder) {
                move_item.des_folder.target = des_folder;
                move_item.des_folder.unread = calFolderUnread(des_folder, move_item.unread);
                obj_folder_tree.setUnreadNumForFolder(move_item.des_folder.target_id, move_item.des_folder.unread.current);
            }
        }
        obj_folder_tree.draw();
        obj_folder_tree.initDrapDropTarget();

        // update navi number
        move_item.navi_number_old = updateNaviNumber(json_obj.mail_move_count);
        updateNaviDownNumber();

        //disable button after moving
        disable_button();
    });
};

GRN_MoveEmail_Util.remove_item = function (selected_items){
    var me = this;
    var rows = new Array();
    var unread_count = 0;
    jQuery(selected_items).each(function(index,item){
        var row_id = me.list_item.id+'-row_'+item.value.replace(/,/g,'_');
        var summary_row = jQuery("#summary_row_" + item.value.replace(/,/g,'_'));
        var row = document.getElementById(row_id);
        if(row)
        {
            if( row.className.indexOf("unread_color") > -1 )
                unread_count++;
            rows.push(row);
            var row_jquery_obj = jQuery(row);
            fadeOut = new YAHOO.util.Anim(row_id, { opacity: { to: 0 } }, 0.5);
            fadeOut.onComplete.subscribe(function(){
                item.checked = false;
                if(row_jquery_obj.hasClass("unread_color"))
                {
                    row_jquery_obj.removeClass('unread_color');
                    row.unread = 1;
                }
                row_jquery_obj.removeClass('row_highlight');
                jQuery(item).hide();

                row_jquery_obj.hide();
                summary_row.hide();
            });
            fadeOut.animate();
        }
    });
    this.list_item.move_item.rows = rows;
    this.list_item.move_item.unread = unread_count;
};
