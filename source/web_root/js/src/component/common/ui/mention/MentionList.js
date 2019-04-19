import TagList from "../tag_list/TagList";
import TagItem from "../tag_list/TagItem";
import MemberSuggestionList from "../suggestion_list/MemberSuggestionList";
import MemberType from "../../constant/MemberType";
import Locale from "../../locale/Locale";

const $ = jQuery;

const DEFAULT_SETTINGS = {
    suggestionListClass: MemberSuggestionList,
    resource: {
        inputPlaceHolderText: Locale.getMessage("grn", "grn.mention.input"),
        inputPlaceHolderTitle: Locale.getMessage("grn", "grn.mention.input"),
    },
};

const ADD_MENTION_SYMBOL_DELAY_TIME = 50;
const MENTION_SYMBOL = "@";

export class MentionTagItem extends TagItem {
    _onRender(data) {
        super._onRender(data);

        const $link = this._findByClassName("js_label_a");

        switch (data.type) {
            case MemberType.USER: {
                if (data.url.match(/^\//)) {
                    const url = `javascript:popupWin('${data.url}','user_view',500,480,0,0,0,1,0,1)`;
                    $link.attr("href", url);
                } else {
                    $link.attr("href", data.url);
                    // .com
                    if (!data.url.match(/^javascript/)) {
                        $link.attr("target", "_blank");
                    }
                }
                break;
            }
            case MemberType.STATIC_ROLE:
            case MemberType.ORGANIZATION: {
                const id_mapping = {
                    [MemberType.ORGANIZATION]: "group",
                    [MemberType.STATIC_ROLE]: "role",
                };

                $link.attr("id", `mention_member_dialog_link_${id_mapping[data.type]}_${data.id}`);
                $link.addClass("dialog_link");
                break;
            }
        }
    }
}

class MentionMemberSuggestionList extends MemberSuggestionList {
    /**
     * @param {string} text
     * @returns {string}
     * @protected
     */
    _filterSearchText(inputText = "") {
        const text = inputText.trim();
        const ignoreCharacters = ["@", "＠"];
        return (ignoreCharacters.indexOf(text.substr(0, 1)) >= 0) ? text.substr(1) : text;
    }

    _handleSearch(params) {
        if (this._filterSearchText(params.term) === "") {
            this.list.hide();
            this.lastSearchText = "";
            return;
        }

        super._handleSearch(params);
    }
}

export default class MentionList extends TagList {
    constructor(settings = {}) {
        super(settings);
        this.isOpen = false;
    }

    _getDefaultSettings() {
        const settings = $.extend(true, {}, super._getDefaultSettings(), DEFAULT_SETTINGS);

        return settings;
    }

    _createSuggestionList() {
        const member_suggestion_list_settings = {
            name: this.settings.name,
            element: this.$tagInputTextBox,
            source: "grn/ajax/incremental_search_members",
            accessPluginEncoded: this.settings.accessPluginEncoded,
        };

        return new MentionMemberSuggestionList(member_suggestion_list_settings);
    }

    _handleSuggestionListOnSelected(event, data) {
        const tag_item = new MentionTagItem({data: data});
        this.addTagItem(tag_item);

        // Automatically set focus to the input field after selecting the suggestion list.
        this.$tagInputTextBox.focus();
    }

    /**
     * @returns {Object}
     */
    getData() {
        const data_list = {};
        $.each(super.getData(), (index, item) => {
            const {id: value, type} = item;
            data_list[index] = {value, type};
        });

        return data_list;
    }

    /**
     * @param {TagItem} tag_item
     */
    addTagItem(tag_item) {
        if (this.isExistedItem(tag_item)) {
            return;
        }

        const $tag_item = tag_item.render();
        $tag_item.insertBefore(this.$tagInput);

        this.trigger("change");
    }

    /**
     * @param {TagItem} tag_item
     * @returns {boolean}
     */
    isExistedItem(tag_item) {
        const {id, type} = tag_item.settings.data;
        const data_list = this.getData();

        for (const i in data_list) {
            if (data_list.hasOwnProperty(i) &&
                data_list[i].value.toString() === id.toString() &&
                data_list[i].type === type) {
                return true;
            }
        }
        return false;
    }

    addMentionSymbol() {
        this.$tagInputTextBox.focus().val(MENTION_SYMBOL);
    }

    show({addMentionSymbol = true} = {}) {
        // Using setTimeout to prevent the added mention symbol (@) is cleared by the _handleDocumentOnMouseUp
        // which is implemented in SuggestionList.js
        setTimeout(() => {
            if (!this.isOpen) {
                super.show({focus: false});
                this.isOpen = true;
            }

            if (addMentionSymbol) {
                this.addMentionSymbol();
            }
        }, ADD_MENTION_SYMBOL_DELAY_TIME);
    }

    hide() {
        super.hide();
        this.isOpen = false;
    }
}