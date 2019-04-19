export const getRequestToken = () => {
    let request_token = null;
    if (grn.data && grn.data.hasOwnProperty("CSRF_TICKET")) {
        request_token = grn.data.CSRF_TICKET;
    }

    return request_token;
};

export default {
    getRequestToken,
};