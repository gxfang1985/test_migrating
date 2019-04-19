/**
 * Removing unnecessary whitespace between tags
 * @param {String} html
 */
export function collapseWhiteSpace(html = "") {
    if (html === null) {
        return html;
    }

    return html.replace(/>\s+</g, "><");
}
