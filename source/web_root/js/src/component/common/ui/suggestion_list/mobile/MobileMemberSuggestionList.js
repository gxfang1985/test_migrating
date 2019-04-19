import MobileSuggestionList from "./MobileSuggestionList";
import MobileListItem from "./MobileListItem";
import MemberType from "../../../constant/MemberType";

const $ = jQuery;

export const LIST_MOBILE_ITEM_ICON_CSS = {
    [MemberType.USER]: {
        "active": "mobile_img_userPlofile_grn",
        "inactive": "mobile_img_userInvalidPlofile_grn",
        "login_user": "mobile_img_userLoginPlofile_grn",
    },
    [MemberType.STATIC_ROLE]: "mobile_img_role_profile_grn",
    [MemberType.ORGANIZATION]: "mobile_img_groupPlofile_grn",
};

class MobileMemberListItem extends MobileListItem {
    _getTemplates() {
        return {
            default: super._getTemplates(),
            suggest_member_item: (displayName, primaryGroupName, class_icon) => this.html`
                <div class="js_item_anchor mobile_user_photo_grn ${class_icon}"></div>
                <div class="mobile_info_grn">
                    <div class="mobile_position_center_grn">
                        <div class="mobile_position_width_grn">
                            <div class="mobile_user_grn">${displayName}</div>
                            <div class="mobile_text_grn">${primaryGroupName}</div>
                        </div>
                    </div>
                </div>`,
        };
    }

    _onRender(data) {
        const suggest_item = this._getTemplates().suggest_member_item(data.displayName, data.primaryGroupName, this._getClassIcon(data));
        this._findByClassName("js_item_anchor").empty();
        this._findByClassName("js_item_anchor").append(suggest_item);
    }

    _getClassIcon(data) {
        let class_icon = "";
        const object_type = data.type;

        switch (object_type) {
            case MemberType.USER: {
                const css_user = LIST_MOBILE_ITEM_ICON_CSS[object_type];
                const {isLoginUser, isInvalidUser} = data;
                class_icon = css_user.active;

                if (isInvalidUser) {
                    class_icon = css_user.inactive;
                } else if (isLoginUser) {
                    class_icon = css_user.login_user;
                }

                break;
            }
            case MemberType.ORGANIZATION:
            case MemberType.STATIC_ROLE: {
                class_icon = LIST_MOBILE_ITEM_ICON_CSS[object_type];
                break;
            }
        }

        return class_icon;
    }
}

export default class MobileMemberSuggestionList extends MobileSuggestionList {
    _getDefaultSettings() {
        return $.extend(super._getDefaultSettings(), {
            listItemClass: MobileMemberListItem,
        });
    }

    _getRequiredSettings() {
        return ["name", "element", "accessPluginEncoded", "searchResultArea"];
    }

    _transformDataForRenderingItems(members) {
        const results = [];
        $.each(members, (index, member) => {
            const member_for_view = $.extend(true, {}, member);
            member_for_view.name = member.displayName;
            if (member.primaryGroupName) {
                member_for_view.name += "; " + member.primaryGroupName;
            }
            results.push(member_for_view);
        });

        return results;
    }
}