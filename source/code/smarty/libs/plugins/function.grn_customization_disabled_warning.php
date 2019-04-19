<?php

use grn\grn\customization\common\CustomizationSetting;

/***
 * @param $parameters
 * @param $smarty
 *
 * @return string
 */
function smarty_function_grn_customization_disabled_warning(
    $parameters,
    & $smarty
) {
    $is_force_disabled = CustomizationSetting::isForceDisabled();
    $warning_message = cb_msg('grn.common',
        'js_customization_disabled_warning_message');
    $html_string = '';
    if ($is_force_disabled) {
        $html_string = "<div class='attention_area_grn mTop10 js_warning_area'>"
                       .
                       "<div class='icon_attention_grn'>" .
                       "<span>$warning_message</span>" .
                       "</div>" .
                       "</div>";
    }

    return $html_string;
}
