import SuggestionList from "./SuggestionList";
import ListItem from "./ListItem";
import MemberType from "../../constant/MemberType";

const $ = jQuery;

export const LIST_ITEM_ICON_CSS = {
    [MemberType.USER]: {
        normal: "profileImageUser-grn",
        loggedIn: "profileImageLoginuser-grn",
        invalid: "profileImageInvaliduser-grn",
    },
    [MemberType.STATIC_ROLE]: "profile_image_role_grn",
    [MemberType.ORGANIZATION]: "profile_image_organization_grn",
};

class MemberListItem extends ListItem {
    _getTemplates() {
        return {
            default: super._getTemplates(),
            iconWrapper: data =>
                `<div class="profileImage-grn v-allign-middle mRight7"> 
                    <div class="profileImageFrame-grn"> 
                        ${this._renderIcon(data)} 
                    </div> 
                </div>`,
            icon: css =>
                `<div class="${css}" />`,
            profileImage: icon_path =>
                `<div class="js_img_profile user_photo_grn" style="background-image: url(${icon_path});"></div>`,
        };
    }

    _onRender(data) {
        const $icon = $(this._getTemplates().iconWrapper(data));
        this._findByClassName("js_item_anchor").prepend($icon);
    }

    _renderIcon(data) {
        let css,
            icon_path = "";
        const type = data.type;

        switch (data.type) {
            case MemberType.USER: {
                const css_user = LIST_ITEM_ICON_CSS[type];
                const {isLoginUser, isInvalidUser} = data;
                css = css_user.normal;

                if (isInvalidUser) {
                    css = css_user.invalid;
                    break;
                } else if (isLoginUser) {
                    css = css_user.loggedIn;
                }

                icon_path = data.image.small;

                break;
            }
            case MemberType.ORGANIZATION:
            case MemberType.STATIC_ROLE: {
                css = LIST_ITEM_ICON_CSS[type];
                break;
            }
        }

        let html;
        if (icon_path) {
            html = this._getTemplates().profileImage(icon_path);
        } else {
            html = this._getTemplates().icon(css);
        }

        return html;
    }
}

export default class MemberSuggestionList extends SuggestionList {
    _getDefaultSettings() {
        return $.extend(super._getDefaultSettings(), {
            listItemClass: MemberListItem,
        });
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

    _getAvailableMemberTypes() {
        return Object.values(MemberType);
    }
}