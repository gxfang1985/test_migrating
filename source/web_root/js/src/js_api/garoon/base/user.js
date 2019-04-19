export const getLoginUser = () => {
    const loginUser = {
        garoonId: grn.data.login.id,
        name: grn.data.login.name,
        timezone: grn.data.login.timezone,
        language: grn.data.login.language
    };
    if (grn.data.login.slash !== "") {
        loginUser.id = grn.data.login.slash;
    }
    if (grn.data.login.hasOwnProperty("code")) {
        loginUser.code = grn.data.login.code;
    }
    if (grn.data.login.hasOwnProperty("email")) {
        loginUser.email = grn.data.login.email;
    }
    if (grn.data.login.hasOwnProperty("url")) {
        loginUser.url = grn.data.login.url;
    }
    if (grn.data.login.hasOwnProperty("phone")) {
        loginUser.phone = grn.data.login.phone;
    }
    return loginUser;
};

export default {
    getLoginUser,
};