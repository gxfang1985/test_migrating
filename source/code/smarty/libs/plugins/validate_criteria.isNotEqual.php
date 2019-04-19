<?php
// @codingStandardsIgnoreStart

/**
 * test if a value is a valid range
 *
 * @param string $value the value being tested
 * @param boolean $empty if field can be empty
 * @param array params validate parameter values
 * @param array formvars form var values
 */
function smarty_validate_criteria_isNotEqual($value, $empty, &$params, &$formvars) {
        if(!isset($params['field2'])) {
                trigger_error("SmartyValidate: [grn_isNotEqual] parameter 'field2' is missing.");            
                return false;
        }
        if(strlen($value) == 0)
            return $empty;
        
        return $value != $formvars[$params['field2']];
}

// @codingStandardsIgnoreEnd
?>
