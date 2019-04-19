import Page from "./Page";

/**
 * Base controller for a page
 */
export default class MobilePage extends Page {

    _getDefaultSettings() {
        return {
            element: ".mobile-content-grn",
        };
    }
}
