<?php

/*
 * The warning message about the expiration date will be displayed on all screens of the space which is less than 30 days remaining.
 *
 * @param array $parameters
 * @param $smarty
 *
 * @return null|string
 */
function smarty_function_grn_space_show_expiration_date_warning(
    $parameters,
    &$smarty
) {
    /** @var \grn\space\data\bean\Space $space */
    $space = $parameters['space'] ?? null;
    $is_mobile = $parameters['is_mobile'] ?? false;

    $html_result = null;

    if ($space == null) {
        return $html_result;
    }

    if ($space->getIsUnlimitedExpirationDate()) {
        return $html_result;
    }

    $now = time();
    $previous_month = strtotime('-30 days',
        $space->getExpirationDateTimestamp());
    if ($now < $previous_month || $now > $space->getExpirationDateTimestamp()) {
        return $html_result;
    }

    require_once $smarty->_get_plugin_filepath('function',
        'grn_space_display_expiration_date');
    $expiration_date
        = smarty_function_grn_space_display_expiration_date(['space' => $space],
        $smarty);

    $message = cb_msg('grn.space', 'warning_expiration_date',
        ['expiration_date' => $expiration_date]);

    if ($is_mobile) {
        $html_result
            = '<div class="mobile_box_area_grn mTop15">
                <span class="mobile_box_message_grn"><span class="mobile_icon_attentions_grn"></span>'
              . $message . '</span>
            </div>';
    } else {
        $html_result
            = '<div class="mTop10 mBottom7">
            <span class="icon_attention_grn">' . $message . '</span>
        </div>';
    }

    return $html_result;
}
