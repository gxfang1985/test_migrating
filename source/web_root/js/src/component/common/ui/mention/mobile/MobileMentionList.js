import Locale from "../../../locale/Locale";
import {collapseWhiteSpace} from "../../../utility/domUtil";
import MobileMemberSuggestionList from "../../suggestion_list/mobile/MobileMemberSuggestionList";
import MentionList, {MentionTagItem} from "../MentionList";
import MemberType from "../../../constant/MemberType";

export class MobileMentionTagItem extends MentionTagItem {
    _getTemplates() {
        const delete_button_title = Locale.getMessage("grn", "grn.ui.tag_item.delete_button_title");
        return (data) => collapseWhiteSpace(this.html`
            <div class="mobile_line_grn js_tag_item">
                <a href="javascript:void(0)" class="js_label_a">${data.name}</a>
                <a href="javascript:void(0);" class="mobile_delete_icon_normal_grn js_tag_item_close_button"
                    role="button" 
                    title="${delete_button_title}" 
                    aria-label="${delete_button_title}"></a>
            </div>`);
    }

    _onRender(data) {
        super._onRender(data);

        if (data.type === MemberType.USER) {
            const $link = this._findByClassName("js_label_a");
            $link.attr("href", data.url);
            $link.attr("target", "_blank");
        }
    }
}

class MobileMentionMemberSuggestionList extends MobileMemberSuggestionList {
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

export default class MobileMentionList extends MentionList {
    _getTemplates() {
        const delete_button_title = Locale.getMessage("grn", "grn.ui.tag_item.delete_button_title");
        return () => {
            const {id, ariaLabelledBy} = this.settings.attribute;
            return collapseWhiteSpace(this.html`
            <div class="mobile_mention_textarea_item_base_grn" 
                ${id ? `id=${id}` : ""}
                ${ariaLabelledBy ? `aria-labelledby=${ariaLabelledBy}` : ""}
                aria-hidden="true"
                style="display: none;">
                <div class="mobile_seletedUser_list_grn">
                    <div class="mobile_userlines_grn js_tag_input">
                        <div class="mobile_user_search_grn mobile_user_search_focus_grn">
                            <div class="ui-input-search ui-body-inherit ui-corner-all ui-shadow-inset ui-input-has-clear">
                                <input type="text" 
                                    data-type="search" 
                                    name="search_text" 
                                    maxlength="100"
                                    class="tbsearch ui-autocomplete-input ui-autocomplete-loading js_text_box" 
                                    placeholder="${this.settings.resource.inputPlaceHolderText}" 
                                    autocomplete="off"  
                                    role="form">
                                <a href="javascript:void(0);" 
                                    tabindex="-1" 
                                    aria-hidden="true" 
                                    class="ui-input-clear ui-btn ui-icon-delete ui-btn-icon-notext ui-corner-all ui-input-clear-hidden" 
                                    title="${delete_button_title}">${delete_button_title}</a>
                            </div>
                        </div>
                        <div class="mobile_pulldown_user_incremental_search_grn mobile_mention_search_result"
                            style="z-index: 200;">
                            <div class="mobile_userselect_space_grn"></div>
                        </div>
                    </div>
                </div>
            </div>`);
        };
    }

    _createSuggestionList() {
        const member_suggestion_list_settings = {
            name: this.settings.name,
            element: this.$tagInputTextBox,
            searchResultArea: this._findByClassName("mobile_mention_search_result"),
            source: "grn/ajax/incremental_search_members",
            accessPluginEncoded: this.settings.accessPluginEncoded,
        };

        return new MobileMentionMemberSuggestionList(member_suggestion_list_settings);
    }

    show({addMentionSymbol = true} = {}) {
        if (!this.isOpen) {
            this.$el.show();
            this.$el.attr("aria-hidden", "false");
            this.isOpen = true;
        }

        if (addMentionSymbol) {
            this.addMentionSymbol();
        }
    }

    _handleSuggestionListOnSelected(event, data) {
        const tag_item = new MobileMentionTagItem({data: data});
        this.addTagItem(tag_item);

        // Automatically set focus to the input field after selecting the suggestion list.
        this.$tagInputTextBox.focus();
    }
}