/**
 * 
 */
grn.base.namespace("grn.component.space");

grn.component.space.BalloonField = function(balloonFieldData){
    this.balloonFieldData = balloonFieldData;
};
grn.component.space.BalloonField.SHOW = "show";
grn.component.space.BalloonField.HIDE = "hide";

grn.component.space.BalloonField.prototype.render = function(balloonElementId, borderElementId, edgeElementId){
    this.balloonElementId = balloonElementId;
    this.borderElementId = borderElementId;
    this.edgeElementId = edgeElementId;
    
    if(this.balloonFieldData["balloonStatus"] == grn.component.space.BalloonField.SHOW){
        jQuery("#" + this.balloonElementId).show();
        jQuery("#" + this.edgeElementId).show();
    } else {
        jQuery("#" + this.balloonElementId).hide();
        jQuery("#" + this.edgeElementId).hide();
    }
    if(this.balloonFieldData["borderStatus"] == grn.component.space.BalloonField.SHOW){
        jQuery("#" + this.borderElementId).show();
    } else {
        jQuery("#" + this.borderElementId).hide();
    }
};

grn.component.space.BalloonField.prototype.showBalloon = function(){
    if(this.balloonFieldData["balloonStatus"] == grn.component.space.BalloonField.HIDE){
        this.balloonFieldData["balloonStatus"] = grn.component.space.BalloonField.SHOW;
        jQuery("#" + this.balloonElementId).show();
        jQuery("#" + this.edgeElementId).show();
    }
};

grn.component.space.BalloonField.prototype.hideBalloon = function(){
    if(this.balloonFieldData["balloonStatus"] == grn.component.space.BalloonField.SHOW){
        this.balloonFieldData["balloonStatus"] = grn.component.space.BalloonField.HIDE;
        jQuery("#" + this.balloonElementId).hide();
        jQuery("#" + this.edgeElementId).hide();
    }
};

grn.component.space.BalloonField.prototype.showBorder = function(){
    if(this.balloonFieldData["borderStatus"] == grn.component.space.BalloonField.HIDE){
        this.balloonFieldData["borderStatus"] = grn.component.space.BalloonField.SHOW;
        jQuery("#" + this.borderElementId).show();
    }
};

grn.component.space.BalloonField.prototype.hideBorder = function(){
    if(this.balloonFieldData["borderStatus"] == grn.component.space.BalloonField.SHOW){
        this.balloonFieldData["borderStatus"] = grn.component.space.BalloonField.HIDE;
        jQuery("#" + this.borderElementId).hide();
    }
};

grn.component.space.ImageToggleButton = function(toggleButtonData){
    this.toggleButtonData = toggleButtonData;
    
    this.onToggleButtonOn  = new YAHOO.util.CustomEvent("onToggleButtonOn");
    this.onToggleButtonOff = new YAHOO.util.CustomEvent("onToggleButtonOff");
};
grn.component.space.ImageToggleButton.STATUS_ON = "on";
grn.component.space.ImageToggleButton.STATUS_OFF = "off";

grn.component.space.ImageToggleButton.prototype.addToggleButtonOnSubscriber = function(subscriber){
    this.onToggleButtonOn.subscribe(subscriber);
};

grn.component.space.ImageToggleButton.prototype.addToggleButtonOffSubscriber = function(subscriber){
    this.onToggleButtonOff.subscribe(subscriber);
};

grn.component.space.ImageToggleButton.prototype.render = function(buttonElementId){
    this.buttonElementId = buttonElementId;
    if(this.isOn()){
        jQuery("#" + this.buttonElementId).addClass("space-show-icon-base-on-grn");
        jQuery("#" + this.buttonElementId).removeClass("space-show-icon-base-off-grn");
    } else {
        jQuery("#" + this.buttonElementId).addClass("space-show-icon-base-off-grn");
        jQuery("#" + this.buttonElementId).removeClass("space-show-icon-base-on-grn");
    }

    jQuery("#" + this.buttonElementId).on("click", jQuery.proxy(this.toggle, this));
};

