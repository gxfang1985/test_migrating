import MobileMemberListShowMore from "./component/common/ui/show_more/mobile/MobileMemberListShowMore";
import MobileMemberListDialog from "./component/common/ui/dialog/mobile/MobileMemberListDialog";
import MobileMention from "./component/common/ui/mention/mobile/MobileMention";
import MobileMentionReply from "./component/common/ui/mention/mobile/MobileMentionReply";

grn.base.namespace("grn.js.component.common");

grn.js.component.common = {
    ui: {
        dialog: {
            MobileMemberListDialog,
        },
        mention: {
            mobile: {
                MobileMention,
                MobileMentionReply,
            },
        },
        show_more: {
            mobile: {
                MobileMemberListShowMore,
            },
        },
    }
};
