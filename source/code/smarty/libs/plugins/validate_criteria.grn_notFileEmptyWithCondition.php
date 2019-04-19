<?php

function smarty_validate_criteria_grn_notFileEmptyWithCondition(
    $value,
    $empty,
    &$params,
    &$formvars
) {
    if (UPLOAD_ERR_NO_FILE == $_FILES[$value]['error']) {
        if (1 == @ $formvars['file_exist'][$value]) {
            if (1 == @ $formvars['file_delete'][$value]) {
                return false;
            }
        } else {
            return false;
        }
    }

    return true;
}

