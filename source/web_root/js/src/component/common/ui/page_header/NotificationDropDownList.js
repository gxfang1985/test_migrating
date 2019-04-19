import HttpRequest from "../../ajax/HttpRequest";
import NotificationListBase from "../../../notification/ui/NotificationListBase";
import {collapseWhiteSpace} from "../../utility/domUtil";
import Locale from "../../locale/Locale";

const $ = jQuery;

export default class NotificationHeader extends NotificationListBase {

    _getDefaultSettings() {
        const setting = {
            css: {
                loadMore: "js_more",
                message: "js_message",
            },
            params: {
                hasNotification: false,
                hasMore: false,
                maxItem: 0,
            }
        };
        return $.extend(true, {}, super._getDefaultSettings(), setting);
    }

    _getTemplates() {
        return {
            default: () => super._getTemplates().default(),
            balloonMessageArea: (balloonMessageContent) => collapseWhiteSpace(`
                <div class="list_message_balloon_grn">
                    ${balloonMessageContent}
                </div>
                <div class="balloon_arrow_down_grn"></div>
                <div class="list_message_icon_grn">
                    <span class="message_middle_icon_size_grn notify_message_middle_icon_grn"></span>
                </div>`),
            balloonMessageContent: (hasAllMessage, message) => {
                const span_item = `<span class="bold_grn">${hasAllMessage ? message[1] : message}</span>`;
                const item_class = this.settings.css.hasUnreadAll;
                return hasAllMessage ? `${message[0]}<a class=${item_class} href="javascript:">${span_item}</a>${message[2]}` : span_item;
            }
        };
    }

    _onRender() {
        super._onRender();
        this._toggleNotificationIndexLink(this.settings.params);
        this._toggleShowMessage(this.settings.params);
        grn.html.com_header.updateNotificationNumber(this.settings.params.totalUnreadAll);
    }

    /**
     * Fetch notification data
     * @protected
     */
    _fetchNotification() {
        const post_data = {
            is_json: 1,
            is_to_me: this.isToMe() === true ? 1 : "",
            read: this.isRead() === true ? 1 : "",
        };

        const request = new HttpRequest({
            grnUrl: "notification/ajax/page_header",
            method: "post",
            dataType: "json",
            data: post_data,
        });
        return request.send();
    }

    /**
     * Update notification list
     * @param {{content: string, totalUnreadToMe: int, totalUnreadAll: int}} json_data
     * @protected
     */
    _updateNotificationList(json_data) {
        this.$contentArea.html(json_data.content);
        this.$contentArea.hide().fadeIn();
        this._toggleNotificationIndexLink(json_data);
        this._toggleShowMessage(json_data);
        this.updateCategoryButtons(json_data);
        grn.html.com_header.updateNotificationNumber(json_data.totalUnreadAll);
        grn.html.com_header.setDropDownHeight();
    }

    _toggleNotificationIndexLink({maxItem, hasMore}) {
        const notification_url = grn.component.url.page("notification/index", {
            is_to_me: this.isToMe() === true ? 1 : "",
            read: this.isRead() === true ? 1 : "",
            sp: maxItem,
        });
        const $load_more_element = this._findByClassName(this.settings.css.loadMore);
        if (hasMore) {
            $load_more_element.find("a").attr("href", notification_url);
            $load_more_element.show();
        } else {
            $load_more_element.hide();
        }
    }

    _toggleShowMessage({totalUnreadAll, totalUnreadToMe, hasNotification}) {
        let message_content = null;
        const is_unread_to_me = this.isToMe() && !this.isRead();
        if (is_unread_to_me && !totalUnreadToMe && totalUnreadAll) {
            const message = [Locale.getMessage("grn.notification", "GRN_NTFC-206"),
                Locale.getMessage("grn.notification", "GRN_NTFC-207"),
                Locale.getMessage("grn.notification", "GRN_NTFC-208")];
            message_content = this._getTemplates().balloonMessageContent(true, message);
        } else if (!hasNotification) {
            const message = Locale.getMessage("grn.notification", "GRN_NTFC-205");
            message_content = this._getTemplates().balloonMessageContent(false, message);
        }

        const messageElement = this._findByClassName(this.settings.css.message);
        const html = message_content ? this._getTemplates().balloonMessageArea(message_content) : "";
        messageElement.html(html);
    }
}