{if !$no_header}
{include file='grn/head.tpl'}
{include file="grn/header.tpl"}
{else}
    <div id="hidden_siteposition" style="display: none;">
        {grn_site_position positions=$site_position}
    </div>
{/if}

{if !$ajax_load}
{grn_load_javascript file="grn/html/component/space.js"}
{grn_load_javascript file="grn/html/component/member_list_dialog.js"}
{grn_load_javascript file="grn/html/page/space/application/join_leave.js"}
{include file='grn/window_simple_dialog.tpl'}
{literal}
<script language="JavaScript" text="text/javascript">
grn.msg = {};
grn.msg.OK = '{/literal}{cb_msg module='grn.common' key='ok' replace='true'}{literal}';
grn.msg.CANCEL = '{/literal}{cb_msg module='grn.common' key='cancel' replace='true'}{literal}';
grn.msg.YES = '{/literal}{cb_msg module='grn.common' key='yes' replace='true'}{literal}';
grn.msg.NO = '{/literal}{cb_msg module='grn.common' key='no' replace='true'}{literal}';
grn.csrfTicket = '{/literal}{$csrf_ticket}{literal}';
</script>
{/literal}
    {include file="space/error_handler.tpl"}
{/if}

{grn_space_show_expiration_date_warning space=$this_getSpace}

