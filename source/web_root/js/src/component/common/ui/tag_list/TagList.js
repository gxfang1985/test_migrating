import Control from "../base/Control";
import TagItem from "./TagItem";
import KeyCode from "../../constant/KeyCode";
import {collapseWhiteSpace} from "../../utility/domUtil";

const $ = jQuery;

const DEFAULT_SETTINGS = {
    css: {
        tagItem: "js_tag_item",
        tagInput: "js_tag_input",
        tagInputTextBox: "js_text_box",
        tagHolder: "js_tag_holder",
    },
    resource: {
        inputPlaceHolderText: "",
        inputPlaceHolderTitle: "",
    },
    attribute: {
        id: "",
        ariaLabelledBy: "",
    },
};

export default class TagList extends Control {
    _getTemplates() {
        return () => {
            const {id, ariaLabelledBy} = this.settings.attribute;
            return collapseWhiteSpace(this.html`
            <div class="mention_textarea_item_base_grn js_mention_list_area" 
                ${id ? `id=${id}` : ""}
                ${ariaLabelledBy ? `aria-labelledby=${ariaLabelledBy}` : ""}
                aria-hidden="true"
                style="display: none;">
                <ul class="holder ui-sortable js_tag_holder">
                    <li class="bit-input js_tag_input">
                        <input name="text" 
                            placeholder="${this.settings.resource.inputPlaceHolderText}"
                            title="${this.settings.resource.inputPlaceHolderTitle}"
                            maxlength="100"
                            style="width:100%"
                            class="maininput prefix-grn js_text_box"
                            size="0"
                            autocomplete="off"
                            type="text"
                            role="form">
                    </li>
                </ul>
            </div>`);
        };
    }

    _getDefaultSettings() {
        return DEFAULT_SETTINGS;
    }

    _onRender() {
        this.$tagInput = this._findByClassName(this.settings.css.tagInput);
        this.$tagInputTextBox = this._findByClassName(this.settings.css.tagInputTextBox);

        // Make tag items sortable
        this.$tagHolder = this._findByClassName(this.settings.css.tagHolder);
        this.$tagHolder.sortable({items: `.${this.settings.css.tagItem}`});

        this.suggestionList = this._createSuggestionList();
        this.suggestionList.render();
    }

    _bindEvents() {
        this.suggestionList.on("selected", this._handleSuggestionListOnSelected.bind(this));
        this.suggestionList.on("show", () => this.trigger("suggestion.show"));
        this._elementOn("click", ".js_tag_item_close_button", this._handleDeleteTagItem.bind(this));
        this.on("change", this._handleTagListOnChange.bind(this));
        this.$tagInputTextBox.on("keydown", this._handleTagInputTextBoxOnKeyDown.bind(this));
    }

    _handleSuggestionListOnSelected(event, data) {
        const tag_item = new TagItem({data: data});
        this.addTagItem(tag_item);
    }

    _handleTagListOnChange() {
        const data_list = this.getData();
        if (Object.keys(data_list).length > 0) {
            this.$tagInputTextBox.attr("placeholder", "");
        } else {
            this.$tagInputTextBox.attr("placeholder", this.settings.resource.inputPlaceHolderTitle);
        }
    }

    _handleTagInputTextBoxOnKeyDown(event) {
        const current_input_value = this.$tagInputTextBox.val();

        if (event.keyCode === KeyCode.BACKSPACE && current_input_value.length === 0) {
            this._deleteLastTagItem();
        }
    }

    _deleteLastTagItem() {
        this._findByClassName(this.settings.css.tagItem).last().remove();
        this.trigger("change");
    }

    _createSuggestionList() {
        throw new Error("TagList._createSuggestionList must be overridden.");
    }

    /**
     * @param {TagItem} tag_item
     */
    addTagItem(tag_item) {
        const $tag_item = tag_item.render();
        $tag_item.insertBefore(this.$tagInput);

        this.trigger("change");
    }

    /**
     * @param event
     * @private
     */
    _handleDeleteTagItem(event) {
        const $tag_item = $(event.target).closest("." + this.settings.css.tagItem);
        $tag_item.remove();

        this.trigger("change");
    }

    /**
     * @returns {Object}
     */
    getData() {
        const data_list = {};
        this._findByClassName(this.settings.css.tagItem).each((index, element) => {
            data_list[index] = $(element).data("data");
        });

        return data_list;
    }

    /**
     * @returns {string}
     */
    getJSONData() {
        return JSON.stringify(this.getData());
    }

    count() {
        return this._findByClassName(this.settings.css.tagItem).length;
    }

    toggle() {
        if (this.$el.is(":visible")) {
            this.hide();
        } else {
            this.show();
        }
    }

    show({focus = true} = {}) {
        this.$el.show();
        this.$el.attr("aria-hidden", "false");

        if (focus) {
            // Automatically set focus to the input field when the tag list area is shown
            this.$tagInputTextBox.focus();
        }
    }

    hide() {
        this.$el.hide();
        this.$el.attr("aria-hidden", "true");
    }

    clear() {
        this._findByClassName(this.settings.css.tagItem).remove();

        this.trigger("change");
    }
}