grn.component.space.ImageToggleButton.prototype.isOn = function(){
    return this.toggleButtonData["status"] == grn.component.space.ImageToggleButton.STATUS_ON;
};

grn.component.space.ImageToggleButton.prototype.toggle = function(){
    if(this.isOn()){
        this.toggleOff();
    } else {
        this.toggleOn();
    }
};

grn.component.space.ImageToggleButton.prototype.toggleOn = function(){
    jQuery("#" + this.buttonElementId).addClass("space-show-icon-base-on-grn");
    jQuery("#" + this.buttonElementId).removeClass("space-show-icon-base-off-grn");
    this.toggleButtonData["status"] = grn.component.space.ImageToggleButton.STATUS_ON;
    
    this.onToggleButtonOn.fire(this);
};

grn.component.space.ImageToggleButton.prototype.toggleOff = function(){
    jQuery("#" + this.buttonElementId).removeClass("space-show-icon-base-on-grn");
    jQuery("#" + this.buttonElementId).addClass("space-show-icon-base-off-grn");
    this.toggleButtonData["status"] = grn.component.space.ImageToggleButton.STATUS_OFF;
    
    this.onToggleButtonOff.fire(this);
};

grn.component.space.MemberField = function(memberFieldData, resource){
    this.memberFieldData = memberFieldData;
    this.resource = resource;
};
grn.component.space.MemberField.STATUS_SHOW = "show";
grn.component.space.MemberField.STATUS_HIDE = "hide";

grn.component.space.MemberField.prototype.render = function(fieldElementId){
    this.fieldElementId = fieldElementId;

    if(this.memberFieldData["status"] == grn.component.space.MemberField.STATUS_SHOW){
        jQuery("#" + fieldElementId).show();
    } else {
        jQuery("#" + fieldElementId).hide();
    }
    this.onMemberFieldOpenEvent  = new YAHOO.util.CustomEvent("onMemberFieldOpen");
    this.onMemberFieldCloseEvent = new YAHOO.util.CustomEvent("onMemberFieldClose");
    
    jQuery("#" + this.fieldElementId + "-close").on("click", jQuery.proxy(this.closeMemberField, this));
};

grn.component.space.MemberField.prototype.addMemberFieldOpenEventSubscriber = function(subscriber){
    this.onMemberFieldOpenEvent.subscribe(subscriber);
};

grn.component.space.MemberField.prototype.addMemberFieldCloseEventSubscriber = function(subscriber){
    this.onMemberFieldCloseEvent.subscribe(subscriber);
};

/**
 * メンバーフィールドを開く
 */
grn.component.space.MemberField.prototype.openMemberField = function(){
    if(this.isMemberFieldClosed()){
        this.memberFieldData["status"] = grn.component.space.MemberField.STATUS_SHOW;
        jQuery("#" + this.fieldElementId).show();

        var openStatus = "1";

        var request = new grn.component.ajax.request(
            {
                url: this.resource["statusPost"],
                method: "post",
                grnRedirectOnLoginError: true,
                data: {spid: this.memberFieldData["spaceId"], status: openStatus, csrf_ticket: this.resource["csrfTicket"]}
            }
        );
        request.send();
        
        this.onMemberFieldOpenEvent.fire(this);
    }
};

/**
 * メンバーフィールドを閉じる
 */
grn.component.space.MemberField.prototype.closeMemberField = function(){
    if(! this.isMemberFieldClosed()){
        this.memberFieldData["status"] = grn.component.space.MemberField.STATUS_HIDE;
        jQuery("#" + this.fieldElementId).hide();

        var openStatus = "0";

        var request = new grn.component.ajax.request(
            {
                url: this.resource["statusPost"],
                method: "post",
                grnRedirectOnLoginError: true,
                data: {spid: this.memberFieldData["spaceId"], status: openStatus, csrf_ticket: this.resource["csrfTicket"]}
            }
        );
        request.send();

        this.onMemberFieldCloseEvent.fire(this);
    }
};

/**
 * メンバーフィールドを開閉する
 */
