import ItemBase from "./ItemBase";
export default class AutoCalculate extends ItemBase {
    /**
     *
     * @returns {*}
     */
    getValue() {
        const $container = this.getElement();
        if ($container !== null) {
            return $container.data("calc");
        }
        return undefined;
    }
}
