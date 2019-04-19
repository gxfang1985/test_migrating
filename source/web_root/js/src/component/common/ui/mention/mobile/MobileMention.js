import Control from "../../base/Control";
import MentionButton from "./../MentionButton";
import MobileMentionList from "./MobileMentionList";

const instances = {};

const DEFAULT_SETTINGS = {
    css: {
        mentionButton: "js_mention_button",
        mentionList: "js_mention_list",
    },
    memberListDialogName: "member_list_dialog_mention_input",
};

export default class MobileMention extends Control {
    constructor(settings = {}) {
        super(settings);

        instances[this.settings.name] = this;
    }

    static getInstance(name) {
        return instances[name];
    }

    _onRender() {
        this.mentionButton = new MentionButton({element: this._findByClassName(this.settings.css.mentionButton)});
        this.mentionButton.render();
        this.mentionList = new MobileMentionList({
            name: this.settings.name + "_list",
            attribute: {
                id: this.settings.name + "_list",
                ariaLabelledBy: this.settings.name + "_button",
            },
            accessPluginEncoded: this.settings.accessPluginEncoded,
        });
        this.mentionList.render();
        this._findByClassName(this.settings.css.mentionList).replaceWith(this.mentionList.getElement());

        this.memberListDialog = grn.js.component.common.ui.dialog.MobileMemberListDialog.getInstance(this.settings.memberListDialogName);
        if (this.memberListDialog === undefined) {
            this._initMemberListDialog();
        }
        this.memberListDialog.bindDialogToMembersContainer(`#${this.settings.name}_list`);
    }

    _initMemberListDialog() {
        this.memberListDialog = new grn.js.component.common.ui.dialog.MobileMemberListDialog({
            name: this.settings.memberListDialogName,
            element: `#${this.settings.memberListDialogName}`,
            accessPluginEncoded: this.settings.accessPluginEncoded
        });
        this.memberListDialog.render();
    }

    _bindEvents() {
        this.mentionButton.on("click", this._mentionButtonOnClick.bind(this));
    }

    _getRequiredSettings() {
        return ["name", "element", "accessPluginEncoded"];
    }

    _getDefaultSettings() {
        return DEFAULT_SETTINGS;
    }

    _mentionButtonOnClick() {
        this.mentionList.suggestionList.clearSearch();
        this.mentionList.show();
    }

    hide() {
        this.mentionList.hide();
    }

    clear() {
        this.mentionList.clear();
    }

    reset() {
        this.mentionList.clear();
        this.mentionList.hide();
    }

    /**
     * @returns {string}
     */
    getMentionData() {
        return this.mentionList.getJSONData();
    }
}