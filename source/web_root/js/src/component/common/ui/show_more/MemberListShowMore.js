import Control from "../base/Control";
import HttpRequest from "../../ajax/HttpRequest";

const $ = jQuery;
const instances = {};

export default class MemberListShowMore extends Control {

    /**
     * Constructor
     *
     * @param {Object} settings
     * @param {string|HTMLElement} settings.element The CSS selector or the DOM element
     *      which is the root element of the MemberListShowMore.
     * @param {string} settings.url URL to get remaining members
     * @param {Object} settings.params Additional params will be added to the request to get remaining members
     */
    constructor(settings = {}) {
        super(settings);
        instances[this.settings.name] = this;
    }

    static getInstance(name) {
        return instances[name];
    }

    _getTemplates() {
        return {
            spinner: () => {
                const img_src = grn.component.url.image("cybozu/spinner.gif");
                return `<li class="${this.settings.attribute.spinnerClass}"><img src="${img_src}" style="width: 16px; height: 16px"/></li>`;
            },
        };
    }

    _getDefaultSettings() {
        return {
            url: "",
            params: {},
            css: {
                expand: "js_expand",
                collapse: "js_collapse",
                remaining_item: "js_remaining_member",
                link_button: "js_link_button",
            },
            attribute: {
                spinnerClass: "user_grn"
            },
        };
    }

    _cacheElements() {
        this.$collapseButton = this._findByClassName(this.settings.css.collapse);
        this.$expandButton = this._findByClassName(this.settings.css.expand);
        this.$spinner = $(this._getTemplates().spinner());
    }

    _bindEvents() {
        this.$collapseButton.on("click", "." + this.settings.css.link_button, this.collapse.bind(this));
        this.$expandButton.on("click", "." + this.settings.css.link_button, this.expand.bind(this));
    }

    collapse() {
        this.$expandButton.show();
        this.$collapseButton.hide();
        this.clearRemainingMember();
    }

    expand() {
        this.$expandButton.hide();
        this.showSpinner();
        const request = new HttpRequest({
            grnUrl: this.settings.url,
            grnRedirectOnLoginError: true,
            method: "post",
            dataType: "json",
            data: this.settings.params,
        });

        request.on("beforeShowError", () => {
            this.$expandButton.show();
            this.clearRemainingMember();
        });

        request.send().done((data) => {
            const $elements = $(data.html);
            $elements.addClass(this.settings.css.remaining_item);
            this.$expandButton.before($elements);
            this.$collapseButton.show();
            this.hideSpinner();
        });
    }

    clearRemainingMember() {
        this._findByClassName(this.settings.css.remaining_item).remove();
    }

    showSpinner() {
        this.$expandButton.before(this.$spinner);
    }

    hideSpinner() {
        this.$spinner.remove();
    }
}