module.exports = {
    "root": true,
    "env": {
        "browser": true,
        "jquery": true,
        "prototypejs": true
    },
    "globals": {
        "grn": false,
        "YAHOO": false
    },
    "rules": {
        "no-bitwise": "off",
        "camelcase": "off",
        "curly": "warn",                // TODO: Fix it
        "eqeqeq": "off",                // There're too many errors. We cannot fix them.
        "guard-for-in": "warn",         // TODO: Fix it
        "no-native-reassign": "warn",   // TODO: Fix it
        "no-use-before-define": "off",
        "new-cap": "off",               // We cannot fix it because the name of the old JS component can be in lower case.
        "no-caller": "error",
        "no-empty": "warn",             // TODO: Fix it
        "no-new": "off",
        "no-plusplus": "off",
        "quotes": [
            "off"
        ],
        "no-undef": "off",  // There're too many errors. We cannot fix them.
        "no-unused-vars": [ // The JS variables might be declared in a template file. It has risk to fix them.
            "off",
            {
                "args": "none"
            }
        ],
        "max-params": [
            "error",
            10
        ],
        "max-depth": [
            "error",
            6
        ],
        "complexity": [
            "error",
            46
        ],
        "max-len": [
            "warn",           // TODO: Fix it
            150
        ],
        "no-eq-null": "off",
        "dot-notation": "off"
    }
};