grn.component.space.MemberField.prototype.toggleMemberField = function(){
    if(this.isMemberFieldClosed()){
        this.openMemberField();
    } else {
        this.closeMemberField();
    }
};

/**
 * メンバーフィールドが閉じているか調べる
 */
grn.component.space.MemberField.prototype.isMemberFieldClosed = function(){
    return this.memberFieldData["status"] == grn.component.space.MemberField.STATUS_HIDE;
};

grn.component.space.MemberField.prototype.showRemainingMember = function(){
    var request = new grn.component.ajax.request(
        {
            url: this.resource["remainingMemberUrl"],
            grnRedirectOnLoginError: true,
            method: "post",
            dataType: "json",
            data: "spid=" + this.memberFieldData["spaceId"],
            beforeSend: function ()
            {
                jQuery("#display_member_close").hide();
                var spinner = jQuery("<img src='" + this.resource["spinner"] + "'>");
                spinner.css({'height': 16, 'width': 16});
                jQuery("#remaining_member").html(spinner);
            }.bind(this)
        }
    );

    request.on('beforeShowError', function (e, jqXHR) {
        jQuery("#display_member_close").show();
        jQuery("#remaining_member").html("");
    });

    request.send().done(
        function (data) {
            jQuery("#remaining_member").html(data.remainingMember);
            jQuery("#display_member_open").show();

            var $members = jQuery("#remaining_member").find(".span-member-dialog");
            var dialog = grn.component.member_list_dialog.get_instance('member_list_dialog');
            dialog.bind_dialog_to_members($members);
        }
    );
};

grn.component.space.MemberField.prototype.hideRemainingMember = function(){
    jQuery("#display_member_open").hide();
    jQuery("#display_member_close").show();
    jQuery("#remaining_member").html("");
};


grn.component.space.MemoField = function(memoData, resource){
    this.memoData = memoData;
    this.resource = resource;
    this.childView = null;
};



grn.component.space.MemoField.STATUS_SHOW = "show";
grn.component.space.MemoField.STATUS_HIDE = "hide";

grn.component.space.MemoField.CLASS_SWITCH_ON  = "icon-toggleMemo-hide-grn";
grn.component.space.MemoField.CLASS_SWITCH_OFF = "icon-toggleMemo-show-grn";
grn.component.space.MemoField.CLASS_INNER_DIV  = "space-spaceMemo-inner-grn";

/**
 * Memo の領域を表示する
 * @param fieldElementId メモを表示する領域のID
 */
grn.component.space.MemoField.prototype.render = function(fieldElementId){
    this.fieldElementId  = fieldElementId;

    var fieldElement  = jQuery("#" + this.fieldElementId);
    
    if(this.memoData['status'] == grn.component.space.MemoField.STATUS_SHOW){
        fieldElement.show();
    }

    if(jQuery("#" + this.fieldElementId + "-view-edit").length)
    {
        jQuery("#" + this.fieldElementId + "-view-edit").on("click", jQuery.proxy(this.onClickEdit, this));
    }
    jQuery("#" + this.fieldElementId + "-edit-submit").on("click", jQuery.proxy(this.onClickPost, this));
    jQuery("#" + this.fieldElementId + "-edit-cancel").on("click", jQuery.proxy(this.onClickCancel, this));
    jQuery("#" + this.fieldElementId + "-close").on("click", jQuery.proxy(this.closeMemoField, this));

    this.onMemoFieldOpenEvent = new YAHOO.util.CustomEvent("onMemoFieldOpen");
    this.onMemoFieldCloseEvent = new YAHOO.util.CustomEvent("onMemoFieldClose");
};

grn.component.space.MemoField.prototype.addMemoFieldOpenEventSubscriber = function(subscriber){
    this.onMemoFieldOpenEvent.subscribe(subscriber);
};

grn.component.space.MemoField.prototype.addMemoFieldCloseEventSubscriber = function(subscriber){
    this.onMemoFieldCloseEvent.subscribe(subscriber);
};

/**
 * メモの領域を開く
 */
