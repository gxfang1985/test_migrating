import Control from "../base/Control";

export default class MentionButton extends Control {
    constructor(settings = {}) {
        super(settings);

        this.$el.click(this.click.bind(this));
    }

    _getRequiredSettings() {
        return ["element"];
    }

    click() {
        this.setExpand(true);

        this.trigger("click");
    }

    setExpand(value) {
        this.$el.attr("aria-expanded", value ? "true" : "false");
    }
}