<?php

function smarty_validate_criteria_grn_notFileEmpty(
    $value,
    $empty,
    &$params,
    &$formvars
) {
    if (UPLOAD_ERR_NO_FILE == $_FILES[$value]['error']) {
        return false;
    }

    return true;
}