grn.component.space.MemoField.prototype.openMemoField = function(){
    if(this.isMemoFieldClosed()){
        this.memoData['status'] = grn.component.space.MemoField.STATUS_SHOW;
        jQuery("#" + this.fieldElementId).show();

        var openStatus = "1";

        var request = new grn.component.ajax.request(
            {
                url: this.resource["statusPost"],
                method: "post",
                grnRedirectOnLoginError: true,
                data: {spid: this.memoData["spaceId"], status: openStatus, csrf_ticket: this.resource["csrfTicket"]}
            }
        );
        request.send();

        this.onMemoFieldOpenEvent.fire(this);
    }
};

/**
 * メモの領域を閉じる
 */
grn.component.space.MemoField.prototype.closeMemoField = function(){
    if(! this.isMemoFieldClosed()){
        this.memoData['status'] = grn.component.space.MemoField.STATUS_HIDE;
        jQuery("#" + this.fieldElementId).hide();

        var openStatus = "0";

        var request = new grn.component.ajax.request(
            {
                url: this.resource["statusPost"],
                method: "post",
                grnRedirectOnLoginError: true,
                data: {spid: this.memoData["spaceId"], status: openStatus, csrf_ticket: this.resource["csrfTicket"]}
            }
        );

        request.send();

        this.onMemoFieldCloseEvent.fire(this);
    }
};

/**
 * メモの領域を開閉する
 */
grn.component.space.MemoField.prototype.toggleMemoField = function(){
    if(this.isMemoFieldClosed()){
        this.openMemoField();
    }else{
        this.closeMemoField();
    }
};

/**
 * メモの領域が閉じているかどうか調べる
 * @returns {Boolean}
 */
grn.component.space.MemoField.prototype.isMemoFieldClosed = function(){
    return this.memoData['status'] == grn.component.space.MemoField.STATUS_HIDE;
};

/**
 * キャンセルボタンが押されたときの処理
 */
grn.component.space.MemoField.prototype.onClickCancel = function(){
    var viewField = jQuery("#" + this.fieldElementId + "-view");
    viewField.show();

    var editField = jQuery("#" + this.fieldElementId + "-edit");
    editField.hide();
};

/**
 * メモの変更するボタンが押されたときの処理
 */
grn.component.space.MemoField.prototype.onClickPost = function(e){
    grn.component.button(e.currentTarget).showSpinner();
    var data, grnEditor, editor = "0";
    var editorRadioElement = jQuery("#editor_on");
    if(editorRadioElement.length && editorRadioElement.is(":checked")){
        editor = "1";
        grnEditor = grn.component.editor.Editor.getInstanceById('spacememo_editor_id');
        grnEditor.save();
    }
    data = jQuery("#spacememo_editor_id").val();

    var request = new grn.component.ajax.request(
        {
            url: this.resource["memoPost"],
            method: "post",
            dataType: "json",
            data: {spid: this.memoData["spaceId"], editor: editor, data: data, csrf_ticket: this.resource["csrfTicket"]}
        }
    );

    request.send().done(
        jQuery.proxy(this.onPostMemoSuccess, this)
    );

    grn.component.button(e.currentTarget).hideSpinner();
};

/**
 * 変更されたメモをポストしたときのコールバック
 * @param response
 * @returns {Boolean}
 */
grn.component.space.MemoField.prototype.onPostMemoSuccess = function(data, textStatus,response){
    this.updateMemoData(data);
    this.onClickCancel();
};

/**
 * 「メモを編集する」リンクをクリックしたときの処理
 */
grn.component.space.MemoField.prototype.onClickEdit = function(){
    var viewField = jQuery("#"+ this.fieldElementId + "-view");
    viewField.hide();

    var editField = jQuery("#" + this.fieldElementId + "-edit");
    editField.show();

    var grnEditor = grn.component.editor.Editor.getInstanceById('spacememo_editor_id');
    grnEditor.resize();
};

/**
 * this.memoData を更新し、画面に反映する
 * @param memoData
 */
