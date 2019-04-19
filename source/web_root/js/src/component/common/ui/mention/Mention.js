import Control from "../base/Control";
import MentionButton from "./MentionButton";
import MentionList from "./MentionList";

const instances = {};

const DEFAULT_SETTINGS = {
    textEditor: null, // The instance of grn.component.editor.Editor
    css: {
        mentionButton: "js_mention_button",
        mentionList: "js_mention_list",
    },
};

export default class Mention extends Control {
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
        this.mentionList = new MentionList({
            name: this.settings.name + "_list",
            attribute: {
                id: this.settings.name + "_list",
                ariaLabelledBy: this.settings.name + "_button",
            },
            accessPluginEncoded: this.settings.accessPluginEncoded,
        });
        this.mentionList.render();
        this._findByClassName(this.settings.css.mentionList).replaceWith(this.mentionList.getElement());

        this._initMemberListDialog();
    }

    _initMemberListDialog() {
        let dialog = grn.component.member_list_dialog.get_instance("member_list_dialog_mention_input");
        if (dialog === undefined) {
            dialog = new grn.component.member_list_dialog.MemberListDialog({
                url: grn.component.url.page("grn/ajax/member_list_dialog"),
                dialog_name: "member_list_dialog_mention_input",
                app_id: this.settings.app_id,
                auto_bind: false,
                access_plugin_encoded: this.settings.accessPluginEncoded,
            });
        }
        dialog.bindDialogToMembersContainer(this.mentionList.getElement(), ".dialog_link");
    }

    _bindEvents() {
        this.mentionButton.on("click", this._mentionButtonOnClick.bind(this));
        if (this.settings.textEditor) {
            this.settings.textEditor.on("switch", this._handleEditorOnSwitch.bind(this));
        }
    }

    /**
     * Clear search result of the suggestion list when clicking the rich editor.
     * @param event
     * @param type
     * @private
     */
    _handleEditorOnSwitch(event, {type}) {
        if (type !== "RICH_TEXT") {
            return;
        }

        const rich_editor = this.settings.textEditor.getRichTextEditor();
        rich_editor.on("click", () => this.mentionList.suggestionList.clearSearch());
    }

    _getRequiredSettings() {
        return ["name", "element", "accessPluginEncoded"];
    }

    _getDefaultSettings() {
        return DEFAULT_SETTINGS;
    }

    _mentionButtonOnClick() {
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
        this.mentionButton.setExpand(false);
    }

    /**
     * @returns {string}
     */
    getMentionData() {
        return this.mentionList.getJSONData();
    }
}