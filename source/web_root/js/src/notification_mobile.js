import MobileNotification from "./component/notification/ui/mobile/MobileNotification";
import Index from "./page/notification/mobile/Index";

grn.base.namespace("grn.js.component.notification");

grn.js.component.notification = {
    ui: {
        mobile: {
            MobileNotification
        }
    },
};

grn.base.namespace("grn.js.page.notification");

grn.js.page.notification = {
    mobile: {
        Index
    }
};