grn.component.space.MemoField.prototype.updateMemoData = function(memoData){
    this.memoData = memoData;
    var memoFieldUserLink = jQuery("#" + this.fieldElementId + "-view" + "-user-link");
    if(memoFieldUserLink.length == 0) {
        var memoFieldUserIcon = jQuery("#" + this.fieldElementId + "-view" + "-user-icon");
        var memoFieldUserName = jQuery("#" + this.fieldElementId + "-view" + "-user-name");
        var updateLinkField = '<a id="space-memo-field-view-user-link" class="space-userName-grn" href="#"> '
                                   + jQuery("<p>").append(memoFieldUserIcon.clone()).html()
                                   + jQuery("<p>").append(memoFieldUserName.clone()).html()
                            + '</a>';

        memoFieldUserIcon.remove();
        memoFieldUserName.replaceWith(updateLinkField);
    }
    this.updateEditView();
};

/**
 * this.memoData を使って画面を更新する
 */
grn.component.space.MemoField.prototype.updateEditView = function(){
    jQuery("#" + this.fieldElementId + "-view" + "-content").html(this.memoData["dataDisplay"]);  //This should not be escaped because it has some style data.
    var memoFieldUserLink = jQuery("#" + this.fieldElementId + "-view" + "-user-link");
    var memoFieldUserIcon = jQuery("#" + this.fieldElementId + "-view" + "-user-icon");
    var memoFieldUserName = jQuery("#" + this.fieldElementId + "-view" + "-user-name");
    if( memoFieldUserLink != null )
    {
        memoFieldUserLink.attr("href", this.memoData['userLink']);
    }
    if( memoFieldUserIcon != null )
    {
        memoFieldUserIcon.attr("src", this.memoData['userIcon']);
    }
    if( memoFieldUserName != null )
    {
        memoFieldUserName.html(this.memoData['modifierName'].replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;"));
    }
    jQuery("#" + this.fieldElementId + "-view" + "-mtime").html(this.memoData['mtimeDisplay'].replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;"));
};

grn.component.space.PopupMenu = function(popupMenuItemList){
    this.popupMenuItemList = popupMenuItemList;
    jQuery.each(this.popupMenuItemList, jQuery.proxy(function(i, v){
        v.setPopupMenu(this);}, this)
    );
};

grn.component.space.PopupMenu.CLASS_DIALOG_DIV = "space-manageMenu-item-grn";
grn.component.space.PopupMenu.CLASS_SWITCH_ON  = "icon-showMenu-grn";
grn.component.space.PopupMenu.CLASS_SWITCH_OFF = "icon-hideMenu-grn";

grn.component.space.PopupMenu.prototype.render = function(switchElementId, dialogElementId){
    this.switchElementId = switchElementId;
    this.dialogElementId = dialogElementId;

    var switchElement = jQuery("#" + this.switchElementId);

    var dialogElement = jQuery("<div>").addClass(grn.component.space.PopupMenu.CLASS_DIALOG_DIV).attr("id", this.dialogElementId).css("display", "none");

    var dialogUlElement = jQuery("<ul>");
    dialogElement.append(dialogUlElement);

    jQuery.each(this.popupMenuItemList, function(i, v){
        dialogUlElement.append(v.createDom());
    });

    dialogElement.insertBefore(switchElement);
    
    var self = this;

    jQuery(window).on('resize', function(){
        setTimeout(function(){
            self.setDialogPosition();
        }, 0);
    });

    switchElement.on("click",function(){
        self.onClick();
    });

    jQuery(window.document).on("click", jQuery.proxy(function(e){
        var target = jQuery(e.target);
        // ダイアログ外をクリックしたらダイアログを隠す
        if( (!target.is(switchElement)) && (!jQuery("#" + this.switchElementId).has(e.target).length) && (!target.is(dialogElement)) && (!jQuery("#" + this.dialogElementId).has(e.target).length) && dialogElement.is(":visible") ){
            this.onClick();
        }

    }, this));
};

grn.component.space.PopupMenu.prototype.setDialogPosition = function(){
    var switchElement = jQuery("#" + this.switchElementId);

    var switchOffset = cumulativeOffset(switchElement.get(0));
    var left = switchOffset[0] + switchElement.outerWidth(true) + 10;
    var top = switchOffset[1];

    var dialogElement = jQuery("#" + this.dialogElementId);
    dialogElement.css({
        "left": (left - dialogElement.outerWidth()),
        "top": top + 2,
        "width": dialogElement.outerWidth()
    });
};

grn.component.space.PopupMenu.prototype.toggleArrow = function(){
    var switchElement = jQuery("#" + this.switchElementId);
    if(switchElement.hasClass(grn.component.space.PopupMenu.CLASS_SWITCH_OFF)){
        switchElement.addClass(grn.component.space.PopupMenu.CLASS_SWITCH_ON);
        switchElement.removeClass(grn.component.space.PopupMenu.CLASS_SWITCH_OFF);
    }else{
        switchElement.removeClass(grn.component.space.PopupMenu.CLASS_SWITCH_ON);
        switchElement.addClass(grn.component.space.PopupMenu.CLASS_SWITCH_OFF);
    }
};

grn.component.space.PopupMenu.prototype.onClick = function(){
    this.toggleArrow();
    var dialogElement = jQuery("#" + this.dialogElementId);
    this.setDialogPosition();
    dialogElement.toggle();
    if(dialogElement.is(":visible")){
        this.setDialogPosition();
    }
};

grn.component.space.PopupMenuItem = function(){
    
};
grn.component.space.PopupMenuItem.prototype.setPopupMenu = function(popupMenu){
    this.popupMenu = popupMenu;
};
grn.component.space.PopupMenuItem.prototype.getPopupMenu = function(){
    return this.popupMenu;
};

 grn.component.space.PopupMenuItemLink = function(link, caption, onclick_function){
    this.link = link;
    this.caption = caption;
    this.popupMenu = null;
    this.onclickFun = onclick_function;
};
YAHOO.lang.extend(grn.component.space.PopupMenuItemLink, grn.component.space.PopupMenuItem);

grn.component.space.PopupMenuItemLink.prototype.createDom = function(){
    var li = jQuery("<li>");
    var a = jQuery("<a>").attr("href", this.link).html(this.caption);
    a.innerHTML = this.caption;
    if( this.onclickFun !== undefined )
    {
        a.attr("onClick", this.onclickFun);
    }
    li.append(a);
    return li;
};

grn.component.space.PopupMenuItemSpacer = function(){
    this.popupMenu = null;
};
YAHOO.lang.extend(grn.component.space.PopupMenuItemSpacer, grn.component.space.PopupMenuItem);

grn.component.space.PopupMenuItemSpacer.CLASS = "space-manageMenu-item-separator-grn";

grn.component.space.PopupMenuItemSpacer.prototype.createDom = function(){
    return jQuery("<li>").addClass(grn.component.space.PopupMenuItemSpacer.CLASS);
};

grn.component.space.PopupMenuItemEvent = function(caption){
    this.onClickEventSubscriber = new YAHOO.util.CustomEvent("click");
    this.caption = caption;
    this.captionElement = null;
    this.popupMenu = null;
};
YAHOO.lang.extend(grn.component.space.PopupMenuItemEvent, grn.component.space.PopupMenuItem);

grn.component.space.PopupMenuItemEvent.prototype.addOnClickEventSubscriber = function(onClickEventSubscriber){
    this.onClickEventSubscriber.subscribe(onClickEventSubscriber);
};

grn.component.space.PopupMenuItemEvent.prototype.createDom = function(){
    var li = jQuery("<li>");
    var a = jQuery("<a>").attr("href", "javascript:");
    a.on("click", jQuery.proxy(this.onClickEvent, this));
    a.html(this.caption);
    li.append(a);
    this.captionElement = a;
    return li;
};

grn.component.space.PopupMenuItemEvent.prototype.onClickEvent = function(){
    this.getPopupMenu().onClick();
    this.onClickEventSubscriber.fire(this);
};

grn.component.space.PopupMenuItemEvent.prototype.updateCaption = function(caption){
    this.caption = caption;
    this.captionElement.innerHTML = this.caption;
};