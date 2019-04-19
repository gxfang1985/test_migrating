(function () {
    'use strict';
    grn.base.namespace("grn.component.string");

    var G = grn.component.string;

    /**
     *
     * @param string
     * @returns {*}
     */
    G.getByteCount = function (string) {
        var encodeString = encodeURIComponent(string).match(/%[89ABab]/g);
        return string.length + (encodeString ? encodeString.length : 0);
    };
})();
