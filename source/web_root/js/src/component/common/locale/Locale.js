const i18n = grn.component.i18n;

const Locale = {
    /**
     * Get localized message
     * @param module
     * @param key
     */
    getMessage(module, key) {
        return i18n.cbMsg(module, key);
    },
};

export default Locale;
