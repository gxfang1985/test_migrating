import Control from "../base/Control";
import Pagination from "./Pagination";

const $ = jQuery;

export default class NotificationPagination extends Control {

    _getDefaultSettings() {
        const setting = {
            element: ".mainarea",
            css: {
                paginationTop: "js_pagination_top",
                paginationBottom: "js_pagination_bottom",
            }
        };
        return $.extend(true, {}, super._getDefaultSettings(), setting);
    }

    _cacheElements() {
        this.$paginationTop = new Pagination();
        this._findByClassName(this.settings.css.paginationTop).append(this.$paginationTop.render());

        this.$paginationBottom = new Pagination();
        this._findByClassName(this.settings.css.paginationBottom).append(this.$paginationBottom.render());

        this.setState(this.settings.pagination);
    }

    _bindEvents() {
        super._bindEvents();
        this.$paginationTop.on("pageChange", (event, data) => this.trigger("pageChange", data));
        this.$paginationBottom.on("pageChange", (event, data) => this.trigger("pageChange", data));
    }

    /**
     * Update pagination state
     * @param {Object} pagination
     */
    setState(pagination) {
        this.$paginationTop.setState(pagination);
        this.$paginationBottom.setState(pagination);
    }
}