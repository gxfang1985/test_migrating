<?php

function smarty_function_grn_group_name($params, &$smarty)
{
    define('MY_GROUP', 1);
    define('PRIORITY_GROUP', 2);
    define('MEMBERSHIP', 3);
    define('FREQUENT_GROUP', 4);
    define('RECENTLY_SELECTED', 5);
    define('OFTEN_USED', 6);

    $group = cb_at($params, "group");
    $name = cb_at($group, "name");
    $type = cb_at($group, "type");
    if ($group === null || $type === null) {
        return '';
    }

    switch ($group["type"]) {
        case MY_GROUP:
            $name = htmlspecialchars($name, ENT_QUOTES);

            return $name . cb_msg('grn.grn', 'GRN_GRN-813') . cb_msg('grn.grn',
                    'GRN_GRN-814');
        case PRIORITY_GROUP:
            $name = htmlspecialchars($name, ENT_QUOTES);

            return $name . cb_msg('grn.grn', 'GRN_GRN-815');
        case MEMBERSHIP:
            $name = htmlspecialchars($name, ENT_QUOTES);

            return $name . cb_msg('grn.grn', 'GRN_GRN-816');
        case FREQUENT_GROUP:
            return cb_msg("grn.common", "title_frequent_group",
                ["name" => $name]);
        case RECENTLY_SELECTED:
            return cb_msg('grn.grn', 'GRN_GRN-817') . cb_msg("grn.common",
                    "title_frequent_users")
                   . cb_msg('grn.grn', 'GRN_GRN-818');
        case OFTEN_USED:
            return cb_msg("grn.common", "title_oftenused_group",
                ["name" => $name]);
        default:
            return '';
    }
}
