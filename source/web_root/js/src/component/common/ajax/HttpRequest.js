const Request = grn.component.ajax.request;
export default class HttpRequest extends Request {
    constructor(settings = {}) {
        const new_settings = jQuery.extend(true, {}, settings);
        if (location.pathname.match(/\/mobile\//)) {
            new_settings.grnErrorHandler = grn.component.mobile_error_handler;
        }
        super(new_settings);
    }
}
