export const triggerJsApiApproveSubmitSuccess = (data) => {
    if (!_isAvailableForJsApiTrigger()) {
        return undefined;
    }
    const request_data = garoon.workflow.request.get();

    if (data !== null
        && typeof data.response !== "undefined"
        && typeof data.response.petition_status !== "undefined") {
        request_data.status = data.response.petition_status;
    }

    const event_data = {
        "type": "workflow.request.approve.submit.success",
        "viewer": "APPROVER",
        "stepCode": request_data.processingStepCode,
        "request": request_data
    };

    return garoon.events.trigger("workflow.request.approve.submit.success", event_data);
};

const _isAvailableForJsApiTrigger = () => {
    return typeof garoon !== "undefined"
        && typeof garoon.workflow !== "undefined"
        && typeof garoon.workflow.request !== "undefined";
};