<div class="space-header-grn">
    <div class="space-header-inner-grn">
        <div id="balloonField" class="space-spaceBalloon-grn" {if !$this->isBalloonShow()}style="display:none;"{/if}>
            <div class="space-spaceBalloon-inner-grn">
                <div id="space-member-field" {if !$this->isMemberFieldOpen()}style="display:none;"{/if}>
                    <div id="space-member-field-view" class="space-spaceMemo-inner-grn">
                        {* アイコン前後にCSS指定以外のスペースが入るのを防ぐため、意図的にタグの前後に半角スペース、改行コードが入らないようにしている *}
                        <span class="space-spaceMemberIcon-grn">{
                            if $has_privilege
                            }<a class="icon-edit-sub-grn" href="{grn_pageurl page='space/member_modify' spid=$this->getSpaceId() from='top'}" title="{cb_msg module='grn.space' key='application-common-17' replace='true'}"></a>{
                            /if
                            }<span id="space-member-field-close" class="icon-close-sub-grn" title="{cb_msg module='grn.space' key='application-common-15' replace='true'}"></span></span>
                        <div class="space-spaceMemberInfo-grn">
                            <span class="space-itemLabel-grn">
                                {cb_msg module="grn.space" key="application-common-16" replace='true'}
                                {strip}
                                    {$count_space_members|escape}
                                    {if $count_space_members > 1}
                                        {cb_msg module='grn.space' key='view-space-27' replace='true'}
                                    {else}
                                        {cb_msg module='grn.space' key='view-space-22' replace='true'}
                                    {/if}
                                {/strip}
                            </span>
                            {include file='space/application/header_member.tpl'}
                            {if $this_getSpaceUserCollection->getCountNoLimit() > $maxNumMember}
                                <span id="display_member_close">
                                    {cb_msg module='grn.space' key='view-space-1' replace='true'}
                                    <span class="nowrap-grn">
                                        <small>
                                            {cb_msg module='grn.space' key='view-space-2' replace='true'}
                                            <a id="display_member_close_a" href="javascript:void(0);">{cb_msg module='grn.space' key='view-space-3' replace='true'}</a>
                                            {cb_msg module='grn.space' key='view-space-4' replace='true'}
                                        </small>
                                    </span>
                                </span>
                                <span id="remaining_member"></span>
                                <span id="display_member_open" style="display:none">
                                    <span class="nowrap-grn">
                                        <small>
                                            {cb_msg module='grn.space' key='view-space-5' replace='true'}
                                            <a id="display_member_open_a" href="javascript:void(0);">{cb_msg module='grn.space' key='view-space-6' replace='true'}</a>
                                            {cb_msg module='grn.space' key='view-space-7' replace='true'}
                                        </small>
                                    </span>
                                </span>
                            {/if}
                        </div>
                    </div>
                </div>

                <div id="balloonBorder" class="border-partition-common-grn" {if !$this->isBalloonBorderShow()}style="display:none;{/if}"></div>

                <div id="space-memo-field" {if !$this_getSpaceMemo->isMemoOpen()}style="display:none;"{/if}>
                    <div id="space-memo-field-view" class="space-spaceMemo-inner-grn">
                        {* アイコン前後にCSS指定以外のスペースが入るのを防ぐため、意図的にタグの前後に半角スペース、改行コードが入らないようにしている *}
                        <span class="space-spaceMemoIcon-grn">{
                            if $has_privilege
                            }<a id="space-memo-field-view-edit" class="icon-edit-sub-grn" href="javascript:;" title="{cb_msg module='grn.space' key='application-common-3' replace='true'}"></a>{
                            /if
                            }<span id="space-memo-field-close" class="icon-close-sub-grn" title="{cb_msg module='grn.space' key='application-common-15' replace='true'}"></span></span>
                        <div class="space-spaceMemoMain-grn">
                            <span id="space-memo-field-view-content">{$this_getSpaceMemo->getDisplayMemo()}</span>
                        </div>
                        <div class="space-spaceMemoInfo-grn">
                            <span class="space-itemLabel-grn">{cb_msg module='grn.space' key='application-common-2' replace='true'}</span>
                            {if $this_isModifierDeleted }
                                {capture name='user_icon_path'}{grn_user_icon_path userId=$this_getSpaceMemo->getModifierId() modifier=$this_getModifier}{/capture}
                                {grn_image direct=true image=$smarty.capture.user_icon_path id="space-memo-field-view-user-icon" height=20 width=20}
                                <span id="space-memo-field-view-user-name">{$this_getSpaceMemo->getModifierDisplayName()|escape}</span>
                                <span id="space-memo-field-view-mtime" class="space-datetime-grn">{$this_getSpaceMemo->getModifyDisplayDatetime()|escape}</span>
                            {else}
                                <a id="space-memo-field-view-user-link" class="space-userName-grn" href="{grn_popup_user_link uid=$this_getSpaceMemo->getModifierId()}">
                                    {capture name='user_icon_path'}{grn_user_icon_path userId=$this_getSpaceMemo->getModifierId() modifier=$this_getModifier}{/capture}
                                    {grn_image direct=true image=$smarty.capture.user_icon_path id="space-memo-field-view-user-icon" height=20 width=20}
                                    <span id="space-memo-field-view-user-name">{$this_getSpaceMemo->getModifierDisplayName()|escape}</span>
                                </a>
                                <span id="space-memo-field-view-mtime" class="space-datetime-grn">{$this_getSpaceMemo->getModifyDisplayDatetime()|escape}</span>
                            {/if}
                        </div>
                    </div>
                    <div id="space-memo-field-edit" class="space-spaceMemo-inner-grn" style="display:none;">
                    {if $this_getSpaceMemo->isRichText()}
                        {include file="grn/richeditor.tpl" html=$this_getSpaceMemo->getDisplayMemo() enable=1 name="spacememo" class="form_textarea_grn"}
                    {else}
                        {include file="grn/richeditor.tpl" text=$this_getSpaceMemo->getMemo() enable=1 name="spacememo" class="form_textarea_grn"}
                    {/if}
                        <div class="mTop10">
                            {strip}
                                {capture name="grn_space_application_common_4"}{cb_msg module="grn.space" key="application-common-4" replace="true"}{/capture}
                                {grn_button id='space-memo-field-edit-submit' ui='main' caption=$smarty.capture.grn_space_application_common_4 spacing='normal'}
                                {capture name="grn_space_application_common_5"}{cb_msg module="grn.space" key="application-common-5" replace="true"}{/capture}
                                {grn_button id='space-memo-field-edit-cancel' ui='normal' caption=$smarty.capture.grn_space_application_common_5}
                            {/strip}
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="balloonEdge" class="space-balloon-source-under-base-grn" {if !$this->isBalloonShow()}style="display:none;"{/if}>
            <span class="space-balloon-source-under-grn"></span>
            <div class="clear_both_0px">&nbsp;</div>
        </div>
    </div>

</div>

