export const EVENT_TYPE = {
    REGULAR: "REGULAR",
    ALL_DAY: "ALL_DAY",
    REPEATING: "REPEATING"
};
export const VISIBILITY_TYPE_PRIVATE_WATCHERS = "SET_PRIVATE_WATCHERS";
export const VISIBILITY_TYPE = ["PUBLIC", "PRIVATE", "SET_PRIVATE_WATCHERS"];
export const DEFAULT_EVENT_MENU = "-----";
export const COMPANY_FIELDS = ["name", "zipCode", "address", "route", "routeTime", "routeFare", "phone"];
export const REPEAT_TYPE = {
    EVERY_DAY: "EVERY_DAY",
    EVERY_WEEKDAY: "EVERY_WEEKDAY",
    EVERY_WEEK: "EVERY_WEEK",
    EVERY_1STWEEK: "EVERY_1STWEEK",
    EVERY_2NDWEEK: "EVERY_2NDWEEK",
    EVERY_3RDWEEK: "EVERY_3RDWEEK",
    EVERY_4THWEEK: "EVERY_4THWEEK",
    EVERY_LASTWEEK: "EVERY_LASTWEEK",
    EVERY_MONTH: "EVERY_MONTH"
};
export const REPEAT_TYPE_VALUE = {
    EVERY_WEEK: "week",
    EVERY_1STWEEK: "1stweek",
    EVERY_2NDWEEK: "2ndweek",
    EVERY_3RDWEEK: "3rdweek",
    EVERY_4THWEEK: "4thweek",
    EVERY_LASTWEEK: "lastweek",
    EVERY_MONTH: "month"
};
export const REPEAT_WEEK_TYPES = ["EVERY_WEEK", "EVERY_1STWEEK", "EVERY_2NDWEEK", "EVERY_3RDWEEK", "EVERY_4THWEEK", "EVERY_LASTWEEK"];
export const REPEAT_DAY_OF_WEEK = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];
export const REPEAT_END_OF_MONTH = "EOM";
export const REPEAT_DAY_1 = 1;
export const REPEAT_DAY_31 = 31;
export const API_MEMBER_TYPE = {
    USER: "USER",
    ORGANIZATION: "ORGANIZATION",
    ROLE: "ROLE"
};
export const MEMBER_TYPE = {
    USER: "user",
    ORGANIZATION: "group",
    ROLE: "static_role"
};
export const MEMBER_TYPE_PREFIX = {
    USER: "",
    GROUP: "g",
    STATIC_ROLE: "r"
};
export const DEFAULT_FACILITY_RESERVATION_DROP_DOWN = "------------";
export const FACILITY_RESERVATION_TYPE = {
    SINGLE_LINE_TEXT: "SINGLE_LINE_TEXT",
    MULTI_LINE_TEXT: "MULTI_LINE_TEXT",
    DROP_DOWN: "DROP_DOWN"
};
export const DEFAULT_TIME_FLAG_START_ONLY = false;
export const DEFAULT_TIME_FLAG_IS_ALL_DAY = false;
export const REPEAT_RANGE = {
    THIS_EVENT_ONLY: "THIS_EVENT_ONLY",
    ON_AND_AFTER_THIS_EVENT: "ON_AND_AFTER_THIS_EVENT",
    ALL_EVENT: "ALL_EVENT"
};