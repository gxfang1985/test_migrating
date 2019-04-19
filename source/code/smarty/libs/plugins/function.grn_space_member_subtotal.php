<?php
require_once('grn/controller.csp');

use grn\space\common\data\collection\SpaceMemberCollection;

/**
 * @param $params        array \grn\space\common\data\collection\SpaceMemberCollection SpaceMemberCollection
 *                       need_member_label                                       boolean
 * @param $smarty
 *
 * @return string
 */
function smarty_function_grn_space_member_subtotal($params, &$smarty)
{
    $need_member_label = cb_at($params, "need_member_label", false);
    $memberCollection = cb_at($params, "memberCollection",
        new \grn\space\common\data\collection\SpaceMemberCollection());

    $result = "";

    if ($need_member_label) {
        $result .= cb_msg("grn.space", "grn.space.member_subtotal.label");
        $result .= '<span class="mRight5 mLeft5">';
        $result .= cb_msg("grn.space",
            "grn.space.member_subtotal.label.separator");
        $result .= '</span>';
    }

    $members_array
        = _smarty_function_grn_space_member_subtotal_get_members_array($memberCollection);
    $format = '<span class="mRight7">%s</span>';
    $delimiter = '<span class="mLeft3">' . cb_msg("grn.space",
            "grn.space.member_subtotal.delimiter") . '</span>';
    $index = 1;
    foreach ($members_array as $value) {
        $is_last = count($members_array) === $index;
        if ($is_last) {
            $delimiter = "";
        }

        if ($value) {
            $result .= sprintf($format, $value . $delimiter);
        }
        $index++;
    }

    return $result;

}

/**
 * @param $memberCollection \grn\space\common\data\collection\SpaceMemberCollection
 *
 * @return array
 */
function _smarty_function_grn_space_member_subtotal_get_members_array(
    $memberCollection
) {
    $result = [];
    // Now english only.
    $plural_suffix = cb_msg("grn.space",
        "grn.space.member_subtotal.plural.suffix");

    $groups_count = $memberCollection->countGroups();
    if ($groups_count > 0) {
        $suffix = $groups_count === 1 ? "" : $plural_suffix;
        $result["groups"] = cb_msg("grn.space",
                "grn.space.member_subtotal.group", ["count" => $groups_count])
                            . $suffix;
    }

    $roles_count = $memberCollection->countRoles();
    if ($roles_count > 0) {
        $suffix = $roles_count === 1 ? "" : $plural_suffix;
        $result["roles"] = cb_msg("grn.space", "grn.space.member_subtotal.role",
                ["count" => $roles_count]) . $suffix;
    }

    $users_count = $memberCollection->countUsers();
    if ($users_count > 0) {
        $suffix = $users_count === 1 ? "" : $plural_suffix;
        $result["users"] = cb_msg("grn.space", "grn.space.member_subtotal.user",
                ["count" => $users_count]) . $suffix;
    }

    return $result;
}