<div class="space-manageMenu-grn">
    <span id="openMember" class="space-show-icon-base-off-grn" title="{cb_msg module='grn.space' key='application-common-18' replace='true'}"><span class="space-show-member-grn"></span></span>
    <span id="openMemo" class="space-show-icon-base-off-grn" title="{cb_msg module='grn.space' key='application-common-19' replace='true'}"><span class="space-show-memo-grn"></span></span>
    <span id="space-operation" class="icon-showMenu-grn" title="{cb_msg module='grn.space' key='application-common-14' replace='true'}"><div class="space-optionmenu-icon-grn">{grn_image image="image-common/menu_a16.png" height=16 width=16}</div></span>
</div>

<div class="tab_memu">
{foreach from=$this->getTabList() item=tab}
    <div class="tab">
        <span class="tab_left_{if $tab->isSelected()}on{else}off{/if}"></span>
        <span class="tab_{if $tab->isSelected()}on{else}off{/if}">
        {if $tab->isSelected()}<span>{else}<a href="{$tab->getLink()}">{/if}{$tab->getName()|escape}{if $tab->isSelected()}</span>{else}</a>{/if}
        </span>
        <span class="tab_right_{if $tab->isSelected()}on{else}off{/if}"></span>
    </div>
{/foreach}
{if $this->isMember() && $this->isKintoneAvailable()}
    <div class="tab">
        <span class="tab_left_off"></span>
        <span class="tab_off">
        <a class="icon-pale-add-grn" href="{grn_pageurl page='space/appmanage_add' spid=$this->getSpaceId()}" title="{cb_msg module='grn.space' key='application-common-6' replace='true'}"></a>
        </span>
    <span class="tab_right_off"></span>
    </div>
{/if}
</div>

<div class="tab_menu_end">&nbsp;</div>

{$component->fetch()}

<script>{literal}
    grn.base.namespace("grn.page.component.space");

