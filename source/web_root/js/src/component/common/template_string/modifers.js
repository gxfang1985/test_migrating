export function htmlEscape(str = "") {
    if (str === null) {
        return "";
    }

    return str.toString()
        .replace(/&/g, "&amp;") // first!
        .replace(/>/g, "&gt;")
        .replace(/</g, "&lt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#39;")
        .replace(/`/g, "&#96;");
}

export function noescape(value) {
    return value;
}