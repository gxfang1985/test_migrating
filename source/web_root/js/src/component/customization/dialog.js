/* global GRN_MsgBox */
/* global GRN_MsgBoxButtons */
export const errors_queue = [];

const showError = () => {
    const queue_length = errors_queue.length;
    if (queue_length === 0) {
        return;
    }
    const error = errors_queue[0];
    const error_content = grn.component.ajax.error_default_view.render(error);
    GRN_MsgBox.show(error_content, "", GRN_MsgBoxButtons.ok, {
        ui: [],
        caption: {ok: grn.component.i18n.cbMsg("grn.common", "ok")},
        callback: () => {
            GRN_MsgBox._remove();
            errors_queue.shift();
            showError();
        }
    });
};

/**
 *
 * @param error
 */
export const throwError = (error) => {
    errors_queue.push(error);
    if (errors_queue.length === 1) {
        showError();
    }
};