grn.page.component.space.Director = function(){
    var c = grn.component.space;

    this.popupMenuItems = new Array();
    {/literal}{if $has_privilege }{literal}
    this.popupMenuItems.push(new c.PopupMenuItemLink("{/literal}{grn_pageurl page='space/folder_setting' spid=$this->getSpaceId()}{literal}", "{/literal}{cb_msg module='grn.space.folder' key='GRN_SP_FOLDER-11' replace='true'}{literal}"));
    {/literal}{/if}{literal}

    {/literal}{if $this->isMember() || $has_privilege}{literal}
    this.popupMenuItems.push(new c.PopupMenuItemLink("{/literal}{grn_pageurl page='space/thread_move' spid=$this->getSpaceId()}{literal}", "{/literal}{cb_msg module='grn.space' key='application-common-21' replace='true'}{literal}"));
    {/literal}{/if}{literal}

    {/literal}{if $schedule_active && $schedule_available_for_external}{literal}
        /* オプションメニューの中のスケジュール関連 */
        this.popupMenuItems.push(
            new c.PopupMenuItemLink("{/literal}{grn_pageurl page='space/schedule_redirect' spid=$this->getSpaceId()}{literal}", "{/literal}{cb_msg module='grn.space' key='application-common-7' replace='true'}{literal}")
        );
        this.popupMenuItems.push(
            new c.PopupMenuItemLink("{/literal}{grn_pageurl page='space/schedule_add_redirect' spid=$this->getSpaceId()}{literal}", "{/literal}{cb_msg module='grn.space' key='application-common-8' replace='true'}{literal}")
        );
    {/literal}{/if}

    {literal}

    /* オプションメニューの中の仕切り線 */
    if(this.popupMenuItems.length != 0)
        this.popupMenuItems.push(new c.PopupMenuItemSpacer());

    {/literal}{if $this->isSpaceAllowJoinLeave()}
        {if !$this->isMember(TRUE) }{literal}
            this.popupMenuItems.push(new c.PopupMenuItemLink( "javascript:void(0);", "{/literal}{cb_msg module='grn.space' key='application-common-22' replace='true'}{literal}", "grn.page.space.join_leave.checkShowDialog({/literal}{$this->getSpaceId()}{literal}, 'join')"));
        {/literal}{elseif !$this->isUniqueSpaceMember() && !$this->isUniqueSpaceOperatorWithCurrentUser()}{literal}
            this.popupMenuItems.push(new c.PopupMenuItemLink( "javascript:void(0);", "{/literal}{cb_msg module='grn.space' key='application-common-23' replace='true'}{literal}", "grn.page.space.join_leave.checkShowDialog({/literal}{$this->getSpaceId()}{literal}, 'leave')"));
        {/literal}{/if}
    {elseif $this->isMember(TRUE) && $has_privilege && !$this->isUniqueSpaceMember() && !$this->isUniqueSpaceOperatorWithCurrentUser()}{literal}
        this.popupMenuItems.push(new c.PopupMenuItemLink( "javascript:void(0);", "{/literal}{cb_msg module='grn.space' key='application-common-23' replace='true'}{literal}", "grn.page.space.join_leave.checkShowDialog({/literal}{$this->getSpaceId()}{literal}, 'leave')"));
    {/literal}{/if}

    {literal}

    /* オプションメニューの中のスペースの詳細 */
    this.popupMenuItems.push(new c.PopupMenuItemLink("{/literal}{grn_pageurl page='space/config_view' spid=$this->getSpaceId()}{literal}", "{/literal}{cb_msg module='grn.space' key='application-common-9' replace='true'}{literal}"));

    /* スペースの再利用 */
    this.popupMenuItems.push(new c.PopupMenuItemLink("{/literal}{grn_pageurl page='space/reuse' spid=$this->getSpaceId()}{literal}", "{/literal}{cb_msg module='grn.space' key='application-common-20' replace='true'}{literal}"));

    /* オプションメニューの中のアプリ管理 */
    {/literal}{if $this->isMember() && $this->isKintoneAvailable()}{literal}
        this.popupMenuItems.push(new c.PopupMenuItemLink("{/literal}{grn_pageurl page='space/appmanage_view' spid=$this->getSpaceId()}{literal}", "{/literal}{cb_msg module='grn.space' key='application-common-10' replace='true'}{literal}"));
    {/literal}{/if}{literal}



    /* オプションメニューの外側 */
    this.popupMenu = new c.PopupMenu(this.popupMenuItems);
    this.popupMenu.render("space-operation", "dialog");

    /* バルーンと、その中のボーダー */
    this.balloon = new c.BalloonField({
        "balloonStatus" : {/literal}{if $this->isBalloonShow()}c.BalloonField.SHOW{else}c.BalloonField.HIDE{/if}{literal},
        "borderStatus"  : {/literal}{if $this->isBalloonBorderShow()}c.BalloonField.SHOW{else}c.BalloonField.HIDE{/if}{literal}
    });
    this.balloon.render("balloonField", "balloonBorder", "balloonEdge" );

    /* メモの領域 */
    this.memoField = new c.MemoField({
        "spaceId"      : "{/literal}{$this_getSpace->getId()|escape:'javascript'}{literal}",
        "status"       : {/literal}{if $this_getSpaceMemo->isMemoOpen()}c.MemoField.STATUS_SHOW{else}c.MemoField.STATUS_HIDE{/if}{literal},
        "data"         : "{/literal}{$this_getSpaceMemo->getMemo()|escape:'javascript'}{literal}",
        "dataDisplay"  : "{/literal}{$this_getSpaceMemo->getDisplayMemo()|escape:'javascript'}{literal}",
        "modifierName" : "{/literal}{$this_getSpaceMemo->getModifierDisplayName()|escape:'javascript'}{literal}",
        "mtimeDisplay" : "{/literal}{$this_getSpaceMemo->getModifyDisplayDatetime()|escape:'javascript'}{literal}",
        "userIcon"     : "{/literal}{grn_user_icon_path userId=$this_getSpaceMemo->getModifierId() modifier=$this_getModifier}{literal}",
        "userLink"     : "{/literal}{grn_popup_user_link uid=$this_getSpaceMemo->getModifierId()}{literal}"
        },{
        "edit":"{/literal}{cb_msg module='grn.space' key='application-common-13' replace='true'}{literal}",
        "csrfTicket":"{/literal}{$csrf_ticket}{literal}",
        "memoPost":"{/literal}{grn_pageurl page='space/command_memo_modify'}{literal}",
        "statusPost":"{/literal}{grn_pageurl page='space/command_memo_status'}{literal}"
    });
    this.memoField.render("space-memo-field");

    /* スペースメンバーの領域 */
    this.memberField = new c.MemberField({
        "spaceId"  : "{/literal}{$this_getSpace->getId()|escape:'javascript'}{literal}",
        "status"   :{/literal}{if $this->isMemberFieldOpen()}c.MemberField.STATUS_SHOW{else}c.MemberField.STATUS_HIDE{/if}{literal}
        },{
        "csrfTicket":"{/literal}{$csrf_ticket}{literal}",
        "statusPost":"{/literal}{grn_pageurl page='space/command_member_status'}{literal}",
        "remainingMemberUrl":"{/literal}{grn_pageurl page='space/application/ajax/get_remaining_member'}{literal}",
        "spinner":"{/literal}{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}{literal}"
    });
    this.memberField.render("space-member-field");
    jQuery("#display_member_close_a").on("click", function(){this.memberField.showRemainingMember()}.bind(this));
    jQuery("#display_member_open_a").on("click", function(){this.memberField.hideRemainingMember()}.bind(this));

    /* スペースのメモのボタン */
    this.memoFieldButton = new c.ImageToggleButton({
        "status":{/literal}{if $this_getSpaceMemo->isMemoOpen()}c.ImageToggleButton.STATUS_ON{else}c.ImageToggleButton.STATUS_OFF{/if}{literal}
    });
    this.memoFieldButton.render("openMemo");

    /* スペースメンバーのボタン */
    this.memberFieldButton = new grn.component.space.ImageToggleButton({
        "status":{/literal}{if $this->isMemberFieldOpen()}c.ImageToggleButton.STATUS_ON{else}c.ImageToggleButton.STATUS_OFF{/if}{literal}
    });
    this.memberFieldButton.render("openMember");

    /* メモが閉じられたら.. */
    this.memoField.addMemoFieldCloseEventSubscriber(function(type, args){

        /* ボタンの状態を更新 */
        this.memoFieldButton.toggleOff();

        /* バルーンの状態を更新 */
        if(! this.isBorderNeed()){
            this.balloon.hideBorder();
        }
        if(! this.isBalloonNeed()){
            this.balloon.hideBalloon();
        }
    }.bind(this));

    this.memoField.addMemoFieldOpenEventSubscriber(function(type, args){

        /* ボタンの状態を更新 */
        this.memoFieldButton.toggleOn();

        /* バルーンの状態を更新 */
        this.balloon.showBalloon();
        if(this.isBorderNeed()){
            this.balloon.showBorder();
        }
    }.bind(this));

    this.memberField.addMemberFieldCloseEventSubscriber(function(){
        /* ボタンの状態を更新 */
        this.memberFieldButton.toggleOff();

        /* バルーンの状態を更新 */
        if(! this.isBorderNeed()){
            this.balloon.hideBorder();
        }
        if(! this.isBalloonNeed()){
            this.balloon.hideBalloon();
        }
    }.bind(this));

    this.memberField.addMemberFieldOpenEventSubscriber(function(type, args){
        /* ボタンの状態を更新 */
        this.memberFieldButton.toggleOn();

        /* バルーンの状態を更新 */
        this.balloon.showBalloon();
        if(this.isBorderNeed()){
            this.balloon.showBorder();
        }
    }.bind(this));

    this.memoFieldButton.addToggleButtonOnSubscriber(function(){
        this.memoField.openMemoField();
    }.bind(this));
    this.memoFieldButton.addToggleButtonOffSubscriber(function(){
        this.memoField.closeMemoField();
    }.bind(this));

    this.memberFieldButton.addToggleButtonOnSubscriber(function(){
        this.memberField.openMemberField();
    }.bind(this));
    this.memberFieldButton.addToggleButtonOffSubscriber(function(){
        this.memberField.closeMemberField();
    }.bind(this));

    new grn.component.member_list_dialog.MemberListDialog({
        url: grn.component.url.page("grn/ajax/member_list_dialog"),
        app_id: "space",
    });
};

grn.page.component.space.Director.prototype.isBorderNeed = function(){
    return ! this.memoField.isMemoFieldClosed() && ! this.memberField.isMemberFieldClosed();
};

grn.page.component.space.Director.prototype.isBalloonNeed = function(){
    return ! this.memoField.isMemoFieldClosed() || ! this.memberField.isMemberFieldClosed();
};

(function(){ new grn.page.component.space.Director();})();

</script>{/literal}

{if !$no_footer}
{include file="grn/footer.tpl"}
{else}
    <div id="hidden_backlink" style="display: none;">
        {grn_backlink positions=$site_position}
    </div>
{/if}
