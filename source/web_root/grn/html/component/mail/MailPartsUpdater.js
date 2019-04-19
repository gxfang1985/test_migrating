(function(){
    grn.base.namespace("grn.component.mail.MailPartsUpdater");
    var updater = grn.component.mail.MailPartsUpdater;

    updater.updateReceiveButtonNumOfRemainsInMailServer = function(numOfRemain) {
        var receive_button =jQuery("span.icon-receiveBSmall-grn");
        if(! receive_button.get(0))
        {
            return;
        }
        var text = receive_button.html().replace(/\(|\d|\)/g, "");
        if(typeof numOfRemain === "number" && numOfRemain > 0)
        {
            text = text + "(" + numOfRemain + ")";
        }
        receive_button.html(text);

    };

    updater.updateEachFolderNumOfUnreadMail = function(numOfUnreadMails) {
        if(typeof numOfUnreadMails !== "object")
        {
            return;
        }

        if(typeof obj_folder_tree !== "object")
        {
            return;
        }
        jQuery.each(numOfUnreadMails, function(folderId, numOfUnreadMailsInFolder){
            obj_folder_tree.setUnreadNumForFolder(folderId, numOfUnreadMailsInFolder);
        });
    };

    updater.updateNotes = function(notes) {

        if (jQuery('.notes'))
        {
            jQuery('.notes').remove();
        }

        if (notes)
        {
            jQuery(notes).prependTo(jQuery('#menu_part'));
        }
    };

})();