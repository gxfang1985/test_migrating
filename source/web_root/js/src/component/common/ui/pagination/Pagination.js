import Control from "../base/Control";
import Locale from "../../locale/Locale";
import PaginationButton from "./PaginationButton";
import PaginationItemRange from "./PaginationItemRange";

export default class Pagination extends Control {
    _getTemplates() {
        return {
            default: () => this.html`
                <div class="navi"><div class="list_paging_grn inline_block_grn js_inner"></div></div>`,
        };
    }

    _getDefaultSettings() {
        return {
            css: {
                inner: "js_inner"
            }
        };
    }

    _onRender() {
        this._renderButtons();
        this._renderItemRange();
    }

    _renderButtons() {
        this.firstButton = new PaginationButton({
            page: "first",
            title: Locale.getMessage("grn.grn", "GRN_GRN-1555"),
            css: {
                buttonEnabled: "top_page_on",
                buttonDisabled: "top_page_off",
                icon: "arrow_first_button_grn",
            },
        });

        this.previousButton = new PaginationButton({
            page: "previous",
            css: {
                buttonEnabled: "prev_page_on",
                buttonDisabled: "prev_page_off",
                icon: "arrow_left_button_grn",
            },
        });

        this.nextButton = new PaginationButton({
            page: "next",
            css: {
                buttonEnabled: "next_page_on",
                buttonDisabled: "next_page_off",
                icon: "arrow_right_button_grn",
            },
        });

        this._findByClassName(this.settings.css.inner)
            .append(this.firstButton.render())
            .append(this.previousButton.render())
            .append(this.nextButton.render());
    }

    _renderItemRange(data = {startNumber: 0, endNumber: 0}) {
        if (this.itemRange) {
            this.itemRange.getElement().remove();
        }

        this.itemRange = new PaginationItemRange();
        this._findByClassName(this.settings.css.inner)
            .append(this.itemRange.render(data));
    }

    _bindEvents() {
        this._elementOn("click", "[data-page]", this._handleButtonsOnClick.bind(this));
    }

    _handleButtonsOnClick(event) {
        const {page, offset} = event.currentTarget.dataset;
        this.trigger("pageChange", {page, offset});
    }

    setState(state) {
        const limit = state.limit || "";

        this.previousButton.settings.pageOffset = state.previousPageOffset;
        this.previousButton.settings.title = Locale.getMessage("grn.grn", "GRN_GRN-1556") +
            limit + Locale.getMessage("grn.grn", "GRN_GRN-1557");

        this.nextButton.settings.pageOffset = state.nextPageOffset;
        this.nextButton.settings.title = Locale.getMessage("grn.grn", "GRN_GRN-1558") +
            limit + Locale.getMessage("grn.grn", "GRN_GRN-1559");

        // Enable/Disable buttons
        if (state.previousPageOffset >= 0) {
            this.firstButton.enable();
            this.previousButton.enable();
        } else {
            this.firstButton.disable();
            this.previousButton.disable();
        }

        if (state.nextPageOffset > 0) {
            this.nextButton.enable();
        } else {
            this.nextButton.disable();
        }

        // Item range: XX-YY
        this._renderItemRange({
            startNumber: state.rangeNumberStart || 0,
            endNumber: state.rangeNumberEnd || 0
        });
    }
}
