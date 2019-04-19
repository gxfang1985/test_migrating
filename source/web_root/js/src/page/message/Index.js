import Page from "../../component/common/ui/base/Page";
import Locale from "../../component/common/locale/Locale";
import ButtonDropdown from "../../component/common/ui/dropdown/ButtonDropdown";

const $ = jQuery;

const DEFAULT_SETTINGS = {
    id: {
        additionalOptionsTop: "additional_options_top",
        additionalOptionsBottom: "additional_options_bottom",
    },
    selectors: {
        additionalOptionsTop: "#js_additional_options_top",
        additionalOptionsBottom: "#js_additional_options_bottom",
    },
};

export default class Index extends Page {
    _getDefaultSettings() {
        return $.extend(true, {}, super._getDefaultSettings(), DEFAULT_SETTINGS);
    }

    _onRender() {
        this._renderAdditionalOptionsDropdown();
    }

    _renderAdditionalOptionsDropdown() {
        const settings = {
            text: Locale.getMessage("grn.message", "GRN_MSG-426"),
            items: [
                {
                    text: Locale.getMessage("grn.message", "GRN_MSG-427"),
                    value: "unread",
                },
            ],
        };
        const settings_top = $.extend(true, {}, settings, {name: this.settings.id.additionalOptionsTop});
        const settings_bottom = $.extend(true, {}, settings, {name: this.settings.id.additionalOptionsBottom});
        this.additionalOptionsTop = new ButtonDropdown(settings_top);
        this.additionalOptionsBottom = new ButtonDropdown(settings_bottom);
        const {selectors} = this.settings;
        this.additionalOptionsTop.render().replaceAll(selectors.additionalOptionsTop);
        this.additionalOptionsBottom.render().replaceAll(selectors.additionalOptionsBottom);
    }

    _bindEvents() {
        this.additionalOptionsTop.on("select", this._additionalOptionsOnSelect.bind(this));
        this.additionalOptionsBottom.on("select", this._additionalOptionsOnSelect.bind(this));
    }

    _additionalOptionsOnSelect(event, data) {
        const form = this._find("form[name='message/index']");
        const command_field = form.find("input[name=cmd]");
        if (data === "unread") {
            command_field.val(data);
            form.submit();
        }
    }
}