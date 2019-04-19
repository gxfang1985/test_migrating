grn.base.namespace("grn.component.i18n");
(function () {
    'use strict';
    var G = grn.component.i18n;

    G.GRN_RESOURCES = {};
    /**
     * @param {string} moduleKey
     * @param {string} resourceKey
     */
    G.cbMsg = function (moduleKey, resourceKey) {
        if (this.GRN_RESOURCES[moduleKey] && this.GRN_RESOURCES[moduleKey].hasOwnProperty(resourceKey)) {
            return this.GRN_RESOURCES[moduleKey][resourceKey];
        }

        moduleKey = moduleKey ? moduleKey.replace(/\./g, "/") : "";
        resourceKey = resourceKey ? resourceKey : "";
        return "XX" + moduleKey + "." + resourceKey + "XX";
    };
})();
