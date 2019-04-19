<?php

function smarty_validate_criteria_grn_noCheck(
    $value,
    $empty,
    & $params,
    & $formvars
) {
    $value = cb_unserialize($value, ["allowed_classes" => false]);
    if (0 == count($value)) {
        return false;
    }

    return true;
}

