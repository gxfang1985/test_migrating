import * as modifiers from "./modifers";

function getModifier(text) {
    // The modifier of a substitution looks like "|htmlEscape", "|noescape"
    const regex = new RegExp("^\\|(\\w+)\\s*?([\\s\\S]*)");
    const match = regex.exec(text);
    if (!match) {
        return;
    }

    return {
        name: match[1],
        text: match[2],
    };
}

/**
 * The function for template literals which automatically escapes HTML entities
 *
 * EXAMPLE:
 * - Auto escaping:
 *      let content = html`Name: <a href="${user.url}">${user.displayName}</a>`
 * - Ignore escaping:
 *      let content = html`Note:<p>${note}|noescape</p>`
 *
 * @param sections
 * @param substitutions
 * @returns {string}
 */
export default function html(sections, ...substitutions) {
    let result = sections[0];

    for (let i = 0; i < substitutions.length; i++) {
        let substitution = substitutions[i];
        let next_section = sections[i + 1];

        const modifier = getModifier(next_section);

        if (modifier) {
            const modifier_func = modifiers[modifier.name];
            if (typeof modifier_func !== "function") {
                throw new Error(`Invalid modifier: ${modifier.name}`);
            }

            next_section = modifier.text;
            substitution = modifier_func(substitution);
        } else {
            substitution = modifiers.htmlEscape(substitution);
        }

        result += substitution + next_section;
    }

    return result;
}
