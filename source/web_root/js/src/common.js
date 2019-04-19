import KeyCode from "./component/common/constant/KeyCode";
import Mention from "./component/common/ui/mention/Mention";
import MemberListShowMore from "./component/common/ui/show_more/MemberListShowMore";
import MentionReply from "./component/common/ui/mention/MentionReply";
import NotificationDropDownList from "./component/common/ui/page_header/NotificationDropDownList";
import ReplyDialog from "./component/common/ui/comment/ReplyDialog";
import customization from "./component/customization";
import * as validator from "./component/common/validator/validator";

grn.base.namespace("grn.js.component.common");

grn.js.component.common = {
    constant: {
        KeyCode,
    },
    ui: {
        mention: {
            Mention,
            MentionReply,
        },
        show_more: {
            MemberListShowMore,
        },
        page_header: {
            NotificationDropDownList,
        },
        comment: {
            ReplyDialog
        },
    },
    validator: validator
};

grn.base.namespace("grn.js.component.customization");

grn.js.component.customization = customization;