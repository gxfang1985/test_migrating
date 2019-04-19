import MemberListShowMore from "../MemberListShowMore";

const instances = {};
const DEFAULT_SETTINGS = {
    attribute: {
        spinnerClass: "mobile_user_grn mobile_mention_comment_li_grn"
    },
    params: {
        is_mobile: true
    }
};

export default class MobileMemberListShowMore extends MemberListShowMore {

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

    _getDefaultSettings() {
        const settings = $.extend(true, {}, super._getDefaultSettings(), DEFAULT_SETTINGS);
        return settings;
    }
}