import Control from "../base/Control";
import {collapseWhiteSpace} from "../../utility/domUtil";

const $ = jQuery;

export default class PaginationButton extends Control {
    _getTemplates() {
        return {
            default: () => collapseWhiteSpace(this.html`
                <span class="action_disable_grn ${this.settings.css.buttonDisabled}">
                    <span class="${this.settings.css.icon}"
                        role="button"
                        title="${this.settings.title}"
                        aria-disabled="true"
                        aria-label="${this.settings.title}">
                    </span>
                </span>`),
            enable: () => collapseWhiteSpace(this.html`
                <span class="${this.settings.css.buttonEnabled}"
                    data-page="${this.settings.page}"
                    data-offset="${this.settings.pageOffset}">
                    <a href="javascript:void(0);"
                        class="action_grn"
                        role="button"
                        title="${this.settings.title}"
                        aria-label="${this.settings.title}">
                        <span class="${this.settings.css.icon}"></span>
                    </a>
                </span>`),
        };
    }

    isEnabled() {
        return this.$el.hasClass(this.settings.css.buttonEnabled);
    }

    enable() {
        const $button = $(this._getTemplates().enable());
        this.$el.replaceWith($button);
        this.$el = $button;
    }

    disable() {
        const $button = $(this._getTemplates().default());
        this.$el.replaceWith($button);
        this.$el = $button;
    }
}